require 'rails_helper'

describe Api::V1::TinyUrlsController do
  describe '#encode' do
    let(:action) { post :encode, body: tiny_url_params.to_json, as: :json }

    context 'valid params' do
      let(:tiny_url_params) { { long_url: 'https://oivan.com' } }

      it 'returns status 200' do
        action
        expect(response).to have_http_status 200
      end

      it 'created successfully' do
        action
        body = JSON.parse(response.body)
        expect(body['success']).to be true
        expect(body['message']).to eq 'Created successfully'
        expect(body['data']['short_url']).not_to be_nil
      end

      it 'returns existed url' do
        other_url = create(:tiny_url)
        action
        body = JSON.parse(response.body)
        expect(body['success']).to be true
        expect(body['message']).to eq 'Url is existed'
        expect(body['data']['short_url']).not_to be_nil
      end
    end

    context 'invalid params' do
      let(:tiny_url_params) { { long_url: '' } }

      it 'returns status 422' do
        action
        expect(response).to have_http_status 422
      end

      it 'return missing long url' do
        action
        body = JSON.parse(response.body)
        expect(body['success']).to be false
        expect(body['message']).to eq 'Created failed'
        expect(body['errors']['long_url']).to include "Long url can't be blank"
      end

      it 'returns invalid url' do
        post :encode, body: { long_url: 'https://oivan. com' }.to_json, as: :json
        body = JSON.parse(response.body)
        expect(body['success']).to be false
        expect(body['message']).to eq 'Created failed'
        expect(body['errors']['long_url']).to include "Long url is invalid"
      end
    end
  end

  describe '#decode' do
    let(:action) { post :decode, body: tiny_url_params.to_json, as: :json }

    context 'valid params' do
      let(:short_url) { create(:tiny_url) }
      let(:tiny_url_params) { { short_url: short_url.short_url } }

      it 'returns status 200' do
        action
        expect(response).to have_http_status 200
      end

      it 'returns long url' do
        action
        body = JSON.parse(response.body)
        expect(body['success']).to be true
        expect(body['message']).to eq 'Url is found'
        expect(body['data']['long_url']).to eq short_url.long_url
      end
    end

    context 'invalid params' do
      let(:tiny_url_params) { { short_url: "#{TinyUrl::SHORT_URL}/#{TinyUrl::LETTERS.sample(TinyUrl::UNIQUE_SLUG_LENGTH).join}" } }

      it 'returns invalid url' do
        post :decode, body: { short_url: 'https://short.est/ 6Kzi9sC' }.to_json, as: :json
        body = JSON.parse(response.body)
        expect(response).to have_http_status 422
        expect(body['success']).to be false
        expect(body['message']).to eq 'Short url is invalid'
      end

      it 'returns short url not found' do
        post :decode, body: { short_url: 'https://short.est/6Kzi9sC' }.to_json, as: :json
        body = JSON.parse(response.body)
        expect(response).to have_http_status 404
        expect(body['success']).to be false
        expect(body['message']).to eq 'Record Not Found'
      end
    end
  end
end
