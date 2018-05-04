class InstitutionalUnit < ActiveRecord::Base
  
  validates :name, :slug, presence: true
  validates_uniqueness_of :name, :slug

  belongs_to :institution
  has_many :departments, dependent: :destroy
  has_many :administrators, dependent: :destroy
  has_many :notes, dependent: :destroy

  accepts_nested_attributes_for :notes, reject_if: :all_blank

  def to_param
    slug
  end
end
