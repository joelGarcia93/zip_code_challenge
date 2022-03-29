FactoryBot.define do
	postal_code_code = Faker::Address.zip_code 
	factory :zip_code do
		catalog_municipality
		id { postal_code_code }
		name { postal_code_code }
		code { postal_code_code }
	end
end