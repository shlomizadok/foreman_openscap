require 'pry'
module ForemanOpenscap
  module HostsHelperExtensions
    extend ActiveSupport::Concern

    included do
      alias_method_chain :multiple_actions, :scap
    end

    Colors = {
        :passed  => '#89A54E',
        :failed  => '#AA4643',
        :othered => '#DB843D',
    }

    def multiple_actions_with_scap
      multiple_actions_without_scap + [[_('Assign Compliance Policy'), select_multiple_hosts_scaptimony_policies_path],
                                       [_('Unassign Compliance Policy'), disassociate_multiple_hosts_scaptimony_policies_path]]

    end

    def host_policy_breakdown_chart(report, options = {})
      data = []
      [[:passed, _('Passed')],
       [:failed, _('Failed')],
       [:othered, _('Other')],
      ].each { |i|
        data << {:label => i[1], :data => report[i[0]], :color => Colors[i[0]]}
      }
      flot_pie_chart 'overview', _('Compliance reports breakdown'), data, options
    end

    def host_arf_reports_chart(policy_id)
      passed, failed, othered, = [], [], []
      @host.arf_reports.of_policy(policy_id).each do |report|
        passed  << [report.created_at.to_i*1000, report.passed]
        failed  << [report.created_at.to_i*1000, report.failed]
        othered << [report.created_at.to_i*1000, report.othered]
      end
      [{:label => _("Passed"), :data => passed, :color => Colors[:passed]},
       {:label => _("Failed"), :data => failed, :color => Colors[:failed]},
       {:label => _("Othered"), :data => othered, :color => Colors[:othered]}]
    end

    def openscap_proxies(form)
      proxies = SmartProxy.unscoped.with_features("Openscap").with_taxonomy_scope(@location,@organization,:path_ids)
      return if proxies.count == 0
      select_f form, :proxy_id, proxies, :id, :name,
               { :include_blank => _('Select openscap proxy'), :selected => inherited_proxy(form.object) },
               { :label       => _("OpenSCAP proxy"),
                 :help_inline => _("Use this openscap server as the Server or to recieve arf reports for this host.") }
    end

    def openscap_policies(form)
      multiple_selects(form, :policies, Scaptimony::Policy.unscoped,
                       host_combined_policies(form.object),
                       {:disabled => inherited_policies(form.object) })
    end

    def inherited_proxy(object)
      if object.assetable.is_a?(Host::Base) && object.assetable.hostgroup.asset && object.assetable.hostgroup.asset.proxy
        object.assetable.hostgroup.asset.proxy.id
      end
    end

    def inherited_policies(object)
      if object.assetable.is_a?(Host::Base)
        object.assetable.hostgroup.policy_ids
      end
    end

    def host_combined_policies(object)
      # binding.pry
      if object.assetable.is_a?(Host::Base)
        object.assetable.combined_policies.map(&:id)
      else
        object.policy_ids
      end
    end
  end
end
