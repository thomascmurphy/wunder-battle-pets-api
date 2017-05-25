require 'rails_helper'

RSpec.describe 'Disciplines API', type: :request do

  # initialize test data
  let!(:disciplines) { create_list(:discipline, 10) }
  let(:discipline_id) { disciplines.first.id }

  describe 'GET /disciplines' do
    before { get '/disciplines' }

    it 'returns disciplines' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /disciplines/:id' do
    before { get "/disciplines/#{discipline_id}" }

    context 'when the record exists' do
      it 'returns the discipline' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(discipline_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:discipline_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Discipline with 'id'=#{discipline_id}/)
      end
    end
  end

end
