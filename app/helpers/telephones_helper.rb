module TelephonesHelper
	def formated_phone(number)
		@area = number[0..2]
    @prefix = number[3..5]
    @sufix = number[6..9]
    formated = "(#{@area})-#{@prefix}-#{@sufix}"
	end
  
  def phone_description(collection, f, classes)
    f.select(:description, collection, {:include_blank => 'Select'}, {class: classes})
  end
  
  def phone_collection(type)
    case type
    when "A"
      [['Home', 'Home'], ['Mr. cell', 'Mr. cell'], ['Mrs. cell', 'Mrs. cell'], ['Mr. work', 'Mr. work'], ['Mrs. work', 'Mrs. work']]
    when "B"
      [['Cell', 'Cell'], ['Home', 'Home']] 
    end
  end
end
