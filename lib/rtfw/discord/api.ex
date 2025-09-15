defmodule Rtfw.Discord.Api do
  alias Rtfw.Discord.Constants

  defp default_headers do
    %{
      "Authorization" => "Bot #{Rtfw.token()}",
      "Content-Type" => "application/json"
    }
  end

  def post(endpoint, body) do 
    url = Constants.base_url() <> endpoint
    Req.post(url, json: body, headers: default_headers())
  end

  def create_message(channel_id, content) do
    endpoint = "/channels/#{channel_id}/messages"
    body = %{content: content}
    post(endpoint, body)
  end

end
