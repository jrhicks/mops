---
to: snippets/<%=app_name%>/production.rb
---

# Assume all access to the app is happening through a SSL-terminating reverse proxy.
# Can be used together with config.force_ssl for Strict-Transport-Security and secure cookies.
config.assume_ssl = true

# Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
config.force_ssl = true
