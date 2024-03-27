class Event < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true, length: { minimum: 10 }
  validates :location, :date_and_time, presence: true
  validates :total_tickets, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
