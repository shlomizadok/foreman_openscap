require 'scaptimony/asset'

module ForemanOpenscap
  module HostgroupExtensions
    extend ActiveSupport::Concern



    included do
      has_one :asset, :as => :assetable, :class_name => "::Scaptimony::Asset"
      has_many :asset_policies, :through => :asset, :class_name => "::Scaptimony::AssetPolicy"
      has_many :policies, :through => :asset_policies, :class_name => "::Scaptimony::Policy"
      include ForemanOpenscap::HostCommon
    end

    def get_asset
      Scaptimony::Asset.where(:assetable_type => 'Hostgroup', :assetable_id => id).first_or_create!
    end
  end
end
