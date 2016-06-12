defmodule Rumbl.VideoControllerTest do
  use Rumbl.ConnCase

  alias Rumbl.Video
  @valid_attrs %{description: "description", title: "title", url: "url"}
  @invalid_attrs %{}

  setup %{conn: conn} = config do
    if username = config[:login_as] do
      user = insert_user(username: username)
      conn = assign(conn, :current_user, user)

      {:ok, conn: conn, user: user}
    else
      :ok
    end
  end

  test "requires user authentication on all actions", %{conn: conn} do
    video = insert_video(insert_user(), title: "foo")
    Enum.each([
      get(conn, video_path(conn, :new)),
      get(conn, video_path(conn, :index)),
      get(conn, video_path(conn, :show, "123")),
      get(conn, video_path(conn, :edit, "123")),
      put(conn, video_path(conn, :update, "123"), %{}),
      post(conn, video_path(conn, :create, %{})),
      delete(conn, video_path(conn, :delete, "123"))
    ], fn conn ->
      assert html_response(conn, 302)
      assert conn.halted
    end)
  end

  @tag login_as: "foo"
  test "lists all user's videos on index", %{conn: conn, user: user} do
    user_video = insert_video(user, title: "foo")
    other_video = insert_video(insert_user(username: "bar"), title: "bar")
    conn = get conn, video_path(conn, :index)

    assert html_response(conn, 200) =~ "Listing videos"

    assert String.contains?(conn.resp_body, user_video.title)
    refute String.contains?(conn.resp_body, other_video.title)
  end

  @tag login_as: "foo"
  test "renders form for new resources", %{conn: conn} do
    conn = get conn, video_path(conn, :new)
    assert html_response(conn, 200) =~ "New video"
  end

  @tag login_as: "foo"
  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, video_path(conn, :create), video: @valid_attrs
    assert redirected_to(conn) == video_path(conn, :index)
    assert Repo.get_by(Video, @valid_attrs)
  end

  @tag login_as: "foo"
  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, video_path(conn, :create), video: @invalid_attrs
    assert html_response(conn, 200) =~ "New video"
  end

  @tag login_as: "foo"
  test "shows chosen resource", %{conn: conn, user: user} do
    video = insert_video(user, title: "foo")
    conn = get conn, video_path(conn, :show, video)
    assert html_response(conn, 200) =~ "Show video"
  end

  @tag login_as: "foo"
  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, video_path(conn, :show, -1)
    end
  end

  @tag login_as: "foo"
  test "renders form for editing chosen resource", %{conn: conn, user: user} do
    video = insert_video(user, title: "foo")
    conn = get conn, video_path(conn, :edit, video)
    assert html_response(conn, 200) =~ "Edit video"
  end

  @tag login_as: "foo"
  test "updates chosen resource and redirects when data is valid", %{conn: conn, user: user} do
    video = insert_video(user, title: "foo")
    conn = put conn, video_path(conn, :update, video), video: @valid_attrs
    assert redirected_to(conn) == video_path(conn, :show, video)
    assert Repo.get_by(Video, @valid_attrs)
  end

  @tag login_as: "foo"
  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn, user: user} do
    video = insert_video(user, title: "foo")
    conn = put conn, video_path(conn, :update, video), video: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit video"
  end

  @tag login_as: "foo"
  test "deletes chosen resource", %{conn: conn, user: user} do
    video = insert_video(user, title: "foo")
    conn = delete conn, video_path(conn, :delete, video)
    assert redirected_to(conn) == video_path(conn, :index)
    refute Repo.get(Video, video.id)
  end
end
