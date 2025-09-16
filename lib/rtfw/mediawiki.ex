defmodule Rtfw.Mediawiki do
  @endpoint "#{Rtfw.mediawiki_url()}/api.php"

  def query(q) do
    IO.puts ("Fetching from wiki...")
    params = [
      action: "query",
      list: "search",
      srsearch: q,
      format: "json"
    ]

    case Req.get(@endpoint, params: params) do 
      {:ok, %{status: 200, body: body}}
        -> handle_response(body)
      {:error, reason} ->
        IO.puts "Rtfw.Mediawiki: Mediawiki request failed: #{inspect(reason)}"
        {:error, :request_failed}
    end
  end

  defp handle_response(%{"query" => %{"searchinfo" => %{"totalhits" => 0}}}) do
    IO.puts "No results from wiki"
    {:no_results, %{}}
  end

  defp handle_response(%{"query" => %{"search" => [best | _]}}) do
    IO.puts "Getting page extract..."
    title = best["title"]

    extract_params = [
      action: "query",
      prop: "extracts",
      explaintext: true,
      exsentences: 2,
      format: "json",
      titles: title
    ]

    case Req.get(@endpoint, params: extract_params) do
      {:ok, %{status: 200, body: %{"query" => %{"pages" => pages}}}} ->
        page = pages |> Map.values() |> hd()
        extract = page["extract"]

        if extract && extract != "" do
          {:ok, %{title: title, extract: extract}}
        else
          {:no_results, %{}}
        end

      _ ->
        {:no_results, %{}}
    end
  end

  defp handle_response(_body) do
    IO.puts "Unexpected response format"
    {:error, :unexpected_response_format}
  end
end

