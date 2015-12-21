class TicketsController < ApplicationController
  def new
  	if request_user_logged
   		@event = Event.find(params[:event_id])
   	end
  end
end
