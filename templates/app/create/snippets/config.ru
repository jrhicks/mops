---
to: snippets/<%=app_name%>/config.ru
---
require_relative 'config/environment'
use Yabeda::Prometheus::Exporter
run Rails.application
Rails.application.load_server