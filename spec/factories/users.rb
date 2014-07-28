# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name "MyString"
    email "MyString"
    password_digest "MyString"
    password_confirmation "MyString"
  end
end
