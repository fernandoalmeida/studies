defmodule Rumbl.UserView do
  use Rumbl.Web, :view

  def render("user.json", %{user: user}) do
    %{id: user.id, username: user.username}
  end
end
