sub init()
    m.top.impressionCountedArray = []

    m.progressSpinner = m.top.findNode("progressSpinner")
    m.progressSpinnerDialog = m.top.findNode("progressSpinnerDialog")
    m.progressSpinnerDialog.visible = false

    m.top.setFocus(true)
    m.currentlyFocusedViewIndex = 0
    m.currentlyFocusedView = m.top.findNode("gridElement" + m.currentlyFocusedViewIndex.toStr())

    m.colorTvDiscoveryCenterEvents = m.top.findNode("colorTvDiscoveryCenterEvents")
    m.colorTvContentRecommendationEvents = m.top.findNode("colorTvContentRecommendationEvents")
    m.colorTvGridEvents = m.top.findNode("colorTvGridEvents")
    m.colorTvGridEvents.ObserveField("moreDataUrl", "moreDataDownloadFinished")

    m.recommendationsForLabel = m.top.findNode("becauseYouWatchedLabel")
    m.recommendationsForTitleLabel = m.top.findNode("becauseYouWatchedTitleLabel")
    m.recommendationsForContainer = m.top.findNode("becauseYouWatchedContainer")

    initAnimations()

    initGridElementsViews()

    m.engagementFormShown = false
    m.loadingMoreData = false
end sub

function updateViewWithData(dataArray)
    m.dataArray = dataArray
    setRegularCustomFont(dataArray[0].regularCustomFont)
    setBoldCustomFont(dataArray[0].boldCustomFont)
    for i = 0 to dataArray.count() - 1
        m.dataArray[i].index = i
    end for
    if not m.loadingMoreData then
        removeGridElementsIfNecessary()
        setGridAndAnimationDimensions()
        for i = 0 to m.gridElementViews.count() - 1 
            m.gridElementViews[i].contentModel = m.dataArray[i]
            setFavouriteButtonColors(m.gridElementViews[i])
            setTextColors(m.gridElementViews[i])
            setBackgroundColors(m.gridElementViews[i])
            m.gridElementViews[i].findNode(getBackgroundImageNodeName()).findNode("backgroundImage").ObserveField("loadStatus", "checkIfAlreadyLoaded")
        end for
        setFeatured()
        setRecommendationsFor()
        checkIfAlreadyLoaded()
    else
        updateGridViewsPositionsAndContent("last")
        m.showNewDataAnimation.control = "start"
        m.showNewDataAnimation.ObserveField("state", "animationFinished")
        updateScreenPositions(-1)
        m.clippedRight = true
    end if
end function

function getBackgroundImageNodeName()
    if m.top.dataModel.type = "discovery" then
        nodeName = "gridDiscoveryElement"
    else
        if m.top.dataModel.format <> invalid and m.top.dataModel.format = "simple" then
            nodeName = "gridContentSimplifiedElement"
        else
            nodeName = "gridContentElement"
        end if
    end if
    return nodeName
end function

function setFavouriteButtonColors(gridElementView)
    if m.top.dataModel.favoriteButton <> invalid then
        if m.top.dataModel.favoriteButton.backgroundColor <> invalid and m.top.dataModel.favoriteButton.backgroundColor.normal <> invalid then
            backgroundNormal = m.top.dataModel.favoriteButton.backgroundColor.normal
        else
            backgroundNormal = {r:255,g:255,b:255}
        end if
        if m.top.dataModel.favoriteButton.backgroundColor <> invalid and m.top.dataModel.favoriteButton.backgroundColor.selected <> invalid then
            backgroundSelected = m.top.dataModel.favoriteButton.backgroundColor.selected
        else
            backgroundSelected = {r:167,g:50,b:49}
        end if
        if m.top.dataModel.favoriteButton.textColor <> invalid and m.top.dataModel.favoriteButton.textColor.normal <> invalid then
            textNormal = m.top.dataModel.favoriteButton.textColor.normal
        else
            textNormal = {r:74,g:74,b:74}
        end if
        if m.top.dataModel.favoriteButton.textColor <> invalid and m.top.dataModel.favoriteButton.textColor.selected <> invalid then
            textSelected = m.top.dataModel.favoriteButton.textColor.selected
        else
            textSelected = {r:255,g:255,b:255}
        end if
        gridElementView.favouriteButtonColor = interpolateColors(backgroundNormal, backgroundSelected)
        gridElementView.favouriteButtonTextColor = interpolateColors(textNormal, textSelected)
    end if
