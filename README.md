# ColorTV Roku SDK Demo Channel

This repository contains a demo channel for the ColorTV SDK. It shows different ad formats and a proper way of implementing ColorTV SDK to a channel. Use it as a reference to implement ColorTV SDK into your channel. Below you can find a complete guide for integrating the SDK and using all of it's features.

## Getting Started

Before getting started make sure you have added your channel in the My Applications section of the ColorTV Dashboard. You need to do this so that you can get your App ID that you'll be adding to your channel with our SDK.

Download this repository as a zip file, extract it and merge the components, fonts and source folders with your project's folders. You will gain access to the SDK. Use the `source/main.brs` and the `components/demo` files as a demo of our platform and remove them from your project before submitting.

## Using the ColorTV SDK

Initialize the ColorTV SDK by invoking the following method in your main.brs:

```
colorTvSdk = ColorTvSdk("your_app_id_from_dashboard")
```

Your app id is generated in the publisher dashboard after adding or editing an application in the My Applications section. Copy the app id and paste the value for "your_app_id_from_dashboard".

After initialization, you can obtain a reference to the SDK by calling the following function:

```
colorTvSdk = ColorTVSdkGetInstance()
```

**IMPORTANT:** To ensure that all the session and currency calls are being invoked in the background, please implement the following function call in all your event loops, like so:

```
while true
    msg = wait(GetColorTVSDKTimerInterval(), m.port)
    msgType = type(msg)
    if msgType = "roSGScreenEvent"
        if msg.isScreenClosed() then
            print "Exiting app"
            return
        end if
    end if
    colorTvSdk.timerTick()
end while
```

The first `wait` function parameter will ensure the loop gets executed every second with an invalid message. If a session ping event is scheduled, it will be fired in the `colorTvSdk.timerTick()` function. This will ensure you get the most acurate statistics about your users' behaviour as well as a currency reward if your channel uses it.

To obtain verbose logging from the SDK you can enable debug mode by calling:

```
colorTvSdk.setDebugMode(true)
```

### Ads

#### Placements
Below are all the possible placement values:

- AppLaunch

- AppResume

- AppClose

- MainMenu

- Pause

- StageOpen

- StageComplete

- StageFailed

- LevelUp

- BetweenLevels

- StoreOpen

- InAppPurchase

- AbandonInAppPurchase

- VirtualGoodPurchased

- UserHighScore

- OutofGoods

- OutofEnergy

- InsufficientCurrency

- FinishedTutorial

- VideoStarted

- VideoPaused

- VideoStopped

- VideoFinished


