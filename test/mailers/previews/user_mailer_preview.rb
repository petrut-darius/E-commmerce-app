# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def welcome
    user = User.first || User.new(name: "Preview User", email: "preview@example.com")
    UserMailer.with(user: user).welcome
  end
end
