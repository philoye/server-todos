class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.string    :text
      t.integer  :order
      t.boolean  :done
      t.timestamps
    end

  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
