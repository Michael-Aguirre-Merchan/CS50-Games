--[[
    GD50
    Super Mario Bros. Remake

    -- GameLevel Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

GameLevel = Class{}

function GameLevel:init()
end

function GameLevel:update(dt)
end

function GameLevel:render()
end

function GameLevel:addObstacles(vertices, position) do
    obstacles = {}
    for i in vertices do
        table.insert(obstacles, {(i-1)*(CIRC / vertices) + position})
    end
    rdm = math.random(vertices)
    for i in rdn do
        table.remove(obstacles, math,random(vertices))
    end
    return obstacles
end