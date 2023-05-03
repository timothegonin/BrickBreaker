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

local brick = {}
local level = {}


function Start()
  ball.hooked = true

  level = {}
  local line, column

  for line = 1, 6 do 
    level[line] = {}
    for column = 1, 15 do 
      level[line][column] = 1
    end
  end

end

-- ZeroBraneStudio debug
-- if arg[#arg] == "-debug" then require("mobdebug").start() end

function love.load()
  
  screen_width = love.graphics.getWidth()
  screen_height = love.graphics.getHeight()

  brick.height = 25
  brick.width = screen_width / 15

  print("screen width",screen_width)
  print('screen height', screen_height)

  pad.y = screen_height - (pad.height / 2)
  Start()

end

function love.update(dt)

--[[ 
  ┌─────────────────────────────────────────────────────────────────────────────┐
  │   PAD - start                                                               │
  └─────────────────────────────────────────────────────────────────────────────┘
 ]]
  --mouse movements
  pad.x = love.mouse.getX()

  --catch pad and ball collision
  local posCollisionPad = pad.y - (pad.height / 2) - ball.radius

  --ball and pad, X-axis collision
  if ball.y > posCollisionPad then 
    local dist = math.abs(pad.x - ball.x)
    if dist < pad.width / 2 then 
      ball.speed_y = 0 - ball.speed_y
      ball.y = posCollisionPad
    end
  end
--[[ 
  ┌─────────────────────────────────────────────────────────────────────────────┐
  │   PAD - end                                                                 │
  └─────────────────────────────────────────────────────────────────────────────┘
 ]]

--[[ 
  ┌─────────────────────────────────────────────────────────────────────────────┐
  │   BALL - strat                                                              │
  └─────────────────────────────────────────────────────────────────────────────┘
 ]]
  --ball movements
  if ball.hooked == true then
    ball.x = pad.x
    ball.y = pad.y - pad.height / 2 - ball.radius
  else
    ball.x = ball.x + (ball.speed_x * dt)
    ball.y = ball.y + (ball.speed_y * dt)
  end

  --X-axis collisions
  if ball.x > screen_width then 
    ball.speed_x = 0 - ball.speed_x
    ball.x = screen_width
  end
  if ball.x < 0 then 
    ball.speed_x = 0 - ball.speed_x
    ball.x = 0
  end
  --Y-axis collision
  if ball.y < 0 then
    ball.speed_y = 0 - ball.speed_y
    ball.y = 0
  end
  if ball.y > screen_height then 
    Start()
  end
--[[ 
  ┌─────────────────────────────────────────────────────────────────────────────┐
  │   BALL - end                                                                │
  └─────────────────────────────────────────────────────────────────────────────┘
 ]]

end

function love.draw()
  local line, column
  local brick_x, brick_y = 0, 0

  for line = 1, 6 do 
    brick_x = 0
    for column = 1, 15 do 
      if level[line][column] == 1 then
        love.graphics.rectangle('fill', brick_x + 1 ,brick_y + 1, brick.width - 2, brick.height -2)
      end
      brick_x = brick_x + brick.width
    end
    brick_y = brick_y + brick.height
  end

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
  