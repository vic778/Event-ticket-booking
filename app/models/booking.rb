class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :event

  def generate_reference
    loop do
      random_code = 6.times.map { rand(0..9) }.join
      break random_code if Booking.where(ticket_number: random_code).count.zero?
    end
  end
end
