class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_event, only: %i[show edit update destroy]

  def index
    @events = Rails.cache.fetch('events', expires_in: 1.hour) do
      Event.all.order("name ASC")
    end
  end

  def current_user_events
    @events = Rails.cache.fetch('current_user_events', expires_in: 1.hour) do
      current_user.events.order(created_at: :desc)
    end
  end

  def show; end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.create(event_params)
    if @event.save
      redirect_to @event, notice: 'Event was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: 'Event was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to events_url, notice: 'Event was successfully destroyed.'
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :description, :location, :date_and_time, :total_tickets, :user_id)
  end
end
