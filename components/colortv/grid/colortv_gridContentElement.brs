sub init()
    initViews()

    initAnimations()

    m.top.ObserveField("contentModel", "setContentModel")
    m.top.ObserveField("backgroundColor", "setBackgroundColor")
    m.top.ObserveField("favouriteButtonColor", "setFavouriteButtonColor")
    m.top.ObserveField("favouriteButtonTextColor", "setFavouriteButtonTextColor")
    m.top.ObserveField("textColor", "setTextColor")
end sub

function initViews()
    m.separator1 = m.top.findNode("separator1")
    m.separator2 = m.top.findNode("separator2")
    m.watchNowButton = m.top.findNode("watchNowButton")
    m.favouriteButton = m.top.findNode("favouriteButton")

    m.clockImage = m.top.findNode("clockImage")
    m.metaDataContainer = m.top.findNode("metaDataContainer")
    m.backgroundImage = m.top.findNode("backgroundImage")
    m.durationLabel = m.top.findNode("duration")
    m.titleLabel = m.top.findNode("title")
    m.descriptionLabel = m.top.findNode("description")
    m.viewsImage = m.top.findNode("viewsImage")
    m.dataContainer = m.top.findNode("dataContainer")
    m.starImage = m.top.findNode("starImage")
    m.ratingsLabel = m.top.findNode("ratings")
    m.viewsCountLabel = m.top.findNode("viewsCount")
    m.logoImage = m.top.findNode("logoImage")
end function

function initAnimations()
    m.backgroundFocusedAnimation = m.top.findNode("backgroundFocusedAnimation")
    m.backgroundUnfocusedAnimation = m.top.findNode("backgroundUnfocusedAnimation")
    m.clockImageFocusedAnimation = m.top.findNode("clockImageFocusedAnimation")
    m.clockImageUnfocusedAnimation = m.top.findNode("clockImageUnfocusedAnimation")
    m.durationFocusedAnimation = m.top.findNode("durationFocusedAnimation")
    m.durationUnfocusedAnimation = m.top.findNode("durationUnfocusedAnimation")
    m.starImageFocusedAnimation = m.top.findNode("starImageFocusedAnimation")
    m.starImageUnfocusedAnimation = m.top.findNode("starImageUnfocusedAnimation")
    m.ratingsFocusedAnimation = m.top.findNode("ratingsFocusedAnimation")
    m.ratingsUnfocusedAnimation = m.top.findNode("ratingsUnfocusedAnimation")
    m.viewsImageFocusedAnimation = m.top.findNode("viewsImageFocusedAnimation")
    m.viewsImageUnfocusedAnimation = m.top.findNode("viewsImageUnfocusedAnimation")
    m.viewsCountFocusedAnimation = m.top.findNode("viewsCountFocusedAnimation")
    m.viewsCountUnfocusedAnimation = m.top.findNode("viewsCountUnfocusedAnimation")
    m.titleFocusedAnimation = m.top.findNode("titleFocusedAnimation")
    m.titleUnfocusedAnimation = m.top.findNode("titleUnfocusedAnimation")
    m.descriptionFocusedAnimation = m.top.findNode("descriptionFocusedAnimation")
    m.descriptionUnfocusedAnimation = m.top.findNode("descriptionUnfocusedAnimation")
end function

function setBackgroundColor()
    reversedColors = m.top.backgroundColor
    reversedColors.reverse()
    m.backgroundFocusedAnimation.getChild(0).keyValue = m.top.backgroundColor
    m.backgroundUnfocusedAnimation.getChild(0).keyValue = reversedColors
    m.watchNowButton.colors = m.top.backgroundColor
    m.dataContainer.color = m.top.backgroundColor[0]
end function

function setFavouriteButtonColor()
    m.favouriteButton.colors = m.top.favouriteButtonColor
end function

function setFavouriteButtonTextColor()
    m.favouriteButton.textColors = m.top.favouriteButtonTextColor
end function

