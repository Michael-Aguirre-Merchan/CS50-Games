--[[
    GD50
    Match-3 Remake

    -- Tile Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    The individual tiles that make up our game board. Each Tile can have a
    color and a variety, with the varietes adding extra points to the matches.
]]

Tile = Class{}

function Tile:init(x, y, color, variety, shiny)
    
    -- board positions
    self.gridX = x
    self.gridY = y

    -- coordinate positions
    self.x = (self.gridX - 1) * 32
    self.y = (self.gridY - 1) * 32

    -- tile appearance/points
    self.color = color
    self.variety = variety

    self.isShiny = shiny
    self.alpha = 1
    self.testing = false
end

function Tile:render(x, y)

    -- draw tile itself
    love.graphics.setColor(255, 255, 255, self.alpha)
    love.graphics.draw(gTextures['main'], gFrames['tiles'][self.color][self.variety],
        self.x + x, self.y + y)
    if self.testing then
        love.graphics.setColor(0, 0, 0, 1)
        love.graphics.circle('fill', self.x + x, self.y + y, 5)
    end
end

function Tile:update(dt)

    if self.isShiny then
        Timer.tween(1, {

            [self] = {alpha = 0.6}

        }):finish(function()
            Timer.tween(1, {

                [self] = {alpha = 1}
    
            })
        end
        )
    end
end