json.extract! car, :id, :name, :is_pink, :latitude, :longitude, :address, :created_at, :updated_at
json.url car_url(car, format: :json)