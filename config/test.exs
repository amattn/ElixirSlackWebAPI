use Mix.Config

# Print only warnings and errors during test
config :logger, level: :warn, truncate: :infinity

# Here's an example of configuring this library to route requests through a Proxyman.io proxy.
# https://proxyman.io

# config :slack_web,
#        :web_http_client_opts,
#        proxy: {"127.0.0.1", 9090},
#        hackney: [{:ssl_options, [{:cacertfile, "/path_to_cert/your_cert.pem"}]}]
