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

	def link_to_remove_fields(name, f, opt={})
    opt.store(:onclick, "remove_fields(this); return false")
    f.hidden_field(:_destroy) + link_to(name, " ", opt)
	end
 
	def link_to_add_fields(name, f, association, opt={})
    	new_object = f.object.class.reflect_on_association(association).klass.new
    	fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      		render(association.to_s + "/" + association.to_s.singularize + "_fields", :f => builder)
      end
      opt.store(:onclick, "add_fields(this, \"#{ association }\", \"#{ escape_javascript(fields) }\"); return false")
      
       link_to(name, " ", opt)
  end
  
  def active_link(c)
    unless current_page?(root_path)
      params[:controller] == c ? "active" : ""
    end
  end
    
    def format_time(t)
      t.strftime("%I:%M %p") 
    end
    
    def format_time_short(t)
      t.strftime("%l:%M") 
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
    
    def status_name(status, option)
      if option == "html"
        case status
        when "s" 
          '<span class="text-info">Scheduled</span>'.html_safe
        when "c" 
          '<span class="text-warning">Canceled</span>'.html_safe
        when "a" 
          '<span class="text-success">Attended</span>'.html_safe
        when "m" 
          '<span class="text-error">Missed</span>'.html_safe
        when "u" 
          '<span style ="color:orange;">Needs Attention</span>'.html_safe
        end
      elsif option == "plain"
        case status
        when "s" 
          'Scheduled'
        when "c" 
          'Canceled'
        when "a" 
          'Attended'
        when "m" 
          'Missed'
        when "u"
          'N/A'
        end
      end
    end
    
    def sharing_attendance(attendance)
      case attendance
      when true
        '<span class="text-success">Attended</span>'.html_safe
      when false
        '<span class="text-error">Missed</span>'.html_safe
      end
    end
    
    def join_date_time(d, t)
      dt = DateTime.new(d.year, d.month, d.day, t.hour, t.min, t.sec)
    end
    
    def display_error(object, field)
      if object.errors.any?
        if object.errors[field.to_sym].present?
        '<div class="field inline alert alert-error"><i class="icon-warning-sign icon-white"></i>'.html_safe + " #{object.errors[field.to_sym].first}" + '</div>'.html_safe
        end
      end
    end
      
end
