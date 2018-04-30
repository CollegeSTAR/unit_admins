class Department < ActiveRecord::Base

  validates :name, :slug, presence: true
  validates_uniqueness_of :name, :slug

  belongs_to :institution
  belongs_to :institutional_unit

  def to_param
    slug
  end
end
