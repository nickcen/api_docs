class CreateWorkers < ActiveRecord::Migration
  def change
    create_table :workers do |t|
      t.string :sso_id
      t.string :name
      t.string :email
      t.boolean :is_admin, default:false
      t.boolean :is_developer, default:false
      t.boolean :is_tester, default:false

      t.timestamps
    end

    add_index :workers, :sso_id
  end
end
