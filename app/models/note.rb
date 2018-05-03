class Note < ApplicationRecord
  
  validates :text, presence: true
  
  belongs_to :institution, optional: true
  belongs_to :institutional_unit, optional: true
  belongs_to :department, optional: true
  belongs_to :administrator, optional: true
end
