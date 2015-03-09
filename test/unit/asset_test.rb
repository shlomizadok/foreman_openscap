require 'test_plugin_helper'

class AssetTest < ActiveSupport::TestCase
  setup do
    disable_orchestration
    User.current = users :admin
    Setting[:token_duration] = 0
    Scaptimony::Policy.any_instance.stubs(:ensure_needed_puppetclasses).returns(true)
  end

  test "asset should have policy" do
    asset =  FactoryGirl.create(:asset, :policies => [FactoryGirl.create(:policy)])
    refute_empty(asset.policies)
  end

  test "asset should have a smart proxy" do
    asset =  FactoryGirl.create(:asset, :policies => [FactoryGirl.create(:policy)])
  end

end
