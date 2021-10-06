class AdminMailer < ApplicationMailer
  # メール送信アクション
  def send_mail(mail_title,mail_content,group_users)
    # Groupコントローラーからメールの件名と内容、グループ内にいるメンバー情報を取得
    @mail_title = mail_title
    @mail_content = mail_content
    mail bcc: group_users.pluck(:email), subject: mail_title
  end
end
