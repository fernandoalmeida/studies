defmodule AuthTest do
  use Rumbl.ConnCase

  alias Rumbl.Auth

  setup %{conn: conn} do
    conn = conn
    |> bypass_through(Rumbl.Router, :browser)
    |> get("/")

    {:ok, %{conn: conn}}
  end

  test "authenticate_user halts when no current_user exists", %{conn: conn} do
    conn = conn
    |> Auth.authenticate_user([])

    assert conn.halted
  end

  test "authenticate_user continues when current_user exists", %{conn: conn} do
    conn = conn
    |> assign(:current_user, %Rumbl.User{})
    |> Auth.authenticate_user([])

    refute conn.halted
  end

  test "login puts the user in the session", %{conn: conn} do
    conn = conn
    |> Auth.login(%Rumbl.User{id: 123})
    |> send_resp(:ok, "")
    |> get("/")

    assert get_session(conn, :user_id) == 123
  end

  test "logout drops the user from the session", %{conn: conn} do
    conn = conn
    |> put_session(:user_id, 123)
    |> Auth.logout()
    |> send_resp(:ok, "")
    |> get("/")

    refute get_session(conn, :user_id)
  end

  test "call places user from session into assigns", %{conn: conn} do
    user = insert_user()
    conn = conn
    |> put_session(:user_id, user.id)
    |> Auth.call(Repo)

    assert conn.assigns.current_user.id == user.id
  end

  test "call with no session sets current_user to nil", %{conn: conn} do
    conn = conn
    |> put_session(:user_id, nil)
    |> Auth.call(Repo)

    refute conn.assigns.current_user
  end

  test "login with valid username and password", %{conn: conn} do
    user = insert_user(username: "user", password: "pass123")
    {:ok, conn} = conn
    |> Auth.login_by_password("user", "pass123", repo: Repo)

    assert conn.assigns.current_user.id == user.id
  end

  test "login with invalid username", %{conn: conn} do
    assert {:error, :not_found, _conn} =
      Auth.login_by_password(conn, "user", "pass", repo: Repo)
  end

  test "login with invalid password", %{conn: conn} do
    user = insert_user(username: "user", password: "pass123")
    assert {:error, :unouthorized, _conn} =
      Auth.login_by_password(conn, "user", "wrongpass", repo: Repo)
  end
end
