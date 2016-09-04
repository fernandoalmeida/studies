import "phoenix_html"

import Player from "./player"

let video = document.getElementById("video")

if (video) {
    Player.init(video.id, video.getAttribute("data-player-id"), () => {
	console.log("player ready!")
    })
}