end function

function setTextColors(gridElementView)
    if m.top.dataModel.textColor <> invalid then
        if m.top.dataModel.textColor.normal <> invalid then
            textNormal = m.top.dataModel.textColor.normal
        else
            textNormal = {r:74,g:74,b:74}
        end if
        if m.top.dataModel.textColor.selected <> invalid then
            textSelected = m.top.dataModel.textColor.selected
        else
            textSelected = {r:255,g:255,b:255}
        end if
        gridElementView.textColor = interpolateColors(textNormal, textSelected)
    end if
end function

function setBackgroundColors(gridElementView)
    if m.top.dataModel.backgroundColor <> invalid then
        if m.top.dataModel.backgroundColor.normal <> invalid then
            backgroundNormal = m.top.dataModel.backgroundColor.normal
        else
            backgroundNormal = {r:255,g:255,b:255}
        end if
        if m.top.dataModel.backgroundColor.selected <> invalid then
            backgroundSelected = m.top.dataModel.backgroundColor.selected
        else
            backgroundSelected = {r:228,g:9,b:19}
        end if
        gridElementView.backgroundColor = interpolateColors(backgroundNormal, backgroundSelected)
    end if
end function

function initAnimations()
    m.animations = []
    m.moveSlightlyLeftAnimation = m.top.findNode("moveSlightlyLeftAnimation")
    m.moveSlightlyRightAnimation = m.top.findNode("moveSlightlyRightAnimation")
    m.moveFullyLeftAnimation = m.top.findNode("moveFullyLeftAnimation")
    m.moveFullyRightAnimation = m.top.findNode("moveFullyRightAnimation")
    m.showFeaturedAnimation = m.top.findNode("showFeaturedAnimation")
    m.showNewDataAnimation = m.top.findNode("showNewDataAnimation")
    m.animations.push(m.showNewDataAnimation)
    m.animations.push(m.moveSlightlyLeftAnimation)
    m.animations.push(m.moveSlightlyRightAnimation)
    m.animations.push(m.moveFullyLeftAnimation)
    m.animations.push(m.moveFullyRightAnimation)
    m.animations.push(m.showFeaturedAnimation)
    m.animationTranslation = m.top.findNode("animationTranslation")
    m.animationTranslation.ObserveField("translation", "animateGridTranslation")
    m.clippedRight = true

    m.showFeaturedAnimation.ObserveField("state", "animationFinished")
end function

function initGridElementsViews()
    m.gridElementViews = []
    j = 0
    for i = 0 to 7
        m.gridElementViews.push(m.top.findNode("gridElement" + i.toStr()))
        m.gridElementViews[i].startTranslation = m.gridElementViews[i].translation
        m.gridElementViews[i].currentScreenPosition = j
        m.gridElementViews[i].currentlyShownElementIndex = i
        m.gridElementViews[i].parentNodeReference = m.top
        m.gridElementViews[i].impressionNode = m.colorTvGridEvents
        if i MOD 2 = 1 then
            j++
        end if
    end for
end function

