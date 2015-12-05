return {
   screen = {
      background = {0,0,0},
      width = 1280,
      height = 720,
      vsync = false
   },
   input = {
      keyboard = true,
      mouse = true,
      touch = true
   },
   startup = {
      screen = "screens/ShooterScreen",
      parameters = {}
   },
   debugMode = {
      active = true,
      displayFPS = true,
      drawHitboxes = true
   }
}
