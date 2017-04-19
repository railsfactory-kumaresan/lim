# spec/factories/crawler_list.rb
require 'factory_helpers'

FactoryGirl.define do
  factory :crawler_list do
    url { FFaker::Internet.http_url }
    content { FactoryHelpers.page_content }
  end
end