function setFeatured()
    featuredModel = invalid
    if m.top.dataModel.featuredAd <> invalid then
        featuredModel = m.top.dataModel.featuredAd
    else if m.top.dataModel.featuredContent <> invalid then
        featuredModel = m.top.dataModel.featuredContent
    end if
    if featuredModel <> invalid then
        m.featured = CreateObject("RoSGNode","colortv_featuredContent")
        m.top.findNode("gridContainer").appendChild(m.featured)
        m.featured.impressionNode = m.colorTvGridEvents
        m.featured.contentModel = featuredModel
        m.featured.findNode("backgroundImage").ObserveField("loadStatus", "checkIfAlreadyLoaded")
        slightlyLeftAnimationInterpolator = m.top.findNode("moveSlightlyLeftAnimationInterpolator")
        slightlyRightAnimationInterpolator = m.top.findNode("moveSlightlyRightAnimationInterpolator")
        showNewDataAnimationInterpolator = m.top.findNode("showNewDataAnimationInterpolator")
        if isSimplifiedContentRecommendation() then
            endXValueDimension = 412
            slightlyLeftAnimationInterpolator.keyValue = [[0,0],[-endXValueDimension,0]]
            slightlyRightAnimationInterpolator.keyValue = [[0,0],[endXValueDimension,0]]
        else
            endXValueDimension = 601
            slightlyLeftAnimationInterpolator.keyValue = [[0,0],[-endXValueDimension,0]]
            slightlyRightAnimationInterpolator.keyValue = [[0,0],[endXValueDimension,0]]
        end if
        newDataEndXValueDimension = -68
        showNewDataAnimationInterpolator.keyValue = [[0,0],[newDataEndXValueDimension,0]]
    end if
end function

function animateGridTranslation()
    for i = 0 to m.gridElementViews.count() - 1
        startTranslation = m.gridElementViews[i].startTranslation
        animationTranslation = m.animationTranslation.translation
        m.gridElementViews[i].translation = [startTranslation[0] + animationTranslation[0], m.gridElementViews[i].translation[1]]
    end for
end function

function removeGridElementsIfNecessary()
    if m.dataArray.count() < m.gridElementViews.count() then
        gridElementsContainer = m.top.findNode("gridContainer")
        for i = m.gridElementViews.count() - 1 to m.dataArray.count() step -1
            gridElementsContainer.removeChild(m.gridElementViews[i])
            m.gridElementViews.delete(i)
        end for
    end if
end function

function setGridAndAnimationDimensions()
    marginDimension = 29
    gridElementWidth = getGridElementWidth()
    for i = 0 to m.gridElementViews.count() - 1
        if i MOD 2 = 1 then
            row = (i - 1) / 2
        else
            row = i / 2
        end if
        m.gridElementViews[i].translation = [(row + 1) * marginDimension + row * gridElementWidth, m.gridElementViews[i].translation[1]]
        m.gridElementViews[i].startTranslation = m.gridElementViews[i].translation
    end for
    if isSimplifiedContentRecommendation() then
        fullMoveDimension = 909
        slightMoveDimension = 836
    else
        fullMoveDimension = 669
        slightMoveDimension = 116
    end if
    slightlyLeftAnimationInterpolator = m.top.findNode("moveSlightlyLeftAnimationInterpolator")
    slightlyRightAnimationInterpolator = m.top.findNode("moveSlightlyRightAnimationInterpolator")
    fullyLeftAnimationInterpolator = m.top.findNode("moveFullyLeftAnimationInterpolator")
    fullyRightAnimationInterpolator = m.top.findNode("moveFullyRightAnimationInterpolator")
    slightlyLeftAnimationInterpolator.keyValue = [[0,0],[-slightMoveDimension,0]]
    slightlyRightAnimationInterpolator.keyValue = [[0,0],[slightMoveDimension,0]]
    fullyLeftAnimationInterpolator.keyValue = [[0,0],[-fullMoveDimension,0]]
    fullyRightAnimationInterpolator.keyValue = [[0,0],[fullMoveDimension,0]]
end function

function getGridElementWidth()
    if isSimplifiedContentRecommendation() then
        elementWidthDimension = 880
    else
        elementWidthDimension = 640
    end if
    return elementWidthDimension
end function

sub checkIfAlreadyLoaded()
    ' Only first 6 items are visible
    maxViewIndex = 5
    if m.gridElementViews.count() < 6 then
        maxViewIndex = m.gridElementViews.count() - 1
    end if
    for i = 0 to maxViewIndex
        if isViewStillLoading(m.gridElementViews[i].findNode(getBackgroundImageNodeName())) or isViewStillLoading(m.featured) then
            return
        end if
    end for
    presentView()
end sub

function isViewStillLoading(view) as Boolean
    if view = invalid then
        return false
    end if
    loadStatus = view.findNode("backgroundImage").loadStatus
    return view <> invalid and (loadStatus = "none" or loadStatus = "loading" or loadStatus = "error")
end function

