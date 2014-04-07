class AttendanceMailer < ActionMailer::Base
  default from: "frenteriav@gmail.com"

  helper ApplicationHelper

  def sub_confirmation(sub, teacher, attendance, lesson, student)
  	@sub = sub
  	@teacher = teacher
  	@attendance = attendance
  	@lesson = lesson
  	@student = student
  	mail(to: sub.email, subject: "you're subbing on #{@attendance.date.strftime("%A, %b %-d, %Y")}" )
  end

  def cancelation(current_teacher, attendance, lesson, student)
    @current_teacher = current_teacher
    @attendance = attendance
    @lesson = lesson
    @student = student
    mail(to: current_teacher.email, subject: "Your lesson on #{@attendance.date.strftime("%A, %b %-d, %Y")} has been canceled." )
  end
end


