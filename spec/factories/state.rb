FactoryBot.define do
	state_code = Faker::Address.state_abbr 
	factory :state do
		country
		id { state_code }
		name { Faker::Address.state }
		code { state_code }
        code2 { state_code }
	end
end