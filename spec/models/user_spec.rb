require 'rails_helper'

describe User do
  describe "#create" do
    it "is created with a shopping_list initialized" do
      user = create(:user)
      expect(user.shopping_list).to_not be_nil
    end
  end
end
