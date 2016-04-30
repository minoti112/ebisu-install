class CreateAppClients < ActiveRecord::Migration
  def change
    create_table :app_clients do |t|
      t.integer :app_client_id
      t.string :clinet_no
      t.string :refresh_token
      t.integer :created_user
      t.integer :updated_user

      t.timestamps null: false
    end
  end
end
