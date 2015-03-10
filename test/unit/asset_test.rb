require 'test_plugin_helper'

class AssetTest < ActiveSupport::TestCase
  setup do
    disable_orchestration
    User.current = users :admin
    Setting[:token_duration] = 0
    Scaptimony::Policy.any_instance.stubs(:ensure_needed_puppetclasses).returns(true)
  end

  test "asset should have policy" do
    asset = FactoryGirl.create(:asset, :policies => [FactoryGirl.create(:policy)])
    refute_empty(asset.policies)
  end

  test "asset should have a smart proxy" do
    asset = FactoryGirl.create(:asset, :policies => [FactoryGirl.create(:policy)])
    smart_proxy = FactoryGirl.create(:smart_proxy)
    assert asset.proxy = smart_proxy
  end

  test "asset server should be url" do
    proxy = FactoryGirl.create(:smart_proxy)
    asset = FactoryGirl.create(:asset, :proxy => proxy)
    assert_equal(asset.proxy_url, proxy.url)
    assert asset.server.is_a? URI::HTTP

    assert_equal(asset.server, URI.parse(proxy.url).host)
    assert_equal(asset.port, URI.parse(proxy.url).port)
  end

end
