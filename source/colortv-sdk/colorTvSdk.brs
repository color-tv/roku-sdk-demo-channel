function a(b as String) as Object
c = {
d: "https://adsrv.colortv.com"
e: b
f: g
h: j
k: l
n: o
p: q
r: s
t: u
v: w
x: y
z: aa
ab: ac
ad: ae
af: ag
ah: false
ai: aj
ak: al
am: an
ao: ap
aq: ar
as: at
au: av
aw: ax
}
return c
end function
function g(ay as String) as Void
az = m.d + "/ad/req"
ba = "GET"
bb = {
"app": m.e
"placement": ay
}
bc = m.n(az, ba, bb)
bd = bc.GetResponseCode()
be = (bd = 200)
colorTvSdk = ColorTVSdkGetInstance()
if not be then
bf("Failure reason: " + bc.GetFailureReason())
bg = {
"errorMessage": bc.GetFailureReason()
"error": bd.toStr()
}
colorTvSdk.bh(bg, ay)
else
bi = bj(bc.GetString())
if bi["type"] = "discovery" then
bk = m.h(ay)
bi["featuredAd"] = bk
end if
colorTvSdk.bh(bi, ay)
end if
end function
function j(ay as String) as Object
az = m.d + "/ad/req"
ba = "GET"
bb = {
"app": m.e
"placement": ay
"type": "featured"
}
bc = m.n(az, ba, bb)
bd = bc.GetResponseCode()
be = (bd = 200)
colorTvSdk = ColorTVSdkGetInstance()
bl = ParseJson(bc.getString())
if be and bl["error"] = invalid and bl["ads"] <> invalid then
return bl["ads"][0]
end if
return invalid
end function
function l(az as String)
bc = m.n(az, "GET", invalid)
bd = bc.GetResponseCode()
be = (bd = 200)
colorTvSdk = ColorTVSdkGetInstance()
bl = bj(bc.getString())
if be and bl["error"] = invalid and (bl["ads"] <> invalid or bl["recommendations"] <> invalid) then
return bl
end if
return invalid
end function
function q(az as String, bm as String, bn as String)
bb = "{""" + bn + """:""" + bm + """}"
bc = m.n(az, "POST", bb)
end function
function o(az as String, ba as String, bb as Dynamic)
bo = CreateObject("roUrlTransfer")
if ba = "GET" and bb <> invalid and bb.count() > 0 then
az = bp(az, bb)
end if
bf("URL: " + az)
bo.setUrl(az)
bo.setRequest(ba)
bo.retainBodyOnError(true)
bo.SetCertificatesFile ("common:/certs/ca-bundle.crt")
bq = CreateObject("roMessagePort")
bo.SetPort(bq)
if m.br <> invalid then
bo.addHeader("CTV-SessionId", m.br["sessionId"])
end if
if ba = "GET" or ba = "PUT" then
bo.AsyncGetToString()
else if ba = "POST" then
bo.addHeader("Content-Type", "application/json")
bo.AsyncPostFromString(bb)
else
bf("Request method not supported: " + ba)
return invalid
end if
bc =  wait(0,bq)
bf("Response code: " + StrI(bc.GetResponseCode()))
bf("Response body: " + bc.GetString())
return bc
end function
function s(az as String)
m.n(az, "GET", invalid)
end function
sub u(e as String, bs as String, sdkVersion as String)
if bt("installed", "colortv") <> invalid then
return
end if
bf("Registering app install for version " + bu())
bv("installed", "true", "colortv")
bb = "{""sdkVersion"":""" + sdkVersion + """, ""appVersion"":""" + bu() + """}"
bw = m.d + "/app/inst/" + e + "?deviceid=" + bs
bc = m.n(bw, "POST", bb)
end sub
function w() as Void
bf("Starting session")
az = m.d + "/app/sess/" + m.e
bx = bp(az, {"state" : "start"})
by = bz()
m.ai(by)
ca = FormatJson(by)
bc = m.n(bx, "POST", ca)
m.br = cb(bc.GetString())
m.z()
end function
sub aa()
cc = ColorTVSdkGetInstance()
cd = ce()
if m.br <> invalid then
cd = m.br["pingInterval"] * 1000
end if
cf = cg(cd , {c: m}, function(ch as Dynamic) as Void
ch.c.x()
end function)
cc.ci(cf)
end sub
sub y()
if m.br = invalid then
m.v()
return
end if
az = m.d + "/app/sess/"
by = bz()
m.ai(by)
ca = FormatJson(by)
bc = m.n(az, "PUT", ca)
m.br = cb(bc.GetString())
m.z()
end sub
sub ac(cj)
if cj <> invalid then
if ck().count() <> 0 then
if not m.ah then
m.ah = true
m.af(cj)
end if
end if
end if
end sub
sub ag(cj)
cc = ColorTVSdkGetInstance()
cd = 5 * 1000
cl = cg(cd , {c: m, cm: cj}, function(ch as Dynamic) as Void
ch.c.ad(ch.cm)
ch.c.ah = false
end function)
cc.ci(cl)
end sub
sub ae(cj)
cn = ck()
if cn.count() = 0 then
bf("No urls to poll currency")
return
end if
co = []
cp = []
bq = CreateObject("roMessagePort")
for each az in cn
bf("polling for currency for url: " + az)
bo = CreateObject("roUrlTransfer")
bo.setUrl(az)
bo.setRequest("GET")
bo.retainBodyOnError(true)
bo.SetCertificatesFile ("common:/certs/ca-bundle.crt")
bo.SetPort(bq)
if m.br <> invalid then
bo.addHeader("CTV-SessionId", m.br["sessionId"])
end if
co.push(bo)
cp.push({az: az, id: bo.getIdentity()})
end for
for each cq in co
cq.AsyncGetToString()
end for
cr = []
for each cq in co
bc =  wait(0,bq)
cr.push(bc)
end for
for each bc in cr
az = ""
for each cs in cp
if cs.id = bc.getSourceIdentity() then
az = cs.az
exit for
end if
end for
bf("Response code for url " + az + ": " + StrI(bc.GetResponseCode()))
bf("Response body: " + bc.GetString())
bd = bc.GetResponseCode()
be = (bd = 200)
if be then
ct = ParseJson(bc.GetString())
if ct["status"] = "true" then
cu(az)
if cj <> invalid then
cj(ct["currencyType"], ct["currencyAmount"].toInt(), ct["placement"])
else
bf("Currency polling succeeded, result: {placement: " + ct["placement"] + ", currencyType: " + ct["currencyType"] + ", currencyAmount: " + ct["currencyAmount"] + "}")
end if
end if
end if
end for
end sub
sub aj(cv)
cw = bt("userAge", "colortv")
cx = bt("userGender", "colortv")
cy = bt("userKeywords", "colortv")
cz = {}
if cw <> invalid then
cz["userAge"] = cw
end if
if cx <> invalid then
cz["userGender"] = cx
end if
if cy <> invalid then
cz["userKeywords"] = cy
end if
if cz.count() = 0 then return
cv["user"] = cz
end sub
function al(da)
bw = m.d + "/ad/info/" + m.e
db = CreateObject("roDeviceInfo")
bs = db.GetAdvertisingId()
for each e in da
bb = {
"identifierForAds": bs
"rokuAppId": e
}
m.n(bw, "POST", FormatJson(bb))
end for
end function
sub an(e as String)
dc = dd()
az = "http://" + dc + ":8060/install/" + e
m.n(az, "POST", "")
end sub
sub ar(e as String, de as String)
df = m.ao()
if e = "11" or df.doesExist(e) then
dg = "launch"
else
dg = "install"
end if
dc = dd()
az = "http://" + dc + ":8060/" + dg + "/" + e + "?contentID=" + de
m.n(az, "POST", "")
end sub
function ap() as Object
dc = dd()
az = "http://" + dc + ":8060/query/apps"
ct = m.n(az, "GET", invalid)
dh = CreateObject("roXMLElement")
if not dh.Parse(ct) then
return {}
else
di = {}
dj = dh.getbody()
dj.ResetIndex()
dk = dj.GetIndex()
while dk <> invalid
dl = {
"name": dk.getBody()
"type": dk.getAttributes()["type"]
"version": dk.getAttributes()["version"]
"id": dk.getAttributes()["id"]
}
di.AddReplace(dk.getAttributes()["id"], dl)
dk = dj.GetIndex()
end while
return di
end if
end function
function at(ay as String, dm="" as String) as Void
az = m.d + "/ct/rec/" + m.e + "/" + ay
if dm <> invalid and dm <> "" then
az += "?videoId="
az += dm
end if
ba = "GET"
bc = m.n(az, ba, invalid)
bd = bc.GetResponseCode()
be = (bd = 200)
colorTvSdk = ColorTVSdkGetInstance()
if not be then
bf("Failure reason: " + bc.GetFailureReason())
bg = {
"errorMessage": bc.GetFailureReason()
"error": bd.toStr()
}
colorTvSdk.dn(bg, ay)
else
do = bj(bc.GetString())
colorTvSdk.dn(do, ay)
end if
end function
function av(az as String)
by = bz()
m.ai(by)
ca = FormatJson(by)
m.n(az, "POST", ca)
end function
function ax(dm as String, dp as String, bb as Object)
az = m.d + "/ct/evt/" + m.e
ba = "POST"
if bb = invalid then
bb = {}
end if
dq = {
"videoId": dm
"eventType": dp
}
bb.append(dq)
bc = m.n(az, ba, FormatJson(bb))
bd = bc.GetResponseCode()
be = (bd = 200)
if not be then
bf("Failed to report video tracking event because of: " + bc.GetFailureReason())
end if
end function
Function bt(dr, ds=invalid)
if ds = invalid then ds = "Default"
du = CreateObject("roRegistrySection", ds)
if du.Exists(dr) then return du.Read(dr)
return invalid
End Function
Function bv(dr, dv, ds=invalid)
if ds = invalid then ds = "Default"
du = CreateObject("roRegistrySection", ds)
du.Write(dr, dv)
du.Flush() 'dw dx
End Function
Function dy(dr, ds=invalid)
if ds = invalid then ds = "Default"
du = CreateObject("roRegistrySection", ds)
du.Delete(dr)
du.Flush() 'dw dx
End Function
Function validstr(dz As Dynamic) As String
if ea(dz) return dz
return ""
End Function
Function eb(dz as dynamic) As Boolean
if dz = invalid return false
if GetInterface(dz, "ifString") = invalid return false
return true
End Function
Function ea(dz)
if ec(dz) return false
return true
End Function
Function ec(dz)
if dz = invalid return true
if not eb(dz) return true
if Len(dz) = 0 return true
return false
End Function
Sub bf(ed As Dynamic)
if ColorTVSdkGetInstance().ee then
ef = CreateObject("roDateTime")
print StrI(ef.getDayOfMonth()).Trim() + "." + StrI(ef.getMonth()).Trim() + "." StrI(ef.getYear()).Trim() + " " + StrI(ef.getHours()).Trim() + ":" + StrI(ef.getMinutes()).Trim() + ":" + StrI(ef.getSeconds()).Trim() + ":" + StrI(ef.getMilliseconds()).Trim() + ": " + ed.toStr().Trim()
end if
End Sub
function eg(eh as Integer) as String
if eh < 0 then
eh = 0
end if
ei = StrI(eh, 16)
if(eh < 16) then
ei = "0" + ei
end if
return ei
end function
function ej(ek as Integer, el as Integer, em as Integer) as String
en = "#ff" + eg(ek) + eg(el) + eg(em)
return en
end function
function bu() as String
eo = CreateObject("roAppInfo")
return eo.GetVersion()
end function
function ep() as LongInteger
eq = CreateObject("roDateTime")
er& = eq.asSeconds() * 1000&
er& += eq.getMilliseconds()
return er&
end function
function es(et as String) as LongInteger
if not eu(et) then
return invalid
end if
ev = 0&
for ew = 0 to et.len() - 1
ev += et.mid(et.len() - 1 - ew, 1).toInt() * 10&^ew
end for
return ev
end function
function eu(ex) as Boolean
ey = CreateObject("roRegex", "^\d+$", "")
return ey.isMatch(ex)
end function
function dd() as String
db = CreateObject("roDeviceInfo")
ez = db.getIpAddrs()
fa = ez.keys()
for each dr in fa
return ez[dr]
end for
return invalid
end function
function fb(fc, fd)
for ew = 0 to fd.count() - 1
if fe(fc, fd[ew]) then
return ew
end if
end for
return invalid
end function
function fe(ff, fg)
if type(ff) = "roAssociativeArray" and type(fg) = "roAssociativeArray" then
if ff.equals = invalid or fg.equals = invalid then
print "Objects have to implement 'equals' method in order to be comparable"
end if
return ff.equals(fg)
end if
return ff = fg
end function
function bp(az as String, fh as Object) as String
fi = fh.keys()
az = az + "?"
for each dr in fi
az = az + dr + "=" + fh[dr] + "&"
end for
az = az.left(az.len() - 1)
return az
end function
function bz() as Dynamic
fj = CreateObject("roDeviceInfo")
eo = CreateObject("roAppInfo")
by = {
"deviceModel": fj.GetModel()
"systemVersion": fj.GetVersion()
"systemName": fj.GetModelDetails().VendorName
"identifierForAds": fj.GetAdvertisingId()
"identifierForVendor": fj.GetPublisherId()
"language": fj.GetCurrentLocale()
"timezone": fj.GetTimeZone()
"appName": eo.GetTitle()
"appVersion": eo.GetVersion()
"sdkVersion": GetColorTVSDKVersion()
}
return by
end function
function ck() as Dynamic
fk = bt("pollingUrls", "colortv")
if fk = invalid then
return []
end if
fl = ParseJson(fk)
fm = fl.Keys()
cn = []
fn = 24 * 60 * 60 * 1000
fo = false
for each dr in fm
fp = es(dr)
if fp <> invalid then
if fp + fn < ep() then
fo = true
fl.delete(dr)
else
cn.push(fl[dr])
end if
end if
end for
if fo then
fq(fl)
end if
return cn
end function
function fq(fl)
fr = FormatJson(fl)
bv("pollingUrls", fr, "colortv")
end function
sub cu(az)
fk = bt("pollingUrls", "colortv")
if fk = invalid then
return
end if
fl = ParseJson(fk)
fm = fl.Keys()
for each dr in fm
if fl[dr] = az then
fl.delete(dr)
end if
end for
fq(fl)
end sub
function ColorTvSdk(e as String) as Object
fs = ColorTVSdkGetInstance()
if fs <> invalid then
print "Color TV SDK has already been initialized"
return fs
end if
print "Color TV SDK initialized with appid " + e
c = {
e: e
sdkVersion: GetColorTVSDKVersion()
ee: false
registerAdCallbacks: ft
registerContentRecommendationCallbacks: fu
setDebugMode: fv
fw: a(e)
t: fx
fy: {}
loadAd: fz
bh: ga
showAd: gb
gc: gd
ge: gf
gg: gh
gi: gj
k: gk
gl: gm
ab: gn
go: []
timerTick: gp
ci: gq
gr: gs
setUserAge: gt
setUserGender: gu
setUserKeywords: gv
gw: gx
gy: gz
ha: {}
loadContentRecommendation: hb
dn: hc
hd: he
showContentRecommendation: hf
trackVideoEvents: hg
}
GetGlobalAA()["colorTvSdkInstance"] = c
c.t()
c.fw.v()
c.gr()
return c
end function
function ft(hh as Object)
m.hh = hh
m.ab()
end function
function fu(hi)
m.hi = hi
end function
function fv(ee as Boolean)
m.ee = ee
end function
function fx()
db = CreateObject("roDeviceInfo")
bs = db.GetAdvertisingId()
m.fw.t(m.e, bs, m.sdkVersion)
end function
function fz(ay as String) as Void
bf("loading ad for placement " + ay)
if m.fy.DoesExist(ay) then
bf("Ad for placement: " + ay + " is already loaded")
if m.hh <> invalid and m.hh["adLoaded"] <> invalid then
m.hh["adLoaded"](ay)
end if
return
end if
m.fw.f(ay)
end function
function ga(hj as Object, ay as String) as Void
if hj.DoesExist("error") then
m.gc(ay, hj["error"], hj["errorMessage"])
else
bf("Ad has been loaded for placement: " + ay)
m.fy.AddReplace(ay, hj)
if m.hh <> invalid and m.hh["adLoaded"] <> invalid then
m.hh["adLoaded"](ay)
end if
end if
end function
sub gb(ay as String)
if not hk(ay, m.fy)
m.fy.delete(ay)
return
end if
hj = m.fy[ay]
m.fy.delete(ay)
if hj["type"] = "discovery" then
for ew = 0 to hj["ads"].count() - 1
if hj["ads"][ew]["pollingUrl"] <> invalid then
hl(hj["ads"][ew]["pollingUrl"])
end if
end for
else
hl(hj["ads"][0]["pollingUrl"])
end if
if hj["type"] = "video" or hj["ads"][0]["markupUrl"] <> invalid then
hm = hn(hj, m.fw, m.hh)
if hm = invalid then
m.gc(ay, "INTERNAL_SDK_ERROR", "Can't play video ad with URL: " + hj["ads"][0]["markupUrl"])
return
end if
hm.ho()
end if
if hj["type"] <> "video" and not hp(hj) then
hq = CreateObject("roSGScreen")
hr = m.ge(hq, hj["type"])
hq.show()
m.gg(hr, hj)
hr["dataModel"] = hj
while true
hs = wait(GetColorTVSDKTimerInterval(), m.bq)
ht = type(hs)
if ht = "roSGScreenEvent"
if hs.isScreenClosed() then
exit while
end if
else if ht = "roSGNodeEvent"
if m.gi(hs, hj, hr) then
exit while
end if
end if
m.timerTick()
end while
if m.hh <> invalid then
m.fw.ab(m.hh["currencyEarned"])
end if
end if
end sub
function gd(ay as String, hu as String, hv as String)
if m.hh <> invalid and m.hh["adError"] <> invalid then
bg = {
"placement": ay
"errorCode": hu
"errorMessage": hv
}
m.hh["adError"](bg)
else
bf("Ad error has occured for placement: """ + ay + """ with code: """ + hu + """ and message: """ + hv + """")
end if
end function
function gf(hq as Object, hw as String)
m.bq = CreateObject("roMessagePort")
hq.setMessagePort(m.bq)
hr = hq.CreateScene("colortv_" + hw)
return hr
end function
function gh(hr as Object, hx as Object)
if hr.findNode("colorTvAdEvents") <> invalid then
hr.findNode("colorTvAdEvents").observeField("closeAd", m.bq)
hr.findNode("colorTvAdEvents").observeField("adShown", m.bq)
end if
if hx["type"] = "engagement" or hx["type"] = "interstitial" then
hy = hx["ads"][0]["actionButton"]["actionType"]
if hz(hy) then
hr.findNode("colorTvSubscriptionEvents").observeField("subscribed", m.bq)
else if ia(hy) then
hr.findNode("colorTvAppstoreEvents").observeField("clicked", m.bq)
end if
else if hx["type"] = "discovery" then
hr.findNode("colorTvGridEvents").observeField("closed", m.bq)
hr.findNode("colorTvGridEvents").observeField("impression", m.bq)
hr.findNode("colorTvGridEvents").observeField("moreDataUrl", m.bq)
hr.findNode("colorTvDiscoveryCenterEvents").observeField("clicked", m.bq)
hr.findNode("colorTvDiscoveryCenterEvents").observeField("subscribed", m.bq)
end if
end function
function gj(hs as Object, hj as Object, hr as Object) as Boolean
ay = hj["placement"]
if hs.getNode() = "colorTvAdEvents" then
if hs.getField() = "closeAd" then
if m.hh <> invalid and m.hh["adClosed"] <> invalid and ay <> invalid then
m.hh["adClosed"](ay)
end if
return true
else if hs.getField() = "adShown" then
m.fw.r(hj["ads"][0]["impressionUrl"])
end if
else if hs.getNode() = "colorTvSubscriptionEvents" then
if hs.getField() = "subscribed" then
m.gl(hj, hj["ads"][0], hs.getData())
end if
else if hs.getNode() = "colorTvAppstoreEvents" then
if hs.getField() = "clicked" then
m.fw.r(hj["ads"][0]["clickTracker"])
if m.hh <> invalid and m.hh["adClosed"] <> invalid then
m.hh["adClosed"](ay)
end if
ib = hj["ads"][0]
if ib["type"] = "appstore" then
if ib["clickData"]["contentId"] <> invalid then
m.fw.aq(ib["clickData"]["channelId"], ib["clickData"]["contentId"])
else
m.fw.am(ib["clickData"]["channelId"])
end if
else if ib["type"] = "content"
m.fw.aq(ib["clickData"]["channelId"], ib["clickData"]["contentId"])
end if
return true
end if
else if hs.getNode() = "colorTvGridEvents" then
if hs.getField() = "impression" and hs.getData() <> ""
m.fw.r(hs.getData())
else if hs.getField() = "moreDataUrl" and hs.getData() <> "" then
m.k(hr, hs.getData())
else if hs.getField() = "closed" then
if m.hh <> invalid and m.hh["adClosed"] <> invalid and ay <> invalid then
m.hh["adClosed"](ay)
end if
return true
end if
else if hs.getNode() = "colorTvDiscoveryCenterEvents" then
if hs.getField() = "subscribed" then
ic = hs.getData()["clickedItemModel"]
id = hs.getData()["inputValue"]
m.gl(hj, ic, id)
else if hs.getField() = "clicked"
ib = hs.getData()
if ib["clickTracker"] <> invalid then
m.fw.r(ib["clickTracker"])
end if
if m.hh <> invalid and m.hh["adClosed"] <> invalid then
m.hh["adClosed"](ay)
end if
if ib["type"] = "appstore" then
if ib["clickData"]["contentId"] <> invalid then
m.fw.aq(ib["clickData"]["channelId"], ib["clickData"]["contentId"])
else
m.fw.am(ib["clickData"]["channelId"])
end if
else if ib["type"] = "content"
m.fw.aq(ib["clickData"]["channelId"], ib["clickData"]["contentId"])
end if
return true
end if
end if
return false
end function
function gk(hr as Dynamic, ie as String)
ig = m.fw.k(ie)
if ig <> invalid then
if hr["dataModel"]["ads"] <> invalid then
ih = hr["dataModel"]["ads"]
ih.append(ig["ads"])
ig["ads"] = ih
hr["dataModel"] = ig
else if hr["dataModel"].ii <> invalid then
ih = hr["dataModel"].ii
ih.append(ig.ii)
ig.ii = ih
hr["dataModel"] = ig
end if
end if
hr.findNode("colorTvGridEvents")["moreDataUrl"] = ""
end function
function gm(ij as Dynamic, ib as Dynamic, ik as String) as Void
ij.il(ik)
m.fw.p(ib["clickTracker"], ik, ib["type"])
if ib["clickUrl"] <> invalid then
m.fw.p(ib["clickUrl"], ik, ib["type"])
else if ib["clickData"]["clickUrl"] <> invalid then
m.fw.p(ib["clickData"]["clickUrl"], ik, ib["type"])
end if
end function
function gn()
if m.hh <> invalid then
m.fw.ab(m.hh["currencyEarned"])
end if
end function
sub gp()
im = []
for each in in m.go
if in.io() then
im.push(in)
end if
end for
for each cl in im
m.go.delete( fb(cl, m.go) )
end for
end sub
function gq(cl as Dynamic) as Void
m.go.push(cl)
end function
function gs()
ip = m.fw.ao()
iq = ip.keys()
ir = is()
bv("installedApps", FormatJson(ip), "colortv")
it = []
for each iu in ir
for each dr in ip.keys()
if dr = iu then
it.push(dr)
end if
end for
end for
for each e in it
iv = fb(e, iq)
iq.delete(iv)
end for
bf("Apps that weren't saved yet: " + FormatJson(iq))
m.fw.ak(iq)
end function
sub gt(iw)
if Type(iw) = "roInt" Or Type(iw) = "roInteger" or Type(iw) = "Integer"
iw = iw.toStr()
else if not ((Type(iw) = "roString" Or Type(iw) = "String") and eu(iw)) then
print "WARNING: Value passed as user age is not a number"
return
end if
bv("userAge", iw, "colortv")
end sub
sub gu(ix as String)
if not (LCase(ix) = "male" or LCase(ix) = "female") then
print "WARNING: Value passed as user gender is neither male nor female"
return
end if
bv("userGender", LCase(ix), "colortv")
end sub
sub gv(iy as String)
bv("userKeywords", iy, "colortv")
end sub
function gz(iz as String, bn as String) as Void
bf("Saving: " + iz + ", " + bn)
bv("subscription_" + bn, iz, "colortv")
end function
function gx(bn as String) as Dynamic
return bt("subscription_" + bn, "colortv")
end function
sub hb(ay, ja="" as String)
bf("loading content recommendation for placement " + ay)
if m.ha.DoesExist(ay) then
bf("Content recommendation for placement: " + ay + " is already loaded")
if m.hi <> invalid and m.hi["contentRecommendationLoaded"] <> invalid then
m.hi["contentRecommendationLoaded"](ay)
end if
return
end if
m.fw.as(ay, ja)
end sub
function hc(jb as Object, ay as String) as Void
if jb.DoesExist("error") then
m.hd(ay, jb["errorCode"].toStr(), jb["error"])
else
bf("Content recommendation has been loaded for placement: " + ay)
m.ha.AddReplace(ay, jb)
if m.hi <> invalid and m.hi["contentRecommendationLoaded"] <> invalid then
m.hi["contentRecommendationLoaded"](ay)
end if
end if
end function
function he(ay as String, hu as String, hv as String)
if m.hi <> invalid and m.hi["contentRecommendationError"] <> invalid then
bg = {
"placement": ay
"errorCode": hu
"errorMessage": hv
}
m.hi["contentRecommendationError"](bg)
else
bf("Content recommendation error has occured for placement: """ + ay + """ with code: """ + hu + """ and message: """ + hv + """")
end if
end function
sub hf(ay as String)
if not jc(ay, m.ha)
m.ha.delete(ay)
return
end if
jb = m.ha[ay]
m.ha.delete(ay)
hq = CreateObject("roSGScreen")
hr = m.ge(hq, "contentRecommendation")
hq.show()
hr.findNode("colorTvGridEvents").observeField("moreDataUrl", m.bq)
hr.findNode("colorTvGridEvents").observeField("impression", m.bq)
hr.findNode("colorTvGridEvents").observeField("closed", m.bq)
hr.findNode("colorTvContentRecommendationEvents").observeField("clicked", m.bq)
hr.findNode("colorTvContentRecommendationEvents").observeField("favourite", m.bq)
hr.findNode("colorTvDiscoveryCenterEvents").observeField("clicked", m.bq)
hr.findNode("colorTvDiscoveryCenterEvents").observeField("subscribed", m.bq)
for ew = 0 to jb["recommendations"].count() - 1
if jb["recommendations"][ew]["pollingUrl"] <> invalid then
hl(jb["recommendations"][ew]["pollingUrl"])
end if
end for
hr["dataModel"] = jb
while true
hs = wait(GetColorTVSDKTimerInterval(), m.bq)
ht = type(hs)
if ht = "roSGScreenEvent"
if hs.isScreenClosed() then
exit while
end if
else if ht = "roSGNodeEvent"
if hs.getNode() = "colorTvContentRecommendationEvents" then
if hs.getField() = "clicked" then
ib = hs.getData()
if ib["clickTracker"] <> invalid then
m.fw.r(ib["clickTracker"])
end if
if m.hi <> invalid and m.hi["contentRecommendationClicked"] <> invalid then
m.hi["contentRecommendationClicked"](ay, ib["partnerVideoId"])
end if
exit while
else if hs.getField() = "favourite" and hs.getData() <> "" then
m.fw.au(hs.getData())
end if
else if hs.getNode() = "colorTvGridEvents" then
if hs.getField() = "impression" and hs.getData() <> ""
m.fw.r(hs.getData())
else if hs.getField() = "moreDataUrl" and hs.getData() <> "" then
m.k(hr, hs.getData())
else if hs.getField() = "closed" then
if m.hi <> invalid and m.hi["contentRecommendationClosed"] <> invalid then
m.hi["contentRecommendationClosed"](ay)
end if
exit while
end if
else if hs.getNode() = "colorTvDiscoveryCenterEvents" then
if hs.getField() = "subscribed" then
ic = hs.getData()["clickedItemModel"]
id = hs.getData()["inputValue"]
m.gl(jb, ic, id)
else if hs.getField() = "clicked"
ib = hs.getData()
if ib["clickTracker"] <> invalid then
m.fw.r(ib["clickTracker"])
end if
if m.hi <> invalid and m.hi["contentRecommendationClosed"] <> invalid then
m.hi["contentRecommendationClosed"](ay)
end if
if ib["type"] = "appstore" then
if ib["clickData"]["contentId"] <> invalid then
m.fw.aq(ib["clickData"]["channelId"], ib["clickData"]["contentId"])
else
m.fw.am(ib["clickData"]["channelId"])
end if
else if ib["type"] = "content"
m.fw.aq(ib["clickData"]["channelId"], ib["clickData"]["contentId"])
end if
exit while
end if
end if
end if
m.timerTick()
end while
end sub
function hg(dm as String, dp as Object)
if type(dp) = "roSGNodeEvent" then
if dp.getField() = "state" then
if dp.getData() = "playing" and (m.jd = invalid or not m.jd.je) then
if m.jd = invalid then
m.jd = {}
end if
m.jd.je = true
m.fw.aw(dm, "VIDEO_STARTED", invalid)
else if dp.getData() = "stopped"  and m.jd <> invalid then
m.fw.aw(dm, "VIDEO_STOPPED", m.jd)
m.jd = invalid
else if dp.getData() = "finished"
m.fw.aw(dm, "VIDEO_COMPLETED", invalid)
m.jd = invalid
end if
else if dp.getField() = "position" then
jf% = dp.getData()
if m.jd = invalid then
m.jd = {}
end if
m.jd["watchedSeconds"] = jf%
end if
else if type(dp) = "roVideoPlayerEvent" then
if dp.isStatusMessage() and dp.GetMessage() = "start of play" then
m.fw.aw(dm, "VIDEO_STARTED", invalid)
else if dp.isPlaybackPosition() then
m.jd = { "watchedSeconds": dp.getIndex() }
else if dp.isFullResult() then
m.fw.aw(dm, "VIDEO_COMPLETED", invalid)
m.jd = invalid
else if dp.isPartialResult() and m.jd <> invalid then
m.fw.aw(dm, "VIDEO_STOPPED", m.jd)
m.jd = invalid
end if
else if type(dp) = "String" or type(dp) = "roString" then
if dp = "interrupted" and m.jd <> invalid then
m.fw.aw(dm, "VIDEO_STOPPED", m.jd)
m.jd = invalid
end if
end if
end function
function ColorTVSdkGetInstance()
return GetGlobalAA()["colorTvSdkInstance"]
end function
function GetColorTVSDKVersion() as String
return "1.1.0"
end function
function GetColorTVSDKTimerInterval() as Integer
return 1000
end function
sub hl(jg)
if jg = invalid then
return
end if
fk = bt("pollingUrls", "colortv")
if fk = invalid then
fk = "{}"
end if
fl = ParseJson(fk)
fl[ep().toStr()] = jg
bv("pollingUrls", FormatJson(fl), "colortv")
end sub
function is()
jh = []
ji = bt("installedApps", "colortv")
if ji <> invalid
jh = ParseJson(ji)
end if
return jh
end function
function hp(hj) as Boolean
return hj.jj <> invalid and hj.jj
end function
function hk(ay as String, fy as Object) as Boolean
if not fy.DoesExist(ay) then
bf("Ad for placement: " + ay + " isn't loaded. Please call loadAd function first.")
return false
else if not jk(fy[ay]) then
bf("Ad for placement: " + ay + " is not valid anymore. Please load the ad again.")
return false
end if
return true
end function
function jc(ay as String, jl as Object) as Boolean
if not jl.DoesExist(ay) then
bf("Content recommendation for placement: " + ay + " isn't loaded. Please call loadContentRecommendation function first.")
return false
else if not jk(jl[ay]) then
bf("Content recommendation for placement: " + ay + " is not valid anymore. Please load the content recommendation again.")
return false
end if
return true
end function
function jk(hj) as Boolean
jm = CreateObject("roDateTime")
jm.fromIso8601String(hj["validUntil"])
jn = CreateObject("roDateTime")
return jm.asSeconds() > jn.asSeconds()
end function
function hz(jo as String) as Boolean
return jo = "CLICK_TO_SMS" or jo = "CLICK_TO_CALL" or jo = "CLICK_TO_EMAIL"
end function
function ia(jo as String) as Boolean
return jo = "CLICK_TO_APPSTORE" or jo = "CLICK_TO_CONTENT"
end function
function bj(ca as String) as Object
c = ParseJson(ca)
if not c.DoesExist("error") then
jp = CreateObject("roDateTime")
jp.fromSeconds(jp.asSeconds() + c["validFor"])
c["validUntil"] = jp.toIsoString()
c.il = jq
c["storedPhoneNumber"] = jr("phone")
c["storedEmailAddress"] = jr("email")
end if
return c
end function
function jr(bn)
return ColorTVSdkGetInstance().gw(bn)
end function
function jq(js as String) as Void
if js = invalid then
return
end if
jt = CreateObject("roRegex", "\A[^@]+@[^@]+\z", "")
ju = CreateObject("roRegex", "[\(]?[0-9]{3}[\)]?[ ]?[-]?[ ]?[0-9]{3}[ ]?[-]?[ ]?[0-9]{3,4}", "")
jv = invalid
if jt.isMatch(js) then
jv = "email"
else if ju.isMatch(js)
jv = "phone"
end if
if jv = invalid then
return
end if
jw = ColorTVSdkGetInstance()
jw.gy(js, jv)
end function
function cb(ca) as Object
if ca = invalid or Len(ca) = 0
return invalid
end if
c = ParseJson(ca)
if c = invalid then
return invalid
end if
if c["pingInterval"] = invalid then
c["pingInterval"] = ce()
end if
return c
end function
function ce()
return 60 * 1000
end function
function cg(jx as Double, fh as Dynamic, cm as Function)
c = {
cm: cm,
fh: fh,
io: jy,
equals: jz
}
c.ka = ep() + jx
return c
end function
function jy() as Boolean
kb = ep()
if kb < m.ka then
return false
end if
if m.fh.isEmpty() then
m.cm()
else
m.cm(m.fh)
end if
return true
end function
function jz(kc as Dynamic) as Boolean
return m.ka = kc.ka and m.cm = kc.cm
end function
function hn(hj as Object, fw as Object, hh as Object) as Object
kd = NWM_VAST()
ke = kd.GetPrerollFromURL(hj["ads"][0]["markupUrl"])
if ke = invalid then
return invalid
end if
c = {
ho: kf
kg: kh
ki: kj
kk: kl
km: kn
ko: kp
kq: kr
ks: kt
ku: kv
kw: kx
ke: ke
hj: hj
hh: hh
fw: fw
}
return c
end function
function kf() as Void
ky = m.kg()
ky.Show()
kz = m.ki()
kz.Play()
if m.hj["type"] <> "video"
m.kk(ky)
end if
while true
hs = wait(GetColorTVSDKTimerInterval(), m.bq)
ht = type(hs)
if ht = "roSGScreenEvent"
if hs.isScreenClosed() then
exit while
end if
else if ht = "roSGNodeEvent"
if hs.getNode() = "colorTvAdEvents" then
if hs.getField() = "closeAd" then
exit while
end if
end if
else if type(hs) = "roVideoPlayerEvent"
if hs.isFullResult()
exit while
else if hs.isPartialResult()
exit while
else if hs.isRequestFailed()
ColorTVSdkGetInstance().gc(m.hj["placement"], "INTERNAL_SDK_ERROR", hs.getMessage())
exit while
else if hs.isStatusMessage() and hs.GetMessage() = "start of play"
m.km(ky)
else if hs.isPlaybackPosition()
m.ko(ky, hs.GetIndex(), m.ke["length"])
m.kq(hs.getIndex())
end if
else if type(hs) = "roImageCanvasEvent" and hs.isRemoteKeyPressed()
if m.ks(hs.GetIndex(), kz) then
exit while
end if
end if
ColorTVSdkGetInstance().timerTick()
end while
end function
function kh()
m.bq = CreateObject("roMessagePort")
ky = CreateObject("roImageCanvas")
ky.SetMessagePort(m.bq)
ky.SetLayer(1, {"color": "#000000"})
return ky
end function
function kj()
db = CreateObject("roDeviceInfo")
kz = CreateObject("roVideoPlayer")
kz.SetMessagePort(m.bq)
kz.SetDestinationRect({la:db.GetDisplaySize().la,lb:db.GetDisplaySize().lb,lc:0,ld:0})
kz.SetPositionNotificationPeriod(1)
kz.AddContent(m.ke)
return kz
end function
function kn(ky as Object)
ky.ClearLayer(2)
ky.SetLayer(1, {"color": "#00000000", "CompositionMode": "Source"})
end function
function kr(le)
for each lf in m.ke["trackingEvents"]
if lf["time"] = le
lg(lf)
end if
end for
end function
function kt(lh, kz) as Boolean
if lh = 2 or lh = 0  'li or lj
m.kw()
return true
else if lh = 6 and m.hj["type"] <> "video"
kz.pause()
if hz(m.hj["ads"][0]["actionButton"]["actionType"]) then
if m.ku() then
m.kw()
m.hj.jj = true
return true
else
kz.resume()
end if
else if m.hj["ads"][0]["actionButton"]["actionType"] = "CLICK_TO_APPSTORE"
m.kw()
m.hj.jj = true
ib = m.hj["ads"][0]
m.fw.r(ib["clickTracker"])
if ib["clickData"]["contentId"] <> invalid then
m.fw.aq(ib["clickData"]["channelId"], ib["clickData"]["contentId"])
else
m.fw.am(ib["clickData"]["channelId"])
end if
return true
else if m.hj["ads"][0]["actionButton"]["actionType"] = "CLICK_TO_CONTENT"
m.kw()
ib = m.hj["ads"][0]
m.hj.jj = true
m.fw.aq(ib["clickData"]["channelId"], ib["clickData"]["contentId"])
return true
end if
end if
return false
end function
function kx()
for each lf in m.ke["trackingEvents"]
if lf["event"] = "CLOSE"
lg(lf)
end if
end for
if m.hh <> invalid and m.hh["adClosed"] <> invalid then
m.hh["adClosed"](m.hj["placement"])
end if
end function
sub kl(ky as Object)
lk = 720.0 / 1080.0
ll% = 1356.0 * lk
lm% = 902.0 * lk
ln% = 400.0 * lk
lo% = 100.0 * lk
lp = invalid
lq = m.hj["ads"][0]
if hz(lq["actionButton"]["actionType"]) then
lr% = ll% + 30 * lk
ls% = lm% + 4 * lk
lt% = ll% + 30.0 * lk
lu% = lm% + 30.0 * lk
lv% = 40.0 * lk
lw% = 40.0 * lk
if lq["actionButton"]["actionType"] = "CLICK_TO_EMAIL" then
lx = "color_tv_icon_mail"
else if lq["actionButton"]["actionType"] = "CLICK_TO_CALL" then
lx = "color_tv_icon_phone"
else
lx = "color_tv_icon_sms"
end if
lp = {
"Url": "pkg:/images/colortv/" + lx + ".png"
"TargetRect": {
"x": lt%
"y": lu%
"w": lw%
"h": lv%
}
}
else
lr% = ll%
ls% = lm%
end if
ly = ej(lq["actionButton"]["backgroundRed"], lq["actionButton"]["backgroundGreen"], lq["actionButton"]["backgroundBlue"])
lz = ej(lq["actionButton"]["textRed"], lq["actionButton"]["textGreen"], lq["actionButton"]["textBlue"])
ma = {
"TargetRect": {
"x": lr%
"y": ls%
"w": ln%
"h": lo%
}
"Text": lq["actionButton"]["text"]
"TextAttrs":{
"Color" : lz,
"Font" : "Small",
"HAlign" : "HCenter",
"VAlign" : "VCenter",
"Direction" : "LeftToRight"
}
}
mb = {
"TargetRect": {
"x": ll%
"y": lm%
"w": ln%
"h": lo%
}
"color": ly
}
ky.SetLayer(20, ma)
ky.SetLayer(19, mb)
if lp <> invalid then
ky.SetLayer(21, lp)
end if
end sub
sub kp(ky as Object, jn as Integer, mc as Integer)
lk = 720.0 / 1080.0
md% = 100.0 * lk
me% = 906.0 * lk
mf% = 902.0 * lk
mg% = 100.0 * lk
mh% = 100.0 * lk
mi = ej(255, 255, 255)
mj = (mc - jn).toStr()
mk = {
"TargetRect": {
"x": md%
"y": me%
"w": mg%
"h": mh%
}
"Text": mj
"TextAttrs":{
"Color" : mi,
"Font" : "Small",
"HAlign" : "HCenter",
"VAlign" : "VCenter",
"Direction" : "LeftToRight"
}
}
ml! = (mc - jn) / mc
if ml! >= 1 then
mm = "colortv_timer_1"
else if ml! >= 0.93 then
mm = "colortv_timer_2"
else if ml! >= 0.86 then
mm = "colortv_timer_3"
else if ml! >= 0.8 then
mm = "colortv_timer_4"
else if ml! >= 0.73 then
mm = "colortv_timer_5"
else if ml! >= 0.66 then
mm = "colortv_timer_6"
else if ml! >= 0.6 then
mm = "colortv_timer_7"
else if ml! >= 0.53 then
mm = "colortv_timer_8"
else if ml! >= 0.46 then
mm = "colortv_timer_9"
else if ml! >= 0.4 then
mm = "colortv_timer_10"
else if ml! >= 0.33 then
mm = "colortv_timer_11"
else if ml! >= 0.26 then
mm = "colortv_timer_12"
else if ml! >= 0.2 then
mm = "colortv_timer_13"
else if ml! >= 0.13 then
mm = "colortv_timer_14"
else if ml! >= 0.066 then
mm = "colortv_timer_15"
else
mm = "colortv_timer_16"
end if
mn = {
"Url": "pkg:/images/colortv/timer/" + mm + ".png"
"TargetRect": {
"x": md%
"y": mf%
"w": mg%
"h": mh%
}
}
ky.SetLayer(22, mn)
ky.SetLayer(23, mk)
end sub
function kv()
hq = CreateObject("roSGScreen")
bq = CreateObject("roMessagePort")
hq.setMessagePort(bq)
hr = hq.CreateScene("colortv_subscriptionWindowWrapper")
hq.show()
hr.findNode("colorTvSubscriptionEvents").observeField("subscribed", bq)
hr.findNode("colorTvSubscriptionEvents").observeField("closed", bq)
hr.findNode("colorTvAdEvents").observeField("closeAd", bq)
hr["dataModel"] = m.hj
while true
hs = wait(GetColorTVSDKTimerInterval(), bq)
ht = type(hs)
if ht = "roSGNodeEvent"
if hs.getNode() = "colorTvSubscriptionEvents" then
if hs.getField() = "subscribed" then
ColorTVSdkGetInstance().gl(m.hj, m.hj["ads"][0], hs.getData())
else if hs.getField() = "closed"
return false
end if
else if hs.getNode() = "colorTvAdEvents" then
if hs.getField() = "closeAd" then
return true
end if
end if
end if
ColorTVSdkGetInstance().timerTick()
end while
end function
function lg(lf)
mo = true
mp = 3000
mq = CreateObject("roTimespan")
mq.Mark()
bq = CreateObject("roMessagePort")
mr = CreateObject("roURLTransfer")
mr.SetCertificatesFile("common:/certs/ca-bundle.crt")
mr.SetPort(bq)
mr.SetURL(lf["url"])
bf("~~~TRACKING: " + mr.GetURL())
if mr.AsyncGetToString()
dp = wait(mp, bq)
if dp = invalid
mr.AsyncCancel()
mo = false
else
bf("Req finished: " + mq.TotalMilliseconds().ToStr())
bf(dp.GetResponseCode().ToStr())
bf(dp.GetFailureReason())
end if
end if
return mo
end function