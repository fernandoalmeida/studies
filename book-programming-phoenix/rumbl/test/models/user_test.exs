defmodule Rumbl.UserTest do
  use Rumbl.ModelCase, async: true
  alias Rumbl.User

  @valid_attrs %{name: "name", username: "user", password: "pass123"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)

    assert changeset.valid?
  end

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)

    refute changeset.valid?
  end

  test "registration_changeset password must be at least 6 chars long" do
    attrs = Map.put(@valid_attrs, :password, "12345")
    changeset = User.registration_changeset(%User{}, attrs)

    assert {:password, {"should be at least %{count} character(s)", count: 6}}
    in changeset.errors
  end

  test "registration_changeset with valid attributes hashes the password" do
    changeset = User.registration_changeset(%User{}, @valid_attrs)

    %{password: password, password_hash: password_hash} = changeset.changes

    assert password_hash
    assert Comeonin.Bcrypt.checkpw(password, password_hash)
  end
end
