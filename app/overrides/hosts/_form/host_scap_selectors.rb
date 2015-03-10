Deface::Override.new(:virtual_path => "hosts/_form",
                     :name         => "compliance_tab",
                     :insert_after => ".nav li:last",
                     :text         => "<li><a href='#compliance' data-toggle='tab'><%= _('Compliance') %></a></li>")

Deface::Override.new(:virtual_path => "hosts/_form",
                     :name         => "host_form_compliance",
                     :insert_after => ".tab-content #info",
                     :partial         => "host_overrides/host_compliance")

