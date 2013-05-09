module CustomersHelper
	def formated_name(first, last)
		@name = first.capitalize + " " + last.capitalize
	end
end
