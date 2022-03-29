class ZipCodeSerializer
  include FastJsonapi::ObjectSerializer
  
  attribute :zip_code do |object|
		object.code
	end

  attribute :locality do |object|
		object.municipality.state.name.upcase
	end

  attribute :federal_entity do |object|
		object.municipality.state.name.upcase
	end

  attribute :settlements do |object|
		object.colonies
	end

  attribute :municipality do |object|
		object.municipality.name.upcase
	end

  attribute :country do |object|
		object.municipality.state.country.name.upcase
	end
end
