class Answer < ActiveRecord::Base
  belongs_to :exam, dependent: :destroy
end
