defmodule Rtfw.Discord.Constants do
  @api_base "https://discord.com/api"
  @api_version "10"

  def api_base, do: @api_base
  def api_version, do: @api_version
  def base_url, do: "#{@api_base}/v#{@api_version}"
  def gateway_wss_url, do: "wss://gateway.discord.gg/?v=#{@api_version}&encoding=json"
end
