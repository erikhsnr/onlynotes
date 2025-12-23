# app/mailers/fach_mailer.rb
class FachMailer < ApplicationMailer
  def notify_followers(user, fach)
    @user = user
    @fach = fach
    mail(to: @user.email, subject: "Update on #{fach.name}")
  end
end