class InstitutionalUnit < ActiveRecord::Base
  
  validates :name, :slug, presence: true
  validates_uniqueness_of :name, :slug

  belongs_to :institution
  has_many :departments, dependent: :destroy
  has_many :institutional_unit_administrator_associations, dependent: :destroy
  has_many :administrators, through: :institutional_unit_administrator_associations

  def to_param
    slug
  end
end
