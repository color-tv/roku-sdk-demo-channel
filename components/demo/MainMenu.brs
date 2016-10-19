sub init()
    print "=============================== NEW INSTANCE ==============================="

    m.menuButtons = [ m.top.findNode("showDiscoveryCenter"),
                    m.top.findNode("showAppFeature"),
                    m.top.findNode("showDirectEngagement"),
                    m.top.findNode("showVideo"),
                    m.top.findNode("showContentRecommendation")
                    ]

    m.menuControlEvents = m.top.findNode("menuControlEvents")
    
    discoveryCenterButtonClickFunction = function ()
        m.menuControlEvents.loadAd = "DemoAppWall"
    end function

    appFeatureButtonClickFunction = function ()
        m.menuControlEvents.loadAd = "DemoInterstitial"
    end function

    directEngagementButtonClickFunction = function ()
        m.menuControlEvents.loadAd = "DemoFullScreen"
    end function

    videoButtonClickFunction = function ()
        m.menuControlEvents.loadAd = "DemoVideo"
    end function

    contentRecommendationButtonClickFunction = function ()
        m.menuControlEvents.loadContentRecommendation = "BetweenLevels"
    end function

    m.buttonListeners = [ discoveryCenterButtonClickFunction,
                        appFeatureButtonClickFunction,
                        directEngagementButtonClickFunction,
                        videoButtonClickFunction,
                        contentRecommendationButtonClickFunction
                        ]

    m.currentlySelectedButton = 0
    m.menuButtons[m.currentlySelectedButton].buttonFocused = true
    m.adIsShown = false
    m.top.SetFocus(true)
End sub

function onKeyEvent(key as String, press as Boolean) as Boolean
    keyIntercepted = false
    if key = "left" and press = true then
        keyIntercepted = true
        m.menuButtons[m.currentlySelectedButton].buttonFocused = false
        m.currentlySelectedButton--
        if m.currentlySelectedButton < 0 then
            m.currentlySelectedButton = m.menuButtons.Count() - 1
        end if
        m.menuButtons[m.currentlySelectedButton].buttonFocused = true
    elseif key = "right" and press = true then
        keyIntercepted = true
        m.menuButtons[m.currentlySelectedButton].buttonFocused = false
        m.currentlySelectedButton++
        if m.currentlySelectedButton >= m.menuButtons.Count() then
            m.currentlySelectedButton = 0
        end if
        m.menuButtons[m.currentlySelectedButton].buttonFocused = true
    elseif key = "OK" then
        keyIntercepted = true
        m.menuButtons[m.currentlySelectedButton].buttonClicked = press
        if not press then
            m.buttonListeners[m.currentlySelectedButton]()
        end if
    end if
    return keyIntercepted 
end function
