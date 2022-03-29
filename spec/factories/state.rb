FactoryBot.define do
	state_code = Faker::Address.state_abbr 
	factory :state do
		catalog_country
		id { state_code }
		name { Faker::Address.state }
		code { state_code }
	end
end