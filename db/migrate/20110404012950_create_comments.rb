class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      
      # our fields
      t.references  :user,                 :null => false
      t.references  :story,                :null => false
      t.text        :comment,              :null => false
      t.integer     :reply_to,             :null => true
      
      # rails fields
      t.timestamps
    end
    
  end

  def self.down
    drop_table :comments
  end
end
