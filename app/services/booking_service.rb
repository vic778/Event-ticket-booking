class BookingService
  attr_reader :event, :current_user, :bookings_params
  attr_accessor :booking

  def initialize(current_user, event, bookings_params)
    @event = event
    @current_user = current_user
    @bookings_params = bookings_params
    @booking = current_user.bookings.build(bookings_params)
  end

  def call
    booking.event = event
    booking.ticket_number = booking.generate_reference

    event.with_lock do
      if enough_tickets_available?
        booking.save!
        update_remaining_ticket(booking, event)
        booking
      else
        booking.errors.add(:base, 'Not enough tickets available')
      end
    end
  end

  private

  def enough_tickets_available?
    event.remaining_ticket >= booking.ticket_quantity
  end

  def update_remaining_ticket(booking, event)
    remaining_tickets = event.remaining_ticket - booking.ticket_quantity
    event.update!(remaining_ticket: remaining_tickets)
  end
end
