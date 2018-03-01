require 'helper'
require 'net/http'

class KintoneWebhookInputTest < Test::Unit::TestCase
  def setup
    Fluent::Test.setup
  end


  def create_driver(conf=CONFIG, tag='test')
    Fluent::Test::OutputTestDriver.new(Fluent::WebhookKintoneInput, tag).configure(conf)
  end

  def test_configure
    assert_raise(Fluent::ConfigError) {
      d = create_driver('')
    }
  end

  def test_basic

  end

end

