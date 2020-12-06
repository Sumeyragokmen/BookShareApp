class AddUserIdToBooks < ActiveRecord::Migration[6.0]
  def change
  	change_table :books do |t|
      t.string :user_id
    end
  end
end
