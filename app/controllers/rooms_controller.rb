class RoomsController < ApplicationController

	before_filter :require_authentication, only: [:new, :create, :update, :edit, :destroy]

  PER_PAGES = 6

	
  # GET /rooms

  def index
    @search_query = params[:q]
    rooms = Room.search(@search_query).page(params[:page]).per(PER_PAGES)

    @rooms = RoomCollectionPresenter.new(self, rooms);

	end

  # GET /rooms/1

  def show
    room_model = Room.find(params[:id])
    @room = RoomPresenter.new(room_model, self);
	end

  # GET /rooms/new

  def new
    @room = current_user.rooms.build
  end

  # GET /rooms/1/edit
  def edit
    @room = current_user.rooms.find(params[:id])
  end

  # POST /rooms

  def create
    @room = current_user.rooms.build(params[:room])


      if @room.save
        redirect_to @room, notice: 'Room was successfully created.'
      else
        render action: :new
      end
  end

  # PUT /rooms/1
  def update
    @room = current_user.rooms.find(params[:id])

    
    if @room.update_attributes(params[:room])
    	redirect_to @room, notice: 'Room was successfully updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /rooms/1
  def destroy
    @room = current_user.rooms.find(params[:id])
    @room.destroy
    redirect_to rooms_url
  end



end
