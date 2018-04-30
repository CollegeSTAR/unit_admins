class Institution < ActiveRecord::Base
  
  validates :name, :slug, presence: true
  validates_uniqueness_of :name, :slug

  has_many :institutional_units, dependent: :destroy
  has_many :departments, dependent: :destroy

  def to_param
    slug
  end
end
