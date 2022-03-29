FactoryBot.define do
	country_name = Faker::Address.country
	factory :country do
		name { country_name }
		code { Faker::Address.country_name_to_code(name: country_name.parameterize.underscore) }
	end
end