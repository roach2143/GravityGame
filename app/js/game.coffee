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
		falling: 0
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

	mouseX = 0
	mouseY = 0
	drawBackground = (color = "rgb(240,240,240)") ->
		ctx.fillStyle = color
		ctx.fillRect 0, 0, canvas.width, canvas.height

	checkKey = (e) ->
		for key of keys
			key = keys[key]
			if e.keyCode == key.code 
				key.pressed = (e.type == "keydown")


	addCube = (e) ->
		for i of x1
			if x1[i] < 20 and x1[i] >= 0
				x1[i] = 20
			if x1[i] > -20 and x1[i] < 0
				x1[i] = -20

			if x2[i] < 20 and x2[i] >= 0
				x2[i] = 20
			if x2[i] > -20 and x2[i] < 0
				x2[i] = -20

			if y1[i] < 20 and y1[i] >= 0
				y1[i] = 20
			if y1[i] > -20 and y1[i] < 0
				y1[i] = -20

			if y2[i] < 20 and y2[i] >= 0
				y2[i] = 20
			if y2[i] > -20 and y2[i] < 0
				y2[i] = -20

		if e.which == 1
			if e.type == "mousedown"
					x1.push e.x
					y1.push e.y
					pushed = 1


			
			if e.type == "mouseup"
				x2.push e.x
				y2.push e.y
				pushed = 0

		else if e.which == 3 and e.type == "mousedown"
			for i of x1
				if x1[i] > x2[i]
					if y1[i] > y2[i]
						if e.x < x1[i] and e.x > x2[i] and e.y < y1[i] and e.y > y2[i]
							x1.splice i,1,99999
							x2.splice i,1,99999
							y1.splice i,1,99999
							y1.splice i,1,99999
							break
					else if y1[i] < y2[i]
						if e.x < x1[i] and e.x > x2[i] and e.y > y1[i] and e.y < y2[i]
							x1.splice i,1,99999
							x2.splice i,1,99999
							y1.splice i,1,99999
							y1.splice i,1,99999
							break
				else if x1[i] < x2[i]
					if y1[i] > y2[i]
						if e.x > x1[i] and e.x < x2[i] and e.y < y1[i] and e.y > y2[i]
							x1.splice i,1,99999
							x2.splice i,1,99999
							y1.splice i,1,99999
							y1.splice i,1,99999
							break
					else if y1[i] < y2[i]
						if e.x > x1[i] and e.x < x2[i] and e.y > y1[i] and e.y < y2[i]
							x1.splice i,1,99999
							x2.splice i,1,99999
							y1.splice i,1,99999
							y1.splice i,1,99999
							break


		if e.type = "mousemove"
			tempX = e.x
			tempY = e.y

	checkGravity = (obj) ->
		obj.fallSpeed = 5
		# Tjek hvornår den skal stå stille
		for i of x1
			if y2[i] - (obj.y + obj.height) >= 0 and y2[i] - (obj.y + obj.height) < obj.fallSpeed
					obj.falling = 0



		if obj.falling
			obj.fallSpeed = obj.fallSpeed + 0.1
		else
			obj.fallSpeed = 0

		player.y+= obj.fallSpeed

	setMousePos = (e) ->
		mouseX = e.x
		mouseY = e.y

	spawnCube = ->
		for i of x1
			ctx.strokeStyle = "#008e46"
			ctx.strokeRect x1[i], y1[i], x2[i]-x1[i], y2[i]-y1[i]

	drawGhost = ->
		if pushed
			ctx.strokeStyle = "rgb(0,0,0)"
			ctx.strokeRect x1[x1.length - 1], y1[y1.length - 1], mouseX - x1[x1.length - 1], mouseY - y1[y1.length - 1]

	drawCursor = (e) ->
			ctx.fillStyle = "rgb(0,0,0)"
			ctx.fillRect mouseX, mouseY, 1, 1
			ctx.fillRect mouseX+1, mouseY, 1, 1
			ctx.fillRect mouseX-1, mouseY, 1, 1
			ctx.fillRect mouseX, mouseY+1, 1, 1
			ctx.fillRect mouseX, mouseY-1, 1, 1

	gameloop = ->
		drawBackground()
		player.draw()
		spawnCube()
		drawGhost()
		checkGravity(player)
		drawCursor()

		if keys.d.pressed
			player.x+=player.speed

		if keys.a.pressed
			player.x-=player.speed



		setTimeout gameloop, 1000/fps

	gameloop()
	window.onmousemove = addCube
	window.onmousemove = setMousePos
	window.onmousedown = addCube
	window.onmouseup = addCube
	window.onkeydown = checkKey
	window.onkeyup = checkKey

