FactoryGirl.define do
  factory :user do
    email 'foo@example.com'
    password_digest 'password'
  end

  factory :group do
    title "Group"
  end

  factory :location do
    title "Location"
  end

  factory :game do
    title "Game"
  end

  factory :vote do
    voted_for "2020-12-11"
    user
    game
  end
end
