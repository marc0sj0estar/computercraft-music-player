--Customization
StartupScreenBackground = colors.gray       --Changes the startup screen color
StartupScreenText       = colors.white      --Changes the startup screen text color
MainMenuTextColor       = colors.black      --Changes the main menu text color
MainMenuBgColor         = colors.white      --Changes the main menu background color
MainMenuBgColor2        = colors.lightGray  --If you want alternating colors for the song list
MainMenuHighlightColor  = colors.orange     --Changes the interface highlight color
SongTextColor           = colors.black      --Changes the text color when playing a song
SongBackgroundColor     = colors.lightGray  --Changes background color when playing a song
SongHighlightColor      = colors.orange     --Changes the highlight color when playing a song
StartupAnimation        = true              --Toggles the startup animation


------------------
-- UI Functions --
------------------


function PaintPause()
    term.setCursorPos(1, 1)
    term.setBackgroundColour(SongHighlightColor)
    term.setTextColor(SongTextColor)
    write("Back")
    local image = paintutils.loadImage("pause.nfp")
    local x = HalfX - 5
    local y = HalfY - 2
    paintutils.drawImage(image, x, y)
end

function PaintPlay()
    term.setCursorPos(1, 1)
    term.setBackgroundColour(SongHighlightColor)
    term.setTextColor(SongTextColor)
    write("Back")
    term.setTextColor(MainMenuTextColor)
    local image = paintutils.loadImage("play.nfp")
    local x = HalfX - 5
    local y = HalfY - 2
    paintutils.drawImage(image, x, y)
end

function PaintReadingDisk()
    local i = 0
    local x = HalfX - 5
    local y = HalfY - 2
    while i < 12 do
        local image = paintutils.loadImage("disk.nfp")
        paintutils.drawImage(image, x, y)
        os.sleep(0.1)
        local image = paintutils.loadImage("disk2.nfp")
        paintutils.drawImage(image, x, y)
        os.sleep(0.1)
        local image = paintutils.loadImage("disk3.nfp")
        paintutils.drawImage(image, x, y)
        os.sleep(0.1)
        local image = paintutils.loadImage("disk4.nfp")
        paintutils.drawImage(image, x, y)
        os.sleep(0.1)

        i = i + 1
    end
end

function DrawButtons()
    term.setCursorPos(1, ScreenSizeY)
    term.setTextColor(MainMenuTextColor)
    term.setBackgroundColour(MainMenuHighlightColor)
    write("<")
    if ScreenSizeY % 2 == 0 then
        term.setBackgroundColour(MainMenuBgColor2)
    else
        term.setBackgroundColour(MainMenuBgColor)
    end
    for i = 2, ScreenSizeX - 1 do
        write(" ")
    end
    term.setBackgroundColour(MainMenuHighlightColor)
    write(">")
    term.setBackgroundColour(MainMenuBgColor)
end

function PrintSongTitle(song, color)
    --Prints a song title in a specific color
    local songStringLength = string.len(song)
    if songStringLength > ScreenSizeX then
        song = string.sub(song, 1, ScreenSizeX)
    else
        local emptyString = ""
        for i = songStringLength, ScreenSizeX do
            emptyString = emptyString .. " "
        end
        song = song .. emptyString
    end
    term.setBackgroundColour(color)
    write(song)
end

function SongMenuTitleAndButtons(songName)
    if string.len(songName) > ScreenSizeX - 4 then
        songName = string.sub(songName, 1, ScreenSizeX - 4)
    end
    paintutils.drawLine(1, ScreenSizeY, ScreenSizeX, ScreenSizeY, SongHighlightColor)
    term.setBackgroundColour(SongHighlightColor)
    term.setTextColor(SongTextColor)
    term.setCursorPos(3, ScreenSizeY)
    write(songName)
    term.setCursorPos(1, ScreenSizeY)
    write("<")
    term.setCursorPos(ScreenSizeX, ScreenSizeY)
    write(">")
end

-------------------
-- AUX FUNCTIONS --
-------------------

