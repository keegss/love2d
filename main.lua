local TILE_WIDTH, TILE_HEIGHT

function love.load()
	loadAssets()
	initializeTilemap()
	initializePlayer()
end

function loadAssets()
	song = love.audio.newSource("song.ogg", "stream")
	song:setLooping(true)
	song:play()

	sfx = love.audio.newSource("sfx.ogg", "static")

	image = love.graphics.newImage("tileset.png")

	local image_width = image:getWidth()
	local image_height = image:getHeight()

	TILE_WIDTH = (image_width / 3) - 2
	TILE_HEIGHT = (image_height / 2) - 2

	quads = {}

	for i = 0, 1 do
		for j = 0, 2 do
			table.insert(
				quads,
				love.graphics.newQuad(
					1 + j * (TILE_WIDTH + 2),
					1 + i * (TILE_HEIGHT + 2),
					TILE_WIDTH,
					TILE_HEIGHT,
					image_width,
					image_height
				)
			)
		end
	end
end

function initializeTilemap()
	tilemap = {
		{ 1, 6, 6, 2, 1, 6, 6, 2 },
		{ 3, 0, 0, 4, 5, 0, 0, 3 },
		{ 3, 0, 0, 0, 0, 0, 0, 3 },
		{ 4, 2, 0, 0, 0, 0, 1, 5 },
		{ 1, 5, 0, 0, 0, 0, 4, 2 },
		{ 3, 0, 0, 0, 0, 0, 0, 3 },
		{ 3, 0, 0, 1, 2, 0, 0, 3 },
		{ 4, 6, 6, 5, 4, 6, 6, 5 },
	}
end

function initializePlayer()
	player = {
		image = love.graphics.newImage("player.png"),
		tile_x = 2,
		tile_y = 2,
	}
end

function isEmpty(x, y)
	return tilemap[y] and tilemap[y][x] == 0
end

function love.keypressed(key)
	if key == "space" then
		sfx:play()
		return
	end

	local x = player.tile_x
	local y = player.tile_y

	if key == "left" then
		x = x - 1
	elseif key == "right" then
		x = x + 1
	elseif key == "up" then
		y = y - 1
	elseif key == "down" then
		y = y + 1
	end

	if isEmpty(x, y) then
		player.tile_x = x
		player.tile_y = y
	end
end

function love.draw()
	for i, row in ipairs(tilemap) do
		for j, tile in ipairs(row) do
			if tile ~= 0 then
				love.graphics.draw(image, quads[tile], j * TILE_WIDTH, i * TILE_HEIGHT)
			end
		end
	end

	love.graphics.draw(player.image, player.tile_x * TILE_WIDTH, player.tile_y * TILE_HEIGHT)
end