function presentView()
    m.progressSpinner.visible = false
    if m.featured <> invalid then
        m.showFeaturedAnimation.control = "start"
    end if
    for i = 0 to m.gridElementViews.count() - 1
        m.gridElementViews[i].findNode(getBackgroundImageNodeName()).findNode("backgroundImage").UnobserveField("loadStatus")
    end for
    if isContentRecommendation(m.top.dataModel) and m.top.dataModel.autoPlayEnabled = "true" then
        startAutoplayTimer()
    end if
    m.gridElementViews[0].focused = true
end function

function setRecommendationsFor()
    title = m.top.dataModel.recommendationsForTitle
    if title <> invalid and title <> "" then
        m.recommendationsForLabel.text = Chr(34) + title + Chr(34)
    else
        m.recommendationsForContainer.visible = false
        standardEvenYDimension = 29
        standardOddYDimension = 554
        for i = 0 to m.gridElementViews.count() - 1
            if i MOD 2 = 0 then
                m.gridElementViews[i].translation = "[" + m.gridElementViews[i].translation[0].toStr() + "," + standardEvenYDimension.toStr() + "]"
            else
                m.gridElementViews[i].translation = "[" + m.gridElementViews[i].translation[0].toStr() + "," + standardOddYDimension.toStr() + "]"
            end if
    end for
    end if
end function

function startAutoplayTimer()
    m.autoplayTimer = m.currentlyFocusedView.findNode(getBackgroundImageNodeName()).findNode("autoplayTimer")
    if m.top.dataModel.autoPlayDuration <> invalid then
        m.autoplayTimer.duration = m.top.dataModel.autoPlayDuration
    end if
    m.autoplayTimer.visible = true
    m.autoplayTimer.startTimer = true
    m.autoplayTimer.ObserveField("closeAd", "autoplayTimerFinished")
end function

function autoplayTimerFinished()
    onKeyEvent("OK", false)
end function

function isContentRecommendation(item) as Boolean
    return item.type = invalid or item.type = "recommendation"
end function

function isAnyAnimationInProgress() as Boolean
    for i = 0 to m.animations.count() - 1
        if m.animations[i].state = "running" then
            return true
        end if
    end for
    return false
end function

function onKeyEvent(key as String, press as Boolean) as Boolean    
    keyIntercepted = false
    cancelAutoPlayTimer()
    if (key = "left" or key = "right" or key = "up" or key = "down") then
        keyIntercepted = true
        if press and not isAnyAnimationInProgress() and not m.progressSpinnerDialog.visible and not m.progressSpinner.visible then
            changeCardFocus(key)
        end if
    else if key = "back" then
        keyIntercepted = true
        if not press then
            if m.engagementFormShown then
                hideEngagementForm()
            else
                m.colorTvGridEvents.closed = true
            end if
        end if
    else if key = "OK" then
        keyIntercepted = true
        if not press then
            if m.featured <> invalid and m.featured.focused then
                clickedItem = m.featured.contentModel
            else
                clickedItem = m.currentlyFocusedView.contentModel
            end if
            if isContentRecommendation(clickedItem) then
                m.colorTvContentRecommendationEvents.clicked = clickedItem
            else
                performDownloadOrEngagement(clickedItem)
            end if
        end if
    else if key = "play" and m.top.dataModel.type = "recommendation" and not isSimplifiedContentRecommendation() then
        keyIntercepted = true
        clickedModel = invalid
        if m.featured <> invalid and m.featured.focused then
            clickedModel = m.featured.dataModel
        else
            clickedModel = m.currentlyFocusedView.contentModel
        end if
        if not press and clickedModel.favoriteUrl <> "" then
            showAddedToFavouritesToast()
            m.colorTvContentRecommendationEvents.favourite = clickedModel.favoriteUrl
        end if
    end if
    return keyIntercepted 
end function

function cancelAutoPlayTimer()
    if m.autoplayTimer <> invalid then
        m.autoplayTimer.visible = false
        m.autoplayTimer.startTimer = false
    end if
end function

