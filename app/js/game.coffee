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
		fallSpeed: 0
		draw: ->
			ctx.fillStyle = "rgb(0,0,200)"
			ctx.fillRect @x, @y, @width, @height

	blocks = 
		block1: {
			x: 200
			y: 400
			width: 300
			height: 20
			draw: ->
				ctx.fillStyle = "#666"
				ctx.fillRect @x, @y, @width, @height
		}

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

		blocks.block1.draw()

		if keys.d.pressed
			player.x+=player.speed

		if keys.a.pressed
			player.x-=player.speed
		

		if player.x < blocks.block1.x or player.x > blocks.block1.x + blocks.block1.width or player.y < blocks.block1.y-blocks.block1.height
			player.fallSpeed+=0.2
		else
			player.fallSpeed=0


		if player.fallSpeed > 0
			player.y+=player.fallSpeed

		setTimeout gameloop, 1000/fps

	gameloop()
	window.onkeydown = checkKey
	window.onkeyup = checkKey
