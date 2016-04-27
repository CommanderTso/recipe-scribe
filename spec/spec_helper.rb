require 'coveralls'
Coveralls.wear!

module LoginHelper
  def login_user(user)
    visit login_path
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    click_button 'Submit'
  end
end

RSpec.configure do |config|
  config.include LoginHelper

  config.filter_run focus: true
  config.run_all_when_everything_filtered = true

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
