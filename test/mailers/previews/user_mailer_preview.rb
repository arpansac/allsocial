# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

	def new_comment_email
		UserMailer.new_comment_email(Comment.last)
	end

end
