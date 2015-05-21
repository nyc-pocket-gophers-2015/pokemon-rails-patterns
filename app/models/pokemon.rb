class Pokemon < ActiveRecord::Base
  self.inheritance_column = nil #Defending against STI

  TYPES = %w(
    bug dark dragon electric fairy fighting fire flying
    ghost grass ground ice normal poison psychic rock
    shadow steel unknown water
  )

  scope :free, -> {where(caught: false)}
  scope :caught, -> { where(caught: true )}

  scope :typed, -> (type=nil) do
    if type
      where(type:type)
    else
      all
    end
  end
end