sub changeCardFocus(key)
    if m.featured <> invalid and m.featured.focused then
        if key = "right"
            tryToChangeFeaturedAdFocus(false)
        end if
        return
    end if

    nextViewToFocusIndex = m.currentlyFocusedViewIndex
    animationToPlay = invalid

    if key = "left" then
        nextViewToFocusIndex = getAbsoluteNextViewIndex(m.currentlyFocusedViewIndex - 2, m.gridElementViews.count())
    else if key = "right" then
        nextViewToFocusIndex = getAbsoluteNextViewIndex(m.currentlyFocusedViewIndex + 2, m.gridElementViews.count())
    else if key = "down" and m.currentlyFocusedViewIndex MOD 2 = 0 and not isOddElementFocused() then
        nextViewToFocusIndex = getAbsoluteNextViewIndex(m.currentlyFocusedViewIndex + 1, m.gridElementViews.count())
    else if key = "up" and m.currentlyFocusedViewIndex MOD 2 = 1 then
        nextViewToFocusIndex = getAbsoluteNextViewIndex(m.currentlyFocusedViewIndex - 1, m.gridElementViews.count())
    end if

    if nextViewToFocusIndex = m.currentlyFocusedViewIndex then
        return
    end if

    m.nextViewToFocus = m.top.findNode("gridElement" + nextViewToFocusIndex.toStr())
    m.currentlyFocusedView = m.top.findNode("gridElement" + m.currentlyFocusedViewIndex.toStr())

    oddElement = false
    if key = "right" and isNextElementToFocusOdd() then
        oddElement = true
        nextViewToFocusIndex = getAbsoluteNextViewIndex(nextViewToFocusIndex - 1, m.gridElementViews.count())
        m.nextViewToFocus = m.top.findNode("gridElement" + nextViewToFocusIndex.toStr())
    end if

    if key = "right" then
        if m.nextViewToFocus.currentScreenPosition < m.currentlyFocusedView.currentScreenPosition then 
            if m.currentlyFocusedView.currentlyShownElementIndex + 2 < m.dataArray.count() or oddElement then
                updateGridViewsPositionsAndContent("last")
            else
                tryToLoadMoreData()
                return
            end if
        end if
    else if key = "left" then
        if m.nextViewToFocus.currentScreenPosition > m.currentlyFocusedView.currentScreenPosition then
            if m.currentlyFocusedView.currentlyShownElementIndex - 2 >= 0 then
                updateGridViewsPositionsAndContent("first")
            else
                tryToChangeFeaturedAdFocus(true)
                return
            end if
        end if
    end if

    if isSimplifiedContentRecommendation() and m.featured <> invalid then
        viewIndexThatTriggersAnimation = 1
    else
        viewIndexThatTriggersAnimation = 2
    end if
    if key = "left" and m.nextViewToFocus.currentScreenPosition = 0 and not m.clippedRight then
        animationToPlay = m.moveSlightlyRightAnimation
        m.clippedRight = true
    else if key = "left" and m.nextViewToFocus.currentScreenPosition = -1 then
        animationToPlay = m.moveFullyRightAnimation
        updateScreenPositions(1)
    else if key = "right" and m.nextViewToFocus.currentScreenPosition = viewIndexThatTriggersAnimation and m.clippedRight then
        animationToPlay = m.moveSlightlyLeftAnimation
        m.clippedRight = false
    else if key = "right" and m.nextViewToFocus.currentScreenPosition = viewIndexThatTriggersAnimation + 1 then
        animationToPlay = m.moveFullyLeftAnimation
        updateScreenPositions(-1)
    end if

    if animationToPlay <> invalid then
        animationToPlay.control = "start"
        animationToPlay.ObserveField("state", "animationFinished")
    end if

    m.nextViewToFocus.focused = true
    m.currentlyFocusedView.focused = false
    m.currentlyFocusedViewIndex = nextViewToFocusIndex
    m.currentlyFocusedView = m.top.findNode("gridElement" + m.currentlyFocusedViewIndex.toStr())
end sub

