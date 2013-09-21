class HomeController < ApplicationController
  
  def index
  	@rooms = Room.most_recent
  end

end
