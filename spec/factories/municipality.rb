FactoryBot.define do
	factory :municipality do
		state
		name { Faker::Address.city }
		code { Faker::Address.city_prefix }
	end
end