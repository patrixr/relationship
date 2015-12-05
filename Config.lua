Config = {
   app = {
      title = "Humble Demo Game",
      author = "Patrick",
      version = "0.1",
      description = "A game skeleton to get started, hopefully"
   },
   screen = {
      background = {0,0,0},
      width = 1280,
      height = 720,
      vsync = true
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

print("#################################################################################")
print("#   ___ ___              ___.   .__             ________                        #")        
print("#  /   |   \\ __ __  _____\\_ |__ |  |   ____    /  _____/_____    _____   ____   #")
print("# /    ~    \\  |  \\/     \\| __ \\|  | _/ __ \\  /   \\  ___\\__  \\  /     \\_/ __ \\  #") 
print("# \\    Y    /  |  /  Y Y  \\ \\_\\ \\  |_\\  ___/  \\    \\_\\  \\/ __ \\|  Y Y  \\  ___/  #") 
print("#  \\___|_  /|____/|__|_|  /___  /____/\\___  >  \\______  (____  /__|_|  /\\___  > #")
print("#        \\/             \\/    \\/          \\/          \\/     \\/      \\/     \\/  #")
print("#                                                                               #")
print("#                                                                               #")
print("#  Title: " .. Config.app.title)
print("#  Author: " .. Config.app.author)
print("#  Version: " .. Config.app.version)
print("#  Description: " .. Config.app.description:gsub("\n", "\n#              "))
print("#                                                                               #")
print("#################################################################################")

return Config
