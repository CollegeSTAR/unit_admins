class InstitutionalUnit < ActiveRecord::Base
  
  validates :name, :slug, presence: true
  validates_uniqueness_of :name, :slug

  def to_param
    slug
  end
end
