class Administrator < ActiveRecord::Base
  validates :job_title, :first_name, :last_name, presence: true
  validates_uniqueness_of :job_title, scope: [:first_name, :last_name]

  belongs_to :institution
  belongs_to :institutional_unit
  has_one :administrative_assistant, dependent: :destroy

  accepts_nested_attributes_for :administrative_assistant, reject_if: :all_blank, allow_destroy: true

  def other_job_title=(value)
    if self.job_title == nil || self.job_title == ''
      self.job_title = value
    end
  end
end
