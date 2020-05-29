class AddConfirmableToDevise < ActiveRecord::Migration[6.0]
  def up
    
    add_column :users, :unconfirmed_email, :string 
    add_index :users, :confirmation_token, unique: true
    
  end

  def down
    remove_column :users, :unconfirmed_email, :string 
    remove_index :users, :confirmation_token
  end
end
