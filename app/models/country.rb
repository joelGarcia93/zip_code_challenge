# frozen_string_literal: true

class Country < ActiveRecord::Base
	has_many :states
	validates :name, uniqueness: true
	validates :code, uniqueness: true
	validates_presence_of :name, :code
end
  