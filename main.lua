function love.load()
	--y=550
	lun = 80
	alte = 20
	speed = 3
	limitSx = 2

	canShoot = false

	width = love.graphics.getWidth( )
	height = love.graphics.getHeight( )

	player = {}
	player.x = 10
	player.y = height-50
	player.bullets = {}
	player.BulletDelay = 5
	player.fire = function()
		if player.BulletDelay <= 0 then
			canShoot= true
			player.BulletDelay = 35
			bullet = {}
			bullet.x = player.x+(lun/2)-5
			bullet.y = player.y
			table.insert(player.bullets,bullet)
		end
	end


	beep = love.audio.newSource("s2.wav","stream")
	r = 0
	g = 0
	b = 0

end

function love.update(dt)--dt = delta time

	player.BulletDelay = player.BulletDelay - 1
	--k = (player.x*255)/717

	cordX = "x = " .. player.x
	cordY = "y = " .. player.y
	FPS = "FPS " .. love.timer.getFPS()
	Swidth = "Width = " .. width
	Sheight = "Height = " .. height
	Color = "r = " .. r .."\ng = " .. g .."\nb= "..b


	--love.graphics.setColor(k-100 , k-100 , k)



	if love.keyboard.isDown("d") and player.x <= width -lun-3 then --Destra
		player.x=player.x+1*speed
	elseif love.keyboard.isDown("a") and player.x >= limitSx then --Sinistra
		player.x=player.x-1*speed
	end

	if love.keyboard.isDown("space") or love.mouse.isDown( 1 ) then
    	player.fire()
		if canShoot then
		r =  love.math.random( 1, 255 )
		g =  love.math.random( 1, 255 )
		b =  love.math.random( 1, 255 )
		love.graphics.setBackgroundColor( r,g,b )
		end
		canShoot = false

		beep:play()
    end


	if love.keyboard.isDown("escape")  then
    	love.event.quit()
    end

    if love.keyboard.isDown("f") then
    	love.window.setFullscreen( true )
		width = love.graphics.getWidth( )
		height = love.graphics.getHeight( )
		player.y = height-50
    end

    for i,b in ipairs(player.bullets)do
    	if b.y < -10 then
    		table.remove(player.bullets,i)
    	end
    	b.y = b.y - 10
    end

end

function love.draw()
	love.graphics.setColor(255,255,255)
	love.graphics.print(cordX, 5, 5)
	love.graphics.print(cordY, 5, 20)
	love.graphics.print(FPS, 5, 35)
	love.graphics.print(Swidth, 5, 50)
	love.graphics.print(Sheight, 5, 65)
	love.graphics.print(Color, 5, 80)

	love.graphics.setColor(0,0,255)
	love.graphics.rectangle("fill",player.x,player.y,lun,alte)


	love.graphics.setColor(255,0,0)

	for _,b in pairs(player.bullets)do
		love.graphics.rectangle("fill", b.x, b.y , 10 , 10)
	end
end
