-- Bader Aljishi
-- CS4849 - Game Programming
-- Assignment #1 - Turret Shooter

-- physics engine
local physics = require("physics")
physics.start()

-- set the background images
local outerSpace = display.newImage("space_background.png", 250, 460)
local alienHead = display.newImage("boss.png", 250, 360)

-- set the turret
local turret = display.newImage("turret.png", 250, 800)
--physics.addBody(turret, "static", {density = 3.0, friction = 0.5, bounce = 0.3})

-- add the explosion sprite sheet
local explosionOptions = 
{
  width = 128,
  height = 128,
  numFrames = 10
}

local explosionSheet = graphics.newImageSheet("explosion_spritesheet.png", explosionOptions)

--local function endOfExplosion(e)
--  if e.phase == "ended" then
--    e.object1:removeSelf()
--  end
--  return true
--end

-- collision event handler
local function onCollision(event)
  if (event.phase == "ended") then
    event.object1:removeSelf()
    event.object2:removeSelf()
  
    -- display explosion animation
    local explosionSequenceData = 
    {
      name = "explosionSprite",
      start = 1,
      count = 10,
      time = 500,
      loopCount = 1,
      loopDirection = "forward"
    }
  
    local explosion = display.newSprite(explosionSheet, explosionSequenceData)
    local explosionX = event.object1.x
    local explosionY = event.object1.y
    explosion.x = explosionX; explosion.y = explosionY
    --explosion:addEventListener("sprite", endOfExplosion)
    explosion:play()
    if explosion.phase == "ended" then
      display.remove(explosion)
      explosion = nil
    end
  end
end

-- function for finding the proper angle that the bullets and turret must rotate
local function angleOfRotation(turretX, turretY, eventX, eventY)
  local angle = (math.deg(math.atan2(eventY - turretY, eventX - turretX)) + 90)
    if (angle < 0) then
      angle = angle + 360
    end
    
    return angle % 360
  end

-- target creation and movement
  --while movingTargets
  local targetSpeed = 1000
  local randomX = math.random(0, 420)
  local randomY = math.random(100, 680)
  local target = display.newImage("squid_alien.png", randomX, randomY)
  physics.addBody(target, "dynamic", {density = 3.0, friction = 0.5, bounce = 0.3})
  
-- event handler for when the user taps the screen
local function aimAndShoot(event)
  -- rotate the turret to desired direction
  local rotationAngle = angleOfRotation(turret.x, turret.y, event.x, event.y)
  turret.rotation = rotationAngle
  
  -- now fire the bullet
  bulletX = turret.x
  bulletY = turret.y
  local bullet = display.newImage("laser_shot.png", bulletX, bulletY)
  physics.addBody(bullet, "kinematics")
  --bullet:toBack()
  bullet.isBullet = true
  
  velocityX = 100*(event.x - bullet.x)
  velocityY = 100*(event.y - bullet.y)
  bullet.rotation = rotationAngle
  bullet:setLinearVelocity(velocityX, velocityY)
  return true
end
  
  -- block looping
  local function1, function2
  
  function function1(e)
    transition.to(target, {time = 500, x = math.random(0, 420), y = math.random(100, 680), onComplete = function2})
  end
  
  function function2(e)
    transition.to(target, {time = 500, x = math.random(0, 420), y = math.random(100, 680), onComplete = function1})
  end
  
  transition.to(target, {time = 1000, x = math.random(0,420), y = math.random(100, 680), onComplete = function1})
  
 -- event listeners
 Runtime:addEventListener("tap", aimAndShoot)
 Runtime:addEventListener("collision", onCollision)