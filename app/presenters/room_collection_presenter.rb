class RoomCollectionPresenter
  delegate :current_page, :num_page, :limit_value, :total_pages, to: :@rooms

  def initialize(contex, rooms)
    @context = contex
    @rooms = rooms
  end

  def to_ary
    @rooms.map do |room|
      RoomPresenter.new(room,@context, false)
    end
  end
end