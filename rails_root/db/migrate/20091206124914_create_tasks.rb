class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.string :seed_url
      t.integer :number
      t.string :charset, :default => 'gb2312'

      t.timestamps
    end
  end

  def self.down
    drop_table :tasks
  end
end
