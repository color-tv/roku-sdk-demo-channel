sub init()
  m.top.setFocus(true)

  videoContent = createObject("RoSGNode", "ContentNode")
  videoContent.url = "https://roku.s.cpl.delvenetworks.com/media/59021fabe3b645968e382ac726cd6c7b/60b4a471ffb74809beb2f7d5a15b3193/roku_ep_111_segment_1_final-cc_mix_033015-a7ec8a288c4bcec001c118181c668de321108861.m3u8"
  videoContent.title = "Test Video"
  videoContent.streamformat = "hls"

  m.video = m.top.findNode("musicvideos")
  m.video.content = videoContent
  m.video.control = "play"
end sub
