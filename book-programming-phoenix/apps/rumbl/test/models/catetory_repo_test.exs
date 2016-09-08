defmodule Rumbl.CatetoryRepoTest do
  use Rumbl.ModelCase
  alias Rumbl.Category

  test "alphabetical orders by name" do
    Repo.insert!(%Category{name: "c"})
    Repo.insert!(%Category{name: "b"})
    Repo.insert!(%Category{name: "a"})

    query = Category |> Category.alphabetical()
    query = from c in query, select: c.name

    assert Repo.all(query) == ~w(a b c)
  end
end
