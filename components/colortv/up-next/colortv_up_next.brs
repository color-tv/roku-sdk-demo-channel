sub init()
    m.container = m.top.findNode("viewContainer")
    m.title = m.top.findNode("title")
    m.description = m.top.findNode("description")
    m.thumbnail = m.top.findNode("thumbnail")
    m.autoplayTimer = m.top.findNode("autoplayTimer")
    m.readyToDisplay = false
    m.shouldDisplayAfterThumbnailLoads = false
    m.videoPaused = false
    m.thumbnail.ObserveField("loadStatus", "thumbnailLoadStatusChanged")
    m.top.ObserveField("show", "tryToPresentView")
    m.top.ObserveField("videoNodeReference", "assignVideoListeners")
    m.top.ObserveField("dataModel", "setDataToView")
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
    isVideoPlaying = (m.top.videoNodeReference.state = "playing" or m.top.videoNodeReference.state = "finished")
    if key = "back" and press and isVideoPlaying and m.container.visible then
        hideView()
        m.top.cancelled = true
        return true
    end if
    return false
end function

function tryToPresentView()
    if m.readyToDisplay and not m.top.cancelled and not m.top.videoMoved then
        presentView()
    else
        m.shouldDisplayAfterThumbnailLoads = true
    end if
end function

function presentView()
    m.container.visible = true
    m.container.setFocus(true)
    startAutoplayTimer()
end function

function startAutoplayTimer()
    m.autoplayTimer.duration = getCurrentTimeUntilVideoEnds()
    m.autoplayTimer.startTimer = true
    m.autoplayTimer.ObserveField("closeAd", "autoplayTimerFinished")
end function

function stopAutoPlayTimer()
    m.autoplayTimer.startTimer = false
end function

function autoplayTimerFinished()
    hideView()
end function

function hideView()
    m.container.visible = false
    m.autoplayTimer.startTimer = false
end function

function thumbnailLoadStatusChanged()
    if m.thumbnail.loadStatus = "ready" or m.thumbnail.loadStatus = "failed" then
        m.readyToDisplay = true
        if m.shouldDisplayAfterThumbnailLoads then
            tryToPresentView()
        end if
    end if
end function

function assignVideoListeners()
    m.top.videoNodeReference.ObserveField("state", "updateViewWithVideoStateChanged")
end function

function updateViewWithVideoStateChanged()
    currentState = m.top.videoNodeReference.state
    if currentState = "buffering" or currentState = "paused" or currentState = "error" then
        hideView()
        m.top.videoMoved = true
    end if
end function

function getCurrentTimeUntilVideoEnds() as Integer
    return m.top.videoNodeReference.duration - m.top.videoNodeReference.position
end function

function setDataToView()
    data = m.top.dataModel
    m.title.text = data.title.trim()
    m.description.text = data.description.trim()
    if data.thumbnailUrl <> invalid
        m.thumbnail.uri = data.thumbnailUrl
    else
        m.thumbnail.uri = "pkg:/images/colortv/color_tv_grid_bg_placeholder.jpg"
    end if
end function
