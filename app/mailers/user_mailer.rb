class UserMailer < ApplicationMailer
  default from: "user_created@example.com"

  def welcome
    @user = params[:user]
    @url = "http://localhost:3000/users/sign_in"
    mail(to: @user.email, subject: "Welcome to my E-commerce store")
  end
end
