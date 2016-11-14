sub init()
    m.top.ObserveField("screenshots", "onScreenshotsSet")
    m.top.ObserveField("focusedChild", "onGainFocus")
end sub

function onScreenshotsSet()
    m.screenshotUrls = m.top.screenshots
    m.indicatorsGroup = m.top.findNode("indicators")
    m.screenshotImagesGroup = m.top.findNode("screenshotsContainer")

    if m.screenshotUrls.count() MOD 2 <> 0 then 
        indicatorPosition = -4 - 24 * (m.screenshotUrls.count() - 1) / 2
        m.currentlyFocusedScreenshot = (m.screenshotUrls.count() - 1) / 2
    else
        indicatorPosition = -16 - 24 * (m.screenshotUrls.count() - 2) / 2
        m.currentlyFocusedScreenshot = m.screenshotUrls.count() / 2
    end if

    m.indicators = []
    m.screenshotImages = []

    for i=0 to m.screenshotUrls.count() - 1
        m.indicators[i] = m.indicatorsGroup.createChild("colortv_screenshotIndicator")
        m.indicators[i].translation = "[" + indicatorPosition.toStr() + ",0]"
        indicatorPosition += 24
    end for

    setScreenshotImages()

    m.indicators[m.currentlyFocusedScreenshot].focused = true
    m.screenshotImages[m.currentlyFocusedScreenshotImage].focused = true
end function

function setScreenshotImages()
    screenshotPosition = 420 - 1320 * 2
    for i = 0 to 4
        m.screenshotImages[i] = m.screenshotImagesGroup.createChild("colortv_screenshotImage")
        m.screenshotImages[i].findNode("screenshot").translation = "[" + screenshotPosition.toStr() + ",0]"
        screenshotPosition += 1320
        m.screenshotImages[i].imageUri = m.screenshotUrls[getAbsoluteImageIndex(m.currentlyFocusedScreenshot + i - 2, m.screenshotUrls.count())]
        m.screenshotImages[i].ObserveField("loadStatus", "checkIfImagesAreAlreadyLoaded")
        m.screenshotImages[i].currentPosition = i
        m.screenshotImages[i].currentScreenshotIndex = getAbsoluteImageIndex(m.currentlyFocusedScreenshot + i - 2, m.screenshotUrls.count())
    end for
    m.currentlyFocusedScreenshotImage = 2
    checkIfImagesAreAlreadyLoaded()
end function

function getAbsoluteImageIndex(index, itemsCount) as Integer
    if index > 0 then
        return index MOD itemsCount
    else
        while index < 0
          index += itemsCount
        end while
        return index
    end if
end function

sub checkIfImagesAreAlreadyLoaded()
    for i = 1 to 3
        if m.screenshotImages[i].loadStatus = "none" or m.screenshotImages[i].loadStatus = "loading"
            return
        end if
    end for
    m.top.parentNodeReference.screenshotsLoaded = true
end sub

function onGainFocus()
    if m.top.hasFocus() then
        m.indicators[m.currentlyFocusedScreenshot].focused = true
        m.screenshotImages[m.currentlyFocusedScreenshotImage].focused = true
    end if
end function

function onKeyEvent(key as String, press as Boolean) as Boolean
    keyIntercepted = false
    if key = "left" and anyIndicatorFocused() then
        keyIntercepted = true
        if press = true then
            previousScreenshot()
        end if
    elseif key = "right" and anyIndicatorFocused() then
        keyIntercepted = true
        if press = true then
            nextScreenshot()
        end if
    else if key = "down" then
        if press then
            setSliderFocused(false)
        end if
    else if key = "up" then
        if press then
            setSliderFocused(true)
        end if
    end if
    m.top.parentNodeReference.cancelAutoCloseTimer = true
    return keyIntercepted 
end function

function anyIndicatorFocused() as Boolean
    for i = 0 to m.indicators.count() - 1
        if m.indicators[i].focused
            return true
        end if
    end for
    return false
end function

