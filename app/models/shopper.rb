# frozen_string_literal: true

class Shopper < ActiveRecord::Base
	validates_presence_of :name, :email, :cif
    validates :email, uniqueness: true
    #validates :cif, uniqueness: true
end
    