function PressedPlay(x, y)
    if (x >= (HalfX - 2)) and (x <= (HalfX + 2)) then
        if (y >= (HalfY - 2)) and (y <= HalfY + 2) then
            return true
        end
    end
    return false
end

function PressedBack(x, y)
    if ((x >= 1) and (x <= 4)) and y == 1 then
        return true
    end
    return false
end

function PressedPrevious(x, y)
    if x == 1 and y == ScreenSizeY then
        return true
    end
    return false
end

function PressedNext(x, y)
    if x == ScreenSizeX and y == ScreenSizeY then
        return true
    end
    return false
end

function FindPeripherals()
    local peripheralsFound = false
    local monitor, drive, speaker
    while not peripheralsFound do
        monitor = peripheral.find("monitor")
        drive = peripheral.find("drive")
        speaker = {peripheral.find("speaker")}
        if not (monitor == nil) and not (drive == nil) and not (speaker == nil) then
            print("Starting player! \nInteract with it using the monitor")
            return monitor, drive, speaker
        else
            print("Please connect all the required peripherals")
            if monitor == nil then print("monitor -> not connected") else print("monitor -> connected") end
            if drive == nil then print("drive -> not connected") else print("drive -> connected") end
            if speaker == nil then print("speaker -> not connected") else print("speaker -> connected") end
            os.pullEvent("peripheral")
        end
    end
end

function PlayOnSpeakers(buffer)
    local aux
    for _, speaker in pairs(Speaker) do
        aux = (not speaker.playAudio(buffer))
    end
    return aux
end

function AwaitSpeakers()
    for _, speaker in pairs(Speaker) do
        os.pullEvent("speaker_audio_empty")
    end
end

function InsertTapeSound()
    local file = io.open("disk/audio.dfpwm")
    if file == nil then
        for chunk in io.lines("tape.dfpwm", 16 * 1024) do
            local buffer = Decoder(chunk)
            while PlayOnSpeakers(buffer) do
                AwaitSpeakers()
            end
        end
        PaintReadingDisk()
    end
end

function EjectTapeSound()
    local file = io.open("disk/audio.dfpwm")
    if file == nil then
        for chunk in io.lines("tapeeject.dfpwm", 16 * 1024) do
            local buffer = Decoder(chunk)
            while PlayOnSpeakers(buffer) do
                AwaitSpeakers()
            end
        end
    end
end

function ShowSongs(page)
    shell.execute("clear")
    local listLength = ScreenSizeY - 2
    local startingSong = 1 + (listLength * (page - 1))
    PrintSongTitle("Page: " .. page, MainMenuHighlightColor)
    for i = startingSong, (startingSong + listLength) - 1 do
        if not (Songs[i] == nil) then
            if i % 2 == 0 then
                PrintSongTitle(Songs[i], MainMenuBgColor)
            else
                PrintSongTitle(Songs[i], MainMenuBgColor2)
            end
        else
            if i % 2 == 0 then
                PrintSongTitle(" ", MainMenuBgColor)
            else
                PrintSongTitle(" ", MainMenuBgColor2)
            end
        end
    end
    DrawButtons()
end

