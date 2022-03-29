require "rails_helper"

RSpec.describe "ZipCode", :type => :request do
	let(:zip_code) { FactoryBot.create(:zip_code) }
	let(:colony) { FactoryBot.create(:colony, zip_code: zip_code) }

	context 'valid' do 
		# http_method, action_method, url
		describe 'GET show /zip_codes/:zip-code' do
			before do
				colony
				get zip_code_path(zip_code)
			end

			it 'should returns status 200' do
				expect(response).to have_http_status(:success)
			end

			it 'should return data information' do
				body = body_response(response)
				expect(body[:data].present?).to eq true
			end

			it 'should return :zip_code, :locality, :federal_entity, :settlements, :municipality, :country keys' do
				json_response = body_response(response)
  			expect(json_response[:data][:attributes].keys).to match_array([:zip_code, :locality, :federal_entity, :settlements, :municipality, :country])
			end
		end
	end

	context 'invalid' do
		# http_method, action_method, url
		describe 'GET show /zip_codes/:zip-code' do
			before do
				colony
				get zip_code_path(id: '00000')
			end

			it 'should returns status 404' do
				expect(response).to have_http_status(:not_found)
			end

			it 'should return :message key with value <Zip code does not exists.>' do
				body = body_response(response)
				expect(body[:message]).to eq 'Zip code does not exists.'
			end
		end
	end
end