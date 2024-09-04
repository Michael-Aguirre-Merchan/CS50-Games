Obstacle = Class{}

function Obstacle:init(position, vertices)
    self.position = position
    self.radius = 270
    self.width = 15
    self.length = CIRC / vertices
    self.limits = {}
end

function Obstacle:render()
    x1 = ((self.radius + self.width) * math.cos(self.position)) + VIRTUAL_WIDTH/2
    y1 = ((self.radius + self.width) * math.sin(self.position)) + VIRTUAL_HEIGHT/2
    x2 = ((self.radius + self.width) * math.cos(self.position + self.length)) + VIRTUAL_WIDTH/2
    y2 = ((self.radius + self.width) * math.sin(self.position + self.length)) + VIRTUAL_HEIGHT/2
    x3 = ((self.radius) * math.cos(self.position + self.length)) + VIRTUAL_WIDTH/2
    y3 = ((self.radius) * math.sin(self.position + self.length)) + VIRTUAL_HEIGHT/2
    x4 = ((self.radius) * math.cos(self.position)) + VIRTUAL_WIDTH/2
    y4 = ((self.radius) * math.sin(self.position)) + VIRTUAL_HEIGHT/2
    love.graphics.setColor(COLORS[1][3])
    self.limits = {
        {{x1, y1}, {x2, y2}}, 
        {{x2, y2}, {x3, y3}}, 
        {{x3, y3}, {x4, y4}}, 
        {{x4, y4}, {x1, y1}}
    }
    love.graphics.polygon('fill', x1, y1, x2, y2, x3, y3, x4, y4)
end

function Obstacle:checkInside(px, py)
    count = 0
    for i = 1, 4 do
      x = self.limits
        if x[i] then
            x1 = x[i][1][1]
            x2 = x[i][2][1]
            y1 = x[i][1][2]
            y2 = x[i][2][2]
            if (py < y1) ~= (py < y2) 
            and px < x1 + ((py - y1)/(y2 - y1)) * (x2 - x1) then
                count = count + 1
            end
        end
    end
    return count == 1
end

function Obstacle:checkCollision(coord)
    for i= 1, 3 do
        if self:checkInside(coord[i*2 - 1], coord[i*2]) then
            return true
        end
    end
    return false
end

function Obstacle:shrinkObstacle(decrease, position)
    self.position = self.position + position
    self.radius = self.radius - decrease
end