FactoryBot.define do
  factory :user do
    username              { Faker::Name.first_name  }
    email                 { "MyString@mystring.com" }
    password              { 'password'              }
    password_confirmation { 'password'              }
    role                  { 0                       }
  end
end
