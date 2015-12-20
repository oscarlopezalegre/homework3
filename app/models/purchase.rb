class Purchase < ActiveRecord::Base

	def self.sold(event_in, ticket_in)
		where("event_id =? AND ticket_type_id = ?",event_in,ticket_in).sum(:quantity)
	end

end
