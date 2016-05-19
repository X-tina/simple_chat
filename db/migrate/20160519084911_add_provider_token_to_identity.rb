class AddProviderTokenToIdentity < ActiveRecord::Migration
  def self.up
    add_column :identities, :provider_token, :string
  end

  def self.down
    remove_column :identities, :provider_token
  end
end
