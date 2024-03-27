class AddTicketNumberToBooking < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :ticket_number, :string
  end
end