function tryToLoadMoreData()
    if m.top.dataModel <> invalid
        url = invalid
        if m.top.dataModel.moreAdsUrl <> invalid then
            url = m.top.dataModel.moreAdsUrl
        else if m.top.dataModel.moreContentUrl <> invalid then
            url = m.top.dataModel.moreContentUrl
        end if
        if url <> invalid then
            m.progressSpinnerDialog.visible = true
            m.loadingMoreData = true
            m.colorTvGridEvents.moreDataUrl = url
        end if
    end if
end function

function moreDataDownloadFinished()
    if m.colorTvGridEvents.moreDataUrl = "" then
        m.progressSpinnerDialog.visible = false
        m.loadingMoreData = false
    end if
end function

function tryToChangeFeaturedAdFocus(focused as Boolean)
    if m.featured <> invalid then
        m.currentlyFocusedView.focused = not focused
        m.featured.focused = focused
    end if
end function

function isOddElementFocused() as Boolean
    return m.top.findNode("gridElement" + m.currentlyFocusedViewIndex.toStr()).currentlyShownElementIndex = m.dataArray.count() -1
end function

function isNextElementToFocusOdd() as Boolean
    currentIndex = m.currentlyFocusedView.currentlyShownElementIndex
    return currentIndex + 2 > m.dataArray.count() - 1 and currentIndex + 1 < m.dataArray.count() and m.currentlyFocusedView.currentlyShownElementIndex MOD 2 = 1
end function

sub updateGridViewsPositionsAndContent(position)
    isUpperViewFocused = (m.currentlyFocusedViewIndex MOD 2 = 0)
    if position = "first" then
        updateLeftGridViews(isUpperViewFocused)
    else if position = "last" then
        updateRightGridViews(isUpperViewFocused)
    end if
end sub

function updateLeftGridViews(isUpperViewFocused)
    for i = 0 to m.gridElementViews.count() - 1
        element = m.gridElementViews[i]
        if element.currentScreenPosition = 3 then
            addFactor = getLeftGridViewIndexAddFactor(element.currentlyShownElementIndex, isUpperViewFocused)
            element.currentScreenPosition = -1
            xTranslation = getLeftGridViewXTranslation()
            element.translation = [xTranslation,element.translation[1]]
            element.startTranslation = element.translation
            element.currentlyShownElementIndex = m.currentlyFocusedView.currentlyShownElementIndex + addFactor
            element.contentModel = m.dataArray[element.currentlyShownElementIndex]
        end if
    end for
end function

function getLeftGridViewIndexAddFactor(currentlyShownElementIndex, isUpperViewFocused) as Integer
    if isUpperViewFocused then
        if currentlyShownElementIndex MOD 2 = 0 then
            return -2
        else
            return -1
        end if
    else
        if currentlyShownElementIndex MOD 2 = 0 then
            return -3
        else
            return -2
        end if
    end if
end function

function getLeftGridViewXTranslation() as Integer
    elementWidth = getGridElementWidth()
    featuredAdWidthDimension = 484
    if m.featured <> invalid then
        return -(elementWidth-featuredAdWidthDimension)
    else
        return -elementWidth
    end if
end function

function isSimplifiedContentRecommendation()
    return m.top.dataModel.format <> invalid and m.top.dataModel.format = "simple"
end function

sub updateRightGridViews(isUpperViewFocused)
    for i = 0 to m.gridElementViews.count() - 1
        element = m.gridElementViews[i]
        if element.currentScreenPosition = -1 then
            element.currentScreenPosition = 3
            addFactor = getRightGridViewIndexAddFactor(element, isUpperViewFocused)
            if m.currentlyFocusedView.currentlyShownElementIndex + addFactor > m.dataArray.count() - 1
                return
            end if
            screenWidthDimension = 1920
            element.translation = [screenWidthDimension,element.translation[1]]
            element.startTranslation = element.translation
            element.currentlyShownElementIndex = m.currentlyFocusedView.currentlyShownElementIndex + addFactor
            element.contentModel = m.dataArray[element.currentlyShownElementIndex]
        end if
    end for
end sub

function getRightGridViewIndexAddFactor(element, isUpperViewFocused) as Integer
    if isUpperViewFocused then
        if element.currentlyShownElementIndex MOD 2 = 0 then
            return 2
        else
            return 3
        end if
    else
        if element.currentlyShownElementIndex MOD 2 = 0 then
            return 1
        else
            return 2
        end if
    end if
