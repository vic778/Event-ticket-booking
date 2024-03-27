class BookingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @bookings = Rails.cache.fetch("bookings", expires_in: 5.minutes) do
      current_user.bookings.includes(:event)
    end
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = current_user.bookings.create(bookings_params)
    @booking.ticket_number = @booking.generate_reference
    
    if @booking.save
      update_remaining_ticket(@booking, @booking.event)
      redirect_to bookings_path, notice: 'Booking was successfully created.'
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
