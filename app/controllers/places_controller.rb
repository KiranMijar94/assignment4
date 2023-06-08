class PlacesController < ApplicationController

  def index
    @places = Place.all
    @current_user = User.find_by({ "id" => session["user_id"] })
  end

  def show
    @place = Place.find_by({ "id" => params["id"] })
    @posts = Post.where({ "place_id" => @place["id"], "user_id" => session["user_id"] })
  end

  def new
    @place = Place.new
  end

  def create
    @place = Place.new(place_params)
    @place.created_at = Time.now
    @place.updated_at = Time.now
   if @place.save
    redirect_to "/places"
   else
      @places = Place.all
      render :action => 'new'
   end
  end

  def delete
    Place.find(params[:name]).destroy
    redirect_to :action => 'index'
  end

  def place_params
    params.require(:place).permit(:name)
  end

end
