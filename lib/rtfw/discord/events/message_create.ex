defmodule Rtfw.Discord.Events.MessageCreate do
  alias Rtfw.Discord, as: Discord

  def handle(%{"d" => msg}, state) do
    # https://discord.com/developers/docs/resources/message
    content = msg["content"]
    channel_id = msg["channel_id"]

    cond do
      msg["author"]["bot"] -> {:ok, state}
      not String.starts_with?(content, Rtfw.prefix()) -> {:ok, state}
      true ->
        query = String.trim_leading(content, Rtfw.prefix())
        process_query(query, channel_id)
        {:ok, state}
    end

  end


  defp process_query(query, channel_id) do
    query = String.downcase(query)
    if query == "-info" do
      Discord.Api.create_message(channel_id, "**Built by [reinitd](https://github.com/reinitd).**\n**Repo: **https://github.com/the-holy-church-of-terry-davis/rtfw")
    
    else
      Discord.Api.create_message(channel_id, "Searching wiki...")
    end

  end

end
