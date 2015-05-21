class Pokemon < ActiveRecord::Base
  self.inheritance_column = nil #Defending against STI

  TYPES = %w(
    bug dark dragon electric fairy fighting fire flying
    ghost grass ground ice normal poison psychic rock
    shadow steel unknown water
  )

end
