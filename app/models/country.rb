# frozen_string_literal: true

class Country < ActiveRecord::Base
	belongs_to :company
	belongs_to :catalog_country
    validates :catalog_country_id, uniqueness: { scope: :company_id }
end
  