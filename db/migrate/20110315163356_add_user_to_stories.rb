class AddUserToStories < ActiveRecord::Migration
  def self.up
    add_column :stories, :user_id, :integer
    add_index  :stories, :user_id
  end

  def self.down
    remove_index  :stories, :user_id
    remove_column :stories, :user_id
  end
end

