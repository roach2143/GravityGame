canvas = document.getElementById "canvas"
ctx = canvas.getContext "2d"

player =
	x: 500
	y: 400
	width: 15
	height: 15

drawBackground = (color = "#333") ->
	ctx.fillStyle = color
	ctx.fillRect 0, 0, canvas.width, canvas.height

drawBackground()
console.log "Hello"