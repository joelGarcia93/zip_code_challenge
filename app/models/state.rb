# frozen_string_literal: true

class State < ActiveRecord::Base
    belongs_to :country
	has_many :municipalities
	validates :name, uniqueness: true
	validates_presence_of :name
end
  