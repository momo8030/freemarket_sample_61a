require 'rails_helper'
describe User do
  describe '#create' do

    describe "Email" do
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

    describe "Password" do
      it "is invalid without a password" do
        user = User.new(password: "")
        user.valid?
        expect(user.errors[:password]).to include("can't be blank")
      end
      it "Password and confirm password do not match" do
        user = User.new(password: "aaaaaaa", password_confirmation: "bbbbbbb")
        user.valid?
        expect(user.errors[:password_confirmation]).to include("doesn't match Password")
      end
      it "Invalid if password is less than 7 digits" do
        user = User.new(password: "aaabbb")
        user.valid?
        expect(user.errors[:password]).to include("is too short (minimum is 7 characters)")
      end
    end

    describe "Name" do
      it "is invalid without a first_name" do
        user = User.new(first_name: "")
        user.valid?
        expect(user.errors[:first_name]).to include("can't be blank")
      end
      it "is invalid without a last_name" do
        user = User.new(last_name: "")
        user.valid?
        expect(user.errors[:last_name]).to include("can't be blank")
      end
      it "is invalid without a first_name_kana" do
        user = User.new(first_name_kana: "")
        user.valid?
        expect(user.errors[:first_name_kana]).to include("can't be blank")
      end
      it "is invalid without a last_name_kana" do
        user = User.new(last_name_kana: "")
        user.valid?
        expect(user.errors[:last_name_kana]).to include("can't be blank")
      end
      it "Invalid if the first name Kana is Hiragana" do
        user = User.new(first_name_kana: "あああ")
        user.valid?
        expect(user.errors[:first_name_kana]).to include("is invalid")
      end
      it "Invalid if the last name Kana is Hiragana" do
        user = User.new(last_name_kana: "あああ")
        user.valid?
        expect(user.errors[:last_name_kana]).to include("is invalid")
      end
    end

    describe "Birthday" do
      it "is invalid without a birth_year" do
        user = User.new(birth_year: "")
        user.valid?
        expect(user.errors[:birth_year]).to include("can't be blank")
      end
      it "Invalid if non-numeric characters are entered in birth year" do
        user = User.new(birth_year: "あああ")
        user.valid?
        expect(user.errors[:birth_year]).to include("is not a number")
      end

      it "is invalid without a birth_month" do
        user = User.new(birth_month: "")
        user.valid?
        expect(user.errors[:birth_month]).to include("can't be blank")
      end
      it "Invalid if non-numeric characters are entered in birth month" do
        user = User.new(birth_month: "aaa")
        user.valid?
        expect(user.errors[:birth_month]).to include("is not a number")
      end
      it "is invalid without a birth_day" do
        user = User.new(birth_day: "")
        user.valid?
        expect(user.errors[:birth_day]).to include("can't be blank")
      end
      it "Invalid if non-numeric characters are entered in birth day" do
        user = User.new(birth_day: "誕")
        user.valid?
        expect(user.errors[:birth_day]).to include("is not a number")
      end
    end

    describe "Phone number"
    it "is invalid without a phone_number" do
      user = User.new(phone_number: "")
      user.valid?
      expect(user.errors[:phone_number]).to include("can't be blank")
    end
  end
end
