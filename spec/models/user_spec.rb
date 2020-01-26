require 'rails_helper'
describe User do
  describe '#create' do
    it "is valid with a email" do
      user = User.new(nickname: "aaa", email: "kkk@gmail.com", password: "00000000", password_confirmation: "00000000")
      user.valid?
    end
    it "is invalid without a email" do
      user = User.new(nickname: "aaa", email: "", password: "00000000", password_confirmation: "00000000")
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end
  end
end