end function

function updateScreenPositions(factor)
    for i = 0 to m.gridElementViews.count() - 1
        m.gridElementViews[i].currentScreenPosition = m.gridElementViews[i].currentScreenPosition + factor
    end for
end function

sub animationFinished()
    if isAnyAnimationInProgress() then
        return
    end if
    for i = 0 to m.gridElementViews.count() - 1
        m.gridElementViews[i].startTranslation = m.gridElementViews[i].translation
    end for
end sub

function getAbsoluteNextViewIndex(index, itemsCount)
    if index > 0 then
        return index MOD itemsCount
    else
        while index < 0
          index += itemsCount
        end while
        return index
    end if
end function

function performDownloadOrEngagement(clickedModel)
    if clickedModel.type = "appstore" or clickedModel.type = "content" then
        m.colorTvDiscoveryCenterEvents.clicked = clickedModel
    else
        showEngagementForm(clickedModel)
    end if
end function

function showEngagementForm(clickedModel)
    m.engagementFormShown = true
    m.subscriptionForm = createObject("RoSGNode","colortv_subscriptionWindow")
    m.subscriptionForm.id = "subscriptionWindow"
    m.subscriptionForm.parentNodeReference = m.top
    m.subscriptionForm.clickedModel = clickedModel
    m.top.appendChild(m.subscriptionForm)
    m.subscriptionForm.setFocus(true)
end function

function hideEngagementForm()
    m.engagementFormShown = false
    m.top.removeChild(m.subscriptionForm)
    m.top.SetFocus(true)
    m.subscriptionForm.removeChildrenIndex(m.subscriptionForm.getChildCount(), 0)
    m.subscriptionForm = invalid
end function

function interpolateColors(colorStartRGB, colorEndRGB)
    colorStartRGBArray = [colorStartRGB.r, colorStartRGB.g, colorStartRGB.b]
    colorEndRGBArray = [colorEndRGB.r, colorEndRGB.g, colorEndRGB.b]

    colorsRGBInBetween = []
    for i = 0 to 3
        factor = (i + 1) / 5
        currentR = linearInterpolation(colorStartRGBArray[0], colorEndRGBArray[0], factor)
        currentG = linearInterpolation(colorStartRGBArray[1], colorEndRGBArray[1], factor)
        currentB = linearInterpolation(colorStartRGBArray[2], colorEndRGBArray[2], factor)

        colorsRGBInBetween.push([currentR, currentG, currentB])
    end for

    resultingArray = []
    resultingArray.push(colorFromRGB(colorStartRGBArray))
    for i = 0 to 3
        resultingArray.push(colorFromRGB(colorsRGBInBetween[i]))
    end for
    resultingArray.push(colorFromRGB(colorEndRGBArray))
    return resultingArray
end function

function linearInterpolation(startValue, endValue, factor)
    return startValue * (1 - factor) + endValue * factor
end function

function colorFromRGB(colorArray) as String
    red = colorArray[0]
    green = colorArray[1]
    blue = colorArray[2]
    color = "0x" + IntToZeroPaddedHexString(red) + IntToZeroPaddedHexString(green) + IntToZeroPaddedHexString(blue) + "ff"
    return color
end function

function IntToZeroPaddedHexString(decimalNumber as Integer) as String 
    if decimalNumber < 0 then
        decimalNumber = 0
    end if
    hexString = StrI(decimalNumber, 16)
    if(decimalNumber < 16) then 
        hexString = "0" + hexString
    end if
    return hexString
end function

function setRegularCustomFont(fontUri)
    if fontUri <> invalid then
        font = createFontObject(fontUri, 28)
        m.recommendationsForLabel.font = font
    end if
end function

function setBoldCustomFont(fontUri)
    if fontUri <> invalid then
        font = createFontObject(fontUri, 28)
        m.recommendationsForTitleLabel.font = font
    end if
end function

function createFontObject(fontUri, fontSize)
    fontNode = CreateObject("roSGNode", "Font")
    fontNode.size = fontSize
    fontNode.uri = fontUri
    return fontNode
end function
