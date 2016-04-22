require 'rails_helper'

feature "User adds a new ingredient" do
  before(:each) do
    @user = create(:user)
    login_user(@user)
  end

  xscenario "User adds a new ingredient" do
  end
end
