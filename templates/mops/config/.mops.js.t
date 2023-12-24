---
to: .mops.js
---

// make-ops config

module.exports = {
  platform_name: '<%= platform_name %>',
  aws_region: '<%= aws_region %>',
  aws_profile: '<%=platform_name%>',
  aws_vpc_cidr: '<%= aws_vpc_cidr %>',
  aws_account_id: '',
  public_domain: '',
  hosted_zone_id: '',
  github_owner: '<%= github_owner %>',
  github_repo_name: '<%= github_repo_name %>',
  github_flux_user: '',
  github_flux_email: '',
}