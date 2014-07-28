# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name "MyString"
    email "MyString"
    password "last"
    password_confirmation "last"

    factory :admin_user do
      admin true
    end
  end
end
