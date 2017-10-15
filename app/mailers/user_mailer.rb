class UserMailer < ApplicationMailer

	def new_comment_email(comment)
		@comment = comment

		mail(
				to: @comment.post.user.email,
				subject: 'New Comment | AllSocial'
				# cc: ['asdf@gmail.com', ]
			)
	end
end
