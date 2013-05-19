module FieldSanitizer
  def nameize(*attrs)
    attrs.each do |att|
      if (self.respond_to?(att) && self[att])
        name = self[att].split
        name.each do |part|
          case
            when (part.match(/^mac/i) && part.length > 3)
              part.gsub!(/^mac/i, "").capitalize!.insert(0, "Mac")
            when (part.match(/^mc/i) && part.length > 2)
              part.gsub!(/^mc/i, "").capitalize!.insert(0, "Mc")
            when (part.match(/^o\'/i) && part.length > 2)
              part.replace(part.split("'").each{ |piece| piece.capitalize! }.join("'"))
            when (part.match(/-/) && part.length > 2)
              part.replace(part.split("-").each{ |piece| piece.capitalize! }.join("-"))
            else
              part.capitalize!
          end
        end
        self[att] = name.join(' ')
      end
    end
  end
end