---
to: snippets/<%=app_name%>-<%=rails_env%>/<%=rails_env%>.rb
---

# Assume all access to the app is happening through a SSL-terminating reverse proxy.
# Can be used together with config.force_ssl for Strict-Transport-Security and secure cookies.
config.assume_ssl = true

# Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
config.force_ssl = true

config.active_storage.service_configurations = {
    amazon_<%=rails_env%>: {
      service: "S3",
      access_key_id: Rails.application.credentials.<%=rails_env%>&.dig(:aws, :access_key_id),
      secret_access_key: Rails.application.credentials.<%=rails_env%>&.dig(:aws, :secret_access_key),
      region: "<%=aws_region%>",
      bucket: "<%=platform_name%>-<%=app_name%>-<%=rails_env%>-bucket"
    }
  }
config.active_storage.service = :amazon_<%=rails_env%>