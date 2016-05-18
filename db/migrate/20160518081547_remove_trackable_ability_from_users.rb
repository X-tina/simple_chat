class RemoveTrackableAbilityFromUsers < ActiveRecord::Migration
  def self.up
  	remove_column :users, :current_sign_in_ip
  	remove_column :users, :last_sign_in_ip
  end

  def self.down
  	add_column :users, :current_sign_in_ip, :inet
  	add_column :users, :last_sign_in_ip, :inet
  end
end
