require 'rails_helper'

RSpec.describe 'Arenas API', type: :request do

  # initialize test data
  let!(:arenas) { create_list(:arena, 10) }
  let(:arena_id) { arenas.first.id }

  describe 'GET /arenas' do
    before { get '/arenas' }

    it 'returns arenas' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /arenas/:id' do
    before { get "/arenas/#{arena_id}" }

    context 'when the record exists' do
      it 'returns the arena' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(arena_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:arena_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Arena with 'id'=#{arena_id}/)
      end
    end
  end

end
