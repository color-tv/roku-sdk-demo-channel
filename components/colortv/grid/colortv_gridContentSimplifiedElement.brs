sub init()
    initViews()

    m.top.ObserveField("contentModel", "setContentModel")
    m.top.ObserveField("textColor", "setTextColor")
end sub

function initViews()
    m.playButton = m.top.findNode("playButton")

    m.backgroundImage = m.top.findNode("backgroundImage")
    m.backgroundOverlay = m.top.findNode("backgroundOverlay")
    m.tagsContainer = m.top.findNode("tagsContainer")
    m.titleLabel = m.top.findNode("title")
    m.durationLabel = m.top.findNode("duration")
    m.clockImage = m.top.findNode("clockImage")
    m.typeFrame = m.top.findNode("typeFrame")
    m.typeLabel = m.top.findNode("typeLabel")
end function

function setTextColor()
    textColor = m.top.textColor[m.top.textColor.count() - 1]
    m.playButton.blendColor = textColor
    m.titleLabel.color = textColor
    m.durationLabel.color = textColor
    m.clockImage.blendColor = textColor
    if m.typeLabel <> invalid
        m.typeLabel.color = textColor
    end if
    reversedColors = m.top.textColor
    reversedColors.reverse()
    for i = 0 to m.tags.count() - 1
        m.tags[i].colors = reversedColors
    end for
end function

function focusView()
    for i = 0 to m.tags.count() - 1
        m.tags[i].visible = not m.top.focused
    end for
    m.playButton.visible = not m.top.focused
    m.backgroundOverlay.visible = not m.top.focused
end function

function setContentModel() as Void
    setContentRecommendationModel(m.top.contentModel)
    m.top.ObserveField("focused", "focusView")
    focusView()
end function

function setContentRecommendationModel(contentModel)
    setGenres(contentModel.genres, contentModel.regularCustomFont)
    if contentModel.thumbnailUrl <> invalid then
        m.backgroundImage.uri = contentModel.thumbnailUrl
    else
        m.backgroundImage.uri = "pkg:/images/colortv/color_tv_grid_bg_placeholder.jpg"
    end if
    duration = contentModel.durationInMinutes * 60
    if duration = 0 then
        m.clockImage.visible = false
    end if
    m.durationLabel.text = getDurationString(duration)
    m.titleLabel.text = box(contentModel.title).trim()

    setRecommendationType(contentModel.index)
    setRegularCustomFont(contentModel.regularCustomFont)
    setBoldCustomFont(contentModel.boldCustomFont)
end function

sub setGenres(genres, customFont)
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

    genres.reverse()

    m.spaceBetweenGenresDimension = 15

    translationX = 0


    for i = 0 to genres.count() - 1
        tag = createObject("RoSGNode","colortv_simplifiedContentTag")
        m.tags.push(tag)
        tag.id = "genre" + i.toStr()
        container.appendChild(tag)
        tag.text = genres[i]
    end for

    reversedColors = m.top.textColor
    reversedColors.reverse()

    for i = 0 to genres.count() - 1
        tag = m.tags[i]
        tag.colors = reversedColors
        if customFont <> invalid then
            smallFont = createFontObject(customFont, 20)
            tag.findNode("tagLabel").font = smallFont
        end if
        translationX -= tag.viewWidth
        tag.translation = [translationX, 0]
        translationX -= m.spaceBetweenGenresDimension
    end for
end sub

function createFontObject(fontUri, fontSize)
    fontNode = CreateObject("roSGNode", "Font")
    fontNode.size = fontSize
    fontNode.uri = fontUri
    return fontNode
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

function setRecommendationType(index)
    if m.typeFrame <> invalid then
        if index = 0 then
            m.typeFrame.visible = true
        else
            m.typeFrame.visible = false
        end if
    end if
end function

function setRegularCustomFont(fontUri)
    if fontUri <> invalid then
        largeFont = createFontObject(fontUri, 20)
        smallFont = createFontObject(fontUri, 16)
        m.top.findNode("autoplayTimer").findNode("autoCloseLabel").font = largeFont
        m.durationLabel.font = smallFont
    end if
end function

function setBoldCustomFont(fontUri)
    if fontUri <> invalid then
        largeFont = createFontObject(fontUri, 24)
        m.titleLabel.font = largeFont
        if m.typeLabel <> invalid
            smallFont = createFontObject(fontUri, 18)
            m.typeLabel.font = smallFont
        end if
    end if
end function
