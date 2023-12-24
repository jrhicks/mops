---
to: snippets/<%=app_name%>/yabeda-initializer.rb
---

module Yabeda
  module Prometheus
    class Exporter
      class << self
        def start_metrics_server!(**rack_app_options)
          Thread.new do
            begin
              default_port = ENV.fetch("PORT", 9394)
              app = rack_app(**rack_app_options)
              server = Puma::Server.new(app)
              server.add_tcp_listener(ENV["PROMETHEUS_EXPORTER_BIND"] || "0.0.0.0", ENV.fetch("PROMETHEUS_EXPORTER_PORT", default_port))
              server.run
            rescue Exception => e
              puts "Error starting metrics server: #{e.message}"
              puts "You must have opened console on a pod with an already running app."
            end
          end
        end
      end
    end
  end
end


unless Rails.env.test?
  Yabeda::Prometheus::Exporter.start_metrics_server!
end