-- printer
io.stdout:setvbuf('no')

local pad = {}
pad.x = 0
pad.y = 0
pad.width = 80
pad.height = 20

-- ZeroBraneStudio debug
-- if arg[#arg] == "-debug" then require("mobdebug").start() end

function love.load()
  
  screen_width = love.graphics.getWidth()
  screen_height = love.graphics.getHeight()

  print("screen width",screen_width)
  print('screen height', screen_height)

  pad.y = screen_height - (pad.height / 2)
  
end

function love.update(dt)
  pad.x = love.mouse.getX()
end

function love.draw()
  love.graphics.rectangle('fill', pad.x - (pad.width / 2 ), pad.y - (pad.height / 2 ), pad.width, pad.height)
end

function love.keypressed(key)
  
  print(key)
  
end
  