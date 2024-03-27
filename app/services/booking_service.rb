class BookingService
  attr_reader :event, :current_user, :bookings_params
  attr_accessor :booking

  def initialize(current_user, event, bookings_params)
    @event = event
    @current_user = current_user
    @bookings_params = bookings_params
    @booking = current_user.bookings.create(bookings_params)
  end

  def call
    booking.event = event
    booking.ticket_number = @booking.generate_reference

    update_remaining_ticket(@booking, @booking.event) if booking.save
    booking
  end

  def update_remaining_ticket(booking, event)
    event.remaining_ticket -= booking.ticket_quantity
    event.save
  end
end
