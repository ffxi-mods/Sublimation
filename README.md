# Sublimation

AutoHotKey script to tab between FFXI windows. Useful for dual boxing without multi-casting keystrokes.

## Requirements

Install these first:

- [AutoHotKey](https://www.autohotkey.com/)

## tldr;

1. Download the release package and unzip.
2. Open the `Sublimation.ahk` script
3. Edit the `Characters` section.
4. Compile the script.
5. Login to FFXI with both characters.
6. Run the program.

## What Do

First, download the release package from the [releases page](https://github.com/ffxi-mods/Sublimation/releases).

Secondly, open the `Sublimation.ahk` script and edit the `CharPrimary` and `CharSecondary` variables. The values should be the windows title name of the FFXI characters you're logged in with.

If you're using [Ashita](https://www.ashitaxi.com/) (or [Windower](http://www.windower.net/)), once you've logged into a character, the FFXI window title should have the same name as the character you've logged in as. These are the names you should put on the `CharPrimary` and `CharSecondary` variables.

For example, if I was dual boxing with two characters, Biggs and Wedge, this is the config I would use:

```ahk
13  ;------------------------------------------------------------------------------
14  ; Characters
15  ;------------------------------------------------------------------------------
16  CharPrimary := "Biggs"
17  CharSecondary := "Wedge"
```

Third, compile the script. You shouldn't be using random executables from the internet in the first place! Also, you will need to compile the script for it to work properly with FFXI.

To compile the script, right-click on the `Sublimation.ahk` file and select `Compile Script` from the Windows context menu. This option should be available if you've installed AutoHotKey (as per the [Requirements](#requirements) section). This should generate a `Sublimation.exe` executable file.

Next, Login to FFXI with your both characters. This should set the correct window titles.

Finally, run the compiled executable as administrator (right-click -> Run as administrator). If you don't run as administrator, key binds won't be detected properly while FFXI is active. ***This last step is important for the program to work properly!!***

## Hotkey Reference

- `Windows Key + Tab`: Toggle between FFXI windows.
- `F12`: Suspend the script.
- `Windows Key + F12`: Exit the AHK script.
