sub init()
    m.closeTimerBg = m.top.findNode("autoCloseTimerBg")
    m.closeTimerText = m.top.findNode("autoCloseLabel")

    m.lastSecondTimer = m.top.findNode("lastSecondTimer")
    m.lastSecondTimer.ObserveField("fire", "decreaseLastSecond")

    m.top.ObserveField("width", "setAutoCloseTimerWidth")
    m.top.ObserveField("height", "setAutoCloseTimerHeight")

    m.top.ObserveField("duration", "setAutoCloseTimerDuration")
    m.top.ObserveField("currentPosition", "updateCurrentPosition")
    m.top.ObserveField("visibility", "updateVisibility")
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
end function

function updateCurrentPosition()
    if m.top.visibility then
        m.closeTimerText.text = m.top.duration - m.top.currentPosition
        decreaseAnimationIfNecessary()
        if m.top.duration - m.top.currentPosition = 1
            m.lastSecondTimer.control = "start"
        end if
    end if
end function

sub decreaseAnimationIfNecessary()
    if 15 * m.top.currentPosition / m.top.duration >= m.currentAnimationFrame then
        m.currentAnimationFrame = m.currentAnimationFrame + 1
        uri = "pkg:/images/colortv/timer/colortv_timer_" + m.currentAnimationFrame.toStr() + ".png"
        m.closeTimerBg.uri = uri
    end if
end sub

sub updateVisibility()
    if m.top.visibility then
        m.top.findNode("cachedImages").visible = false
    end if
end sub

sub decreaseLastSecond()
    m.top.currentPosition = m.top.currentPosition + 1
end sub