>**NOTE**
>
>    You can choose what ad units you want to show for a specific placement in the dashboard, [click to learn more about Ad Units](https://www.colortv.com/dashboard/docs/#ad-units)

#### Integration

If you want to receive status updates about ads create the following callback functions:

```
sub adLoaded(placement as String)
    print "Ad loaded for placement: " + placement
end sub

sub adClosed(placement as String)
    print "Ad has been closed for placement: " + placement
end sub

sub adError(error as Object)
    print "Ad error occured for placement: " + error.placement + " with error code: " + error.errorCode + " and error message: " + error.errorMessage
end sub

sub currencyEarned(currencyType as String, currencyAmount as Integer, placement as String)
    print "Currency earned for placement " + placement + ": " + currencyAmount.toStr() + " x " + currencyType
end sub
```

And then register those callbacks by invoking:

```
adCallbacks = {
    adLoaded: adLoaded
    adClosed: adClosed
    adError: adError
    currencyEarned: currencyEarned
}
colorTvSdk.registerAdCallbacks(adCallbacks)
```

To load an ad for a certain placement, you need to call the following method:

```
colorTvSdk.loadAd("Placement")
```

Use one of the predefined placements listed above.

In order to show an ad, call the following function:

```java
colorTvSdk.showAd("Placement")
```

Calling this method will show an ad for the placement you pass. Make sure you get the `adLoaded` callback first, otherwise the ad won't be played.

We recommend to show ads in the `adLoaded` callback like so:

```
sub adLoaded(placement as String)
    print "Ad loaded for placement: " + placement
    ColorTVSdkGetInstance().showAd(placement)
end sub
```

### Content Recommendation

If you want to receive status updates about content recommendation create the following callback functions:

```
sub contentRecommendationLoaded(placement as String)
    print "Content recommendation loaded for placement: " + placement
end sub

sub contentRecommendationClicked(placement as String, contentData as Object)
    print "Content recommendation has been clicked for placement: " + placement + " and content id: " + contentData.videoId + " and content url: " + contentData.videoUrl
end sub

sub contentRecommendationClosed(placement as String)
    print "Content recommendation has been closed for placement: " + placement
end sub

sub contentRecommendationError(error as Object)
    print "Content recommendation error occured for placement: " + error.placement + " with error code: " + error.errorCode + " and error message: " + error.errorMessage
end sub
```

And then register those callbacks by invoking:

```
contentRecommendationCallbacks = {
    contentRecommendationLoaded: contentRecommendationLoaded
    contentRecommendationClicked: contentRecommendationClicked
    contentRecommendationClosed: contentRecommendationClosed
    contentRecommendationError: contentRecommendationError
}
colorTvSdk.registerContentRecommendationCallbacks(contentRecommendationCallbacks)
```

After the user clicks on one of the content recommendation items, you will be notified with the video ID they have clicked on through the `contentRecommendationClicked` callback function.

To load content recommendation for a certain placement, you need to call the following method:

```
colorTvSdk.loadContentRecommendation("Placement")
```

>**NOTE**
>
>    You can use the same placements as for ads listed above.

You can also add another argument to this method, a previously watched video id, which will make the recommendation more accurate:

```
colorTvSdk.loadContentRecommendation("Placement", "previousVideoId")
```

In order to show content recommendation, call the following function:

```java
colorTvSdk.showContentRecommendation("Placement")
```

Calling this method will show content recommendation for the placement you pass. Make sure you get the `contentRecommendationLoaded` callback first, otherwise the content won't be played.

We recommend to show content recommendation in the `contentRecommendationLoaded` callback function like so:

```
sub contentRecommendationLoaded(placement as String)
    printWithTime("Content recommendation loaded for placement: " + placement)
    ColorTVSdkGetInstance().showContentRecommendation(placement)
end sub
```

#### Video tracking

If you want to collect data about the users' behaviour in your channel's videos you can use the video tracking function:

```
colorTvSdk.trackVideoEvents("videoId", msg)
```

You can use this function with both Scene Graph Video Node messages and `roVideoPlayer` object.

##### Usage with Scene Graph Video Node:

```
screen = CreateObject("roSGScreen")
port = CreateObject("roMessagePort")
screen.setMessagePort(port)

scene = screen.CreateScene("testVideoScene")
screen.show()

scene.findNode("videoNode").observeField("state", port)
scene.findNode("videoNode").observeField("position", port)

while true
    msg = wait(GetColorTVSDKTimerInterval(), port)
    msgType = type(msg)
    if msgType = "roSGScreenEvent"
        if msg.isScreenClosed() then
            colorTvSdk.trackVideoEvents("videoId", "interrupted")
            exit while
        end if
    else if msgType = "roSGNodeEvent"
        if msg.getNode() = "videoNode"
            colorTvSdk.trackVideoEvents("videoId", msg)
        end if
    end if
    m.timerTick()
end while
```

where the `colorTvSdk.trackVideoEvents("videoId", "interrupted")` line is there to notify video being interrupted with the "back" button.

##### Usage with `roVideoPlayer` object:

```
canvas = prepareCanvas()
canvas.Show()

player = prepareVideoPlayer()
player.SetPositionNotificationPeriod(1)
player.Play()

while true
    msg = wait(GetColorTVSDKTimerInterval(), m.port)
    msgType = type(msg)
    if msgType = "roSGScreenEvent"
        if msg.isScreenClosed() then
            exit while
        end if
    else if type(msg) = "roVideoPlayerEvent"
        colorTvSdk.trackVideoEvents("videoId", msg)
    else if type(msg) = "roImageCanvasEvent" and msg.isRemoteKeyPressed()
        buttonIndex = msg.getIndex()
        if buttonIndex = 2 or buttonIndex = 0 then 'UP or BACK
            colorTvSdk.trackVideoEvents("videoId", "interrupted")
            exit while
        end if
    end if
    ColorTVSdkGetInstance().timerTick()
end while
```

where the `colorTvSdk.trackVideoEvents("videoId", "interrupted")` line is there to notify video being interrupted with the "back" button.

The `player.SetPositionNotificationPeriod(1)` is very important, because this will notify the SDK of every second of the video that has passed and will allow to determine the watched lenght of the video.

### User profile

To improve ad targeting you can use the user profile functions. You can set age, gender and some keywords as comma-separated values, eg. `sport,health` like so:

```java
colorTvSdk.setUserAge("32")
colorTvSdk.setUserGender("male")
colorTvSdk.setUserKeywords("sports,health")
```

These values will automatically be saved and attached to an ad request.
