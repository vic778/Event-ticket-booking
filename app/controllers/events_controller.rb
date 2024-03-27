class EventsController < ApplicationController
  def index
     @events = Rails.cache.fetch('events', expires_in: 1.hour) do
      Event.all.order("name ASC")
    end
  end
end
