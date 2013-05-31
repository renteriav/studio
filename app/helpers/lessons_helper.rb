module LessonsHelper
  def frequency
    [['Every week', 1], ['Every other week', 2], ['Once a month', 4]]
  end
  
  def days_of_week
    [['Sunday', 0], ['Monday', 1], ['Tuesday', 2], 
   ['Wednesday', 3], ['Thursday', 4], ['Friday', 5], ['Saturday', 6]]
  end
  
  def frequency_select
    [['One lesson', 0], ['Once a week', 1], ['Every other week', 2], ['Once a month', 3]]
  end
  
  def frequency_display
    a = frequency_select
    b = Array.new
    a.each do |key, value|
      b.push(key)
    end
    return b
  end
end
