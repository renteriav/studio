module ApplicationHelper
	def full_title(page_title)
		base_title = "Whitby Studio" 
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
	end

	def submit_button_message(button_message)
		"#{button_message}"
	end
end
