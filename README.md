# Aegisub-Lua-Stubs
Add type hint for build-in function of aegisub

## Requirements
- VSCode
- [LuaLS](https://luals.github.io/) for enable [Lua annotations](https://luals.github.io/wiki/annotations/)

## Usage
1. install LuaLS
2. add `.luarc.json` to your workspace. Sample:
```json
{
  "$schema": "https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json",
  "runtime.version": "Lua 5.2",
  "workspace.library": [
    "C:/aegisub/automation/include",
    "C:/Aegisub-Lua-Stubs"
  ],
  "diagnostics.disable": ["lowercase-global"]
}
```
3. Code with type hint.
<img width="797" height="639" alt="image" src="https://github.com/user-attachments/assets/cbfb3139-d32c-42b6-a64c-01cfdb06506f" />
