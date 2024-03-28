class Event < ApplicationRecord
  extend FriendlyId
  lock_optimistically
  friendly_id :name, use: :slugged

  belongs_to :user
  has_many :bookings, dependent: :destroy

  before_save :set_remaining_ticket, if: -> { new_record? }

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true, length: { minimum: 10 }
  validates :location, :date_and_time, presence: true
  validates :total_tickets, presence: true, numericality: { only_integer: true, greater_than: 0 }

  def available_for_booking?
    remaining_ticket.positive?
  end

  protected

  def set_remaining_ticket
    self.remaining_ticket = total_tickets
  end
end
