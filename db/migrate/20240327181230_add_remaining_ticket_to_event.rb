class AddRemainingTicketToEvent < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :remaining_ticket, :integer, default: 0
  end
end
