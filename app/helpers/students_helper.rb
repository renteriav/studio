module StudentsHelper
  
  def sharing_attendance(attendance)
    case attendance
    when true
      "Attended"
    when false
      "Missed"
    end
  end
end