class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    limit(5)
  end
  
  def self.dinghy
    where("length < 20")
  end
  
  def self.ship
    where("length >= 20")
  end

  def self.longest_boat_length
    maximum(:length)
  end

  def self.last_three_alphabetically
    limit(3).order('name desc')
  end

  def self.without_a_captain
    where("captain_id IS ?", nil)
  end

  def self.sailboats
    joins(:classifications).where('classifications.name IS ?', 'Sailboat')
  end

  def self.with_three_classifications
    joins(:classifications).group('boats.id').having('count(classification_id) IS ?', 3)
  end
end
