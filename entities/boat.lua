Boat = class('Boat')

function Boat:initialize(x, y)
	self.x = x or love.window.getWidth()/2
	self.y = y or love.window.getHeight()/2
	self.img = love.graphics.newImage('img/boat.png')
	self.width = self.img:getWidth()
	self.height = self.img:getHeight()
	self.rotation = 0
end

function Boat:draw()
	love.graphics.draw(self.img, self.x, self.y, self.rotation, 1, 1, self.width/2, self.height/2)
end