![Build Status](https://github.com/amattn/ElixirSlackWebAPI/actions/workflows/elixir.yml/badge.svg)


# ElixirSlackWebAPI

This is a Slack [Web API][] client for Elixir.

It is derived from the work of Blake Williams and other contributors in the [Elixir-Slack][] repo.  This repo is not a fork, but a new library that borrows generously from their work.  Significantly, it remotes support for deprecated RTM Slack bots and focuses on being an up-to-date Slack Web API Client.

[Web API]: https://api.slack.com/web
[Elixir-Slack]: https://github.com/BlakeWilliams/Elixir-Slack

## Installing

Add Slack to your `mix.exs` `dependencies` function.

```elixir
def application do
  [extra_applications: [:logger]]
end

def deps do
  [{:slack_web, "~> 0.1"}]
end
```

## Web API Usage

The complete Slack Web API is implemented by generating modules/functions from
the JSON documentation. You can view this project's [documentation] for more
details.

[documentation]: http://hexdocs.pm/slack_web/

You'll need a Slack API token which can be retrieved by following the [Token Generation Instructions].  Be aware there are two types of tokens that you can use, user tokens and bot tokens.  For more information on the differences, see the [section on WebAPI in post making Slack apps][tokens] or the official Slack [doc page on tokens][slack_tokens].

[Token Generation Instructions]: https://hexdocs.pm/slack/token_generation_instructions.html
[tokens]: https://amattn.com/p/making_a_slack_app_interaction_bot_in_2021.html#web_api
[slack_tokens]: https://api.slack.com/authentication/token-types

There are two ways to authenticate your API calls. You can configure `api_token`
on `slack` that will authenticate all calls to the API automatically.

```elixir
# bot user token:
config :slack_web, api_token: "xoxb-XXXXXXXXXX-YYYYYYYY..."

# user token:
config :slack_web, api_token: "xoxp-XXXXXXXXXX-YYYYYYYY..."
```

Alternatively you can pass in `%{token: "VALUE"}` to any API call in
`optional_params`. This also allows you to override the configured `api_token`
value if desired.

Quick example, getting the names of everyone on your team:

```elixir
names = SlackWeb.Users.list(%{token: "TOKEN_HERE"})
|> Map.get("members")
|> Enum.map(fn(member) ->
  member["real_name"]
end)
```

### Web Client Configuration

A custom client callback module can be configured for cases in which you need extra control
over how calls to the web API are performed. This can be used to control timeouts, or to add additional
custom error handling as needed.

```elixir
config :slack_web, :web_http_client, YourApp.CustomClient
```

All Web API calls from documentation-generated modules/functions will call `post!/2` with the generated url
and body passed as arguments.

In the case where you only need to control the options passed to HTTPoison/hackney, the default client accepts
a keyword list as an additional configuration parameter. Note that this is ignored if configuring a custom client.

See [HTTPoison docs](https://hexdocs.pm/httpoison/HTTPoison.html#request/5) for a list of available options.

```elixir
config :slack_web, :web_http_client_opts, [timeout: 10_000, recv_timeout: 10_000]

# or set a proxy
config :slack_web, :web_http_client_opts, 
  [proxy: {"127.0.0.1", 9090}],
  hackney: [{:ssl_options, [{:cacertfile, "/path_to_cert/your_cert.pem"}]}]
```

## RTM (Bot) Usage

This fork removes RTM support as Slack has deprecated support for the RTM API.

Please use a different fork if you need RTM support such as this original repo this package was forked from: https://github.com/BlakeWilliams/Elixir-Slack


