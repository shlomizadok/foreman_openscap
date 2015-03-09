require 'test_plugin_helper'

class ScapHostTest < ActionDispatch::IntegrationTest
  def setup
    Capybara.current_driver = Capybara.javascript_driver
    login_admin
  end

  before do
    SETTINGS[:locations_enabled] = false
    SETTINGS[:organizations_enabled] = false
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start
    as_admin { @host = FactoryGirl.create(:host, :with_puppet, :managed) }
    FactoryGirl.create(:smart_proxy,
                       :features => [FactoryGirl.create(:feature, :name => 'Openscap')])
  end

  after do
    SETTINGS[:locations_enabled] = true
    SETTINGS[:organizations_enabled] = true
    DatabaseCleaner.clean
  end

  test 'host form has compliance tab' do
    assert_new_button(hosts_path,"New Host",new_host_path)
    assert(page.has_link?("Compliance", :href => "#compliance"), 'Should have compliance tab')
  end

  test 'compliance proxy and policy are selectable for host' do
    assert_new_button(hosts_path, "New Host", new_host_path)

    # switch to interfaces tab
    page.find(:link, "Compliance").click

    page.find('#host_openscap_proxy_id').click
    # save_screenshot('/tmp/host_openscap.png')
  end
end