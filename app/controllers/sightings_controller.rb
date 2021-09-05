class SightingsController < ApplicationController
    def index
        sightings = Sighting.all
        render json: sightings.to_json(include: [:bird, :location])
        # this is actually what Rails is doing (passing the .to_json) but it doesn't need to add it because of Rails 'magic'
        # it is exactly the same as: "sightings, include: [:bird, :location]"
    end
    
    def show
        sighting = Sighting.find_by(id: params[:id])
        # render json: sighting
        # render json: { id: sighting.id, bird: sighting.bird, location: sighting.location }
        # render json: sighting, include: [:bird, :location] # another option than above
        if sighting
            # render json: sighting.to_json(include: [:bird, :location])

            # we can combine include, only, and exclude
            # render json: sighting, include: [:bird, :location], except: [:updated_at] #this excludes the updated_at from just the sighting, not from bird or location

            # to exclude all updated_at (from sighting, bird, and location)
            # nesting into the options, so the included bird and location data can have their own options listed
            render json: sighting.to_json(:include => {
                :bird => {:only => [:name, :species]},
                :location => {:only => [:latitude, :longitude]}
            }, :except => [:updated_at])
        else
            render json: { message: "No sighting found with that id" }
        end
    end
end
