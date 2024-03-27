class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_event, only: :create

  def index
    @bookings = Rails.cache.fetch("bookings", expires_in: 5.minutes) do
      current_user.bookings.includes(:event)
    end
  end

  def new
    @event = Event.find(params[:event_id])
    @booking = @event.bookings.new
  end

  def create
    @booking = BookingService.new(current_user, @event, bookings_params).call
    if @booking.present?
      redirect_to my_bookings_path, notice: 'Booking was successfully created.'
    else
      render :new
    end
  end

  protected

  def find_event
    @event = Event.find(params[:event_id])
  end

  def bookings_params
    params.require(:booking).permit(:event_id, :ticket_quantity)
  end
end
