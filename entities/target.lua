Target = class('Target')

function Target:initialize(x, y)
	self.x = 0
	self.y = 0
	self.width = 50
	self.height = 50
end

function Target:randomize()
	self.x = math.random(love.window.getWidth())
	self.y = math.random(love.window.getHeight())
	self.width = math.random(100, 200)
	self.height = self.width
end

function Target:draw()
	love.graphics.line(self.x-self.width/2, self.y-self.height/2, self.x+self.width/2, self.y-self.height/2, self.x+self.width/2, self.y+self.height/2, self.x-self.width/2, self.y+self.width/2, self.x-self.width/2, self.y-self.width/2)
	love.graphics.line(self.x-self.width/2, self.y-self.height/2, self.x+self.width/2, self.y+self.height/2)
	love.graphics.line(self.x+self.width/2, self.y-self.height/2, self.x-self.width/2, self.y+self.height/2)
end