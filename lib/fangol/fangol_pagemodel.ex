defmodule Fangol.PageModel do
  use Wallaby.DSL

  defstruct [:page, :posts]

  def new() do
    %__MODULE__{page: 0, posts: []}
  end

  defp process_post(post) do
    title =
      post
      |> find(Query.css("header h1"))
      |> Element.text()

    {hour_string, date_string} =
      case post
           |> find(Query.css(".throw-time span", count: 3)) do
        [hour, _, date] ->
          {hour |> Element.text(), date |> Element.text()}

        _ ->
          {"", ""}
      end

    hour_string =
      case hour_string |> String.length() do
        4 -> "0#{hour_string}"
        _ -> hour_string
      end

    IO.puts("#{date_string} #{hour_string}:00")
    {:ok, naive} = NaiveDateTime.from_iso8601("#{date_string} #{hour_string}:00")

    {:ok, datetime} =
      naive
      |> DateTime.from_naive("Etc/UTC")

    type =
      post
      |> find(Query.css("span.throw-type"))
      |> Element.text()

    img =
      post
      |> all(Query.css("img"))
      |> List.first()
      |> Element.attr("src")

    tags =
      post
      |> all(Query.css("li.tags"))
      |> Enum.map(&Element.text/1)

    text =
      post
      |> all(Query.css(".quote-text-container", visible: :any, minimum: 0, maximum: 1))
      |> List.first()
      |> (fn
            maybe_elem ->
              case maybe_elem do
                nil -> ""
                elem -> Element.text(elem)
              end
          end).()

    %{
      type: type,
      title: title,
      datetime: datetime,
      img: img,
      tags: tags,
      text: text
    }
  end

  def get_posts({session, _struct} = state) do
    sessions =
      session
      |> all(Query.css("section.preview-container"))
      |> Enum.map(&process_post/1)
      |> IO.inspect()

    {sessions, state}
  end
end
