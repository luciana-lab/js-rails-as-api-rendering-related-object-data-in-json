class Location < ApplicationRecord
    has_many :sightings
    has_many :Location, through: :sightings
end
