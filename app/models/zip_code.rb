# frozen_string_literal: true

class ZipCode < ActiveRecord::Base
    belongs_to :municipality
    has_many :colonies
    validates :name, uniqueness: true
    validates :code, uniqueness: true
    validates_presence_of :name, :code
end
