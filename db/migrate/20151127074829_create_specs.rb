class CreateSpecs < ActiveRecord::Migration
  def change
    create_table :specs do |t|
      t.string :version
      t.string :description
      t.text :body

      t.references :app

      t.timestamps
    end
  end
end
