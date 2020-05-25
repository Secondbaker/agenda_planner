class AddTypeToAgendaEvent < ActiveRecord::Migration[6.0]
  def change
    add_column :agenda_events, :type, :string
  end
end
