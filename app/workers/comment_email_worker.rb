class CommentEmailWorker
	@queue = :new_comment_email


	def self.perform comment_id

		puts('******************')
		puts('inside CommentEmailWorker')
		UserMailer.new_comment_email(comment_id).deliver_now
	end

end