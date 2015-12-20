class GuestUser < ActiveRecord::Base
  def role
    "guest"
  end
end
