Class = require 'lib/class'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

require 'src/constants'
require 'src/StateMachine'
require 'src/Util'

require 'src/states/BaseState'
require 'src/states/game/PlayState'
require 'src/states/game/StartState'

require 'src/Animation'
require 'src/Obstacle'
require 'src/Player'
require 'src/Core'
require 'src/Polygon'


gSounds = {
    -- Song Credits:
    -- Name: Dancing Rhythm
    -- Artist: TimTaj
    -- Source: Free Music Archive
    -- License: CC BY-NC-ND
    ['music'] = love.audio.newSource('sounds/TimTaj - Dancing Rhythm.mp3', 'static'),
    ['death'] = love.audio.newSource('sounds/death.wav', 'static'),
}

gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 32),
    ['title'] = love.graphics.newFont('fonts/ArcadeAlternate.ttf', 32)
}