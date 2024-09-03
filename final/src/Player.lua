Player = Class{__includes = Entity}

function Player:init()
    self.position = math.pi / 2
    self.size = 40
    self.score = 0
    self.vertices = {}
end

function Player:getCoordinates()
    x = (30*math.cos(self.position)) + VIRTUAL_WIDTH/2
    y = (30*math.sin(self.position)) + VIRTUAL_HEIGHT/2
    return {x, y}
end

function Player:update(dt, position, speed)
    if love.keyboard.isDown('left') then
        self.position = self.position - 5 * dt * speed
    end
    if love.keyboard.isDown('right') then
        self.position = self.position + 5 * dt * speed
    end

    self.position = self.position + position

    if self.rotation == CIRC then
        self.rotation = 0
    end
    currentPosition = self:getCoordinates()
    self.vertices = CreatePolygon(currentPosition[1], currentPosition[2], 3, self.size, self.position)
end

function Player:getVertices()
    return self.vertices
end

function Player:render()
    if table.getn(self.vertices) > 0 then
        love.graphics.setColor(COLORS[1][3])
        love.graphics.polygon('fill', self.vertices)
    end
end