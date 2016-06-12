defmodule VideoViewTest do
  use Rumbl.ConnCase, async: true
  import Phoenix.View

  test "renders index.html" do
    videos = [%Rumbl.Video{id: "1", title: "foo"},
	      %Rumbl.Video{id: "2", title: "bar"}]

    content = render_to_string(
      Rumbl.VideoView, "index.html", conn: conn, videos: videos
    )

    assert String.contains?(content, "Listing videos")

    for v <- videos do
      assert String.contains?(content, v.title)
    end
  end

  test "renders new.html" do
    changeset = Rumbl.Video.changeset(%Rumbl.Video{})
    categories = [{"foo", 1}]

    content = render_to_string(
      Rumbl.VideoView, "new.html", conn: conn,
      changeset: changeset, categories: categories
    )

    assert String.contains?(content, "New video")
  end
end
