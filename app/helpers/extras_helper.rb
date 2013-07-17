module ExtrasHelper
  
  def extras_categories
      [
        ['Make Up Lesson', 'MU'],
        ['ASP Help', 'AH'],
        ['National Guild Help', 'NH'],
        ['Ensemble Help', 'EH']
      ]
  end
  
  def extra_category_description(c)
    extras_categories.select{ |name, code| code == c}[0][0]
  end
    
  
end
