sub init()
    m.top.currentPosition = -100

    m.screenshot = m.top.findNode("screenshot")
    m.screenshot.ObserveField("loadStatus", "onLoadStatusChanged")

    m.scaleUpAnimation = m.top.findNode("scaleUpAnimation")
    m.scaleDownAnimation = m.top.findNode("scaleDownAnimation")

    m.top.ObserveField("focused", "focusIndicator")
    m.top.ObserveField("imageUri", "setImage")
    m.top.ObserveField("currentPosition", "currentPositionChanged")
end sub

function onLoadStatusChanged()
    m.top.loadStatus = m.screenshot.loadStatus
end function

function focusIndicator()
    if m.top.focused then
        m.scaleUpAnimation.control = "start"
    else 
        m.scaleDownAnimation.control = "start"
    end if
end function

function setImage()
    m.top.findNode("screenshot").uri = m.top.imageUri
end function

function currentPositionChanged()
    if m.currentPosition = invalid then
        m.currentPosition = m.top.currentPosition
    else
        positionDelta = m.top.currentPosition - m.currentPosition
        animationToPerform = invalid
        if positionDelta = 4 then
            moveScreenshotToLastPosition()
        else if positionDelta = -4 then
            moveScreenshotToFirstPosition()
        else if positionDelta = -1 then
            animationToPerform = chooseRightAnimationToPerform()
        else if positionDelta = 1 then
            animationToPerform = chooseLeftAnimationToPerform()
        end if
        if animationToPerform <> invalid then
            performAnimation(animationToPerform)
        end if
        m.currentPosition = m.top.currentPosition
    end if
end function

function moveScreenshotToLastPosition()
    m.screenshot.translation = "[2640,0]"
end function

function moveScreenshotToFirstPosition()
    m.screenshot.translation = "[-2640,0]"
end function

function chooseRightAnimationToPerform()
    if m.top.currentPosition = 2 then
        return "moveRightToFocusedAnimation"
    else if m.top.currentPosition = 1 then
        return "moveRightFromFocusedAnimation"
    else if m.top.currentPosition = 0
        return "moveRightToHiddenAnimation"
    else 
        return "moveRightFromHiddenAnimation"
    end if
end function

function chooseLeftAnimationToPerform()
    if m.top.currentPosition = 2 then
        return "moveLeftToFocusedAnimation"
    else if m.top.currentPosition = 1 then
        return "moveLeftFromHiddenAnimation"
    else if m.top.currentPosition = 3
        return "moveLeftFromFocusedAnimation"
    else
        return "moveLeftToHiddenAnimation"
    end if
end function

function performAnimation(animationId)
    m.top.findNode(animationId).control = "start"
end function
