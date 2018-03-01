lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "fluent-plugin-webhook-kintone"
  spec.version       = File.read(File.expand_path('../VERSION', __FILE__))
  spec.authors       = ["okahashi117"]
  spec.email         = ["naruki_okahashi@jbat.co.jp"]
  spec.summary       = %q{fluentd input plugin for receiving kintone webhook}
  spec.description   = %q{fluentd input plugin for receiving kintone webhook}
  spec.homepage      = "https://github.com/okahashi117/fluent-plugin-webhook-kintone"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "fluentd", "~> 0"
  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
