sub Main()
    showChannelSGScreen()
end sub

sub showChannelSGScreen()
    screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    screen.setMessagePort(m.port)
    scene = screen.CreateScene("MainMenu")
    screen.show()
    m.menuControlEvents = scene.findNode("menuControlEvents")
    m.menuControlEvents.observeField("loadAd", m.port)
    m.menuControlEvents.observeField("loadContentRecommendation", m.port)
    adCallbacks = {
        adLoaded: adLoaded
        adClosed: adClosed
        adError: adError
        currencyEarned: currencyEarned
    }
    contentRecommendationCallbacks = {
        contentRecommendationLoaded: contentRecommendationLoaded
        contentRecommendationClicked: contentRecommendationClicked
        contentRecommendationClosed: contentRecommendationClosed
        contentRecommendationError: contentRecommendationError
    }
    m.colorTvSdk = ColorTvSdk("e11c3048-4337-4eba-ab8e-297b6581fb73")
    m.colorTvSdk.registerAdCallbacks(adCallbacks)
    m.colorTvSdk.registerContentRecommendationCallbacks(contentRecommendationCallbacks)
    m.colorTvSdk.setDebugMode(true)

    m.colorTvSdk.setUserAge("32")
    m.colorTvSdk.setUserGender("male")
    m.colorTvSdk.setUserKeywords("sports,health")

    while true
        msg = wait(GetColorTVSDKTimerInterval(), m.port)
        msgType = type(msg)
        if msgType = "roSGScreenEvent"
            if msg.isScreenClosed() then 
                print "Exiting app"
                return
            end if
        else if msgType = "roSGNodeEvent"
            if msg.getNode() = "menuControlEvents" then
                if msg.getField() = "loadAd" and not msg.getData() = "" then
                    m.menuControlEvents.loadAd = ""
                    m.colorTvSdk.loadAd(msg.getData())
                else if msg.getField() = "loadContentRecommendation" and not msg.getData() = "" then
                    m.menuControlEvents.loadContentRecommendation = ""
                    m.colorTvSdk.loadContentRecommendation(msg.getData())
                end if 
            end if
        end if
        m.colorTvSdk.timerTick()
    end while
end sub

sub adLoaded(placement as String)
    print "Ad loaded for placement: " + placement
    ColorTVSdkGetInstance().showAd(placement)
end sub

sub adClosed(placement as String)
    print "Ad has been closed for placement: " + placement
end sub

sub adError(error as Object)
    print "Ad error occured for placement: " + error.placement + " with error code: " + error.errorCode + " and error message: " + error.errorMessage
end sub

sub contentRecommendationLoaded(placement as String)
    print "Content recommendation loaded for placement: " + placement
    ColorTVSdkGetInstance().showContentRecommendation(placement)
end sub

sub contentRecommendationClicked(placement as String, contentId as String)
    print "Content recommendation has been clicked for placement: " + placement + " and content id: " + contentId
end sub

sub contentRecommendationClosed(placement as String)
    print "Content recommendation has been closed for placement: " + placement
end sub

sub contentRecommendationError(error as Object)
    print "Content recommendation error occured for placement: " + error.placement + " with error code: " + error.errorCode + " and error message: " + error.errorMessage
end sub

sub currencyEarned(currencyType as String, currencyAmount as Integer, placement as String)
    print "Currency earned for placement " + placement + ": " + currencyAmount.toStr() + " x " + currencyType
end sub

function videoTrackingExample()
    screen = CreateObject("roSGScreen")
    port = CreateObject("roMessagePort")
    screen.setMessagePort(port)

    scene = screen.CreateScene("testVideoScene")
    screen.show()

    scene.findNode("musicvideos").observeField("state", port)
    scene.findNode("musicvideos").observeField("position", port)

    while true
        msg = wait(GetColorTVSDKTimerInterval(), port)
        msgType = type(msg)
        if msgType = "roSGScreenEvent"
            if msg.isScreenClosed() then
                m.colorTvSdk.trackVideoEvents("videoId", "interrupted")
                exit while
            end if
        else if msgType = "roSGNodeEvent"
            if msg.getNode() = "musicvideos"
                m.colorTvSdk.trackVideoEvents("videoId", msg)
            end if
        end if
    end while
end function
