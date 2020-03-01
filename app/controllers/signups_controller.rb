class SignupsController < ApplicationController
  def user_information
    @user = User.new
  end

  def user_information_validates
    session[:nickname] = user_params[:nickname]
    session[:email] = user_params[:email]
    session[:password] = user_params[:password]
    session[:password_confirmation] = user_params[:password_confirmation]
    session[:first_name] = user_params[:first_name]
    session[:last_name] = user_params[:last_name]
    session[:first_name_kana] = user_params[:first_name_kana]
    session[:last_name_kana] = user_params[:last_name_kana]
    session[:birth_year] = user_params[:birth_year]
    session[:birth_month] = user_params[:birth_month]
    session[:birth_day] = user_params[:birth_day]

    @user = User.new(
      nickname: session[:nickname],
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation],
      first_name: session[:first_name],
      last_name: session[:last_name],
      first_name_kana: session[:first_name_kana],
      last_name_kana: session[:last_name_kana],
      birth_year: session[:birth_year],
      birth_month: session[:birth_month],
      birth_day: session[:birth_day]
    )
    @user.valid?
    skip_phonenumber_validate(@user.errors) 

    if @user.errors.messages.blank? && @user.errors.details.blank?
      redirect_to phone_number_verification_signups_path
    else
      @user.errors.messages[:birth_day] = change_birthday_validate_message(@user)
      render :user_information
    end
  end

  def phone_number_verification
    @user = User.new
  end

  def create
    @user = User.new(
      nickname: session[:nickname],
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation],
      first_name: session[:first_name],
      last_name: session[:last_name],
      first_name_kana: session[:first_name_kana],
      last_name_kana: session[:last_name_kana],
      birth_year: session[:birth_year],
      birth_month: session[:birth_month],
      birth_day: session[:birth_day],
      phone_number: user_params[:phone_number]
    )
    

    if @user.save
      sign_in User.find(@user.id) unless user_signed_in?
      session.delete(:nickname)
      session.delete(:email)
      session.delete(:password)
      session.delete(:password_confirmation)
      session.delete(:first_name)
      session.delete(:last_name)
      session.delete(:first_name_kana)
      session.delete(:last_name_kana)
      session.delete(:birth_year)
      session.delete(:birth_month)
      session.delete(:birth_day)
      redirect_to done_signups_path 
    else
      render :phone_number_verification
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :nickname, 
      :email, 
      :password, 
      :password_confirmation, 
      :first_name, 
      :last_name, 
      :first_name_kana, 
      :last_name_kana, 
      :birth_year, 
      :birth_month, 
      :birth_day, 
      :phone_number
    )
  end

  def skip_phonenumber_validate(errors)
    errors.messages.delete(:phone_number)
    errors.details.delete(:phone_number)
  end

  def change_birthday_validate_message(user)
    if user.errors.messages[:birth_year].any? || user.errors.messages[:birth_month].any? || user.errors.messages[:birth_day].any?
      user.errors.messages.delete(:birth_year)
      user.errors.messages.delete(:birth_month)
      user.errors.messages[:birth_year] = ["生年月日は正しく入力してください"]
      user.errors.messages[:birth_year]
    end
  end
end