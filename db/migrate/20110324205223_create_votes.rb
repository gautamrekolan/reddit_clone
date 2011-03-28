class CreateVotes < ActiveRecord::Migration
  def self.up
    create_table :votes do |t|
      
      # our fields
      t.references  :user,                 :null => false
      t.references  :story,                :null => false
      t.string      :up_or_down,           :null => true
      
      # rails fields
      t.timestamps
    end
    
    add_index :votes, [:user_id, :story_id], :unique => true
  end

  def self.down
    drop_table :votes
  end
end
