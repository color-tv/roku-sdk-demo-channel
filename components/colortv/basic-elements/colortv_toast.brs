sub init()
    m.toastbg = m.top.findNode("toastBg")
    m.toastlabel = m.top.findNode("toastLabel")
    m.toastanimation = m.top.findNode("toastAnimation")
    m.parentNode = m.top.findNode("parentNodeReference")

    m.top.ObserveField("text", "setToastText")
    m.toastanimation.ObserveField("state", "removeToast")
end sub

function setToastText()
    m.toastlabel.text = m.top.text
    characterWidthDimension = 18
    toastwidth = characterWidthDimension * Len(m.top.text)
    m.toastbg.width = toastwidth
    m.toastlabel.width = toastwidth
    screenCenterDimension = 960
    toastx = screenCenterDimension - toastwidth / 2
    m.toastbg.translation = "[" + Str(toastx) + "," + Str(m.toastbg.translation[1]) + "]"
end function

function removeToast()
    if m.toastanimation.state = "stopped" then
        m.top.parentNodeReference.removeChild(m.top)
        m.top.removeChildrenIndex(m.top.getChildCount(), 0)
        m.toastanimation.UnobserveField("state")
        m.toastbg = invalid
        m.toastlabel = invalid
        m.parentNode = invalid
        m.toastanimation = invalid
        m = invalid
    end if
end function