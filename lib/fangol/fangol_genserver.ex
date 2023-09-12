defmodule Fangol.BrowserAgentGenServer do
  use BrowserAgentGenServer, [Fangol.PageModel, "https://www.fangol.pl"]
end
