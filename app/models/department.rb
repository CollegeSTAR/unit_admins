class Department < ActiveRecord::Base

  validates :name, :slug, presence: true
  validates_uniqueness_of :name, :slug

  belongs_to :institution
  belongs_to :institutional_unit
  has_many :department_administrators, dependent: :destroy
  has_many :notes, dependent: :destroy

  accepts_nested_attributes_for :notes, reject_if: :all_blank

  def to_param
    slug
  end
end
