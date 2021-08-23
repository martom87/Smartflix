# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'MyString' }
    surname { 'MyString' }
    email { 'MyString' }
    password { 'MyString' }
    token { 'MyString' }
    address { 'MyString' }
  end
end
