class Exam < ActiveRecord::Base
  has_many :answers
  has_many :user_answers
  has_many :exam_ranks
end
