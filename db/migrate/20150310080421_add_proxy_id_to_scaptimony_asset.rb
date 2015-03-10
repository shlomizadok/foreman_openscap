class AddProxyIdToScaptimonyAsset < ActiveRecord::Migration
  def change
    add_column :scaptimony_assets, :proxy_id, :integer
  end
end
