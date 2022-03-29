# frozen_string_literal: true

class Colony < ActiveRecord::Base
	belongs_to :zip_code
	validates :zip_code_id, uniqueness: { scope: [:code, :name] }
	validates_presence_of :name, :code
end
    