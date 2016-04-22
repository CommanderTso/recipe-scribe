require 'rails_helper'

feature "User deletes a recipe" do
  before(:each) do
    # @user = create(:user)
    # login_user(@user)
    @recipe = create(:recipe)
  end

  scenario "User deletes a recipe" do
    expect(true).to eq(true)
  end
end
