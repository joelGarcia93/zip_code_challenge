# frozen_string_literal: true

class Municipality < ActiveRecord::Base
    belongs_to :state
    has_many :postal_codes
    validates :name, uniqueness: true
    validates :code, uniqueness: true
    validates_presence_of :name, :code
end
    