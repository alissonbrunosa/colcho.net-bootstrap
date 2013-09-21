class Rooms::ReviewsController < Rooms::BaseController


	def create 
		review = room.reviews.find_or_initialize_by_user_id(current_user.id)
		review.update_attributes!(params[:review])
		head :ok
	end

	def update
		create
	end

	def show
		@room = Room.find([:id])

		if user_signed_in? 
			@user_review = @room.reviews.find_or_initialize_by_user_id(current_user.id)
		end
	
	end

end