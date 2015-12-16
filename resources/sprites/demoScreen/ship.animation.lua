return {
	imageSrc = "resources/sprites/demoScreen/sprite_sheet_ship.png",
	defaultState = "flying",
	states = {
		-- 1st line
		flying = { -- the name of the state is arbitrary
			frameCount = 3,
			offsetX = 0,
			offsetY = 0,
			frameW = 86,
			frameH = 35,
			nextState = "flying", -- we loop the running state
			switchDelay = 0.1
		},
		-- 2nd line
		--[[
		jump = {
			frameCount = 3,
			offsetX = 0,
			offsetY = 100,
			frameW = 100,
			frameH = 150, -- the frame height can change between states
			nextState = "running", -- after the jump is finished, we switch back to running
			switchDelay = 0.16
		},
		-- 3rd line
		attack = {
			frameCount = 3,
			offsetX = 0,
			offsetY = 250,
			frameW = 100,
			frameH = 100,
			nextState = "running",
			switchDelay = 0.1
		}
		]]--
	}
}
