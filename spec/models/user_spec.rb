require 'rails_helper'
describe User do
  describe '#create' do
    it "Can be registered when all items are entered" do
      user = build(:user)
      expect(user).to be_valid
    end

    describe "Email" do
      it "is valid with a email" do
        user = build(:user, email: "kkk@gmail.com")
        user.valid?
        expect(user).to be_valid
      end
      it "is invalid without a email" do
        user = build(:user, email: "")
        user.valid?
        expect(user.errors[:email]).to include("can't be blank")
      end
      it "Invalid if duplicate email address" do
        user = create(:user)
        another_user = build(:user, email: user.email)
        another_user.valid?
        expect(another_user.errors[:email]).to include("has already been taken")
      end
    end

    describe "Password" do
      it "is invalid without a password" do
        user = build(:user, password: "")
        user.valid?
        expect(user.errors[:password]).to include("can't be blank")
      end
      it "is invalid without a email" do
        user = build(:user, password_confirmation: "")
        user.valid?
        expect(user.errors[:password_confirmation]).to include("doesn't match Password")
      end
      it "Password and confirm password do not match" do
        user = build(:user, password_confirmation: "bbbbbbb")
        user.valid?
        expect(user.errors[:password_confirmation]).to include("doesn't match Password")
      end
      it "Invalid if password is less than 7 characters" do
        user = build(:user, password: "000000", password_confirmation: "000000")
        user.valid?
        expect(user.errors[:password]).to include("is too short (minimum is 7 characters)")
      end
      it "Valid if the password is 7 characters or more" do
        user = build(:user, password: "0000000", password_confirmation: "0000000")
        user.valid?
        expect(user).to be_valid
      end
    end

    describe "Name" do
      it "is invalid without a first_name" do
        user = build(:user, first_name: "")
        user.valid?
        expect(user.errors[:first_name]).to include("can't be blank")
      end
      it "is invalid without a last_name" do
        user = build(:user, last_name: "")
        user.valid?
        expect(user.errors[:last_name]).to include("can't be blank")
      end
      it "is invalid without a first_name_kana" do
        user = build(:user, first_name_kana: "")
        user.valid?
        expect(user.errors[:first_name_kana]).to include("can't be blank")
      end
      it "is invalid without a last_name_kana" do
        user = build(:user, last_name_kana: "")
        user.valid?
        expect(user.errors[:last_name_kana]).to include("can't be blank")
      end
      it "Invalid if the first name Kana is Hiragana" do
        user = build(:user, first_name_kana: "ささみた")
        user.valid?
        expect(user.errors[:first_name_kana]).to include("is invalid")
      end
      it "Invalid if the last name Kana is Hiragana" do
        user = build(:user, last_name_kana: "かずしげ")
        user.valid?
        expect(user.errors[:last_name_kana]).to include("is invalid")
      end
    end

    describe "Birthday" do
      it "is invalid without a birth_year" do
        user = build(:user, birth_year: "")
        user.valid?
        expect(user.errors[:birth_year]).to include("can't be blank")
      end
      it "Invalid if non-numeric characters are entered in birth year" do
        user = build(:user, birth_year: "あああ")
        user.valid?
        expect(user.errors[:birth_year]).to include("is not a number")
      end
      it "is invalid without a birth_month" do
        user = build(:user,birth_month: "")
        user.valid?
        expect(user.errors[:birth_month]).to include("can't be blank")
      end
      it "Invalid if non-numeric characters are entered in birth month" do
        user = build(:user, birth_month: "aaa")
        user.valid?
        expect(user.errors[:birth_month]).to include("is not a number")
      end
      it "is invalid without a birth_day" do
        user = build(:user, birth_day: "")
        user.valid?
        expect(user.errors[:birth_day]).to include("can't be blank")
      end
      it "Invalid if non-numeric characters are entered in birth day" do
        user = build(:user, birth_day: "誕")
        user.valid?
        expect(user.errors[:birth_day]).to include("is not a number")
      end
    end

    describe "Phone number" do
      it "is invalid without a phone_number" do
        user = build(:user, phone_number: "")
        user.valid?
        expect(user.errors[:phone_number]).to include("can't be blank")
      end
      it "Invalid if phone number is not a number" do
        user = build(:user, phone_number: "aaabbbbcccc")
        user.valid?
        expect(user.errors[:phone_number]).to include("is not a number")
      end
      it "Invalid if the phone number is 9 digits" do
        user = build(:user, phone_number: "111333555")
        user.valid?
        expect(user.errors[:phone_number]).to include("is invalid")
      end
      it "Invalid if the phone number is 12 digits" do
        user = build(:user, phone_number: "111333355557")
        user.valid?
        expect(user.errors[:phone_number]).to include("is invalid")
      end
      it "Valid if phone number is 10 digits" do
        user = build(:user, phone_number: "1113335555")
        user.valid?
        expect(user).to be_valid
      end
      it "Valid if phone number is 11 digits" do
        user = build(:user, phone_number: "11133335555")
        user.valid?
        expect(user).to be_valid
      end
      it "Invalid if duplicate phone number" do
        user = create(:user)
        another_user = build(:user, phone_number: user.phone_number)
        another_user.valid?
        expect(another_user.errors[:phone_number]).to include("has already been taken")
      end
    end
  end
end
