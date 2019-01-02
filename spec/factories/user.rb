FactoryBot.define do
  factory :user do
    nom 'MAMMER'
    prenom 'Rihab'
    email 'rihabM@yahoo.com'
    password 'usermed'
  end
  factory :random_user, class: User do
    nom { Faker::Name.last_name }
    prenom { Faker::Name.first_name }
    email { Faker::Internet.email('MedRspec') }
    password 'usermed'
  end
end
