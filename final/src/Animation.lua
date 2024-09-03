Animation = Class{}

function Animation:init()
    self.position = 0
end

function Animation:update(dt, position)
    self.position = position

end

function Animation:render(vertices)
    for i = 0, vertices - 1 do
        x1 = (350 * math.cos(self.position + i*CIRC / vertices)) + VIRTUAL_WIDTH/2
        y1 = (350 * math.sin(self.position + i*CIRC / vertices)) + VIRTUAL_HEIGHT/2
        x2 = (350 * math.cos(self.position + (i+1)*CIRC / vertices)) + VIRTUAL_WIDTH/2
        y2 = (350 * math.sin(self.position + (i+1)*CIRC / vertices)) + VIRTUAL_HEIGHT/2
        x3 = (18 * math.cos(self.position + (i+1)*CIRC / vertices)) + VIRTUAL_WIDTH/2
        y3 = (18 * math.sin(self.position + (i+1)*CIRC / vertices)) + VIRTUAL_HEIGHT/2
        x4 = (18 * math.cos(self.position + i*CIRC / vertices)) + VIRTUAL_WIDTH/2
        y4 = (18 * math.sin(self.position + i*CIRC / vertices)) + VIRTUAL_HEIGHT/2
        love.graphics.setColor(COLORS[1][i%2 + 1])
        if vertices%2 ~= 0 and i == vertices - 1 then
            love.graphics.setColor(COLORS[1][4])
        end
        love.graphics.polygon('fill', x1, y1, x2, y2, x3, y3, x4, y4)
    end
end