class Pokemon < ActiveRecord::Base
  self.inheritance_column = nil #Defending against STI
  validate :ok_to_capture

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

  def release
    self.caught = false
    #do other stuff
    save
  end

  def capture
    self.caught = true
    save
  end

  private

  def ok_to_capture
    if caught
      errors.add(:base, "You have this pokemon already") if have_pokemon
      errors.add(:base, "You already have two of type #{type}") if have_two_of_type
    end
  end

  def have_pokemon
    Pokemon.caught.where(id: id).count > 0
  end

  def have_two_of_type
    Pokemon.caught.typed(type).count >= 2
  end
end
