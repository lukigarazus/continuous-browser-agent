defmodule Filmweb.BrowserAgentGenServer do
  use BrowserAgentGenServer, [Filmweb.PageModel, "https://www.filmweb.pl"]
end
