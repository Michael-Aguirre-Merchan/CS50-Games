--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

PlayerHoldingState = Class{__includes = BaseState}

function PlayerHoldingState:init(player, dungeon)
    self.player = player
    self.dungeon = dungeon
end

function PlayerHoldingState:enter(params)
    if not self.player.holding then 
        local currentObject = self.dungeon.currentRoom:canPlayerLift()
        if currentObject then
            self.player:changeAnimation('lift-pot-' .. self.player.direction)
            self.player.holding = currentObject
            currentObject.held = true
        else
            self.player:changeState('idle')
        end
    else
        self.player.holding:throw(self.player)
        self.player.holding = nil
        self.player:changeState('idle')
    end
end

function PlayerHoldingState:update(dt)

    -- if we've fully elapsed through one cycle of animation, change back to idle state
    if self.player.currentAnimation.timesPlayed > 0 then
        self.player.currentAnimation.timesPlayed = 0
        self.player:changeState('idle')
    end

end

function PlayerHoldingState:render()
    local anim = self.player.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.player.x - self.player.offsetX), math.floor(self.player.y - self.player.offsetY))

    --
    -- debug for player and hurtbox collision rects VV
    --

    -- love.graphics.setColor(255, 0, 255, 255)
    -- love.graphics.rectangle('line', self.player.x, self.player.y, self.player.width, self.player.height)
    -- love.graphics.rectangle('line', self.swordHurtbox.x, self.swordHurtbox.y,
    --     self.swordHurtbox.width, self.swordHurtbox.height)
    -- love.graphics.setColor(255, 255, 255, 255)
end