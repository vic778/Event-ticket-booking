class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_event, only: :create

  def index
    @bookings = Rails.cache.fetch("bookings", expires_in: 5.minutes) do
      current_user.bookings.includes(:event)
    end
  end

  def new
    @event = Event.friendly.find(params[:event_id])
    @booking = @event.bookings.new
  end

  def create
    return redirect_to new_event_booking_path(@event), alert: 'Event is not available for booking' unless @event.available_for_booking?
    return redirect_to new_event_booking_path(@event), alert: "Only #{@event.remaining_ticket} tickets are available for Event" if @event.remaining_ticket < bookings_params[:ticket_quantity].to_i

    @booking = BookingService.new(current_user, @event, bookings_params).call
    if @booking.present?
      redirect_to my_bookings_path, notice: 'Booking was successfully created.'
    else
      render :new
    end
  end

  protected

  def find_event
    @event = Event.friendly.find(params[:event_id])
  end

  def bookings_params
    params.require(:booking).permit(:event_id, :ticket_quantity)
  end
end
