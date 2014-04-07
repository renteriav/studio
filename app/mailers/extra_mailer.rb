class ExtraMailer < ActionMailer::Base
	default from: "frenteriav@gmail.com"

  helper ApplicationHelper

  def extra_confirmation(teacher, student, date, start_time, end_time)
  	@teacher = teacher
  	@student = student
  	@date = date
  	@start_time = start_time
  	@end_time = end_time
  	mail(to: teacher.email, subject: "you've been scheduled to teach on #{date.strftime("%A, %b %-d, %Y")}" )
  end

end