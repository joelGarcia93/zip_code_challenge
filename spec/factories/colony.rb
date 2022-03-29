FactoryBot.define do
	colony = Faker::Address.community 
	factory :colony do
		zip_code
		name { colony }
		code { colony }
	end
end