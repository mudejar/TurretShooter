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

-- load necessary audio streams
local laserShot = audio.loadSound("laser_shot.wav")
local explosionSound = audio.loadSound("explosion.wav")

local explosionSoundOptions = 
{
  channel = 1,
  loops = 0,
  duration = 30000,
  fadein = 5000
}

local laserShotSoundOptions = 
{
  channel = 2,
  loops = 0,
  duration = 30000,
  fadein = 5000
}

-- add the explosion sprite sheet
local explosionOptions = 
{
  width = 128,
  height = 128,
  numFrames = 10
}

local explosionSheet = graphics.newImageSheet("explosion_spritesheet.png", explosionOptions)

-- set the score count
enemiesSlain = 0
score = display.newText(0, 100, 800, native.systemFont, 70)
function updateScore(addScore)
  local total = addScore * enemiesSlain
  score:removeSelf()
  score = display.newText(tostring(total), 100, 800, native.systemFont, 70)
  score:setFillColor(1, 1, 1)
  enemiesSlain = enemiesSlain + 1
  
  -- if the total score exceeds 1000 the game is over
  if total > 1000 then
    playerWins()
  end

  return score
end

updateScore(0)

--local function endOfExplosion(e)
--  if e.phase == "ended" then
--    e.object1:removeSelf()
--  end
--  return true
--end

local function playerWins()
  local endText = display.newText("Congratulations!")  
end

time = 1000
function speed()
  if time > 100 then
    time = time - 10
  end
  
  return time
end
-- target creation and movement
--while movingTargets
local targetSpeed = 1000
local randomX = math.random(0, 420)
local randomY = math.random(100, 680)
local target = display.newImage("squid_alien.png", randomX, randomY)
physics.addBody(target, "kinematic", {density = 3.0, friction = 0.5, bounce = 0.3})
local target1 = display.newImage("angry_smiley_alien.png", randomX, randomY)
physics.addBody(target1, "dynamic", {density = 3.0, friction = 0.5, bounce = 1.0})
local target2 = display.newImage("invader_red.png", randomX, randomY)
physics.addBody(target2, "kinematic", {density = 3.0, friction = 0.5, bounce = 1.0})
local target3 = display.newImage("squid_alien.png", randomX, randomY)
physics.addBody(target3, "kinematic", {density = 3.0, friction = 0.5, bounce = 1.0})

-- collision event handler
local function onCollision(event)
  if (event.object1.isBullet or event.object2.isBullet) then
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
      local explosionChannel = audio.play(explosionSound, explosionSoundOptions)
      if explosion.phase == "ended" then
        display.remove(explosion)
        explosion = nil
      end
      
      -- add a score after the hit
      updateScore(300)
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
  laserChannel = audio.play(laserShotSound, laserShotSoundOptions)
  return true
end
  
  -- block looping for target
  local function1, function2
  
  function function1(e)
    transition.to(target, {time = speed(), x = math.random(0, 420), y = math.random(100, 680), onComplete = function2})
  end
  
  function function2(e)
    transition.to(target, {time = speed(), x = math.random(0, 420), y = math.random(100, 680), onComplete = function1})
  end
  
transition.to(target, {time = speed(), x = math.random(0,420), y = math.random(100, 680), onComplete = function1})

-- block looping for target1
local function3, function4
  
function function3(e)
  transition.to(target1, {time = speed(), x = math.random(0, 420), y = math.random(100, 680), onComplete = function4})
end
  
function function4(e)
  transition.to(target1, {time = speed(), x = math.random(0, 420), y = math.random(100, 680), onComplete = function3})
end

transition.to(target1, {time = speed(), x = math.random(0,420), y = math.random(100, 680), onComplete = function3})

-- block looping for target2
local function5, function6
  
function function5(e)
  transition.to(target2, {time = speed(), x = math.random(0, 420), y = math.random(100, 680), onComplete = function6})
end
  
function function6(e)
  transition.to(target2, {time = speed(), x = math.random(0, 420), y = math.random(100, 680), onComplete = function5})
end

transition.to(target2, {time = speed(), x = math.random(0,420), y = math.random(100, 680), onComplete = function5})
  
-- block looping for target3
local function7, function8
  
function function7(e)
  transition.to(target3, {time = speed(), x = math.random(0, 420), y = math.random(100, 680), onComplete = function8})
end
  
function function8(e)
  transition.to(target3, {time = speed(), x = math.random(0, 420), y = math.random(100, 680), onComplete = function7})
end

transition.to(target2, {time = speed(), x = math.random(0,420), y = math.random(100, 680), onComplete = function7})

 -- event listeners
 Runtime:addEventListener("tap", aimAndShoot)
 Runtime:addEventListener("collision", onCollision)