requirejs ['js/keys'], (keys) ->
	canvas = document.getElementById "canvas"
	ctx = canvas.getContext "2d"

	fps = 60

	player =
		x: 200
		y: 200
		width: 20
		height: 20
		speed: 3
		draw: ->
			ctx.fillStyle = "rgb(0,0,200)"
			ctx.fillRect @x, @y, @width, @height

	drawBackground = (color = "#333") ->
		ctx.fillStyle = color
		ctx.fillRect 0, 0, canvas.width, canvas.height

	checkKey = (e) ->
		for key of keys
			key = keys[key]
			if e.keyCode == key.code 
				key.pressed = (e.type == "keydown")



	gameloop = ->
		drawBackground()
		player.draw()
		
		setTimeout gameloop, 1000/fps

	gameloop()

	window.onkeydown = checkKey
	window.onkeyup = checkKey