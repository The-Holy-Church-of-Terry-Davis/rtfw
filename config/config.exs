import Config

token_path = Path.join(__DIR__, "token.key")

config :rtfw,
  token: token_path |> File.read!() |> String.trim(),
  prefix: "rtfw ",
  mediawiki_url: "https://wiki.thcotd.org"
