# spec/requests/crawler_urls_spec.rb
require 'rails_helper'

RSpec.describe 'URL Crawler API', type: :request do
  # initialize test data 
  let!(:crawler_list) { create_list(:crawler_list, 5) }

  #GET previously stored urls
  describe 'GET /crawler_urls' do
    before { get '/crawler_urls' }

    it 'returns get_saved_urls' do
      expect(json).not_to be_empty
      expect(json.size).to eq(5)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  #POST index the content of given url
  describe 'POST index the url content' do

    context 'when the request is valid' do
      url = "http://guides.rubyonrails.org/testing.html"
      before { post '/crawler_urls', params: { url:  url } }

      it 'creates the content' do
        expect(json['url']).to eq(url)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
  end
end