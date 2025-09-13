import Config

token_path = Path.join(__DIR__, "token.key")

config :nostrum,
  token: token_path |> File.read!() |> String.trim(),
  num_shards: :auto,
  ffmpeg: nil,
  youtubedl: nil,
  gateway_intents: :all

config :logger, :console,
  metadata: [:shard, :guild, :channel]
