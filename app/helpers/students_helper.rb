module StudentsHelper
  
  def school_grades
      [
        ['Kinder', 0],
        ['1st', 1],
        ['2nd', 2],
        ['3rd', 3],
        ['4th', 4],
        ['5th', 5],
        ['6th', 6],
        ['7th', 7],
        ['8th', 8],
        ['9th', 9],
        ['10th', 10],
        ['11th', 11],
        ['12th', 12]
      ]
  end
  
  def grade_display
    a = school_grades
    b = Array.new
    a.each do |key, value|
      b.push(key)
    end
    return b
  end
  
  def current_grade(year, grade)
    a = Time.now.year - year
    Time.now.month < 8 ? b = 1: b = 0
    @current_grade = grade + a - b
    return @current_grade
  end
  
end