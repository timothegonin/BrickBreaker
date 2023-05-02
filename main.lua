-- printer
io.stdout:setvbuf('no')

local pad = {}
pad.x = 0
pad.y = 0
pad.width = 80
pad.height = 20

local ball = {}
ball.x = 0
ball.y = 0
ball.radius = 10
ball.hooked = false
ball.speed_x = 0
ball.speed_y = 0

function Start()
  ball.hooked = true
end

-- ZeroBraneStudio debug
-- if arg[#arg] == "-debug" then require("mobdebug").start() end

function love.load()
  
  screen_width = love.graphics.getWidth()
  screen_height = love.graphics.getHeight()

  print("screen width",screen_width)
  print('screen height', screen_height)

  pad.y = screen_height - (pad.height / 2)
  Start()

end

function love.update(dt)
  pad.x = love.mouse.getX()

  if ball.hooked == true then
    ball.x = pad.x
    ball.y = pad.y - pad.height / 2 - ball.radius
  else
    ball.x = ball.x + (ball.speed_x * dt)
    ball.y = ball.y + (ball.speed_y * dt)
  end

end

function love.draw()
  love.graphics.rectangle('fill', pad.x - (pad.width / 2 ), pad.y - (pad.height / 2 ), pad.width, pad.height)
  love.graphics.circle('fill', ball.x, ball.y, ball.radius)
end

function love.mousepressed(x,y,n)
  if ball.hooked == true then
    ball.hooked = false
    ball.speed_x = 200
    ball.speed_y = -200
  end
end

function love.keypressed(key)
  
  print(key)
  
end
  