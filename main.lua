-- libraries
class = require 'libs.middleclass'
vector = require 'libs.vector'
state = require 'libs.state'
tween = require 'libs.tween'
fx = require 'libs.fx'
require 'libs.util'

-- gamestates
require 'states.menu'
require 'states.game'

-- entities
require 'entities.boat'
require 'entities.target'

function love.load()
	love.window.setTitle(config.windowTitle)
    love.window.setIcon(love.image.newImageData(config.windowIcon))
	love.graphics.setDefaultFilter(config.filterModeMin, config.filterModeMax, config.anisotropy)
    love.graphics.setFont(font[14])

    math.randomseed(os.time()/10)

    state.registerEvents()
    state.switch(menu)
end

function love.update(dt)
    tween.update(dt)
end

function love.draw()
    fx.draw()
end