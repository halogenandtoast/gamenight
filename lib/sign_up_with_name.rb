class SignUpWithName < Monban::SignUp
  def perform
    # stop judging me
    super.tap do |user|
      class << user
        validates :name, presence: true
      end
    end
  end
end
