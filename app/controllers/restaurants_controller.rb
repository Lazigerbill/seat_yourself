class RestaurantsController < ApplicationController
	before_action :load_restaurant, only: [:show, :edit, :update, :destroy]

	def index
		@restaurants = Restaurant.all
	end

	def show
	end

	def new
		@restaurant = Restaurant.new
	end

	def create
		@restaurant = Restaurant.new(restaurant_params)

		if @restaurant.save
			redirect_to restaurant_path(@restaurant), notice: "Let's make some food"
		else
			render :new, alert: "Something went wrong!!"
		end
	end

	def edit
	end

	def update
		if @restaurant.update(restaurant_params)
			redirect_to restaurant_path(@restaurant), notice: "Information updated."
		else
			render :edit, alert: "Something went wrong!!"
		end
	end

	def destroy
		session[:user_id] = nil
		@restaurant.destroy
		redirect_to root_path, notice: "Sad to see you go!" 
	end

	private

	def restaurant_params
		params.require(:restaurant).permit(:name, :email, :password, :password_confirmation, :capacity, :address, :city, :province, :postal_code)
	end

	def load_restaurant
		@restaurant = Restaurant.find(params[:id])
	end
end