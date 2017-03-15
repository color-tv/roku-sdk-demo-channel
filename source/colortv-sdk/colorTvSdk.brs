function colortv_a(colortv_b as String) as Object
colortv_c = {
colortv_d: "https://adsrv.colortv.com"
colortv_e: colortv_b
colortv_f: colortv_g
colortv_h: colortv_i
colortv_j: colortv_k
colortv_l: colortv_m
colortv_n: colortv_o
colortv_p: colortv_q
colortv_r: colortv_s
colortv_t: colortv_u
colortv_v: colortv_w
colortv_x: colortv_y
colortv_z: colortv_aa
colortv_ab: colortv_ac
colortv_ad: colortv_ae
colortv_af: false
colortv_ag: colortv_ah
colortv_ai: colortv_aj
colortv_ak: colortv_al
colortv_am: colortv_an
colortv_ao: colortv_ap
colortv_aq: colortv_ar
colortv_as: colortv_at
colortv_au: colortv_av
colortv_aw: colortv_ax
colortv_ay: colortv_az
}
return colortv_c
end function
function colortv_g(colortv_ba as String) as Void
colortv_bb = m.colortv_d + "/ad/req"
colortv_bc = "GET"
colortv_bd = {
"app": m.colortv_e
"placement": colortv_ba
}
colortv_be = m.colortv_l(colortv_bb, colortv_bc, colortv_bd)
colortv_bf = colortv_be.GetResponseCode()
colortv_bg = (colortv_bf = 200)
colorTvSdk = ColorTVSdkGetInstance()
if not colortv_bg then
colortv_bh("Failure reason: " + colortv_be.GetFailureReason())
colortv_bi = {
"errorMessage": colortv_be.GetFailureReason()
"error": colortv_bf.toStr()
}
colorTvSdk.colortv_bj(colortv_bi, colortv_ba)
else
colortv_bk = colortv_bl(colortv_be.GetString())
if colortv_bk["type"] = "discovery" then
colortv_bm = m.colortv_h(colortv_ba)
colortv_bk["featuredAd"] = colortv_bm
end if
colorTvSdk.colortv_bj(colortv_bk, colortv_ba)
end if
end function
function colortv_i(colortv_ba as String) as Object
colortv_bb = m.colortv_d + "/ad/req"
colortv_bc = "GET"
colortv_bd = {
"app": m.colortv_e
"placement": colortv_ba
"type": "featured"
}
colortv_be = m.colortv_l(colortv_bb, colortv_bc, colortv_bd)
colortv_bf = colortv_be.GetResponseCode()
colortv_bg = (colortv_bf = 200)
colorTvSdk = ColorTVSdkGetInstance()
colortv_bn = ParseJson(colortv_be.getString())
if colortv_bg and colortv_bn["error"] = invalid and colortv_bn["ads"] <> invalid then
return colortv_bn["ads"][0]
end if
return invalid
end function
function colortv_k(colortv_bb as String)
colortv_be = m.colortv_l(colortv_bb, "GET", invalid)
colortv_bf = colortv_be.GetResponseCode()
colortv_bg = (colortv_bf = 200)
colorTvSdk = ColorTVSdkGetInstance()
colortv_bn = colortv_bl(colortv_be.getString())
if colortv_bg and colortv_bn["error"] = invalid and (colortv_bn["ads"] <> invalid or colortv_bn["recommendations"] <> invalid) then
return colortv_bn
end if
return invalid
end function
function colortv_o(colortv_bb as String, colortv_bo as String, colortv_bp as String)
colortv_bd = "{""" + colortv_bp + """:""" + colortv_bo + """}"
colortv_be = m.colortv_l(colortv_bb, "POST", colortv_bd)
end function
function colortv_m(colortv_bb as String, colortv_bc as String, colortv_bd as Dynamic)
colortv_bq = CreateObject("roUrlTransfer")
if colortv_bc = "GET" and colortv_bd <> invalid and colortv_bd.count() > 0 then
colortv_bb = colortv_br(colortv_bb, colortv_bd)
end if
colortv_bh("URL: " + colortv_bb)
colortv_bq.setUrl(colortv_bb)
colortv_bq.setRequest(colortv_bc)
colortv_bq.retainBodyOnError(true)
colortv_bq.SetCertificatesFile ("common:/certs/ca-bundle.crt")
colortv_bs = CreateObject("roMessagePort")
colortv_bq.SetPort(colortv_bs)
if m.colortv_bt <> invalid then
colortv_bq.addHeader("CTV-SessionId", m.colortv_bt["sessionId"])
end if
if colortv_bc = "GET" or colortv_bc = "PUT" then
colortv_bq.AsyncGetToString()
else if colortv_bc = "POST" then
colortv_bq.addHeader("Content-Type", "application/json")
colortv_bq.AsyncPostFromString(colortv_bd)
else
colortv_bh("Request method not supported: " + colortv_bc)
return invalid
end if
colortv_be =  wait(0,colortv_bs)
colortv_bh("Response code: " + StrI(colortv_be.GetResponseCode()))
colortv_bh("Response body: " + colortv_be.GetString())
return colortv_be
end function
function colortv_q(colortv_bb as String)
m.colortv_l(colortv_bb, "GET", invalid)
end function
sub colortv_s(colortv_e as String, colortv_bu as String, sdkVersion as String)
if colortv_bv("installed", "colortv") <> invalid then
return
end if
colortv_bh("Registering app install for version " + colortv_bw())
colortv_bx("installed", "true", "colortv")
colortv_bd = "{""sdkVersion"":""" + sdkVersion + """, ""appVersion"":""" + colortv_bw() + """}"
colortv_by = m.colortv_d + "/app/inst/" + colortv_e + "?deviceid=" + colortv_bu
colortv_be = m.colortv_l(colortv_by, "POST", colortv_bd)
end sub
function colortv_u() as Void
colortv_bh("Starting session")
colortv_bb = m.colortv_d + "/app/sess/" + m.colortv_e
colortv_bz = colortv_br(colortv_bb, {"state" : "start"})
colortv_ca = colortv_cb()
m.colortv_ag(colortv_ca)
colortv_cc = FormatJson(colortv_ca)
colortv_be = m.colortv_l(colortv_bz, "POST", colortv_cc)
m.colortv_bt = colortv_cd(colortv_be.GetString())
m.colortv_x()
end function
sub colortv_y()
colortv_ce = ColorTVSdkGetInstance()
colortv_cf = colortv_cg()
if m.colortv_bt <> invalid then
colortv_cf = m.colortv_bt["pingInterval"] * 1000
end if
colortv_ch = colortv_ci(colortv_cf , {colortv_c: m}, function(colortv_cj as Dynamic) as Void
colortv_cj.colortv_c.colortv_v()
end function)
colortv_ce.colortv_ck(colortv_ch)
end sub
sub colortv_w()
if m.colortv_bt = invalid then
m.colortv_t()
return
end if
colortv_bb = m.colortv_d + "/app/sess/"
colortv_ca = colortv_cb()
m.colortv_ag(colortv_ca)
colortv_cc = FormatJson(colortv_ca)
colortv_be = m.colortv_l(colortv_bb, "PUT", colortv_cc)
m.colortv_bt = colortv_cd(colortv_be.GetString())
m.colortv_x()
end sub
sub colortv_aa(colortv_cl)
if colortv_cl <> invalid then
if colortv_cm().count() <> 0 then
if not m.colortv_af then
m.colortv_af = true
m.colortv_ad(colortv_cl)
end if
end if
end if
end sub
sub colortv_ae(colortv_cl)
colortv_ce = ColorTVSdkGetInstance()
colortv_cf = 5 * 1000
colortv_cn = colortv_ci(colortv_cf , {colortv_c: m, colortv_co: colortv_cl}, function(colortv_cj as Dynamic) as Void
colortv_cj.colortv_c.colortv_ab(colortv_cj.colortv_co)
colortv_cj.colortv_c.colortv_af = false
end function)
colortv_ce.colortv_ck(colortv_cn)
end sub
sub colortv_ac(colortv_cl)
colortv_cp = colortv_cm()
if colortv_cp.count() = 0 then
colortv_bh("No urls to poll currency")
return
end if
colortv_cq = []
colortv_cr = []
colortv_bs = CreateObject("roMessagePort")
for each colortv_bb in colortv_cp
colortv_bh("polling for currency for url: " + colortv_bb)
colortv_bq = CreateObject("roUrlTransfer")
colortv_bq.setUrl(colortv_bb)
colortv_bq.setRequest("GET")
colortv_bq.retainBodyOnError(true)
colortv_bq.SetCertificatesFile ("common:/certs/ca-bundle.crt")
colortv_bq.SetPort(colortv_bs)
if m.colortv_bt <> invalid then
colortv_bq.addHeader("CTV-SessionId", m.colortv_bt["sessionId"])
end if
colortv_cq.push(colortv_bq)
colortv_cr.push({colortv_bb: colortv_bb, id: colortv_bq.getIdentity()})
end for
for each colortv_cs in colortv_cq
colortv_cs.AsyncGetToString()
end for
colortv_ct = []
for each colortv_cs in colortv_cq
colortv_be =  wait(0,colortv_bs)
colortv_ct.push(colortv_be)
end for
for each colortv_be in colortv_ct
colortv_bb = ""
for each colortv_cu in colortv_cr
if colortv_cu.id = colortv_be.getSourceIdentity() then
colortv_bb = colortv_cu.colortv_bb
exit for
end if
end for
colortv_bh("Response code for url " + colortv_bb + ": " + StrI(colortv_be.GetResponseCode()))
colortv_bh("Response body: " + colortv_be.GetString())
colortv_bf = colortv_be.GetResponseCode()
colortv_bg = (colortv_bf = 200)
if colortv_bg then
colortv_cv = ParseJson(colortv_be.GetString())
if colortv_cv["status"] = "true" then
colortv_cw(colortv_bb)
if colortv_cl <> invalid then
colortv_cl(colortv_cv["currencyType"], colortv_cv["currencyAmount"].toInt(), colortv_cv["placement"])
else
colortv_bh("Currency polling succeeded, result: {placement: " + colortv_cv["placement"] + ", currencyType: " + colortv_cv["currencyType"] + ", currencyAmount: " + colortv_cv["currencyAmount"] + "}")
end if
end if
end if
end for
end sub
sub colortv_ah(colortv_cx)
colortv_cy = colortv_bv("userAge", "colortv")
colortv_cz = colortv_bv("userGender", "colortv")
colortv_da = colortv_bv("userKeywords", "colortv")
colortv_db = {}
if colortv_cy <> invalid then
colortv_db["userAge"] = colortv_cy
end if
if colortv_cz <> invalid then
colortv_db["userGender"] = colortv_cz
end if
if colortv_da <> invalid then
colortv_db["userKeywords"] = colortv_da
end if
if colortv_db.count() = 0 then return
colortv_cx["user"] = colortv_db
end sub
function colortv_aj(colortv_dc)
colortv_by = m.colortv_d + "/ad/info/" + m.colortv_e
colortv_dd = CreateObject("roDeviceInfo")
colortv_bu = colortv_dd.GetAdvertisingId()
for each colortv_e in colortv_dc
colortv_bd = {
"identifierForAds": colortv_bu
"rokuAppId": colortv_e
}
m.colortv_l(colortv_by, "POST", FormatJson(colortv_bd))
end for
end function
sub colortv_al(colortv_e as String)
colortv_de = colortv_df()
colortv_bb = "http://" + colortv_de + ":8060/install/" + colortv_e
m.colortv_l(colortv_bb, "POST", "")
end sub
sub colortv_ap(colortv_e as String, colortv_dg as String)
colortv_dh = m.colortv_am()
if colortv_e = "11" or colortv_dh.doesExist(colortv_e) then
colortv_di = "launch"
else
colortv_di = "install"
end if
colortv_de = colortv_df()
colortv_bb = "http://" + colortv_de + ":8060/" + colortv_di + "/" + colortv_e + "?contentID=" + colortv_dg
m.colortv_l(colortv_bb, "POST", "")
end sub
function colortv_an() as Object
colortv_de = colortv_df()
colortv_bb = "http://" + colortv_de + ":8060/query/apps"
colortv_cv = m.colortv_l(colortv_bb, "GET", invalid)
colortv_dj = CreateObject("roXMLElement")
if not colortv_dj.Parse(colortv_cv) then
return {}
else
colortv_dk = {}
colortv_dl = colortv_dj.getbody()
colortv_dl.ResetIndex()
colortv_dm = colortv_dl.GetIndex()
while colortv_dm <> invalid
colortv_dn = {
"name": colortv_dm.getBody()
"type": colortv_dm.getAttributes()["type"]
"version": colortv_dm.getAttributes()["version"]
"id": colortv_dm.getAttributes()["id"]
}
colortv_dk.AddReplace(colortv_dm.getAttributes()["id"], colortv_dn)
colortv_dm = colortv_dl.GetIndex()
end while
return colortv_dk
end if
end function
function colortv_ar(colortv_ba as String, colortv_do="" as String) as Void
colortv_dp = m.colortv_as(colortv_ba, colortv_do)
ColorTVSdkGetInstance().colortv_dq(colortv_dp, colortv_ba)
end function
function colortv_av(colortv_ba as String, colortv_do="" as String) as Void
colortv_dp = m.colortv_as(colortv_ba, colortv_do)
ColorTVSdkGetInstance().colortv_dr(colortv_dp, colortv_ba)
end function
function colortv_at(colortv_ba as String, colortv_do="" as String) as Object
colortv_bb = m.colortv_d + "/ct/rec/" + m.colortv_e + "/" + colortv_ba
if colortv_do <> invalid and colortv_do <> "" then
colortv_bb += "?videoId="
colortv_bb += colortv_do
end if
colortv_bc = "GET"
colortv_be = m.colortv_l(colortv_bb, colortv_bc, invalid)
colortv_bf = colortv_be.GetResponseCode()
colortv_bg = (colortv_bf = 200)
if not colortv_bg then
colortv_bh("Failure reason: " + colortv_be.GetFailureReason())
colortv_dp = {
"errorMessage": colortv_be.GetFailureReason()
"error": colortv_bf.toStr()
}
else
colortv_dp = colortv_bl(colortv_be.GetString())
end if
colortv_dp["previousVideoId"] = colortv_do
if colortv_dp["recommendations"] <> invalid then
for colortv_ds = 0 to colortv_dp["recommendations"].count() - 1
if ColorTVSdkGetInstance().colortv_dt <> invalid then
colortv_dp["recommendations"][colortv_ds]["regularCustomFont"] = ColorTVSdkGetInstance().colortv_dt
end if
if ColorTVSdkGetInstance().colortv_du <> invalid then
colortv_dp["recommendations"][colortv_ds]["boldCustomFont"] = ColorTVSdkGetInstance().colortv_du
end if
end for
end if
return colortv_dp
end function
function colortv_ax(colortv_bb as String)
colortv_ca = colortv_cb()
m.colortv_ag(colortv_ca)
colortv_cc = FormatJson(colortv_ca)
m.colortv_l(colortv_bb, "POST", colortv_cc)
end function
function colortv_az(colortv_do as String, colortv_dv as String, colortv_bd as Object)
colortv_bb = m.colortv_d + "/ct/evt/" + m.colortv_e + "/" + colortv_do
colortv_bc = "POST"
if colortv_bd = invalid then
colortv_bd = {}
end if
colortv_dw = {
"videoId": colortv_do
"eventType": colortv_dv
}
colortv_bd.append(colortv_dw)
colortv_be = m.colortv_l(colortv_bb, colortv_bc, FormatJson(colortv_bd))
colortv_bf = colortv_be.GetResponseCode()
colortv_bg = (colortv_bf = 200)
if not colortv_bg then
colortv_bh("Failed to report video tracking event because of: " + colortv_be.GetFailureReason())
end if
end function
Function colortv_bv(colortv_dx, colortv_dy=invalid)
if colortv_dy = invalid then colortv_dy = "Default"
colortv_dz = CreateObject("roRegistrySection", colortv_dy)
if colortv_dz.Exists(colortv_dx) then return colortv_dz.Read(colortv_dx)
return invalid
End Function
Function colortv_bx(colortv_dx, colortv_ea, colortv_dy=invalid)
if colortv_dy = invalid then colortv_dy = "Default"
colortv_dz = CreateObject("roRegistrySection", colortv_dy)
colortv_dz.Write(colortv_dx, colortv_ea)
colortv_dz.Flush() 'colortv_eb colortv_ec
End Function
Function colortv_ed(colortv_dx, colortv_dy=invalid)
if colortv_dy = invalid then colortv_dy = "Default"
colortv_dz = CreateObject("roRegistrySection", colortv_dy)
colortv_dz.Delete(colortv_dx)
colortv_dz.Flush() 'colortv_eb colortv_ec
End Function
Function isvalidstr(colortv_ee As Dynamic) As String
if colortv_ef(colortv_ee) return colortv_ee
return ""
End Function
Function colortv_eg(colortv_ee as dynamic) As Boolean
if colortv_ee = invalid return false
if GetInterface(colortv_ee, "ifString") = invalid return false
return true
End Function
Function colortv_ef(colortv_ee)
if colortv_eh(colortv_ee) return false
return true
End Function
Function colortv_eh(colortv_ee)
if colortv_ee = invalid return true
if not colortv_eg(colortv_ee) return true
if Len(colortv_ee) = 0 return true
return false
End Function
Sub colortv_bh(colortv_ei As Dynamic)
if ColorTVSdkGetInstance().colortv_ej then
colortv_ek = CreateObject("roDateTime")
print StrI(colortv_ek.getDayOfMonth()).Trim() + "." + StrI(colortv_ek.getMonth()).Trim() + "." StrI(colortv_ek.getYear()).Trim() + " " + StrI(colortv_ek.getHours()).Trim() + ":" + StrI(colortv_ek.getMinutes()).Trim() + ":" + StrI(colortv_ek.getSeconds()).Trim() + ":" + StrI(colortv_ek.getMilliseconds()).Trim() + ": " + colortv_ei.toStr().Trim()
end if
End Sub
function colortv_el(colortv_em as Integer) as String
if colortv_em < 0 then
colortv_em = 0
end if
colortv_en = StrI(colortv_em, 16)
if(colortv_em < 16) then
colortv_en = "0" + colortv_en
end if
return colortv_en
end function
function colortv_eo(colortv_ep as Integer, colortv_eq as Integer, colortv_er as Integer) as String
colortv_es = "#ff" + colortv_el(colortv_ep) + colortv_el(colortv_eq) + colortv_el(colortv_er)
return colortv_es
end function
function colortv_bw() as String
colortv_et = CreateObject("roAppInfo")
return colortv_et.GetVersion()
end function
function colortv_eu() as LongInteger
colortv_ev = CreateObject("roDateTime")
colortv_ew& = colortv_ev.asSeconds() * 1000&
colortv_ew& += colortv_ev.getMilliseconds()
return colortv_ew&
end function
function colortv_ex(colortv_ey as String) as LongInteger
if not colortv_ez(colortv_ey) then
return invalid
end if
colortv_fa = 0&
for colortv_ds = 0 to colortv_ey.len() - 1
colortv_fa += colortv_ey.mid(colortv_ey.len() - 1 - colortv_ds, 1).toInt() * 10&^colortv_ds
end for
return colortv_fa
end function
function colortv_ez(colortv_fb) as Boolean
colortv_fc = CreateObject("roRegex", "^\d+$", "")
return colortv_fc.isMatch(colortv_fb)
end function
function colortv_df() as String
colortv_dd = CreateObject("roDeviceInfo")
colortv_fd = colortv_dd.getIpAddrs()
colortv_fe = colortv_fd.keys()
for each colortv_dx in colortv_fe
return colortv_fd[colortv_dx]
end for
return invalid
end function
function colortv_ff(colortv_fg, colortv_fh)
for colortv_ds = 0 to colortv_fh.count() - 1
if colortv_fi(colortv_fg, colortv_fh[colortv_ds]) then
return colortv_ds
end if
end for
return invalid
end function
function colortv_fi(colortv_fj, colortv_fk)
if type(colortv_fj) = "roAssociativeArray" and type(colortv_fk) = "roAssociativeArray" then
if colortv_fj.equals = invalid or colortv_fk.equals = invalid then
print "Objects have to implement 'equals' method in order to be comparable"
end if
return colortv_fj.equals(colortv_fk)
end if
return colortv_fj = colortv_fk
end function
function colortv_br(colortv_bb as String, colortv_fl as Object) as String
colortv_fm = colortv_fl.keys()
colortv_bb = colortv_bb + "?"
for each colortv_dx in colortv_fm
colortv_bb = colortv_bb + colortv_dx + "=" + colortv_fl[colortv_dx] + "&"
end for
colortv_bb = colortv_bb.left(colortv_bb.len() - 1)
return colortv_bb
end function
function colortv_cb() as Dynamic
colortv_fn = CreateObject("roDeviceInfo")
colortv_et = CreateObject("roAppInfo")
colortv_ca = {
"deviceModel": colortv_fn.GetModel()
"systemVersion": colortv_fn.GetVersion()
"systemName": colortv_fn.GetModelDetails().VendorName
"identifierForAds": colortv_fn.GetAdvertisingId()
"dnt": colortv_fn.IsAdIdTrackingDisabled()
"identifierForVendor": colortv_fn.GetPublisherId()
"language": colortv_fn.GetCurrentLocale()
"timezone": colortv_fn.GetTimeZone()
"appName": colortv_et.GetTitle()
"appVersion": colortv_et.GetVersion()
"sdkVersion": GetColorTVSDKVersion()
}
return colortv_ca
end function
function colortv_cm() as Dynamic
colortv_fo = colortv_bv("pollingUrls", "colortv")
if colortv_fo = invalid then
return []
end if
colortv_fp = ParseJson(colortv_fo)
colortv_fq = colortv_fp.Keys()
colortv_cp = []
colortv_fr = 24 * 60 * 60 * 1000
colortv_fs = false
for each colortv_dx in colortv_fq
colortv_ft = colortv_ex(colortv_dx)
if colortv_ft <> invalid then
if colortv_ft + colortv_fr < colortv_eu() then
colortv_fs = true
colortv_fp.delete(colortv_dx)
else
colortv_cp.push(colortv_fp[colortv_dx])
end if
end if
end for
if colortv_fs then
colortv_fu(colortv_fp)
end if
return colortv_cp
end function
function colortv_fu(colortv_fp)
colortv_fv = FormatJson(colortv_fp)
colortv_bx("pollingUrls", colortv_fv, "colortv")
end function
sub colortv_cw(colortv_bb)
colortv_fo = colortv_bv("pollingUrls", "colortv")
if colortv_fo = invalid then
return
end if
colortv_fp = ParseJson(colortv_fo)
colortv_fq = colortv_fp.Keys()
for each colortv_dx in colortv_fq
if colortv_fp[colortv_dx] = colortv_bb then
colortv_fp.delete(colortv_dx)
end if
end for
colortv_fu(colortv_fp)
end sub
function ColorTvSdk(colortv_e as String) as Object
colortv_fw = ColorTVSdkGetInstance()
if colortv_fw <> invalid then
print "Color TV SDK has already been initialized"
return colortv_fw
end if
print "Color TV SDK initialized with appid " + colortv_e
colortv_c = {
colortv_e: colortv_e
sdkVersion: GetColorTVSDKVersion()
colortv_ej: false
registerAdCallbacks: colortv_fx
registerContentRecommendationCallbacks: colortv_fy
registerUpNextCallbacks: colortv_fz
setDebugMode: colortv_ga
colortv_gb: colortv_a(colortv_e)
colortv_r: colortv_gc
colortv_gd: {}
loadAd: colortv_ge
colortv_bj: colortv_gf
showAd: colortv_gg
colortv_gh: colortv_gi
colortv_gj: colortv_gk
colortv_gl: colortv_gm
colortv_gn: colortv_go
colortv_j: colortv_gp
colortv_gq: colortv_gr
colortv_z: colortv_gs
colortv_gt: []
timerTick: colortv_gu
colortv_ck: colortv_gv
colortv_gw: colortv_gx
setUserAge: colortv_gy
setUserGender: colortv_gz
setUserKeywords: colortv_ha
colortv_hb: colortv_hc
colortv_hd: colortv_he
setContentRecommendationRegularCustomFont: colortv_hf
setContentRecommendationBoldCustomFont: colortv_hg
colortv_hh: {}
loadContentRecommendation: colortv_hi
colortv_dq: colortv_hj
colortv_hk: colortv_hl
showContentRecommendation: colortv_hm
trackVideoEvents: colortv_hn
loadUpNext: colortv_ho
loadUpNextScenegraph: colortv_hp
loadUpNextCanvas: colortv_hq
colortv_dr: colortv_hr
colortv_hs: colortv_ht
colortv_hu: colortv_hv
colortv_hw: false
colortv_hx: false
colortv_hy: false
upNextEventOccurred: colortv_hz
colortv_ia: colortv_ib
colortv_ic: colortv_id
colortv_ie: colortv_if
colortv_ig: colortv_ih
colortv_ii: colortv_ij
colortv_ik: colortv_il
shouldCloseUpNextCanvas: colortv_im
colortv_in: colortv_io
}
GetGlobalAA()["colorTvSdkInstance"] = colortv_c
colortv_c.colortv_r()
colortv_c.colortv_gb.colortv_t()
colortv_c.colortv_gw()
return colortv_c
end function
function colortv_fx(colortv_ip as Object)
m.colortv_ip = colortv_ip
m.colortv_z()
end function
function colortv_fy(colortv_iq)
m.colortv_iq = colortv_iq
end function
function colortv_fz(colortv_ir as Object)
m.colortv_ir = colortv_ir
end function
function colortv_ga(colortv_ej as Boolean)
m.colortv_ej = colortv_ej
end function
function colortv_gc()
colortv_dd = CreateObject("roDeviceInfo")
colortv_bu = colortv_dd.GetAdvertisingId()
m.colortv_gb.colortv_r(m.colortv_e, colortv_bu, m.sdkVersion)
end function
function colortv_ge(colortv_ba as String) as Void
colortv_bh("loading ad for placement " + colortv_ba)
if m.colortv_gd.DoesExist(colortv_ba) then
colortv_bh("Ad for placement: " + colortv_ba + " is already loaded")
if m.colortv_ip <> invalid and m.colortv_ip["adLoaded"] <> invalid then
m.colortv_ip["adLoaded"](colortv_ba)
end if
return
end if
m.colortv_gb.colortv_f(colortv_ba)
end function
function colortv_gf(colortv_is as Object, colortv_ba as String) as Void
if colortv_is.DoesExist("error") then
m.colortv_gh(colortv_ba, colortv_is["error"], colortv_is["errorMessage"])
else
colortv_bh("Ad has been loaded for placement: " + colortv_ba)
m.colortv_gd.AddReplace(colortv_ba, colortv_is)
if m.colortv_ip <> invalid and m.colortv_ip["adLoaded"] <> invalid then
m.colortv_ip["adLoaded"](colortv_ba)
end if
end if
end function
sub colortv_gg(colortv_ba as String)
if not colortv_it(colortv_ba, m.colortv_gd)
m.colortv_gd.delete(colortv_ba)
return
end if
colortv_is = m.colortv_gd[colortv_ba]
m.colortv_gd.delete(colortv_ba)
if colortv_is["type"] = "discovery" then
for colortv_ds = 0 to colortv_is["ads"].count() - 1
if colortv_is["ads"][colortv_ds]["pollingUrl"] <> invalid then
colortv_iu(colortv_is["ads"][colortv_ds]["pollingUrl"])
end if
end for
else
colortv_iu(colortv_is["ads"][0]["pollingUrl"])
end if
if colortv_is["type"] = "video" or colortv_is["ads"][0]["markupUrl"] <> invalid then
colortv_iv = colortv_iw(colortv_is, m.colortv_gb, m.colortv_ip)
if colortv_iv = invalid then
m.colortv_gh(colortv_ba, "INTERNAL_SDK_ERROR", "Can't play video ad with URL: " + colortv_is["ads"][0]["markupUrl"])
return
end if
colortv_iv.colortv_ix()
end if
if colortv_is["type"] <> "video" and not colortv_iy(colortv_is) then
colortv_iz = CreateObject("roSGScreen")
colortv_ja = m.colortv_gj(colortv_iz, colortv_is["type"])
colortv_iz.show()
m.colortv_gl(colortv_ja, colortv_is)
colortv_ja["dataModel"] = colortv_is
while true
colortv_jb = wait(GetColorTVSDKTimerInterval(), m.colortv_bs)
colortv_jc = type(colortv_jb)
if colortv_jc = "roSGScreenEvent"
if colortv_jb.isScreenClosed() then
exit while
end if
else if colortv_jc = "roSGNodeEvent"
if m.colortv_gn(colortv_jb, colortv_is, colortv_ja) then
exit while
end if
end if
m.timerTick()
end while
if m.colortv_ip <> invalid then
m.colortv_gb.colortv_z(m.colortv_ip["currencyEarned"])
end if
end if
end sub
function colortv_gi(colortv_ba as String, colortv_jd as String, colortv_je as String)
if m.colortv_ip <> invalid and m.colortv_ip["adError"] <> invalid then
colortv_bi = {
"placement": colortv_ba
"errorCode": colortv_jd
"errorMessage": colortv_je
}
m.colortv_ip["adError"](colortv_bi)
else
colortv_bh("Ad error has occurred for placement: """ + colortv_ba + """ with code: """ + colortv_jd + """ and message: """ + colortv_je + """")
end if
end function
function colortv_gk(colortv_iz as Object, colortv_jf as String)
m.colortv_bs = CreateObject("roMessagePort")
colortv_iz.setMessagePort(m.colortv_bs)
colortv_ja = colortv_iz.CreateScene("colortv_" + colortv_jf)
return colortv_ja
end function
function colortv_gm(colortv_ja as Object, colortv_jg as Object)
if colortv_ja.findNode("colorTvAdEvents") <> invalid then
colortv_ja.findNode("colorTvAdEvents").observeField("closeAd", m.colortv_bs)
colortv_ja.findNode("colorTvAdEvents").observeField("adShown", m.colortv_bs)
end if
if colortv_jg["type"] = "engagement" or colortv_jg["type"] = "interstitial" then
colortv_jh = colortv_jg["ads"][0]["actionButton"]["actionType"]
if colortv_ji(colortv_jh) then
colortv_ja.findNode("colorTvSubscriptionEvents").observeField("subscribed", m.colortv_bs)
else if colortv_jj(colortv_jh) then
colortv_ja.findNode("colorTvAppstoreEvents").observeField("clicked", m.colortv_bs)
end if
else if colortv_jg["type"] = "discovery" then
colortv_ja.findNode("colorTvGridEvents").observeField("closed", m.colortv_bs)
colortv_ja.findNode("colorTvGridEvents").observeField("impression", m.colortv_bs)
colortv_ja.findNode("colorTvGridEvents").observeField("moreDataUrl", m.colortv_bs)
colortv_ja.findNode("colorTvDiscoveryCenterEvents").observeField("clicked", m.colortv_bs)
colortv_ja.findNode("colorTvDiscoveryCenterEvents").observeField("subscribed", m.colortv_bs)
end if
end function
function colortv_go(colortv_jb as Object, colortv_is as Object, colortv_ja as Object) as Boolean
colortv_ba = colortv_is["placement"]
if colortv_jb.getNode() = "colorTvAdEvents" then
if colortv_jb.getField() = "closeAd" then
if m.colortv_ip <> invalid and m.colortv_ip["adClosed"] <> invalid and colortv_ba <> invalid then
m.colortv_ip["adClosed"](colortv_ba)
end if
return true
else if colortv_jb.getField() = "adShown" then
m.colortv_gb.colortv_p(colortv_is["ads"][0]["impressionUrl"])
end if
else if colortv_jb.getNode() = "colorTvSubscriptionEvents" then
if colortv_jb.getField() = "subscribed" then
m.colortv_gq(colortv_is, colortv_is["ads"][0], colortv_jb.getData())
end if
else if colortv_jb.getNode() = "colorTvAppstoreEvents" then
if colortv_jb.getField() = "clicked" then
m.colortv_gb.colortv_p(colortv_is["ads"][0]["clickTracker"])
if m.colortv_ip <> invalid and m.colortv_ip["adClosed"] <> invalid then
m.colortv_ip["adClosed"](colortv_ba)
end if
colortv_jk = colortv_is["ads"][0]
if colortv_jk["type"] = "appstore" or colortv_jk["actionButton"]["actionType"] = "CLICK_TO_APPSTORE" then
if colortv_jk["clickData"]["contentId"] <> invalid then
m.colortv_gb.colortv_ao(colortv_jk["clickData"]["channelId"], colortv_jk["clickData"]["contentId"])
else
m.colortv_gb.colortv_ak(colortv_jk["clickData"]["channelId"])
end if
else if colortv_jk["type"] = "content" or colortv_jk["actionButton"]["actionType"] = "CLICK_TO_CONTENT" then
m.colortv_gb.colortv_ao(colortv_jk["clickData"]["channelId"], colortv_jk["clickData"]["contentId"])
end if
return true
end if
else if colortv_jb.getNode() = "colorTvGridEvents" then
if colortv_jb.getField() = "impression" and colortv_jb.getData() <> ""
m.colortv_gb.colortv_p(colortv_jb.getData())
else if colortv_jb.getField() = "moreDataUrl" and colortv_jb.getData() <> "" then
m.colortv_j(colortv_ja, colortv_jb.getData())
else if colortv_jb.getField() = "closed" then
if m.colortv_ip <> invalid and m.colortv_ip["adClosed"] <> invalid and colortv_ba <> invalid then
m.colortv_ip["adClosed"](colortv_ba)
end if
return true
end if
else if colortv_jb.getNode() = "colorTvDiscoveryCenterEvents" then
if colortv_jb.getField() = "subscribed" then
colortv_jl = colortv_jb.getData()["clickedItemModel"]
colortv_jm = colortv_jb.getData()["inputValue"]
m.colortv_gq(colortv_is, colortv_jl, colortv_jm)
else if colortv_jb.getField() = "clicked"
colortv_jk = colortv_jb.getData()
if colortv_jk["clickTracker"] <> invalid then
m.colortv_gb.colortv_p(colortv_jk["clickTracker"])
end if
if m.colortv_ip <> invalid and m.colortv_ip["adClosed"] <> invalid then
m.colortv_ip["adClosed"](colortv_ba)
end if
if colortv_jk["type"] = "appstore" then
if colortv_jk["clickData"]["contentId"] <> invalid then
m.colortv_gb.colortv_ao(colortv_jk["clickData"]["channelId"], colortv_jk["clickData"]["contentId"])
else
m.colortv_gb.colortv_ak(colortv_jk["clickData"]["channelId"])
end if
else if colortv_jk["type"] = "content"
m.colortv_gb.colortv_ao(colortv_jk["clickData"]["channelId"], colortv_jk["clickData"]["contentId"])
end if
return true
end if
end if
return false
end function
function colortv_gp(colortv_ja as Dynamic, colortv_jn as String)
colortv_jo = m.colortv_gb.colortv_j(colortv_jn)
if colortv_jo <> invalid then
if colortv_ja["dataModel"]["ads"] <> invalid then
colortv_jp = colortv_ja["dataModel"]["ads"]
colortv_jp.append(colortv_jo["ads"])
colortv_jo["ads"] = colortv_jp
colortv_ja["dataModel"] = colortv_jo
else if colortv_ja["dataModel"].colortv_jq <> invalid then
colortv_jp = colortv_ja["dataModel"].colortv_jq
colortv_jp.append(colortv_jo.colortv_jq)
colortv_jo.colortv_jq = colortv_jp
colortv_ja["dataModel"] = colortv_jo
end if
end if
colortv_ja.findNode("colorTvGridEvents")["moreDataUrl"] = ""
end function
function colortv_gr(colortv_jr as Dynamic, colortv_jk as Dynamic, colortv_js as String) as Void
colortv_jr.colortv_jt(colortv_js)
m.colortv_gb.colortv_n(colortv_jk["clickTracker"], colortv_js, colortv_jk["type"])
if colortv_jk["clickUrl"] <> invalid then
m.colortv_gb.colortv_n(colortv_jk["clickUrl"], colortv_js, colortv_jk["type"])
else if colortv_jk["clickData"]["clickUrl"] <> invalid then
m.colortv_gb.colortv_n(colortv_jk["clickData"]["clickUrl"], colortv_js, colortv_jk["type"])
end if
end function
function colortv_gs()
if m.colortv_ip <> invalid then
m.colortv_gb.colortv_z(m.colortv_ip["currencyEarned"])
end if
end function
sub colortv_gu()
colortv_ju = []
for each colortv_jv in m.colortv_gt
if colortv_jv.colortv_jw() then
colortv_ju.push(colortv_jv)
end if
end for
for each colortv_cn in colortv_ju
m.colortv_gt.delete( colortv_ff(colortv_cn, m.colortv_gt) )
end for
end sub
function colortv_gv(colortv_cn as Dynamic) as Void
m.colortv_gt.push(colortv_cn)
end function
function colortv_gx()
colortv_jx = m.colortv_gb.colortv_am()
colortv_jy = colortv_jx.keys()
colortv_jz = colortv_ka()
colortv_bx("installedApps", FormatJson(colortv_jx), "colortv")
colortv_kb = []
for each colortv_kc in colortv_jz
for each colortv_dx in colortv_jx.keys()
if colortv_dx = colortv_kc then
colortv_kb.push(colortv_dx)
end if
end for
end for
for each colortv_e in colortv_kb
colortv_kd = colortv_ff(colortv_e, colortv_jy)
colortv_jy.delete(colortv_kd)
end for
colortv_bh("Apps that weren't saved yet: " + FormatJson(colortv_jy))
m.colortv_gb.colortv_ai(colortv_jy)
end function
sub colortv_gy(colortv_ke)
if Type(colortv_ke) = "roInt" Or Type(colortv_ke) = "roInteger" or Type(colortv_ke) = "Integer"
colortv_ke = colortv_ke.toStr()
else if not ((Type(colortv_ke) = "roString" Or Type(colortv_ke) = "String") and colortv_ez(colortv_ke)) then
print "WARNING: Value passed as user age is not a number"
return
end if
colortv_bx("userAge", colortv_ke, "colortv")
end sub
sub colortv_gz(colortv_kf as String)
if not (LCase(colortv_kf) = "male" or LCase(colortv_kf) = "female") then
print "WARNING: Value passed as user gender is neither male nor female"
return
end if
colortv_bx("userGender", LCase(colortv_kf), "colortv")
end sub
sub colortv_ha(colortv_kg as String)
colortv_bx("userKeywords", colortv_kg, "colortv")
end sub
function colortv_he(colortv_kh as String, colortv_bp as String) as Void
colortv_bh("Saving: " + colortv_kh + ", " + colortv_bp)
colortv_bx("subscription_" + colortv_bp, colortv_kh, "colortv")
end function
function colortv_hc(colortv_bp as String) as Dynamic
return colortv_bv("subscription_" + colortv_bp, "colortv")
end function
function colortv_hf(colortv_ki as String)
m.colortv_dt = colortv_ki
end function
function colortv_hg(colortv_ki as String)
m.colortv_du = colortv_ki
end function
sub colortv_hi(colortv_ba, colortv_kj="" as String)
if m.colortv_hy and colortv_ba = "VideoEnd" then
m.colortv_hy = false
colortv_bh("UpNext should play instead of content recommendation")
return
end if
colortv_bh("loading content recommendation for placement " + colortv_ba)
if m.colortv_hh.DoesExist(colortv_ba) and m.colortv_hh[colortv_ba]["previousVideoId"] = colortv_kj then
colortv_bh("Content recommendation for placement: " + colortv_ba + " is already loaded")
if m.colortv_iq <> invalid and m.colortv_iq["contentRecommendationLoaded"] <> invalid then
m.colortv_iq["contentRecommendationLoaded"](colortv_ba)
end if
return
end if
m.colortv_gb.colortv_aq(colortv_ba, colortv_kj)
end sub
function colortv_hj(colortv_kk as Object, colortv_ba as String) as Void
if colortv_kk.DoesExist("error") then
m.colortv_hk(colortv_ba, colortv_kk["errorCode"].toStr(), colortv_kk["error"])
else
colortv_bh("Content recommendation has been loaded for placement: " + colortv_ba)
m.colortv_hh.AddReplace(colortv_ba, colortv_kk)
if m.colortv_iq <> invalid and m.colortv_iq["contentRecommendationLoaded"] <> invalid then
m.colortv_iq["contentRecommendationLoaded"](colortv_ba)
end if
end if
end function
function colortv_hl(colortv_ba as String, colortv_jd as String, colortv_je as String)
if m.colortv_iq <> invalid and m.colortv_iq["contentRecommendationError"] <> invalid then
colortv_bi = {
"placement": colortv_ba
"errorCode": colortv_jd
"errorMessage": colortv_je
}
m.colortv_iq["contentRecommendationError"](colortv_bi)
else
colortv_bh("Content recommendation error has occurred for placement: """ + colortv_ba + """ with code: """ + colortv_jd + """ and message: """ + colortv_je + """")
end if
end function
sub colortv_hm(colortv_ba as String)
if not colortv_kl(colortv_ba, m.colortv_hh)
m.colortv_hh.delete(colortv_ba)
return
end if
colortv_kk = m.colortv_hh[colortv_ba]
m.colortv_hh.delete(colortv_ba)
colortv_iz = CreateObject("roSGScreen")
colortv_ja = m.colortv_gj(colortv_iz, "contentRecommendation")
colortv_iz.show()
colortv_ja.findNode("colorTvGridEvents").observeField("moreDataUrl", m.colortv_bs)
colortv_ja.findNode("colorTvGridEvents").observeField("impression", m.colortv_bs)
colortv_ja.findNode("colorTvGridEvents").observeField("closed", m.colortv_bs)
colortv_ja.findNode("colorTvContentRecommendationEvents").observeField("clicked", m.colortv_bs)
colortv_ja.findNode("colorTvContentRecommendationEvents").observeField("favourite", m.colortv_bs)
colortv_ja.findNode("colorTvDiscoveryCenterEvents").observeField("clicked", m.colortv_bs)
colortv_ja.findNode("colorTvDiscoveryCenterEvents").observeField("subscribed", m.colortv_bs)
for colortv_ds = 0 to colortv_kk["recommendations"].count() - 1
if colortv_kk["recommendations"][colortv_ds]["pollingUrl"] <> invalid then
colortv_iu(colortv_kk["recommendations"][colortv_ds]["pollingUrl"])
end if
end for
colortv_ja["dataModel"] = colortv_kk
while true
colortv_jb = wait(GetColorTVSDKTimerInterval(), m.colortv_bs)
colortv_jc = type(colortv_jb)
if colortv_jc = "roSGScreenEvent"
if colortv_jb.isScreenClosed() then
exit while
end if
else if colortv_jc = "roSGNodeEvent"
if colortv_jb.getNode() = "colorTvContentRecommendationEvents" then
if colortv_jb.getField() = "clicked" then
colortv_jk = colortv_jb.getData()
if colortv_jk["clickTracker"] <> invalid then
m.colortv_gb.colortv_p(colortv_jk["clickTracker"])
end if
if m.colortv_iq <> invalid and m.colortv_iq["contentRecommendationClicked"] <> invalid then
if colortv_jk["clickData"] <> invalid and colortv_jk["clickData"]["clickParams"] <> invalid then
colortv_km = colortv_jk["clickData"]["clickParams"]
else
colortv_km = {}
end if
colortv_dw = {
"videoId": colortv_jk["partnerVideoId"]
"videoUrl": colortv_jk["url"]
"videoParams": colortv_km
}
m.colortv_iq["contentRecommendationClicked"](colortv_ba, colortv_dw)
end if
exit while
else if colortv_jb.getField() = "favourite" and colortv_jb.getData() <> "" then
m.colortv_gb.colortv_aw(colortv_jb.getData())
end if
else if colortv_jb.getNode() = "colorTvGridEvents" then
if colortv_jb.getField() = "impression" and colortv_jb.getData() <> ""
m.colortv_gb.colortv_p(colortv_jb.getData())
else if colortv_jb.getField() = "moreDataUrl" and colortv_jb.getData() <> "" then
m.colortv_j(colortv_ja, colortv_jb.getData())
else if colortv_jb.getField() = "closed" then
if m.colortv_iq <> invalid and m.colortv_iq["contentRecommendationClosed"] <> invalid then
m.colortv_iq["contentRecommendationClosed"](colortv_ba)
end if
exit while
end if
else if colortv_jb.getNode() = "colorTvDiscoveryCenterEvents" then
if colortv_jb.getField() = "subscribed" then
colortv_jl = colortv_jb.getData()["clickedItemModel"]
colortv_jm = colortv_jb.getData()["inputValue"]
m.colortv_gq(colortv_kk, colortv_jl, colortv_jm)
else if colortv_jb.getField() = "clicked"
colortv_jk = colortv_jb.getData()
if colortv_jk["clickTracker"] <> invalid then
m.colortv_gb.colortv_p(colortv_jk["clickTracker"])
end if
if m.colortv_iq <> invalid and m.colortv_iq["contentRecommendationClosed"] <> invalid then
m.colortv_iq["contentRecommendationClosed"](colortv_ba)
end if
if colortv_jk["type"] = "appstore" then
if colortv_jk["clickData"]["contentId"] <> invalid then
m.colortv_gb.colortv_ao(colortv_jk["clickData"]["channelId"], colortv_jk["clickData"]["contentId"])
else
m.colortv_gb.colortv_ak(colortv_jk["clickData"]["channelId"])
end if
else if colortv_jk["type"] = "content"
m.colortv_gb.colortv_ao(colortv_jk["clickData"]["channelId"], colortv_jk["clickData"]["contentId"])
end if
exit while
end if
end if
end if
m.timerTick()
end while
colortv_iz.close()
end sub
sub colortv_hn(colortv_do as String, colortv_dv as Object)
if colortv_do = invalid then
return
end if
if type(colortv_dv) = "roSGNodeEvent" then
if colortv_dv.getField() = "state" then
if colortv_dv.getData() = "playing" then
if m.colortv_kn = invalid or not (m.colortv_kn.colortv_ko <> invalid and m.colortv_kn.colortv_ko) then
if m.colortv_kn = invalid then
m.colortv_kn = {}
end if
m.colortv_kn.colortv_ko = true
m.colortv_kn["positionSeconds"] = 0
m.colortv_gb.colortv_ay(colortv_do, "VIDEO_STARTED", m.colortv_kn)
else
m.colortv_kp = true
end if
else if colortv_dv.getData() = "stopped"  and m.colortv_kn <> invalid then
m.colortv_gb.colortv_ay(colortv_do, "VIDEO_STOPPED", m.colortv_kn)
m.colortv_kn = invalid
else if colortv_dv.getData() = "paused" then
m.colortv_gb.colortv_ay(colortv_do, "VIDEO_PAUSED", m.colortv_kn)
else if colortv_dv.getData() = "finished"
m.colortv_gb.colortv_ay(colortv_do, "VIDEO_COMPLETED", m.colortv_kn)
m.colortv_kn = invalid
if m.colortv_hw and not m.colortv_hx then
m.colortv_in()
end if
end if
else if colortv_dv.getField() = "position" then
colortv_kq% = colortv_dv.getData()
if m.colortv_kp <> invalid and m.colortv_kp then
m.colortv_kp = false
if m.colortv_kn <> invalid and colortv_kq% - m.colortv_kn["positionSeconds"] > 1 then
m.colortv_kn["positionSeconds"] = colortv_kq%
end if
m.colortv_gb.colortv_ay(colortv_do, "VIDEO_RESUMED", m.colortv_kn)
end if
if m.colortv_kn = invalid then
m.colortv_kn = {}
end if
m.colortv_kn["positionSeconds"] = colortv_kq%
m.colortv_hu(colortv_kq%)
end if
else if type(colortv_dv) = "roVideoPlayerEvent" or type(colortv_dv) = "roVideoScreenEvent" then
if colortv_dv.isStreamStarted() then
if m.colortv_kp = invalid or m.colortv_kp = false then
m.colortv_kn = { "positionSeconds": colortv_dv.getIndex() }
m.colortv_gb.colortv_ay(colortv_do, "VIDEO_STARTED", m.colortv_kn)
end if
else if colortv_dv.isPlaybackPosition() then
m.colortv_kn = { "positionSeconds": colortv_dv.getIndex() }
if m.colortv_kp <> invalid and m.colortv_kp then
m.colortv_kp = false
m.colortv_gb.colortv_ay(colortv_do, "VIDEO_RESUMED", m.colortv_kn)
end if
m.colortv_hu(colortv_dv.getIndex())
m.colortv_ig(colortv_dv.getIndex())
else if colortv_dv.isFullResult() then
m.colortv_gb.colortv_ay(colortv_do, "VIDEO_COMPLETED", m.colortv_kn)
m.colortv_kn = invalid
if m.colortv_hw and not m.colortv_hx then
m.colortv_in()
end if
else if colortv_dv.isPartialResult() and m.colortv_kn <> invalid then
m.colortv_gb.colortv_ay(colortv_do, "VIDEO_STOPPED", m.colortv_kn)
m.colortv_kn = invalid
else if colortv_dv.isPaused() then
m.colortv_kp = true
m.colortv_gb.colortv_ay(colortv_do, "VIDEO_PAUSED", m.colortv_kn)
else if colortv_dv.isResumed() then
m.colortv_kp = false
m.colortv_gb.colortv_ay(colortv_do, "VIDEO_RESUMED", m.colortv_kn)
end if
else if type(colortv_dv) = "String" or type(colortv_dv) = "roString" then
if colortv_dv = "interrupted" and m.colortv_kn <> invalid then
m.colortv_gb.colortv_ay(colortv_do, "VIDEO_STOPPED", m.colortv_kn)
m.colortv_kn = invalid
end if
end if
end sub
sub colortv_hp(colortv_kr, colortv_bs, colortv_ks=10 as Integer, colortv_kj="" as String)
m.loadUpNext(colortv_kr, colortv_bs, colortv_ks, colortv_kj)
end sub
sub colortv_ho(colortv_kr, colortv_bs, colortv_ks as Integer, colortv_kj as String, colortv_kt=invalid)
m.colortv_ku = colortv_kr
m.colortv_kv = colortv_kt
m.colortv_kw = colortv_bs
m.colortv_ks = colortv_ks + 1
m.colortv_kx = true
m.colortv_hx = false
colortv_bh("loading up next")
colortv_ba = "VideoEnd"
if m.colortv_hh.DoesExist(colortv_ba) and m.colortv_hh[colortv_ba]["previousVideoId"] = colortv_kj then
colortv_bh("Up next is already loaded")
if m.colortv_ir <> invalid and m.colortv_ir["upNextLoaded"] <> invalid then
m.colortv_ir["upNextLoaded"]()
end if
return
end if
m.colortv_gb.colortv_au("VideoEnd", colortv_kj)
end sub
sub colortv_hq(colortv_kr, colortv_kt, colortv_bs, colortv_ks=10 as Integer, colortv_kj="" as String)
m.loadUpNext(colortv_kr, colortv_bs, colortv_ks, colortv_kj, colortv_kt)
end sub
function colortv_hr(colortv_ky as Object, colortv_ba as String)
if colortv_ky.DoesExist("error") then
m.colortv_hs(colortv_ba, colortv_ky["errorCode"].toStr(), colortv_ky["error"])
else
colortv_bh("Up next has been loaded")
m.colortv_hh.AddReplace(colortv_ba, colortv_ky)
if m.colortv_ir <> invalid and m.colortv_ir["upNextLoaded"] <> invalid then
m.colortv_ir["upNextLoaded"]()
end if
end if
end function
function colortv_ht(colortv_ba as String, colortv_jd as String, colortv_je as String)
if m.colortv_ir <> invalid and m.colortv_ir["upNextError"] <> invalid then
colortv_bi = {
"placement": colortv_ba
"errorCode": colortv_jd
"errorMessage": colortv_je
}
m.colortv_ir["upNextError"](colortv_bi)
else
colortv_bh("Up next error has occurred with code: """ + colortv_jd + """ and message: """ + colortv_je + """")
end if
end function
function colortv_hv(colortv_kz as Integer)
if m.colortv_hh.DoesExist("VideoEnd") and m.colortv_ku <> invalid and not m.colortv_hw and not m.colortv_hx then
if type(m.colortv_ku) = "roSGNode" then
colortv_la = m.colortv_ku["duration"]
else
colortv_la = m.colortv_ku.getPlaybackDuration()
end if
if colortv_la > 0 and colortv_la - colortv_kz < m.colortv_ks then
if not m.colortv_kx then
m.colortv_ia(m.colortv_hh["VideoEnd"]["recommendations"][0])
m.colortv_gb.colortv_p(m.colortv_lb["impressionUrl"])
else
m.colortv_kx = false
end if
end if
end if
if m.colortv_hw and not m.colortv_hx and type(m.colortv_ku) = "roVideoPlayer" and m.colortv_ku.getPlaybackDuration() - colortv_kz > m.colortv_ks then
m.colortv_ii()
end if
end function
function colortv_ib(colortv_lc)
m.colortv_lb = colortv_lc
if type(m.colortv_ku) = "roSGNode" then
m.colortv_ic()
else
m.colortv_ie()
end if
end function
function colortv_id()
m.colortv_ld = createObject("roSGNode", "colortv_up_next")
m.colortv_ku.appendChild(m.colortv_ld)
m.colortv_ld["timeBeforeVideoEnds"] = m.colortv_ks
m.colortv_ld["videoNodeReference"] = m.colortv_ku
m.colortv_ld["id"] = "colortv_up_next"
m.colortv_ld["dataModel"] = m.colortv_lb
m.colortv_ld["show"] = true
m.colortv_ld.setFocus(true)
m.colortv_ld.observeField("cancelled", m.colortv_kw)
m.colortv_ld.observeField("videoMoved", m.colortv_kw)
m.colortv_hw = true
end function
function colortv_if()
m.colortv_le = colortv_lf(m.colortv_kv)
m.colortv_le.colortv_ia(m.colortv_lb)
m.colortv_hw = true
end function
function colortv_ih(colortv_kz)
if m.colortv_hw and not m.colortv_hx and m.colortv_le <> invalid then
m.colortv_le.colortv_lg(colortv_kz, m.colortv_ku.getPlaybackDuration())
end if
end function
function colortv_im(colortv_jb)
colortv_lh = false
if type(colortv_jb) = "roImageCanvasEvent" and colortv_jb.isRemoteKeyPressed() and colortv_jb.GetIndex() = 2 or colortv_jb.GetIndex() = 0 and m.colortv_hw then
m.colortv_ii()
m.colortv_hx = true
colortv_lh = true
end if
return colortv_lh
end function
function colortv_ij()
m.colortv_kx = true
m.colortv_hw = false
if type(m.colortv_ku) = "roSGNode" then
m.colortv_ik()
else
m.colortv_le.colortv_ii()
end if
end function
function colortv_il()
m.colortv_ku.removeChild(m.colortv_ld)
m.colortv_ku.setFocus(true)
end function
function colortv_hz(colortv_dv)
if type(colortv_dv) = "roSGNodeEvent" then
if colortv_dv.getField() = "cancelled"
m.colortv_ii()
m.colortv_hx = true
else if colortv_dv.getField() = "videoMoved" and m.colortv_hw
m.colortv_ii()
end if
end if
end function
function colortv_io()
m.colortv_hw = false
m.colortv_hy = true
m.colortv_ku = invalid
m.colortv_hh.delete("VideoEnd")
colortv_dw = {}
colortv_dw["videoId"] = m.colortv_lb["partnerVideoId"]
colortv_dw["videoUrl"] = m.colortv_lb["url"]
if m.colortv_lb["clickData"] <> invalid and m.colortv_lb["clickData"]["clickParams"] <> invalid then
colortv_km = m.colortv_lb["clickData"]["clickParams"]
else
colortv_km = {}
end if
colortv_dw["videoParams"] = colortv_km
m.colortv_gb.colortv_p(m.colortv_lb["clickTracker"])
if m.colortv_ir <> invalid and m.colortv_ir["upNextClicked"] <> invalid then
m.colortv_ir["upNextClicked"](colortv_dw)
end if
end function
function ColorTVSdkGetInstance()
return GetGlobalAA()["colorTvSdkInstance"]
end function
function GetColorTVSDKVersion() as String
return "1.5.2"
end function
function GetColorTVSDKTimerInterval() as Integer
return 1000
end function
sub colortv_iu(colortv_li)
if colortv_li = invalid then
return
end if
colortv_fo = colortv_bv("pollingUrls", "colortv")
if colortv_fo = invalid then
colortv_fo = "{}"
end if
colortv_fp = ParseJson(colortv_fo)
colortv_fp[colortv_eu().toStr()] = colortv_li
colortv_bx("pollingUrls", FormatJson(colortv_fp), "colortv")
end sub
function colortv_ka()
colortv_lj = []
colortv_lk = colortv_bv("installedApps", "colortv")
if colortv_lk <> invalid
colortv_lj = ParseJson(colortv_lk)
end if
return colortv_lj
end function
function colortv_iy(colortv_is) as Boolean
return colortv_is.colortv_ll <> invalid and colortv_is.colortv_ll
end function
function colortv_it(colortv_ba as String, colortv_gd as Object) as Boolean
if not colortv_gd.DoesExist(colortv_ba) then
colortv_bh("Ad for placement: " + colortv_ba + " isn't loaded. Please call loadAd function first.")
return false
else if not colortv_lm(colortv_gd[colortv_ba]) then
colortv_bh("Ad for placement: " + colortv_ba + " is not valid anymore. Please load the ad again.")
return false
end if
return true
end function
function colortv_kl(colortv_ba as String, colortv_ln as Object) as Boolean
if not colortv_ln.DoesExist(colortv_ba) then
colortv_bh("Content recommendation for placement: " + colortv_ba + " isn't loaded. Please call loadContentRecommendation function first.")
return false
else if not colortv_lm(colortv_ln[colortv_ba]) then
colortv_bh("Content recommendation for placement: " + colortv_ba + " is not valid anymore. Please load the content recommendation again.")
return false
end if
return true
end function
function colortv_lm(colortv_is) as Boolean
colortv_lo = CreateObject("roDateTime")
colortv_lo.fromIso8601String(colortv_is["validUntil"])
colortv_lp = CreateObject("roDateTime")
return colortv_lo.asSeconds() > colortv_lp.asSeconds()
end function
function colortv_ji(colortv_lq as String) as Boolean
return colortv_lq = "CLICK_TO_SMS" or colortv_lq = "CLICK_TO_CALL" or colortv_lq = "CLICK_TO_EMAIL"
end function
function colortv_jj(colortv_lq as String) as Boolean
return colortv_lq = "CLICK_TO_APPSTORE" or colortv_lq = "CLICK_TO_CONTENT"
end function
function colortv_bl(colortv_cc as String) as Object
colortv_c = ParseJson(colortv_cc)
if not colortv_c.DoesExist("error") then
colortv_lr = CreateObject("roDateTime")
colortv_lr.fromSeconds(colortv_lr.asSeconds() + colortv_c["validFor"])
colortv_c["validUntil"] = colortv_lr.toIsoString()
colortv_c.colortv_jt = colortv_ls
colortv_c["storedPhoneNumber"] = colortv_lt("phone")
colortv_c["storedEmailAddress"] = colortv_lt("email")
end if
return colortv_c
end function
function colortv_lt(colortv_bp)
return ColorTVSdkGetInstance().colortv_hb(colortv_bp)
end function
function colortv_ls(colortv_lu as String) as Void
if colortv_lu = invalid then
return
end if
colortv_lv = CreateObject("roRegex", "\A[^@]+@[^@]+\z", "")
colortv_lw = CreateObject("roRegex", "[\(]?[0-9]{3}[\)]?[ ]?[-]?[ ]?[0-9]{3}[ ]?[-]?[ ]?[0-9]{3,4}", "")
colortv_lx = invalid
if colortv_lv.isMatch(colortv_lu) then
colortv_lx = "email"
else if colortv_lw.isMatch(colortv_lu)
colortv_lx = "phone"
end if
if colortv_lx = invalid then
return
end if
colortv_ly = ColorTVSdkGetInstance()
colortv_ly.colortv_hd(colortv_lu, colortv_lx)
end function
function colortv_cd(colortv_cc) as Object
if colortv_cc = invalid or Len(colortv_cc) = 0
return invalid
end if
colortv_c = ParseJson(colortv_cc)
if colortv_c = invalid then
return invalid
end if
if colortv_c["pingInterval"] = invalid then
colortv_c["pingInterval"] = colortv_cg()
end if
return colortv_c
end function
function colortv_cg()
return 60 * 1000
end function
function colortv_ci(colortv_lz as Double, colortv_fl as Dynamic, colortv_co as Function)
colortv_c = {
colortv_co: colortv_co,
colortv_fl: colortv_fl,
colortv_jw: colortv_ma,
equals: colortv_mb
}
colortv_c.colortv_mc = colortv_eu() + colortv_lz
return colortv_c
end function
function colortv_ma() as Boolean
colortv_md = colortv_eu()
if colortv_md < m.colortv_mc then
return false
end if
if m.colortv_fl.isEmpty() then
m.colortv_co()
else
m.colortv_co(m.colortv_fl)
end if
return true
end function
function colortv_mb(colortv_me as Dynamic) as Boolean
return m.colortv_mc = colortv_me.colortv_mc and m.colortv_co = colortv_me.colortv_co
end function
function colortv_lf(colortv_kt)
colortv_mf = createObject("roFontRegistry")
colortv_mf.register("pkg:/fonts/colortv/ABeeZee-Regular.otf")
colortv_mg = 720 / 1080
colortv_mh = int(960.0 * colortv_mg)
colortv_mi = int(894.0 * colortv_mg)
colortv_c = {
colortv_mf: colortv_mf
colortv_kt: colortv_kt
colortv_mh: colortv_mh
colortv_mi: colortv_mi
colortv_mg: colortv_mg
colortv_mj: false
colortv_ia: colortv_mk
colortv_ml: colortv_mm
colortv_ii: colortv_mn
colortv_lg: colortv_mo
colortv_mp: colortv_mq
colortv_mr: colortv_ms
colortv_mt: colortv_mu
colortv_mv: colortv_mw
colortv_mx: colortv_my
colortv_mz: colortv_na
}
return colortv_c
end function
function colortv_mk(colortv_lc)
m.colortv_ml(colortv_lc)
m.colortv_kt.SetLayer(10028, m.colortv_nb)
m.colortv_kt.SetLayer(10024, m.colortv_nc)
m.colortv_kt.SetLayer(10025, m.colortv_nd)
m.colortv_kt.SetLayer(10026, m.colortv_ne)
m.colortv_kt.SetLayer(10027, m.colortv_nf)
end function
function colortv_mm(colortv_lc)
m.colortv_nc = m.colortv_mp()
m.colortv_nd = m.colortv_mr()
m.colortv_ne = m.colortv_mt(colortv_lc["title"].trim())
m.colortv_nf = m.colortv_mx(colortv_lc["description"].trim())
m.colortv_nb = m.colortv_mz(colortv_lc["thumbnailUrl"])
end function
function colortv_mn()
for colortv_ds = 10024 to 10030
m.colortv_kt.clearLayer(colortv_ds)
end for
end function
function colortv_mo(colortv_lp, colortv_ng)
if not m.colortv_mj then
m.colortv_mj = true
m.colortv_nh = colortv_ng - colortv_lp
end if
colortv_ni% = m.colortv_mh + 555.0 * m.colortv_mg
colortv_nj% = m.colortv_mi + 25.0 * m.colortv_mg
colortv_nk% = 50.0 * m.colortv_mg
colortv_nl% = 50.0 * m.colortv_mg
colortv_nm = colortv_eo(255, 255, 255)
colortv_nn = (colortv_ng - colortv_lp).toStr()
colortv_no = m.colortv_mf.get("ABeeZee", int(17.0*m.colortv_mg), false, false)
colortv_np = {
"TargetRect": {
"x": colortv_ni%
"y": colortv_nj%
"w": colortv_nk%
"h": colortv_nl%
}
"Text": colortv_nn
"TextAttrs":{
"Color" : colortv_nm,
"Font" : colortv_no,
"HAlign" : "HCenter",
"VAlign" : "VCenter",
"Direction" : "LeftToRight"
}
}
colortv_nq! = (m.colortv_nh - (colortv_ng - colortv_lp)) / m.colortv_nh
if colortv_nq! >= 1 then
colortv_nr = "colortv_timer_16"
else if colortv_nq! >= 0.93 then
colortv_nr = "colortv_timer_15"
else if colortv_nq! >= 0.86 then
colortv_nr = "colortv_timer_14"
else if colortv_nq! >= 0.8 then
colortv_nr = "colortv_timer_13"
else if colortv_nq! >= 0.73 then
colortv_nr = "colortv_timer_12"
else if colortv_nq! >= 0.66 then
colortv_nr = "colortv_timer_11"
else if colortv_nq! >= 0.6 then
colortv_nr = "colortv_timer_10"
else if colortv_nq! >= 0.53 then
colortv_nr = "colortv_timer_9"
else if colortv_nq! >= 0.46 then
colortv_nr = "colortv_timer_8"
else if colortv_nq! >= 0.4 then
colortv_nr = "colortv_timer_7"
else if colortv_nq! >= 0.33 then
colortv_nr = "colortv_timer_6"
else if colortv_nq! >= 0.26 then
colortv_nr = "colortv_timer_5"
else if colortv_nq! >= 0.2 then
colortv_nr = "colortv_timer_4"
else if colortv_nq! >= 0.13 then
colortv_nr = "colortv_timer_3"
else if colortv_nq! >= 0.066 then
colortv_nr = "colortv_timer_2"
else
colortv_nr = "colortv_timer_1"
end if
colortv_ns = {
"Url": "pkg:/images/colortv/timer/" + colortv_nr + ".png"
"TargetRect": {
"x": colortv_ni%
"y": colortv_nj%
"w": colortv_nk%
"h": colortv_nl%
}
}
m.colortv_kt.SetLayer(10029, colortv_ns)
m.colortv_kt.SetLayer(10030, colortv_np)
end function
function colortv_mq()
return {
"TargetRect": {
"x": m.colortv_mh
"y": m.colortv_mi
"w": int(4.0 * m.colortv_mg)
"h": int(154.0 * m.colortv_mg)
}
"color": "#ffcc0000"
}
end function
function colortv_ms()
return {
"TargetRect": {
"x": m.colortv_mh + int(4.0 * m.colortv_mg)
"y": m.colortv_mi
"w": int(626.0 * m.colortv_mg)
"h": int(154.0 * m.colortv_mg)
}
"color": "#ff000000"
}
end function
function colortv_mu(colortv_nt)
colortv_nu = m.colortv_mf.getFont("ABeeZee", int(26.0*m.colortv_mg), false, false)
colortv_nv = m.colortv_mf.get("ABeeZee", int(26.0*m.colortv_mg), false, false)
colortv_nw = m.colortv_mv(colortv_nt, colortv_nu, 505.0 * m.colortv_mg)
return {
"TargetRect": {
"x": m.colortv_mh + int(24.0 * m.colortv_mg)
"y": m.colortv_mi + int(32.0 * m.colortv_mg)
"w": int(550.0 * m.colortv_mg)
"h": int(26.0 * m.colortv_mg)
}
"Text": colortv_nw
"TextAttrs":{
"Color" : "#ffffffff",
"Font" : colortv_nv,
"HAlign" : "Left",
"VAlign" : "Top",
"TextDirection": "LeftToRight"
}
}
end function
function colortv_mw(colortv_nx, colortv_ny, colortv_nz)
if colortv_ny.GetOneLineWidth(colortv_nx, 10000) < colortv_nz
return colortv_nx
else
while colortv_ny.GetOneLineWidth(colortv_nx + "...", 10000) > colortv_nz
colortv_nx = left(colortv_nx, len(colortv_nx) - 1)
end while
end if
return colortv_nx + "...     "
end function
function colortv_my(colortv_oa)
colortv_ob = m.colortv_mf.getFont("ABeeZee", int(17.0*m.colortv_mg), false, false)
colortv_oc = m.colortv_mf.get("ABeeZee", int(17.0*m.colortv_mg), false, false)
colortv_od = m.colortv_mv(colortv_oa, colortv_ob, 1500.0 * m.colortv_mg)
return {
"TargetRect": {
"x": m.colortv_mh + int(24.0 * m.colortv_mg)
"y": m.colortv_mi + int(69.0 * m.colortv_mg)
"w": int(550.0 * m.colortv_mg)
"h": int(51.0 * m.colortv_mg)
}
"Text": colortv_od
"TextAttrs":{
"Color" : "#ffffffff",
"Font" : colortv_oc,
"HAlign" : "Left",
"VAlign" : "Top",
"TextDirection": "LeftToRight"
}
}
end function
function colortv_na(colortv_oe)
if colortv_oe = invalid then
colortv_oe = "pkg:/images/colortv/color_tv_grid_bg_placeholder.jpg"
end if
return {
"Url": colortv_oe
"TargetRect": {
"x": m.colortv_mh + int(629.0 * m.colortv_mg)
"y": m.colortv_mi
"w": int(308.0 * m.colortv_mg)
"h": int(154.0 * m.colortv_mg)
}
}
end function
function colortv_iw(colortv_is as Object, colortv_gb as Object, colortv_ip as Object) as Object
colortv_of = NWM_VAST()
colortv_og = colortv_of.GetPrerollFromURL(colortv_is["ads"][0]["markupUrl"])
if colortv_og = invalid then
return invalid
end if
colortv_c = {
colortv_ix: colortv_oh
colortv_oi: colortv_oj
colortv_ok: colortv_ol
colortv_om: colortv_on
colortv_oo: colortv_op
colortv_og: colortv_og
colortv_oq: -1
colortv_is: colortv_is
colortv_ip: colortv_ip
colortv_gb: colortv_gb
}
return colortv_c
end function
function colortv_oh() as Void
colortv_iz = CreateObject("roSGScreen")
m.colortv_bs = CreateObject("roMessagePort")
colortv_iz.setMessagePort(m.colortv_bs)
colortv_ja = colortv_iz.CreateScene("colortv_video")
colortv_iz.show()
m.colortv_oi(colortv_ja, m.colortv_is)
colortv_ja["dataModel"] = m.colortv_is
colortv_ja["videoContent"] = m.colortv_og
while true
colortv_jb = wait(GetColorTVSDKTimerInterval(), m.colortv_bs)
colortv_jc = type(colortv_jb)
if colortv_jc = "roSGScreenEvent"
if colortv_jb.isScreenClosed() then
exit while
end if
else if colortv_jc = "roSGNodeEvent"
if m.colortv_ok(colortv_jb, m.colortv_is, colortv_ja) then
exit while
end if
end if
ColorTVSdkGetInstance().timerTick()
end while
if m.colortv_ip <> invalid then
m.colortv_gb.colortv_z(m.colortv_ip["currencyEarned"])
end if
end function
function colortv_oj(colortv_ja as Object, colortv_jg as Object)
if colortv_ja.findNode("colorTvAdEvents") <> invalid then
colortv_ja.findNode("colorTvAdEvents").observeField("closeAd", m.colortv_bs)
colortv_ja.findNode("colorTvAdEvents").observeField("adShown", m.colortv_bs)
end if
if colortv_jg["type"] = "engagement" or colortv_jg["type"] = "interstitial" then
colortv_jh = colortv_jg["ads"][0]["actionButton"]["actionType"]
if colortv_ji(colortv_jh) then
colortv_ja.findNode("colorTvSubscriptionEvents").observeField("subscribed", m.colortv_bs)
else if colortv_jj(colortv_jh) then
colortv_ja.findNode("colorTvAppstoreEvents").observeField("clicked", m.colortv_bs)
end if
end if
colortv_ja.findNode("videoNode").observeField("position", m.colortv_bs)
end function
function colortv_ol(colortv_jb as Object, colortv_is as Object, colortv_ja as Object) as Boolean
colortv_ba = colortv_is["placement"]
if colortv_jb.getNode() = "videoNode" then
if colortv_jb.getField() = "position" then
colortv_kq% = colortv_jb.getData()
m.colortv_om(colortv_kq%)
end if
else if colortv_jb.getNode() = "colorTvAdEvents" then
if colortv_jb.getField() = "closeAd" then
m.colortv_oo()
return true
else if colortv_jb.getField() = "adShown" then
m.colortv_gb.colortv_p(colortv_is["ads"][0]["impressionUrl"])
end if
else if colortv_jb.getNode() = "colorTvSubscriptionEvents" then
if colortv_jb.getField() = "subscribed" then
colortv_is.colortv_ll = true
ColorTVSdkGetInstance().colortv_gq(colortv_is, colortv_is["ads"][0], colortv_jb.getData())
end if
else if colortv_jb.getNode() = "colorTvAppstoreEvents" then
if colortv_jb.getField() = "clicked" then
colortv_is.colortv_ll = true
m.colortv_gb.colortv_p(colortv_is["ads"][0]["clickTracker"])
if m.colortv_ip <> invalid and m.colortv_ip["adClosed"] <> invalid then
m.colortv_ip["adClosed"](colortv_ba)
end if
colortv_jk = colortv_is["ads"][0]
if colortv_jk["type"] = "appstore" or colortv_jk["actionButton"]["actionType"] = "CLICK_TO_APPSTORE" then
if colortv_jk["clickData"]["contentId"] <> invalid then
m.colortv_gb.colortv_ao(colortv_jk["clickData"]["channelId"], colortv_jk["clickData"]["contentId"])
else
m.colortv_gb.colortv_ak(colortv_jk["clickData"]["channelId"])
end if
else if colortv_jk["type"] = "content" or colortv_jk["actionButton"]["actionType"] = "CLICK_TO_CONTENT" then
m.colortv_gb.colortv_ao(colortv_jk["clickData"]["channelId"], colortv_jk["clickData"]["contentId"])
end if
return true
end if
end if
return false
end function
function colortv_on(colortv_or)
for each colortv_os in m.colortv_og["trackingEvents"]
if colortv_os["time"] = colortv_or and m.colortv_oq <> colortv_or
colortv_ot(colortv_os)
end if
end for
m.colortv_oq = colortv_or
end function
function colortv_ot(colortv_os)
colortv_dp = true
colortv_ou = 3000
colortv_ov = CreateObject("roTimespan")
colortv_ov.Mark()
colortv_bs = CreateObject("roMessagePort")
colortv_ow = CreateObject("roURLTransfer")
colortv_ow.SetCertificatesFile("common:/certs/ca-bundle.crt")
colortv_ow.SetPort(colortv_bs)
colortv_ow.SetURL(colortv_os["url"])
colortv_bh("~~~TRACKING: " + colortv_ow.GetURL())
if colortv_ow.AsyncGetToString()
colortv_dv = wait(colortv_ou, colortv_bs)
if colortv_dv = invalid
colortv_ow.AsyncCancel()
colortv_dp = false
else
colortv_bh("Req finished: " + colortv_ov.TotalMilliseconds().ToStr())
colortv_bh(colortv_dv.GetResponseCode().ToStr())
colortv_bh(colortv_dv.GetFailureReason())
end if
end if
return colortv_dp
end function
function colortv_op()
for each colortv_os in m.colortv_og["trackingEvents"]
if colortv_os["event"] = "CLOSE"
colortv_ot(colortv_os)
end if
end for
end function