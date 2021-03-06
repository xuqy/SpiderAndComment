class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.integer :task_id
      t.string :url
      t.text :html
      t.integer :size
      t.string :title, :default => '无标题'

      t.timestamps
    end
  end

  def self.down
    drop_table :pages
  end
end
