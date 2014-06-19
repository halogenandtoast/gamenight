require 'sign_up_with_name'

Monban.configure do |config|
  config.sign_up_service = SignUpWithName
end
