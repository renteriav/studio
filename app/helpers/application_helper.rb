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

	def link_to_remove_fields(name, f, classes)
    	f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)", class: classes)
	end
 
	def link_to_add_fields(name, f, association, classes)
    	new_object = f.object.class.reflect_on_association(association).klass.new
    	fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      		render(association.to_s + "/" + association.to_s.singularize + "_fields", :f => builder)
      end
    	link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")", class: classes)
  end
  
  def active_link(c)
    unless current_page?(root_path)
      params[:controller] == c ? "active" : ""
    end
  end
    
    def format_time(t)
      t.strftime("%I:%M %p") 
    end
    
    def format_day(d)
      d.strftime("%A, %b #{d.day.ordinalize}, %Y")
    end
    
    def dynamic_teachers(instrument_id)
      if instrument_id == ''
      [['Select a teacher', ""]]
      else
      Instrument.find(instrument_id).teachers.map{|i| [i.first, i.id]}.insert(0, ["Select a teacher", ""])
      end

    end  
    
    def status_name(status)
      case status
      when "s" 
        "Scheduled"
      when "c" 
        "Canceled"
      when "a" 
        "Attended"
      when "m" 
        "Missed"
      end
    end
end
