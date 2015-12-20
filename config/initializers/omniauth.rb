OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '1512939478999206', 'e180cb3841ea7f7cf9bda77d679c5668', 
  :scope => 'email,user_location',
  :image_size => 'large',
  :display => 'popup'
end

