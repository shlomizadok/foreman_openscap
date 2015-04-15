---
layout: page
title: Design
countheads: true
toc: true
comments: true
baseurl: /foreman_openscap/
---

Distribute SCAP content
=======================

Preface
--------
In the current state of foreman_openscap, a user can upload scap_content to foreman_openscap. Yet the user needs also to upload the same content to the client host and save it in the location that puppet-foreman_scap_client expects it to be.

Design
------
![scap design](/static/images/scap_design.png)

A user uploads scap content and creates policy. The policy is configuring puppet module with the policy id, policy profile and file location. This configuration is applied to foreman_scap_client.

**Content distribution:**

- Expose a url on Satellite for downloading the scap file for the policy (/api/compliance/policies/<policy_id>/content)
- OpenSCAP plugin on Proxy serves as a (dumb) proxy to the above url (meaning, calling something like: https://<proxy_url>/compliance/policies/<policy_id>/content will fetch the xml from https://<foreman_url>/api/compliance/policies/<policy_id>/content)
- When foreman_scap_client starts running, it checks if the file configured by puppet exists. If it exists, it will resume operation. If it doesn't exist, it will download the file from the Proxy and resume its operation.

User Stories
------------

- As a user I want RHEL default content pre-configured in foreman_openscap

- As a user I want to have a rake task which bulk uploads scap contents to foreman_openscap

- As a user I want that scap content will be distributed to the client hosts when I assign 
  a policy to a host / hostgroup

- As a user I want the proxy to serve a proxy for networks without direct connection to Foreman



Handle ARF reports
==================

Design
------

User Stories
------------

