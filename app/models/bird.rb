class Bird < ApplicationRecord
    has_many :sightings
    has_many :birds, through: :sightings
end