class CreateAppClients < ActiveRecord::Migration
  def change
    create_table :app_clients do |t|
      t.string :clinet_no
      t.string :refresh_token

      t.timestamps null: false
    end
  end
end
