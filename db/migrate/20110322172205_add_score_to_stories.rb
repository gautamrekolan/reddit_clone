class AddScoreToStories < ActiveRecord::Migration
  def self.up
    add_column :stories, :score, :integer, :default => 0
  end

  def self.down
    remove_column :stories, :score
  end
end
