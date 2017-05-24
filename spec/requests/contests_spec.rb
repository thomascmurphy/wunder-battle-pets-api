require 'rails_helper'

RSpec.describe 'Contests API', type: :request do

  # initialize test data
  let!(:contests) { create_list(:contest, 10) }
  let(:contest_id) { contests.first.id }
  let(:pet_1_id) { '2251ef5c-4abb-4f97-943e-0dc8738b5844' }
  let(:pet_2_id) { '1d4d557b-2470-40cb-b2e4-1bc138914464' }

  describe 'GET /contests' do
    before { get '/contests' }

    it 'returns contests' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /contests/:id' do
    before { get "/contests/#{contest_id}" }

    context 'when the record exists' do
      it 'returns the contest' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(contest_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:contest_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Contest with 'id'=#{contest_id}/)
      end
    end
  end

  describe 'POST /contests' do
    let(:valid_attributes) { { pet_1_id: pet_1_id, pet_2_id: pet_2_id, arena_id: contests.first.arena.id } }

    context 'when the request is valid' do
      before { post '/contests', params: valid_attributes }

      it 'creates a contest' do
        expect(json['pet_1_id']).to eq(pet_1_id)
        expect(json['pet_2_id']).to eq(pet_2_id)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/contests', params: { pet_1_id: pet_1_id, arena_id: contests.first.arena.id } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Pet 2 can't be blank/)
      end
    end
  end

  # Test suite for PUT /contests/:id
  describe 'PUT /contests/:id' do
    let(:valid_attributes) { { arena_id: 2 } }

    context 'when the record exists' do
      before { put "/contests/#{contest_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /contests/:id
  describe 'DELETE /contests/:id' do
    before { delete "/contests/#{contest_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
