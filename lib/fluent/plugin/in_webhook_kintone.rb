require "thread"
require "json"
require 'webrick'
require 'webrick/https'
require 'fluent/plugin/input'
require 'fluent/process'

module Fluent
  class WebhookKintoneInput < Plugin::Input
    include DetachProcessMixin

    Plugin.register_input('webhook_kintone', self)

    config_param :tag, :string
    config_param :bind, :string, :default => "0.0.0.0"
    config_param :port, :integer, :default => 3838
    config_param :mount, :string, :default => "/"
    config_param :secure, :bool, :default => true
    config_param :cert_path, :string, :default => nil
    config_param :private_key_path, :string, :default => nil
    config_param :chain_path, :string, :default => nil
    config_param :document_root, :string, :default =>"/"

    def start
      @thread = Thread.new(&method(:run))
    end

    def shutdown
      @server.shutdown
      Thread.kill(@thread)
    end

    def run
      @server = WEBrick::HTTPServer.new(
        :BindAddress => @bind,
        :Port => @port, 
        :DocumentRoot => @document_root,
        :SSLEnable => @secure,
        :SSLCertificate => OpenSSL::X509::Certificate.new(open(@cert_path).read),
        :SSLExtraChainCert => [OpenSSL::X509::Certificate.new(open(@chain_path).read)],
        :SSLPrivateKey => OpenSSL::PKey::RSA.new(open(@private_key_path).read),
      )
      $log.debug "Listen on http://#{@bind}:#{@port}#{@mount}"
      @server.mount_proc(@mount) do |req, res|
        begin
        $log.debug req.header    
           if req.request_method != "POST"
             res.status = 405
           else
             payload = JSON.parse(req.body)
             process(payload)
             res.status = 204
           end
        rescue => e
          $log.error e.inspect
          $log.error e.backtrace.join("\n")
          res.status = 400
         end
      end
      @server.start
    end

    def process(payload) 
      router.emit("#{@tag.dup}.#{payload}", Engine.now, payload) 
    end
  end
end