function setTextColor()
    reversedColors = m.top.textColor
    reversedColors.reverse()
    m.durationFocusedAnimation.getChild(0).keyValue = m.top.textColor
    m.durationFocusedAnimation.getChild(0).key = [0.0, 0.1, 0.25, 0.5, 0.75, 1.0]
    m.durationUnfocusedAnimation.getChild(0).keyValue = reversedColors
    m.durationUnfocusedAnimation.getChild(0).key = [0.0, 0.1, 0.25, 0.5, 0.75, 1.0]
    m.starImageFocusedAnimation.getChild(0).keyValue = m.top.textColor
    m.starImageFocusedAnimation.getChild(0).key = [0.0, 0.1, 0.25, 0.5, 0.75, 1.0]
    m.starImageUnfocusedAnimation.getChild(0).keyValue = reversedColors
    m.starImageUnfocusedAnimation.getChild(0).key = [0.0, 0.1, 0.25, 0.5, 0.75, 1.0]
    m.clockImageFocusedAnimation.getChild(0).keyValue = m.top.textColor
    m.clockImageFocusedAnimation.getChild(0).key = [0.0, 0.1, 0.25, 0.5, 0.75, 1.0]
    m.clockImageUnfocusedAnimation.getChild(0).keyValue = reversedColors
    m.clockImageUnfocusedAnimation.getChild(0).key = [0.0, 0.1, 0.25, 0.5, 0.75, 1.0]
    m.ratingsFocusedAnimation.getChild(0).keyValue = m.top.textColor
    m.ratingsFocusedAnimation.getChild(0).key = [0.0, 0.1, 0.25, 0.5, 0.75, 1.0]
    m.ratingsUnfocusedAnimation.getChild(0).keyValue = reversedColors
    m.ratingsUnfocusedAnimation.getChild(0).key = [0.0, 0.1, 0.25, 0.5, 0.75, 1.0]
    m.viewsImageFocusedAnimation.getChild(0).keyValue = m.top.textColor
    m.viewsImageFocusedAnimation.getChild(0).key = [0.0, 0.1, 0.25, 0.5, 0.75, 1.0]
    m.viewsImageUnfocusedAnimation.getChild(0).keyValue = reversedColors
    m.viewsImageUnfocusedAnimation.getChild(0).key = [0.0, 0.1, 0.25, 0.5, 0.75, 1.0]
    m.viewsCountFocusedAnimation.getChild(0).keyValue = m.top.textColor
    m.viewsCountFocusedAnimation.getChild(0).key = [0.0, 0.1, 0.25, 0.5, 0.75, 1.0]
    m.viewsCountUnfocusedAnimation.getChild(0).keyValue = reversedColors
    m.viewsCountUnfocusedAnimation.getChild(0).key = [0.0, 0.1, 0.25, 0.5, 0.75, 1.0]
    m.titleFocusedAnimation.getChild(0).keyValue = m.top.textColor
    m.titleFocusedAnimation.getChild(0).key = [0.0, 0.1, 0.25, 0.5, 0.75, 1.0]
    m.titleUnfocusedAnimation.getChild(0).keyValue = reversedColors
    m.titleUnfocusedAnimation.getChild(0).key = [0.0, 0.1, 0.25, 0.5, 0.75, 1.0]
    m.descriptionFocusedAnimation.getChild(0).keyValue = m.top.textColor
    m.descriptionFocusedAnimation.getChild(0).key = [0.0, 0.1, 0.25, 0.5, 0.75, 1.0]
    m.descriptionUnfocusedAnimation.getChild(0).keyValue = reversedColors
    m.descriptionUnfocusedAnimation.getChild(0).key = [0.0, 0.1, 0.25, 0.5, 0.75, 1.0]
    for i = 0 to m.tags.count() - 1
        m.tags[i].colors = m.top.textColor
    end for
    if m.separator1 <> invalid then
        m.separator1.colors = m.top.textColor
    end if
    if m.separator2 <> invalid then
        m.separator2.colors = m.top.textColor
    end if
end function

function focusView()
    setChildViewsFocus()
    if m.top.focused then
        m.backgroundFocusedAnimation.control = "start"
        m.durationFocusedAnimation.control = "start"
        m.starImageFocusedAnimation.control = "start"
        m.clockImageFocusedAnimation.control = "start"
        m.ratingsFocusedAnimation.control = "start"
        m.viewsImageFocusedAnimation.control = "start"
        m.viewsCountFocusedAnimation.control = "start"
        m.titleFocusedAnimation.control = "start"
        m.descriptionFocusedAnimation.control = "start"
    else
        m.backgroundUnfocusedAnimation.control = "start"
        m.durationUnfocusedAnimation.control = "start"
        m.starImageUnfocusedAnimation.control = "start"
        m.clockImageUnfocusedAnimation.control = "start"
        m.ratingsUnfocusedAnimation.control = "start"
        m.viewsImageUnfocusedAnimation.control = "start"
        m.viewsCountUnfocusedAnimation.control = "start"
        m.titleUnfocusedAnimation.control = "start"
        m.descriptionUnfocusedAnimation.control = "start"
    end if
end function

function setChildViewsFocus()
    for i = 0 to m.tags.count() - 1
        m.tags[i].focused = m.top.focused
    end for
    if m.separator1 <> invalid then
        m.separator1.focused = m.top.focused
    end if
    if m.separator2 <> invalid then
        m.separator2.focused = m.top.focused
    end if
    m.watchNowButton.focused = m.top.focused
    m.favouriteButton.focused = m.top.focused
