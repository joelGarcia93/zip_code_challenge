FactoryBot.define do
	factory :municipality do
		catalog_state
		name { Faker::Address.city }
		code { Faker::Address.city_prefix }
	end
end