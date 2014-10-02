game = {}

function game:enter()
    love.graphics.setBackgroundColor(71, 170, 209)
	love.graphics.setPointSize(10)
	love.graphics.setLineWidth(6)
	
	self.boat = Boat:new()
	self.t = 0
	
	self.mode = 'draw'
	
	self.path = {}
	
	self.curve = nil
	
	
	self.windAngle = math.random(math.rad(360))
	self.windSpeed = math.random(5, 30) -- pixels per second
	
	self.target = Target:new()
	self.target:randomize()
end

function game:update(dt)
	if self.mode == 'draw' then
		if love.mouse.isDown('l') then
			local mx, my = love.mouse.getPosition()
			if #self.path > 1 or mx >= self.boat.x - 50 and mx <= self.boat.x + 50 and my >= self.boat.y - 50 and my <= self.boat.y + 50 then
				table.insert(self.path, love.mouse.getX())
				table.insert(self.path, love.mouse.getY())
			end
			
			if self.curve then
				--self.curve:setControlPoint(self.curve:getControlPointCount()+1, love.mouse.getX(), love.mouse.getY())
				self.curve:insertControlPoint(love.mouse.getX(), love.mouse.getY())
			end
		elseif self.curve then
			self.derivativeCurve = self.curve:getDerivative()
			
			self.mode = 'run'
			tween.start(7, game, {t = 1}, 'linear', function()
				game.mode = 'draw'
				self.path = {}
				self.curve = nil
				self.t = 0
				
				self.windAngle = math.random(math.rad(360))
				self.windSpeed = math.random(5, 30) -- pixels per second
				
				self.target:randomize()
			end)
		end
	
		if not self.curve and #self.path >= 4 then
			self.curve = love.math.newBezierCurve(self.path)
		end
	
	
	elseif self.mode == 'run' then
		local x, y = self.curve:evaluate(self.t)
		
		local timePassed = self.t*7
		local dx = math.cos(self.windAngle)*self.windSpeed*timePassed
		local dy = math.sin(self.windAngle)*self.windSpeed*timePassed
		
		x = x - dx
		y = y - dy
		
		self.boat.x, self.boat.y = x, y
		
		--[[
		if self.t > .2 then
			local x2, y2 = self.curve:evaluate(self.t-.1)
			self.boat.rotation = math.atan2(math.rad((y2-y)/(x2-x)))
		end]]
		
		--self.boat.rotation = math.rad(self.derivativeCurve:evaluate(self.t))
	end
end

function game:keypressed(key, isrepeat)

end

function game:draw()
    love.graphics.setFont(fontBold[48])
	love.graphics.setColor(255, 255, 255)
	
	self.boat:draw()
	self.target:draw()
	
	if self.curve then
		local points = self.curve:render(2)
		love.graphics.line(points)
	end
	
	local width, height = love.window.getDimensions()
	
	local x, y = width-150, 150
	love.graphics.print('Wind:\n'..self.windSpeed..' m/s', x, y+80)
	
	local dx, dy = math.cos(self.windAngle)*self.windSpeed, math.sin(self.windAngle)*self.windSpeed
	love.graphics.line(x, y, x-dx, y-dy)
	
	love.graphics.setColor(255, 0, 0)
	love.graphics.point(x+.5, y+.5)
	
	love.graphics.print(love.timer.getFPS())
end