end function

function setContentModel() as Void
    setContentRecommendationModel(m.top.contentModel)
    m.top.ObserveField("focused", "focusView")
    if m.top.focused then
        focusView()
    else
        setChildViewsFocus()
    end if
end function

function setContentRecommendationModel(contentModel)
    setGenres(contentModel.genres)
    m.logoImage.uri = contentModel.logoUrl
    if contentModel.thumbnailUrl <> invalid then
        m.backgroundImage.uri = contentModel.thumbnailUrl
    else
        m.backgroundImage.uri = "pkg:/images/colortv/color_tv_grid_bg_placeholder.jpg"
    end if
    duration = contentModel.durationInMinutes * 60
    m.durationLabel.text = getDurationString(duration)
    m.titleLabel.text = box(contentModel.title).trim()
    if contentModel.description <> invalid then
        m.descriptionLabel.text = box(contentModel.description).trim()
    end if
    if contentModel.rating = invalid then
        hideSeparators()
        m.starImage.visible = false
        m.ratingsLabel.visible = false
    else
        showSeparators()
        m.starImage.visible = true
        m.ratingsLabel.visible = true
        m.ratingsLabel.text = getRatingsString(contentModel.rating.toStr())
    end if
    if contentModel.views = invalid then
        hideSeparators()
        m.viewsImage.visible = false
        m.viewsCountLabel.visible = false
    else
        showSeparators()
        m.viewsImage.visible = true
        m.viewsCountLabel.visible = true
        m.viewsCountLabel.text = contentModel.views
    end if
end function

function hideSeparators()
    m.separator1.visible = false
    m.separator2.visible = false
end function

function showSeparators()
    m.separator1.visible = true
    m.separator2.visible = true
end function

function getRatingsString(rating as String) as String
    returnValue = rating
    if rating.len() = 1 then
        returnValue += ".0"
    end if
    return returnValue
end function

sub setGenres(genres)
    container = m.top.findNode("tagsContainer")
    if m.tags <> invalid and m.tags.count() > 0 then
        for i = 0 to m.tags.count() - 1
            container.removeChild(m.tags[i])
        end for
    end if

    m.tags = []

    if genres = invalid then
        return
    end if

    if genres.count() > 3 then
        for i = 3 to genres.count() - 1
            genres.delete(genres.count() - 1)
        end for
    end if

    m.spaceBetweenGenresDimension = 12
    
    if genres.count() > 1 then
        totalViewWidthDimension = 330
        translationX = (totalViewWidthDimension - calculateTotalGenresWidth(genres)) / 2
    else
        totalViewWidthDimension = 300
        translationX = (totalViewWidthDimension - calculateTotalGenresWidth(genres))
    end if

    if translationX < 0 then
        translationX = 0
    end if

    for i = 0 to genres.count() - 1
        tag = createObject("RoSGNode","colortv_contentTag")
        m.tags.push(tag)
        tag.id = "genre" + i.toStr()
        container.appendChild(tag)
        tag.translation = [translationX, 0]
        tag.text = genres[i]
        tag.colors = m.top.textColor
        translationX += calculateGenreViewWidth(genres[i].toStr())
        translationX += m.spaceBetweenGenresDimension
    end for
end sub

function calculateTotalGenresWidth(genres as Object)
    totalWidth = 0
    for i = 0 to genres.count() - 1
        totalWidth += calculateGenreViewWidth(genres[i])
    end for
    totalWidth += (genres.count() - 1) * m.spaceBetweenGenresDimension
    return totalWidth
end function

function calculateGenreViewWidth(genre as String) as Integer
    approximateCharacterWidthDimension = 7
    paddingXDimension = 3
    roundedEgdesWidthDimension = 30
    retValue = approximateCharacterWidthDimension * genre.len() + paddingXDimension + roundedEgdesWidthDimension
    return retValue
end function

function getDurationString(duration as Integer) as String
    if duration = 0 then
        return ""
    end if
    hours = fix(duration / 60 / 60)
    minutes = fix((duration - hours * 60 * 60) / 60)
    seconds = duration - hours * 60 * 60 - minutes * 60
    if hours < 10 then
        hours = "0" + hours.toStr()
    end if
    if minutes < 10 then
        minutes = "0" + minutes.toStr()
    end if
    if seconds < 10 then
        seconds = "0" + seconds.toStr()
    end if
    return hours.toStr() + ":" + minutes.toStr() + ":" + seconds.toStr()
end function
