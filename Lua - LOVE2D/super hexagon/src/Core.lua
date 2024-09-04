Core = Class{}

function Core:init(currentLevel)
    self.x = VIRTUAL_WIDTH/2
    self.y = VIRTUAL_HEIGHT/2
    self.size = 324
    self.vertices = currentLevel + 3
    self.rotation = math.pi / 2
end

function Core:render()
	love.graphics.setColor(COLORS[1][3])
    love.graphics.setLineWidth(5)
	love.graphics.polygon('line', CreatePolygon(self.x, self.y, self.vertices, self.size, self.rotation))
    love.graphics.setColor (COLORS[1][2])
    love.graphics.polygon('fill', CreatePolygon(self.x, self.y, self.vertices, self.size - 1, self.rotation))
end

function Core:update(dt, position, currentLevel)
    self.rotation = position
    self.vertices = currentLevel + 3
end