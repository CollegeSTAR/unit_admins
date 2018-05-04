class Institution < ActiveRecord::Base
  before_save :sync_slug  
  validates :name, :slug, presence: true
  validates_uniqueness_of :name, :slug

  has_many :institutional_units, dependent: :destroy
  has_many :departments, dependent: :destroy
  has_many :notes, dependent: :destroy

  def to_param
    slug
  end

  private

  def sync_slug
    self.slug = self.name.parameterize
  end
end
