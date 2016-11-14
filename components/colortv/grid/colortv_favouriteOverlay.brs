sub init()
    m.bg = m.top.findNode("favouriteOverlayBackground")
    m.bg.blendColor = "0xFFFFFF00"
    m.bg.uri = "pkg:/images/colortv/color_tv_favourite_overlay.png"
    m.showAnimation = m.top.findNode("showAnimation")
    m.hideAnimation = m.top.findNode("hideAnimation")
    m.hideTimer = m.top.findNode("hideTimer")
    m.hideTimer.ObserveField("fire", "startHideAnimation")
    m.hideTimer.control = "start"
    m.parentNode = m.top.findNode("parentNodeReference")
    m.showAnimation.control = "start"
end sub

function startHideAnimation()
    m.hideAnimation.ObserveField("state", "removeOverlay")
    m.hideAnimation.control = "start"
end function

function removeOverlay()
    if m.hideAnimation.state = "stopped" then
        m.top.parentNodeReference.removeChild(m.top)
        m.top.removeChildrenIndex(m.top.getChildCount(), 0)
        m.hideAnimation.UnobserveField("state")
        m.toastbg = invalid
        m.toastlabel = invalid
        m.parentNode = invalid
        m.hideAnimation = invalid
        m = invalid
    end if
end function