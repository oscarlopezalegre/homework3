class PurchaseController < ApplicationController
  def new

    if request_user_logged
      	@event = Event.find(params[:eventid])
  	    @event_types = {}
        @event.ticket_types.each do |type|
      	key = "type_id_"+type.id.to_s
      	@event_types[key] = params[key]
      end
    end
  end

  def create
    if request_user_logged
      @event = Event.find(params[:eventid])  
      if event_in_past
            flash[:warning] = "Purchase error"        
        return
      end
      if check_quantity_error
            flash[:warning] = "Purchase error"        
        return 
      end
      @event.ticket_types.each do |type|
        key = "type_id_"+type.id.to_s
        quantity = params[key].to_i
        if quantity>0
          p = Purchase.new(:quantity => quantity, :event_id => @event.id, :total_price => quantity*type.price,:ticket_type_id => type.id )
          if p.save
            flash[:success] = "Purchase Success"        
          # success
          else
            flash[:warning] = "Purchase error"        
          end
        end

      end
    end
  end

  def show
  end

  def event_in_past
    if @event.ends_at < Time.new.inspect
      #you can't purchase on event in the past 
      redirect_to root_path
      return true
    end
  end

  def quantity_limit(t,q)
    sold = Purchase.sold(@event.id,t.id)
    if ((t.max_quantity - sold)<q) or (q>10)
      #quantity can't be sold
      return true
    end
    return false
  end

  def check_quantity_error()
    @event.ticket_types.each do |type|
      key = "type_id_"+type.id.to_s
      quantity = params[key].to_i
      if quantity_limit(type,quantity)
        #at least one ticket can be sold therefore we redirect
        redirect_to root_path
        return true
      end
    end
    return false  
  end


end
