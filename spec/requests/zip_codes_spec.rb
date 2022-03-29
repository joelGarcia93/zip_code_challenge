require "rails_helper"
include ActionController::RespondWith

RSpec.describe "ZipCode", :type => :request do
	let(:zip_code) { FactoryBot.create(:zip_code) }

	context 'valid' do 
		# http_method, action_method, url
		describe 'GET index /zip-codes/:zip-code' do
			before do
				get api_v1_figures_path, headers: @headers
			end

			it 'should returns status 200' do
				expect(response).to have_http_status(:success)
			end

			it 'should return 1 figure operator in array list' do
				body = body_response(response)
				expect(body[:data].count).to eq 1
			end
		end
	end

	context 'invalid' do
		
	end
end