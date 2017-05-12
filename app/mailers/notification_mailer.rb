class NotificationMailer < ActionMailer::Base
  default from: 'do-not-reply@punchclock.com'

  def notify_admin_registration(admin_user)
    @user = admin_user
    mail(to: @user.email, subject: 'You was registered on Punchclock')
  end

  def notify_successful_signup(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Punchclock')
  end

  def notify_user_registration(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Punchclock')
  end

  def notify_user_password_change(user, new_password)
    @user = user
    @new_password = new_password
    mail(to: @user.email,
         subject: 'Punchclock - Your password has been modified')
  end

  def notify_admin_punches_pending(admin, user)
    @admin = admin
    @user = user
    mail(to: @admin.email, subject: "Punchclock - #{user.name} still inactive")
  end

  def notify_user_to_fill_punch(user)
    @user = user
    mail(to: @user.email, subject: "Preencher Punch")
  end

  def notify_admin_extra_hour(admin, user, worked_days)
    @admin = admin
    @user = user
    @worked_days = worked_days
    mail(to: @admin.email, subject: "Punchclock - #{user.name} registrou hora extra")
  end
end
