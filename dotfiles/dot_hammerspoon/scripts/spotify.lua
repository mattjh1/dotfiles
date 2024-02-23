local spotify = {}

function spotify.toggle()
    if (hs.spotify.isPlaying()) then
        hs.spotify.pause()
    else
        hs.spotify.play()
    end
end

function spotify.next()
    hs.spotify.next()
end

function spotify.previous()
    hs.spotify.previous()
end

function spotify.playing()
    local album = hs.spotify.getCurrentAlbum()
    local artist = hs.spotify.getCurrentArtist()
    local track = hs.spotify.getCurrentTrack()
    local message = "Now playing: \n" .. artist .. " - " .. track .. " - " .. album

    if hs.spotify.isPlaying() ~= true then
        message = message .. "\n Paused"
    end

    hs.alert.show(message)
end

function spotify.nextNotify()
    hs.spotify.next()
    hs.timer.doAfter(0.5, spotify.playing)
end

function spotify.previousNotify()
    spotify.previous()
    hs.timer.doAfter(0.5, spotify.playing)
end

return spotify
