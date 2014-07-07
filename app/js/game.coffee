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

	blocks = 
		block1: {
			x: canvas.width / 2
			y: 800
			width: 400
			height: 5
		}
		block2: {
			x: canvas.width / 2
			y: 500
			width: 400
			height: 5
		}


	drawBackground = (color = "#333") ->
		ctx.fillStyle = color
		ctx.fillRect 0, 0, canvas.width, canvas.height

	checkKey = (e) ->
		for key of keys
			key = keys[key]
			if e.keyCode == key.code 
				key.pressed = (e.type == "keydown")


	drawBlock = (x, y, width, height) ->
		ctx.fillStyle = "rgb(200,200,200)"
		ctx.fillRect x, y, width, height


	gameloop = ->
		drawBackground()
		player.draw()

		drawBlock(blocks.block1.x, blocks.block1.y, blocks.block1.width, blocks.block1.height)

		if keys.d.pressed
			player.x+=player.speed

		if keys.a.pressed
			player.x-=1
		

		setTimeout gameloop, 1000/fps

	gameloop()
	window.onkeydown = checkKey
	window.onkeyup = checkKey
