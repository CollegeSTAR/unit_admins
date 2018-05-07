class InstitutionalUnit < ActiveRecord::Base
  
  before_save :sync_slug
  validates :name, :slug, presence: true
  validates_uniqueness_of :name, :slug

  belongs_to :institution
  has_many :departments, dependent: :destroy
  has_many :unit_administrators, dependent: :destroy
  has_many :notes, dependent: :destroy

  accepts_nested_attributes_for :notes, reject_if: :all_blank

  def to_param
    slug
  end

  private 
  
  def sync_slug
    if self.slug != self.name.parameterize
      self.slug = self.name.parameterize
    end
  end
end
