function love.load()
	arrow = {}
	arrow.x = 200
	arrow.y = 200
	arrow.speed = 300
	arrow.angle = 0
	arrow.image = love.graphics.newImage("arrow_right.png")
	arrow.origin_x = arrow.image:getWidth() / 2
	arrow.origin_y = arrow.image:getHeight() / 2
end

function love.update(dt)
	mouse_x, mouse_y = love.mouse.getPosition()
	arrow.angle = math.atan2(mouse_y - arrow.y, mouse_x - arrow.x)
	angle = math.atan2(mouse_y - arrow.y, mouse_x - arrow.x)
	cos = math.cos(angle)
	sin = math.sin(angle)

	local distance = getDistance(mouse_x, mouse_y, arrow.x, arrow.y)

	if distance > 50 then
		arrow.x = arrow.x + arrow.speed * cos * dt
		arrow.y = arrow.y + arrow.speed * sin * dt
	end
end

function love.draw()
	love.graphics.draw(arrow.image, arrow.x, arrow.y, arrow.angle, 1, 1, arrow.origin_x, arrow.origin_y)
	love.graphics.circle("fill", mouse_x, mouse_y, 5)
end

function getDistance(x1, y1, x2, y2)
	local h_distance = x1 - x2
	local v_distance = y1 - y2

	local a = h_distance ^ 2
	local b = v_distance ^ 2
	return math.sqrt(a + b)
end
