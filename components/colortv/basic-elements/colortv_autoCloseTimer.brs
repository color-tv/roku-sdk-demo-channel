sub init()
    m.closeTimerBg = m.top.findNode("autoCloseTimerBg")
    m.closeTimerText = m.top.findNode("autoCloseLabel")

    m.secondsTimer = m.top.findNode("secondsTimer")
    m.animationTimer = m.top.findNode("animationTimer")

    m.top.ObserveField("width", "setAutoCloseTimerWidth")
    m.top.ObserveField("height", "setAutoCloseTimerHeight")

    m.top.ObserveField("duration", "setAutoCloseTimerDuration")
    m.animationTimer.ObserveField("fire", "decreaseAnimation")
    m.secondsTimer.ObserveField("fire", "decreaseSeconds")

    m.top.ObserveField("startTimer", "startTimers")
end sub

function setAutoCloseTimerHeight()
    m.closeTimerBg.height = m.top.height
    m.closeTimerText.height = m.top.height
end function

function setAutoCloseTimerWidth()
    m.closeTimerBg.width = m.top.width
    m.closeTimerText.width = m.top.width
end function

function setAutoCloseTimerDuration()
    m.currentTime = m.top.duration
    m.currentAnimationFrame = 1
    m.closeTimerText.text = m.currentTime
    timeForTick! = m.top.duration / 15

    m.animationTimer.duration = timeForTick!
end function

function startTimers()
    if m.top.startTimer then
        m.secondsTimer.control = "start"
        m.animationTimer.control = "start"
    else
        m.secondsTimer.control = "stop"
        m.animationTimer.control = "stop"
    end if
end function

sub decreaseAnimation()
    m.currentAnimationFrame = m.currentAnimationFrame + 1
    if m.currentAnimationFrame = 16 then
        m.animationTimer.control = "stop"
    end if
    if m.top.visible then
        m.closeTimerBg.uri = "pkg:/images/colortv/timer/colortv_timer_" + m.currentAnimationFrame.toStr() + ".png"
    end if
end sub

sub decreaseSeconds()
    m.currentTime = m.currentTime - 1
    if m.currentTime < 0 then
        m.secondsTimer.control = "stop"
        m.top.closeAd = true
        return
    end if
    if m.top.visible then
        m.closeTimerText.text = m.currentTime
    end if
end sub
