class Notification < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification.new_comment_notify.subject
  #
  def new_comment_notify(user)
    @greeting = "Hi"

    mail subject: "新留言" , to: user.email
  end

end
