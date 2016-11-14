sub init()
    m.loaderImage = m.top.findNode("progressLoaderImage")
    m.loaderAnimation = m.top.findNode("rotateAnimation")
    m.loaderImage.observeField("loadStatus", "startAnimation")
    startAnimation()
end sub

function startAnimation()
    if m.loaderImage.loadStatus = "ready" then
        m.loaderAnimation.control = "start"
    end if
end function
