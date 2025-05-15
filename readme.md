# FluxionUI

FluxionUI is a lightweight Roblox UI library designed for executor scripts (e.g., Fluxion) to easily create customizable GUIs with player info, tabs, buttons, and labels.

---

## Features

- Create a UI window with player avatar and username display  
- Add tabs, buttons, and labels easily  
- Toggle UI visibility with a keybind (RightShift)  
- Classic Roblox notification on load  
- Can be loaded directly from GitHub via HTTP request in executors  

---

## Usage in Executors (Fluxion, etc.)

Load the UI library directly from GitHub and start creating your UI:

```lua
local FluxionUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/YourUsername/YourRepo/main/FluxionUI.lua"))()

FluxionUI:CreateWindow("My Executor UI")
FluxionUI:CreateTab("Main")

FluxionUI:CreateLabel("Welcome to FluxionUI!")
FluxionUI:CreateButton("Click Me", function()
    print("Button clicked!")
end)
