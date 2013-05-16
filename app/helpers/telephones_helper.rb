module TelephonesHelper
	def formated_phone(number)
		@area = number[0..2]
    @prefix = number[3..5]
    @sufix = number[6..9]
    formated = "(#{@area})-#{@prefix}-#{@sufix}"
	end
  
  def phone_description(collection, f, classes)
    f.select(:description, collection, {}, {class: classes})
  end
end
