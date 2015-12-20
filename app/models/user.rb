class User < ActiveRecord::Base
  has_many :user_answers
  has_many :exam_ranks 
  def self.from_omniauth(auth_hash)
    user = find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
    user.name = auth_hash['info']['name']
    user.email = auth_hash['info']['email']
    user.location = auth_hash['info']['location']
    user.image = auth_hash['info']['image']
    user.token = auth_hash['credentials']['token']
    user.expires_at = Time.at(auth_hash['credentials']['expires_at'])
    user.role = 'normal'
    user.save!
    user
  end
end
