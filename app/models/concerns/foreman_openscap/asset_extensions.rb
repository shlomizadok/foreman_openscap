#
# Copyright (c) 2014 Red Hat Inc.
#
# This software is licensed to you under the GNU General Public License,
# version 3 (GPLv3). There is NO WARRANTY for this software, express or
# implied, including the implied warranties of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. You should have received a copy of GPLv3
# along with this software; if not, see http://www.gnu.org/licenses/gpl.txt
#

require 'scaptimony/asset'

module ForemanOpenscap
  module AssetExtensions
    extend ActiveSupport::Concern
    included do
      belongs_to :assetable, :polymorphic => true
      scope :hosts, where(:assetable_type => 'Host::Base')
      belongs_to :proxy, :class_name => "SmartProxy"
      default_scope includes(:policies)
    end

    def host
      fetch_asset('Host::Base')
    end

    def name
      assetable.name
    end

    def proxy_url
      proxy.url if proxy
    end

    def server
      URI.parse(proxy_url).host if proxy
    end

    def port
      URI.parse(proxy_url).port if proxy
    end

    private
    def fetch_asset(type)
      assetable if assetable_type == type
    end
  end
end
