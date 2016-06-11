defmodule Rumbl.Repo do
  @moduledoc """
  In memory repository
  """

  alias Rumbl.User

  def all(User) do
    [
      %User{id: "1", name: "Fernando", username: "fernando", password: 'abc123'},
      %User{id: "2", name: "Denise", username: "denise", password: 'abc123'},
      %User{id: "3", name: "Sofia", username: "sofia", password: 'abc123'}
    ]
  end

  def all(_module), do: []

  def get(module, id) do
    Enum.find(all(module), fn map -> map.id == id end)
  end

  def get_by(module, params) do
    Enum.find(
      all(module),
      fn map ->
	Enum.all?(params, fn {key, val} -> Map.get(map, key) == val end)
      end
    )
  end
end
