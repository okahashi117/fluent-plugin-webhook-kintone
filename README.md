# Fluent::Plugin::Webhook::Kintone

fluentd input plugin for incoming webhook from Kintone.

## Installation

buid and gem install localy.

## Usage

```
<source>
  type webhook_kintone
  tag whkinton
  
  secure true #https or http
  cert_pth path/for/certificate/cert.pem
  private_key_path path/for/certificate/key.pem
  chain_path path/for/certificate/chaincertpem

  # optional (values are default)
  bind 0.0.0.0
  port 3838
  mount /
  
</source>

```

Set your url on your kintone app webhook setting.

## Copyright
Copyright(C) 2018- @okahashi117

## License
MIT

## Thanks
Thanks for Makerel.
