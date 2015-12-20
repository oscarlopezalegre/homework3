require 'carrierwave/orm/activerecord'


class Event < ActiveRecord::Base
  belongs_to :venue
  belongs_to :category
  belongs_to :user
  has_many :ticket_types
  validates :ticket_types, :length => { :minimum => 1 }


  accepts_nested_attributes_for :ticket_types, allow_destroy: true
  accepts_nested_attributes_for :venue

  validates_presence_of :extended_html_description, :venue, :category, :starts_at
  validates_uniqueness_of :name, uniqueness: {scope: [:venue, :starts_at]}



  def self.upcoming_events
  	where(" ends_at >= ? AND published=true ", Time.new.inspect )
  end

  def self.search_upcoming_events(search_in)
  	upcoming_events.where(" UPPER(name) like UPPER(?) AND published=true", '%'+search_in.html_safe+'%' )
  end
  def self.pending_event(user_in)
    where("user = ? AND published = FALSE", user_in)
  end

  def self.search_my_events(user_in)
    where("user_id = ?", user_in)
  end

  def self.is_published(event_in)
    where("id = ? AND published=TRUE", event_in).length>0
  end

end
