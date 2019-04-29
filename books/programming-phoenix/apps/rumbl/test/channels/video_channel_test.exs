defmodule Rumbl.Channels.VideoChannelTest do
  use Rumbl.ChannelCase
  import Rumbl.TestHelpers

  alias Rumbl.UserSocket

  setup do
    user = insert_user(name: "Sofia")
    video = insert_video(user, title: "Testing")
    token = Phoenix.Token.sign(@endpoint, "user socket", user.id)
    {:ok, socket} = connect(Rumbl.UserSocket, %{"token" => token})

    {:ok, user: user, video: video, socket: socket}
  end

  test "join replies with video annotations", %{socket: socket, video: video} do
    for body <- ~w(one two) do
      video
      |> build_assoc(:annotations, %{body: body})
      |> Repo.insert!()
    end
    {:ok, reply, socket} = subscribe_and_join(socket, "videos:#{video.id}", %{})

    assert socket.assigns.video_id == video.id
    assert reply = [%{body: "one"}, %{body: "two"}]
  end

  test "inserting new annotations", %{socket: socket, video: video} do
    {:ok, _, socket} = subscribe_and_join(socket, "videos:#{video.id}", %{})
    ref = push(socket, "new_annotation", %{body: "the body", at: 0})
    assert_reply ref, :ok, %{}
    assert_broadcast "new_annotation", %{}
  end

  test "new annotatioin triggers SysInfo", %{socket: socket, video: video} do
    insert_user(username: "wolfram")
    {:ok, _, socket} = subscribe_and_join(socket, "videos:#{video.id}", %{})
    ref = push(socket, "new_annotation", %{body: "1+1", at: 123})

    assert_reply ref, :ok, %{}
    assert_broadcast "new_annotation", %{body: "1+1", at: 123}
    assert_broadcast "new_annotation", %{body: "2", at: 123}
  end
end
