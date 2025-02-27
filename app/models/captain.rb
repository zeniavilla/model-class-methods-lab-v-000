class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    joins(:boats => :classifications).where('classifications.name IS ?', 'Catamaran')
  end

  def self.sailors
    joins(:boats => :classifications).where('classifications.name IS ?', 'Sailboat').distinct
  end

  def self.motorboaters
    joins(:boats => :classifications).where('classifications.name IS ?', 'Motorboat').distinct
  end

  def self.talented_seamen
    where('id IN (?)', self.sailors.pluck(:id) & self.motorboaters.pluck(:id))
  end

  def self.non_sailors
    where.not('id IN (?)', self.sailors.pluck(:id))
  end
end
