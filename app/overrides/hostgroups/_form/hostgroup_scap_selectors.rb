Deface::Override.new(:virtual_path => "hostgroups/_form",
                     :name         => "compliance_tab",
                     :insert_after => ".nav li:last",
                     :text         => "<li><a href='#compliance' data-toggle='tab'><%= _('Compliance') %></a></li>")

Deface::Override.new(:virtual_path => "hostgroups/_form",
                     :name         => "hostgroup_form_compliance",
                     :insert_after => ".tab-content div.tab-pane:last",
                     :partial      => "host_overrides/host_compliance")

