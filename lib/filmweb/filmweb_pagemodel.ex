defmodule Filmweb.PageModel do
  use Wallaby.DSL

  defstruct [:current_page]

  @base_url "https://www.filmweb.pl"

  def new() do
    %__MODULE__{
      current_page: :home
    }
  end

  def get_wanted_list(username, {session, _} = state) do
    go_to_user_page(username, state)

    current_url_value = session |> current_url()

    session |> visit("#{current_url_value}/wantToSee")

    {:ok, state}
  end

  defp get_wanted_elements({session, _} = state) do
    session
    |> find_all(Query.css(".filmPreview__title"))
    |> Enum.map(fn element ->
      element
      |> Element.attribute("href")
      |> URI.decode()
      |> String.split("/")
      |> List.last()
      |> String.to_integer()
    end)
  end

  def accept_cookies({session, _} = state) do
    session
    |> find(Query.css("#didomi-notice-agree-button"))
    |> Element.click()

    {:ok, state}
  end

  def bypass_ads({session, _} = state) do
    :timer.sleep(5000)

    session
    |> find(Query.text("Przejdź do Filmwebu teraz"))
    |> Element.click()

    {:ok, state}
  end

  def go_home({session, struct}) do
    session
    |> visit(@base_url)

    {:ok,
     {
       session,
       struct |> Map.put(:current_page, :home)
     }}
  end

  def go_to_user_page(
        username,
        {session,
         %{
           current_page: :home
         } = struct}
      ) do
    session
    |> visit("#{@base_url}/user/#{username}")

    new_stuct = struct |> Map.put(:current_page, :user_page)

    {:ok, {session, new_stuct}}
  end

  def go_to_user_page(username, state) do
    go_home(state)
    go_to_user_page(username, state)
  end
end
