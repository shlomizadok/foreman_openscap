module ForemanOpenscap
  module HostCommon
    extend ActiveSupport::Concern

    included do
      accepts_nested_attributes_for :asset

      def asset_attributes=(asset_attributes)
        asset = get_asset
        asset.update_attribute(:proxy_id, asset_attributes[:proxy_id])
        asset.policy_ids = asset_attributes[:policy_ids] unless asset_attributes[:policy_ids].empty?
      end

      def asset
        super || build_asset
      end
    end
  end
end