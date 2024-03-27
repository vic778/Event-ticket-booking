class BookingsController < ApplicationController
  before_action :authenticate_user!

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
    @event = Event.find(params[:event_id])
    @booking = current_user.bookings.create(bookings_params)
    @booking.event = @event
    @booking.ticket_number = @booking.generate_reference

    if @booking.save
      update_remaining_ticket(@booking, @booking.event)
      redirect_to my_bookings_path, notice: 'Booking was successfully created.'
    else
      render :new
    end
  end

  protected

  def bookings_params
    params.require(:booking).permit(:event_id, :ticket_quantity)
  end

  def update_remaining_ticket(booking, event)
    event.remaining_ticket -= booking.ticket_quantity
    event.save
  end
end
