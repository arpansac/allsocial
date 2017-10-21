class UserMailer < ApplicationMailer

	def new_comment_email(comment_id)

		@comment = Comment.find(comment_id)
		mail(
				to: @comment.post.user.email,
				subject: 'New Comment | AllSocial'

				# cc: [email1, email2]
			)

	end
end
