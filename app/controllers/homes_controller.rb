class HomesController < ApplicationController
  def index

   @car  = Car.where(status: false)
   
   @car_req = @car.map{|h| {lat: h.latitude, lng: h.longitude, infowindow: "I am available", width: 32, height: 32}}
   
   @car_req = @car_req.to_json.html_safe

  end

  def get_car

    is_pink = params[:is_pink] == "1" ? true : false
  	start_cordinate = Geocoder.coordinates(params[:start_location])
  	end_cordinate = Geocoder.coordinates(params[:end_location]) 
  	@car  = Car.where(status: false, is_pink: is_pink)
    @detail = []
  	@car.each do |k|
  	  lat_long = [k.latitude.to_f, k.longitude.to_f]	
      @detail <<  {id: k.id, diff: Geocoder::Calculations.distance_between(start_cordinate, lat_long)}
    end
    if @detail.present?
    temp = @detail.sort_by{|h| h[:diff]}
    car_req = [] << Car.find_by_id(temp.first[:id])
    car_req = car_req.map{|h| {lat: h.latitude, lng: h.longitude, infowindow: "I am available", width: 32, height: 32}}
    @car_req = car_req.to_json.html_safe
    @car_id =  temp.first[:id]
    @distance =  temp.first[:diff]
    else
      flash[:error] = "No Car available..."
      redirect_to :back
    end
  end

  def start_trip
  	@car = Car.find_by_id(params[:car_id])
    @car.update(status: true)
    distance = params[:distance].to_f * 1.60934
    @car.trips.create(start_time: Time.now, distance: distance)
    @car_id = params[:car_id]
  	render :nothing => true
  end

   def end_trip
    @car = Car.find_by_id(params[:car_id])
    trip = @car.trips.last
    start_time = trip.start_time
    end_time = Time.now
    diff_time = (end_time - start_time) / 60
    price = trip.distance.to_f * 2
    price = (price + 5 ) if @car.is_pink == true
    trip.update(end_time: Time.now, price: price)
  	@car.update(status: false)
    render :nothing => true
  end
end