function PlaySong(songId)
    --Plays the song
    term.setCursorPos(1, 1)
    term.setBackgroundColour(SongBackgroundColor)
    shell.execute("clear")
    PaintPause()
    SongMenuTitleAndButtons(Songs[songId])
    for chunk in io.lines("disk/" .. Songs[songId], 512) do
        local buffer = Decoder(chunk)
        while PlayOnSpeakers(buffer) do
            --Music playing loop
            
            local eventData = { os.pullEvent() }
            local event = eventData[1]
            if event == "monitor_touch" then
                --The monitor was touched
                local x, y = eventData[3], eventData[4]
                if PressedPlay(x, y) then
                    term.setBackgroundColour(SongBackgroundColor)
                    shell.execute("clear")
                    PaintPlay()
                    SongMenuTitleAndButtons(Songs[songId])
                    local paused = true
                    while paused do
                        local eventData = { os.pullEvent() }
                        local event = eventData[1]
                        if event == "monitor_touch" then
                            local x, y = eventData[3], eventData[4]
                            if PressedPlay(x, y) then
                                paused = false
                                term.setBackgroundColour(SongBackgroundColor)
                                shell.execute("clear")
                                PaintPause()
                                SongMenuTitleAndButtons(Songs[songId])
                            elseif PressedBack(x, y) then
                                return nil
                            elseif PressedPrevious(x, y) then
                                return songId - 1
                            elseif PressedNext(x, y) then
                                return songId + 1
                            end
                        elseif  event == "disk_eject" then
                            return
                        end
                    end
                elseif PressedBack(x, y) then
                    return nil
                elseif PressedPrevious(x, y) and songId > 1 then
                    return songId - 1
                elseif PressedNext(x, y) and songId < #Songs then
                    return songId + 1
                end
            elseif event == "disk_eject" then
                return nil
            end
        end
        if not Drive.isDiskPresent() then
            return nil
        end
    end
    if songId < #Songs then return songId + 1 else return nil end
end

------------------
--     MAIN     --
------------------

--Peripheral check and setup
Monitor, Drive, Speaker = FindPeripherals()
Monitor.setTextScale(0.5)
term.redirect(Monitor)

--Global variables
ScreenSizeX, ScreenSizeY = term.getSize()
HalfX = math.floor((ScreenSizeX / 2) + 0.5)
HalfY = math.floor((ScreenSizeY / 2) + 0.5)
local dfpwm = require("cc.audio.dfpwm")
Decoder = dfpwm.make_decoder()

while true do
    term.setBackgroundColour(StartupScreenBackground)
    term.setTextColor(StartupScreenText)
    shell.execute("clear")

    -- Check for a disk
    if not Drive.isDiskPresent() then
        print("Please insert a disk")
        os.pullEvent("disk")
        shell.execute("clear")
    end
    print("Reading disk")

    if StartupAnimation then InsertTapeSound() end
    term.setBackgroundColour(MainMenuBgColor)
    shell.execute("clear")
    term.setTextColor(MainMenuTextColor)

    if not Drive.isDiskPresent() then os.reboot() end

    Songs = fs.list("/disk")
    MaxPage = math.ceil(#Songs / (ScreenSizeY - 2) + 0.5)
    local showMenu = true
    local currentPage = 1
    local currentSong = 0
    local pause = true
    local eventData = nil


    while showMenu do --showMenu turns off when the disk is ejected
        
        if not (currentSong == 0) then
            local nextSong = PlaySong(currentSong)
            if not (nextSong == nil) then currentSong = nextSong
            else
                currentSong = 0
            end
            if not Drive.isDiskPresent() then
                EjectTapeSound()
                showMenu = false
            end
        else
            --Wait for button push
            ShowSongs(currentPage)
            eventData = { os.pullEvent() }
            local event = eventData[1]
    
            --disk_eject or monitor_touch event
            if event == "disk_eject" then
                showMenu = false
                EjectTapeSound()
            elseif event == "monitor_touch" then
                local x, y = eventData[3], eventData[4]
                --Clicked on a song
                if y > 1 and y < ScreenSizeY then
                    if not (Songs[(y - 1) + ((currentPage - 1) * (ScreenSizeY - 2))] == nil) then
                        currentSong = ((y - 1) + ((currentPage - 1) * (ScreenSizeY - 2)))
                    end
                    -- <
                elseif y == ScreenSizeY and x == 1 then
                    if currentPage > 1 then
                        ShowSongs(currentPage - 1)
                        currentPage = currentPage - 1
                    end
                    -- >
                elseif y == ScreenSizeY and x == ScreenSizeX then
                    if currentPage + 1 <= MaxPage then
                        ShowSongs(currentPage + 1)
                        currentPage = currentPage + 1
                    end
                    -- Play / Pause
                end
                --Clicked not valid place
            end
        end
        
        
    end
end
