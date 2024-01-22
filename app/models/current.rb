# current user global
class Current < ActiveSupport::CurrentAttributes
  attribute :user, :app_session, :organization
end
