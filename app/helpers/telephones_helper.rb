module TelephonesHelper
	def formated_phone(area, prefix, sufix)
		formated = "(#{area}) #{prefix}-#{sufix}"
	end
end
