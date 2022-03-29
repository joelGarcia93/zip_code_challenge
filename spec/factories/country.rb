FactoryBot.define do
	country_name = Faker::Address.country
	code_number = Faker::Address.country_name_to_code(name: country_name.parameterize.underscore)
	factory :country do
		name { country_name }
		code { code_number }
		code2 { code_number }
	end
end