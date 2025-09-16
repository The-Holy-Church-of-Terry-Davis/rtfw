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
      search_wiki(query, channel_id)
    end
  end

  defp search_wiki(query, channel_id) do
    case Discord.Api.create_message(channel_id, "Searching the wiki...") do
      {:error, reason} ->
        IO.puts "Rtfw.Discord.Events.MessageCreate: API call failed because: #{inspect(reason)}"
        {:error, reason}

      {:ok, new_message} ->
        m_id = new_message["id"]
        send_response(Rtfw.Mediawiki.query(query), %{q: query, c_id: channel_id, m_id: m_id})

    end
  end

  defp send_response({:no_results, %{}}, details) do
    IO.puts ":no_results from wiki"
    Discord.Api.edit_message(details[:c_id], details[:m_id], "No pages found.")
  end

  defp send_response({:error, :unexpected_response_format}, details) do
    IO.puts ":error from wiki"
    Discord.Api.edit_message(details[:c_id], details[:m_id], "Unexpected response from the API (ping Trollage).")
  end

  defp send_response({:ok, %{title: t, extract: e}}, details) do
    IO.puts ":ok from wiki"
    c_id = details[:c_id]
    m_id = details[:m_id]

    title_with_underscores = String.replace(t, " ", "_")
    encoded_t = URI.encode_www_form(title_with_underscores)
    
    Discord.Api.edit_message(c_id, m_id, "### [#{t}](<#{Rtfw.mediawiki_url()}/wiki/#{encoded_t}>)\n#{e}")
  end 

end
