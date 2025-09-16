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

  def patch(endpoint, body) do
    url = Constants.base_url() <> endpoint
    Req.patch(url, json: body, headers: default_headers())
  end

  def edit_message(channel_id, message_id, content) do
    endpoint = "/channels/#{channel_id}/messages/#{message_id}"
    body = %{content: content}
    case patch(endpoint, body) do
      {:ok, response_body} ->
        {:ok, response_body}

      {:error, reason} ->
        {:error, reason}
    end
  end

  def create_message(channel_id, content) do
    endpoint = "/channels/#{channel_id}/messages"
    body = %{content: content}
    case post(endpoint, body) do
      {:ok, %{body: response_body}} ->
        {:ok, response_body}

      {:error, reason} ->
        {:error, reason}

    end

  end

end
