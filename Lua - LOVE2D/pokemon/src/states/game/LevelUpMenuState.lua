--[[
    GD50
    Pokemon

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

LevelUpMenuState = Class{__includes = BaseState}

function LevelUpMenuState:init(stats, onClose)

    self.onClose = onClose
    
    self.LevelUpMenu = Menu {
        x = 0,
        y = VIRTUAL_HEIGHT - 64,
        width = VIRTUAL_WIDTH,
        height = 64,
        items = {
            {
                text = 'HP Increased: ' .. stats[1][1] .. ' + ' .. stats[2][1] .. ' = ' .. stats[1][1]+stats[2][1],
                onSelect = function()
                    gStateStack:pop()
                    self.onClose()
                end
            },
            {
                text = 'Attack Increased: ' .. stats[1][2] .. ' + ' .. stats[2][2] .. ' = ' .. stats[1][2]+stats[2][2],
                onSelect = function()
                    gStateStack:pop()
                    self.onClose()
                end
            },
            {
                text = 'Defense Increased: ' .. stats[1][3] .. ' + ' .. stats[2][3] .. ' = ' .. stats[1][3]+stats[2][3],
                onSelect = function()
                    gStateStack:pop()
                    self.onClose()
                end
            },
            {
                text = 'Speed Increased: ' .. stats[1][4] .. ' + ' .. stats[2][4] .. ' = ' .. stats[1][4]+stats[2][4],
                onSelect = function()
                    gStateStack:pop()
                    self.onClose()
                end
            },
        },
        cursor = false,
        font = gFonts['medium'],
        orientation = 'left'
    }
end

function LevelUpMenuState:update(dt)
    self.LevelUpMenu:update(dt)
end

function LevelUpMenuState:render()
    self.LevelUpMenu:render()
end