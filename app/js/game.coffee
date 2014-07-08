requirejs ['js/keys'], (keys) ->
	canvas = document.getElementById "canvas"
	ctx = canvas.getContext "2d"

	fps = 60

	player =
		x: 400
		y: 200
		width: -30
		height: 30
		speed: 3
		fallSpeed: 0
		draw: ->
			ctx.strokeStyle = "rgb(50,50,50)"
			ctx.strokeRect @x, @y, @width, @height

	x1 = [
		500
	]
	x2 = [
		200
	]

	y1 = [
		400
	]
	y2 = [
		420
	]

	tempX = 0

	tempY = 0

	pushed = 0

	drawBackground = (color = "rgb(200,200,200)") ->
		ctx.fillStyle = color
		ctx.fillRect 0, 0, canvas.width, canvas.height

	checkKey = (e) ->
		for key of keys
			key = keys[key]
			if e.keyCode == key.code 
				key.pressed = (e.type == "keydown")


	addCube = (e) ->
		if e.type == "mousedown"
			if e.which == 1
				x1.push e.x
				y1.push e.y
				pushed = 1

			e.preventDefault

			if e.which == 3
				for i of x1
					if e.x < x2[i] and e.x > x1[i] and e.y < y2[i] and e.y > y2[i]
						x1.splice(i,1,0)
						x2.splice(i,1,0)
						y1.splice(i,1,0)
						y1.splice(i,1,0)

		
		if e.type == "mouseup"
			x2.push e.x
			y2.push e.y
			pushed = 0

		if e.type = "mousemove"
			tempX = e.x
			tempY = e.y



	spawnCube = ->
		for i of x1
			ctx.strokeStyle = "#008e46"
			ctx.strokeRect x1[i], y1[i], x2[i]-x1[i], y2[i]-y1[i]

	drawGhost = ->
		if pushed

			ctx.strokeStyle = "rgb(0,0,0)"
			ctx.strokeRect x1[x1.length - 1], y1[y1.length - 1], tempX - x1[x1.length - 1], tempY - y1[y1.length - 1]

	gameloop = ->
		drawBackground()
		player.draw()
		spawnCube()
		drawGhost()

		if keys.d.pressed
			player.x+=player.speed

		if keys.a.pressed
			player.x-=player.speed



		setTimeout gameloop, 1000/fps

	gameloop()
	window.onmousemove = addCube
	window.onmousedown = addCube
	window.onmouseup = addCube
	window.onkeydown = checkKey
	window.onkeyup = checkKey

