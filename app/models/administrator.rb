class Administrator < ActiveRecord::Base
  validates :job_title, :first_name, :last_name, presence: true
  validates_uniqueness_of :job_title, scope: [:first_name, :last_name]

  has_many :institutional_unit_administrator_associations, dependent: :destroy
  has_many :institutional_units, through: :institutional_unit_administrator_associations

  def other_job_title=(value)
    if self.job_title == nil || self.job_title == ''
      self.job_title = value
    end
  end
end
