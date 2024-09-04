--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

GameObject = Class{}

function GameObject:init(def, x, y)
    
    -- string identifying this object type
    self.type = def.type

    self.texture = def.texture
    self.frame = def.frame or 1

    -- whether it acts as an obstacle or not
    self.solid = def.solid

    self.defaultState = def.defaultState
    self.state = self.defaultState
    self.states = def.states

    -- dimensions
    self.x = x
    self.y = y
    self.width = def.width
    self.height = def.height

    -- default empty collision callback
    self.onCollide = function() end
    self.held = false
    self.thrown = false
    self.finalCoordinates = {0, 0}
    self.velocity = {0, 0}

    self.done = false
end

function GameObject:update(dt, player)
    if self.held then
        self.x = player.x
        self.y = player.y - self.height + 2
    elseif self.thrown then
        self.x = self.x + self.velocity[1] * dt
        self.y = self.y + self.velocity[2] * dt
        if self.velocity[1] > 0 and self.x + self.width > self.finalCoordinates[1] or
            self.velocity[1] < 0 and self.x < self.finalCoordinates[1] or
            self.velocity[2] > 0 and self.y + self.height > self.finalCoordinates[2] or
            self.velocity[2] < 0 and self.y < self.finalCoordinates[2] then
                self.done = true
        end

    end
end

function GameObject:render(adjacentOffsetX, adjacentOffsetY)
    if not self.done then
        love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.states[self.state].frame or self.frame],
            self.x, self.y)
    end
end

function GameObject:isPotThere(px, py, width, height)
    return not (self.x + self.width < px or self.x > px + width or
    self.y + self.height < py or self.y > py + height)
end

function GameObject:throw(player)
    self.held = false
    if player.direction == 'left' then
        self.x = player.x - self.width
        self.y = player.y + player.height / 2 
        self.velocity[1] = -POT_SPEED
        self.finalCoordinates = {math.max(self.x - TILE_SIZE * 3, MAP_RENDER_OFFSET_X), self.y}
    elseif player.direction == 'right' then
        self.x = player.x + player.width
        self.y = player.y + player.height / 2 
        self.velocity[1] = POT_SPEED
        self.finalCoordinates = {math.min(self.x + TILE_SIZE * 4, VIRTUAL_WIDTH - self.width), self.y}
    elseif player.direction == 'up' then
        self.x = player.x
        self.y = player.y - self.height + 2 
        self.velocity[2] = -POT_SPEED
        self.finalCoordinates = {self.x, math.max(self.y - TILE_SIZE * 3, MAP_RENDER_OFFSET_Y)}
    else
        self.x = player.x
        self.y = player.y + player.height 
        self.velocity[2] = POT_SPEED
        self.finalCoordinates = {self.x, math.min(self.y + TILE_SIZE * 4, VIRTUAL_HEIGHT - self.height)}
    end
    self.thrown = true
end