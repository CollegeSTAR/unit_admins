class InstitutionalUnitAdministratorAssociation < ActiveRecord::Base
  belongs_to :institutional_unit
  belongs_to :administrator
end
