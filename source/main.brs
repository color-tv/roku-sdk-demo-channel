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
    upNextCallbacks = {
        upNextLoaded: upNextLoaded
        upNextClicked: upNextClicked
        upNextError: upNextError
    }
    m.colorTvSdk = ColorTvSdk("e11c3048-4337-4eba-ab8e-297b6581fb73")
    m.colorTvSdk.registerAdCallbacks(adCallbacks)
    m.colorTvSdk.registerContentRecommendationCallbacks(contentRecommendationCallbacks)
    m.colorTvSdk.registerUpNextCallbacks(upNextCallbacks)
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

sub contentRecommendationClicked(placement as String, contentData as Object)
    print "Content recommendation has been clicked for placement: " + placement + " and content id: " + contentData.videoId
    print "video params:"
    for each param in contentData["videoParams"]
        print Chr(34) + param + Chr(34) + ": " + Chr(34) + contentData["videoParams"][param].toStr() + Chr(34)
    end for
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

sub upNextLoaded()
    print "UpNext has been loaded"
end sub

sub upNextClicked(contentData as Object)
    print "UpNext has been clicked for video id: " + contentData.videoId + " + and content url: " + contentData.videoUrl
    print "video params:"
    for each param in contentData["videoParams"]
        print Chr(34) + param + Chr(34) + ": " + Chr(34) + contentData["videoParams"][param].toStr() + Chr(34)
    end for
end sub

sub upNextError(error as Object)
    print "UpNext error occured with error code: " + error.errorCode + " and error message: " + error.errorMessage
end sub

function contentRecommendationSceneGraphExample()
    screen = CreateObject("roSGScreen")
    port = CreateObject("roMessagePort")
    screen.setMessagePort(port)

    scene = screen.CreateScene("testVideoScene")
    screen.show()

    scene.findNode("musicvideos").observeField("state", port)
    scene.findNode("musicvideos").observeField("position", port)

    upNextCallbacks = {
        upNextLoaded: upNextLoaded
        upNextClicked: upNextClicked
        upNextError: upNextError
    }
    contentRecommendationCallbacks = {
        contentRecommendationLoaded: contentRecommendationLoaded
        contentRecommendationClicked: contentRecommendationClicked
        contentRecommendationClosed: contentRecommendationClosed
        contentRecommendationError: contentRecommendationError
    }
    m.colorTvSdk = ColorTvSdk("e11c3048-4337-4eba-ab8e-297b6581fb73")
    m.colorTvSdk.setDebugMode(true)
    m.colorTvSdk.registerUpNextCallbacks(upNextCallbacks)
    m.colorTvSdk.registerContentRecommendationCallbacks(contentRecommendationCallbacks)

    m.colorTvSdk.loadUpNextScenegraph(scene.findNode("musicvideos"), port, 15)
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
                if msg.getField() = "state" and msg.getData() = "finished" then
                    m.colorTvSdk.loadContentRecommendation("VideoEnd")
                end if
            else if msg.getNode() = "colortv_up_next"
                m.colorTvSdk.upNextEventOccurred(msg)
            end if
        end if
    end while
end function

function contentRecommendationCanvasVideoExample()
    port = CreateObject("roMessagePort")

    canvas = CreateObject("roImageCanvas")
    canvas.SetMessagePort(port)
    canvas.SetLayer(1, {"color": "#000000"})
    canvas.Show()

    di = CreateObject("roDeviceInfo")
    player = CreateObject("roVideoPlayer")
    player.SetMessagePort(port)
    player.SetDestinationRect({h:di.GetDisplaySize().h,w:di.GetDisplaySize().w,x:0,y:0})
    player.SetPositionNotificationPeriod(1)
    stream = {}
    stream.url = "https://roku.s.cpl.delvenetworks.com/media/59021fabe3b645968e382ac726cd6c7b/60b4a471ffb74809beb2f7d5a15b3193/roku_ep_111_segment_1_final-cc_mix_033015-a7ec8a288c4bcec001c118181c668de321108861.m3u8"
    stream.title = "Test Video"
    stream.streamformat = "hls"
    videoContent = {streamformat: "hls", streams: [stream]}
    player.AddContent(videoContent)
    player.Play()

    upNextCallbacks = {
        upNextLoaded: upNextLoaded
        upNextClicked: upNextClicked
        upNextError: upNextError
    }
    contentRecommendationCallbacks = {
        contentRecommendationLoaded: contentRecommendationLoaded
        contentRecommendationClicked: contentRecommendationClicked
        contentRecommendationClosed: contentRecommendationClosed
        contentRecommendationError: contentRecommendationError
    }
    m.colorTvSdk = ColorTvSdk("e11c3048-4337-4eba-ab8e-297b6581fb73")
    m.colorTvSdk.setDebugMode(true)
    m.colorTvSdk.registerUpNextCallbacks(upNextCallbacks)
    m.colorTvSdk.registerContentRecommendationCallbacks(contentRecommendationCallbacks)

    while true
        msg = wait(GetColorTVSDKTimerInterval(), port)
        msgType = type(msg)
        if type(msg) = "roVideoPlayerEvent"
            m.colorTvSdk.trackVideoEvents("videoId", msg)
            if msg.isFullResult()
                m.colorTvSdk.loadContentRecommendation("VideoEnd")
                exit while
            else if msg.isPartialResult()
                exit while
            else if msg.isRequestFailed()
                exit while
            else if msg.isStatusMessage() and msg.GetMessage() = "start of play"
                canvas.ClearLayer(2)
                canvas.SetLayer(1, {"color": "#00000000", "CompositionMode": "Source"})
                m.colorTvSdk.loadUpNextCanvas(player, canvas, port, 15)
            end if
        else if type(msg) = "roImageCanvasEvent" and msg.isRemoteKeyPressed()
            if m.colorTvSdk.shouldCloseUpNextCanvas(msg) then
            else if msg.GetIndex() = 2 or msg.GetIndex() = 0 then ' BACK or UP
                exit while
            end if
        end if
        ColorTVSdkGetInstance().timerTick()
    end while
end function
