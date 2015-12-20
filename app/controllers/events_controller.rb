class EventsController < ApplicationController
  def index
  	if(params[:search])
		  @events = Event.search_upcoming_events(params[:search])
	  else
   		@events = Event.upcoming_events
	end

  end

  def new
    @editing_event = Event.new
    @editing_event.build_venue()

  end

  def create
    @editing_event = Event.new(event_params)  
    
    if @editing_event.save
      flash[:success] = "Message saved"
      redirect_to myevents_path
    else
      @editing_event.build_venue()
      flash[:warning] = "Error saving"
      render 'new'
    end
  end

  def show_my_events
    @events = Event.search_my_events(session[:userid])
  end


  def show
    @event = Event.find(params[:id])
  end

  def edit
    @editing_event = Event.find(params[:id])
    render 'new'
  end

  def update
    @editing_event = Event.find(params[:id])
    @editing_event.update(event_params)
    if @editing_event.save
      flash[:success] = "Message saved"
      redirect_to myevents_path
    else
      flash[:warning] = "Couldn't edit message"
      redirect_to edit_event_path(params[:id])
    end

  end

  def publish
    @editing_event = Event.find(params[:id])
    @editing_event.published=params[:publish]
    if @editing_event.save
      flash[:success] = "Message published"
      redirect_to myevents_path
    else
      flash[:warning] = "Error publishing"
      redirect_to myevents_path
    end
  end
  


  private
    def event_params
      params.require(:event).permit(:name, :starts_at, :ends_at, :extended_html_description, :category_id,:user_id, 
                                    :hero_image_url, ticket_types_attributes:[:id, :name, :price,:max_quantity,:_destroy],venue_attributes:[:name,:region_id])
  end 
end