function previousScreenshot()
    m.indicators[m.currentlyFocusedScreenshot].focused = false
    m.currentlyFocusedScreenshot -= 1
    if m.currentlyFocusedScreenshot < 0 then
        m.currentlyFocusedScreenshot = m.screenshotUrls.count() - 1
    end if
    m.indicators[m.currentlyFocusedScreenshot].focused = true
    moveSliderLeft()
end function

function nextScreenshot()
    m.indicators[m.currentlyFocusedScreenshot].focused = false
    m.currentlyFocusedScreenshot += 1
    if m.currentlyFocusedScreenshot >= m.screenshotUrls.count() then
        m.currentlyFocusedScreenshot = 0
    end if
    m.indicators[m.currentlyFocusedScreenshot].focused = true
    moveSliderRight()
end function

function moveSliderRight()
    m.screenshotImages[m.currentlyFocusedScreenshotImage].focused = false
    
    for i = 0 to m.screenshotImages.count() - 1
        if m.screenshotImages[i].currentPosition - 1 < 0 then
            updateLastScreenshot()
        end if
        m.screenshotImages[i].currentPosition = getAbsoluteImageIndex(m.screenshotImages[i].currentPosition - 1, m.screenshotImages.count())
    end for

    m.currentlyFocusedScreenshotImage += 1
    m.currentlyFocusedScreenshotImage = getAbsoluteImageIndex(m.currentlyFocusedScreenshotImage, m.screenshotImages.count())
    m.screenshotImages[m.currentlyFocusedScreenshotImage].focused = true
end function

function moveSliderLeft()
    m.screenshotImages[m.currentlyFocusedScreenshotImage].focused = false
    
    for i = 0 to m.screenshotImages.count() - 1
        if m.screenshotImages[i].currentPosition + 1 >= m.screenshotImages.count() then
            updateFirstScreenshot()
        end if
        m.screenshotImages[i].currentPosition = getAbsoluteImageIndex(m.screenshotImages[i].currentPosition + 1, m.screenshotImages.count())
    end for

    m.currentlyFocusedScreenshotImage = getAbsoluteImageIndex(m.currentlyFocusedScreenshotImage - 1, m.screenshotImages.count())
    m.screenshotImages[m.currentlyFocusedScreenshotImage].focused = true
end function

function updateLastScreenshot()
    nextLastScreenshotImage = m.screenshotImages[getAbsoluteImageIndex(m.currentlyFocusedScreenshotImage - 2, m.screenshotImages.count())]
    currentlyLastScreenshotImage = m.screenshotImages[getAbsoluteImageIndex(m.currentlyFocusedScreenshotImage + 2, m.screenshotImages.count())]
    nextLastScreenshotImage.currentScreenshotIndex = getAbsoluteImageIndex(currentlyLastScreenshotImage.currentScreenshotIndex + 1, m.screenshotUrls.count())
    nextLastScreenshotImage.imageUri = m.screenshotUrls[nextLastScreenshotImage.currentScreenshotIndex]
end function

function updateFirstScreenshot()
    nextFirstScreenshotImage = m.screenshotImages[getAbsoluteImageIndex(m.currentlyFocusedScreenshotImage + 2, m.screenshotImages.count())]
    currentlyFirstScreenshotImage = m.screenshotImages[getAbsoluteImageIndex(m.currentlyFocusedScreenshotImage - 2, m.screenshotImages.count())]
    nextFirstScreenshotImage.currentScreenshotIndex = getAbsoluteImageIndex(currentlyFirstScreenshotImage.currentScreenshotIndex - 1, m.screenshotUrls.count())
    nextFirstScreenshotImage.imageUri = m.screenshotUrls[nextFirstScreenshotImage.currentScreenshotIndex]
end function

function setSliderFocused(isFocused as Boolean)
    m.indicators[m.currentlyFocusedScreenshot].focused = isFocused
    m.screenshotImages[m.currentlyFocusedScreenshotImage].focused = isFocused
end function
