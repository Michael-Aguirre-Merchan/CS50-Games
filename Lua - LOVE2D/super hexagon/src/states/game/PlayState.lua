PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.level = 0
    self.core = Core(1)
    self.obstacles  = {}
    self.player = Player()
    self.position =  math.pi / 2
    self.speed = -1
    self.back = Animation()
    self.timer = 0
    self.lost = false
    Timer.every(1, function()
        if not self.lost then
            self.timer = self.timer + 1
        end
    end
    )
    Timer.every(5, function()
        self.speed = math.random(-1.5, 1.5)
    end
    )
    Timer.every(5, function()
        self.speed = math.random(-1.3, 1.3)
    end
    )
    Timer.every(10, function()
        self.obstacles = {}
        self.level = math.min(self.level + 1, 8)
    end
    )
end

function PlayState:addObstacles()
    response = {}
    for i = 1, self.level + 3 do
       table.insert(response, Obstacle((i-1)*(CIRC / (self.level + 3)) + self.position, self.level + 3))
    end
    rdm = math.random(self.level + 3)
    for i = 1, rdm do
        table.remove(response, math.random(self.level + 3))
    end
    return response
end

function PlayState:update(dt)
    Timer.update(dt)

    rotation = self.speed * dt

    self.position = self.position + rotation

    self.player:update(dt, rotation, math.abs(self.speed))
    self.core:update(dt, self.position, self.level)
    self.back:update(dt, self.position)

    for i, x in pairs(self.obstacles) do
        x:shrinkObstacle(math.abs(self.speed) * 100 * dt, rotation)
    end

    if (table.getn(self.obstacles) < 1 or self.obstacles[table.getn(self.obstacles)].radius < 190) then
        current = self:addObstacles()
        for i, x in pairs(current) do
            table.insert(self.obstacles, current[i])
        end
    end

    if self.obstacles[1].radius <= 0 then
        table.remove(self.obstacles, 1)
    end

    for i, x in pairs(self.obstacles) do
        if x:checkCollision(self.player.vertices) then
            gSounds['death']:setLooping(false)
            gSounds['death']:setVolume(1)
            gSounds['death']:play()
            self.lost = true
        end
    end

    if self.lost and (love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return'))then
        Timer.clear()
        love.audio.stop()
        gStateMachine:change('start')
        
    end

end

function PlayState:render()
    love.graphics.push()
    self.back:render(self.level + 3)
    if not self.lost then
        self.player:render()
        for i, x in pairs(self.obstacles) do
            x:render()
        end
    end

    self.core:render()

    if self.lost then
        love.graphics.setFont(gFonts['medium'])
        love.graphics.setColor(0, 0, 0, 1)
    end
    
    love.graphics.pop()
    love.graphics.setFont(gFonts['medium'])
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.print(tostring(self.timer), 5, 5)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print(tostring(self.timer), 4, 4)

    if self.lost then
        love.graphics.setFont(gFonts['title'])
        love.graphics.setColor(0, 0, 0, 255)
        love.graphics.printf('Game Over', 1, VIRTUAL_HEIGHT / 2 - 40 + 1, VIRTUAL_WIDTH, 'center')
        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.printf('Game Over', 0, VIRTUAL_HEIGHT / 2 - 40, VIRTUAL_WIDTH, 'center')

        love.graphics.setFont(gFonts['medium'])
        love.graphics.setColor(0, 0, 0, 255)
        love.graphics.printf('Score: ' .. tostring(self.timer), 1, VIRTUAL_HEIGHT / 2 - 10, VIRTUAL_WIDTH, 'center')
        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.printf('Score: ' .. tostring(self.timer), 0, VIRTUAL_HEIGHT / 2 - 9, VIRTUAL_WIDTH, 'center')
    
        love.graphics.setFont(gFonts['large'])
        love.graphics.setColor(0, 0, 0, 255)
        love.graphics.printf('Press Enter', 1, VIRTUAL_HEIGHT / 2 + 17, VIRTUAL_WIDTH, 'center')
        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.printf('Press Enter', 0, VIRTUAL_HEIGHT / 2 + 16, VIRTUAL_WIDTH, 'center')
    end
end