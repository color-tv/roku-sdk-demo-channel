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
return colortv_dp
end function
function colortv_ax(colortv_bb as String)
colortv_ca = colortv_cb()
m.colortv_ag(colortv_ca)
colortv_cc = FormatJson(colortv_ca)
m.colortv_l(colortv_bb, "POST", colortv_cc)
end function
function colortv_az(colortv_do as String, colortv_ds as String, colortv_bd as Object)
colortv_bb = m.colortv_d + "/ct/evt/" + m.colortv_e + "/" + colortv_do
colortv_bc = "POST"
if colortv_bd = invalid then
colortv_bd = {}
end if
colortv_dt = {
"videoId": colortv_do
"eventType": colortv_ds
}
colortv_bd.append(colortv_dt)
colortv_be = m.colortv_l(colortv_bb, colortv_bc, FormatJson(colortv_bd))
colortv_bf = colortv_be.GetResponseCode()
colortv_bg = (colortv_bf = 200)
if not colortv_bg then
colortv_bh("Failed to report video tracking event because of: " + colortv_be.GetFailureReason())
end if
end function
Function colortv_bv(colortv_du, colortv_dv=invalid)
if colortv_dv = invalid then colortv_dv = "Default"
colortv_dw = CreateObject("roRegistrySection", colortv_dv)
if colortv_dw.Exists(colortv_du) then return colortv_dw.Read(colortv_du)
return invalid
End Function
Function colortv_bx(colortv_du, colortv_dx, colortv_dv=invalid)
if colortv_dv = invalid then colortv_dv = "Default"
colortv_dw = CreateObject("roRegistrySection", colortv_dv)
colortv_dw.Write(colortv_du, colortv_dx)
colortv_dw.Flush() 'colortv_dy colortv_dz
End Function
Function colortv_ea(colortv_du, colortv_dv=invalid)
if colortv_dv = invalid then colortv_dv = "Default"
colortv_dw = CreateObject("roRegistrySection", colortv_dv)
colortv_dw.Delete(colortv_du)
colortv_dw.Flush() 'colortv_dy colortv_dz
End Function
Function isvalidstr(colortv_eb As Dynamic) As String
if colortv_ec(colortv_eb) return colortv_eb
return ""
End Function
Function colortv_ed(colortv_eb as dynamic) As Boolean
if colortv_eb = invalid return false
if GetInterface(colortv_eb, "ifString") = invalid return false
return true
End Function
Function colortv_ec(colortv_eb)
if colortv_ee(colortv_eb) return false
return true
End Function
Function colortv_ee(colortv_eb)
if colortv_eb = invalid return true
if not colortv_ed(colortv_eb) return true
if Len(colortv_eb) = 0 return true
return false
End Function
Sub colortv_bh(colortv_ef As Dynamic)
if ColorTVSdkGetInstance().colortv_eg then
colortv_eh = CreateObject("roDateTime")
print StrI(colortv_eh.getDayOfMonth()).Trim() + "." + StrI(colortv_eh.getMonth()).Trim() + "." StrI(colortv_eh.getYear()).Trim() + " " + StrI(colortv_eh.getHours()).Trim() + ":" + StrI(colortv_eh.getMinutes()).Trim() + ":" + StrI(colortv_eh.getSeconds()).Trim() + ":" + StrI(colortv_eh.getMilliseconds()).Trim() + ": " + colortv_ef.toStr().Trim()
end if
End Sub
function colortv_ei(colortv_ej as Integer) as String
if colortv_ej < 0 then
colortv_ej = 0
end if
colortv_ek = StrI(colortv_ej, 16)
if(colortv_ej < 16) then
colortv_ek = "0" + colortv_ek
end if
return colortv_ek
end function
function colortv_el(colortv_em as Integer, colortv_en as Integer, colortv_eo as Integer) as String
colortv_ep = "#ff" + colortv_ei(colortv_em) + colortv_ei(colortv_en) + colortv_ei(colortv_eo)
return colortv_ep
end function
function colortv_bw() as String
colortv_eq = CreateObject("roAppInfo")
return colortv_eq.GetVersion()
end function
function colortv_er() as LongInteger
colortv_es = CreateObject("roDateTime")
colortv_et& = colortv_es.asSeconds() * 1000&
colortv_et& += colortv_es.getMilliseconds()
return colortv_et&
end function
function colortv_eu(colortv_ev as String) as LongInteger
if not colortv_ew(colortv_ev) then
return invalid
end if
colortv_ex = 0&
for colortv_ey = 0 to colortv_ev.len() - 1
colortv_ex += colortv_ev.mid(colortv_ev.len() - 1 - colortv_ey, 1).toInt() * 10&^colortv_ey
end for
return colortv_ex
end function
function colortv_ew(colortv_ez) as Boolean
colortv_fa = CreateObject("roRegex", "^\d+$", "")
return colortv_fa.isMatch(colortv_ez)
end function
function colortv_df() as String
colortv_dd = CreateObject("roDeviceInfo")
colortv_fb = colortv_dd.getIpAddrs()
colortv_fc = colortv_fb.keys()
for each colortv_du in colortv_fc
return colortv_fb[colortv_du]
end for
return invalid
end function
function colortv_fd(colortv_fe, colortv_ff)
for colortv_ey = 0 to colortv_ff.count() - 1
if colortv_fg(colortv_fe, colortv_ff[colortv_ey]) then
return colortv_ey
end if
end for
return invalid
end function
function colortv_fg(colortv_fh, colortv_fi)
if type(colortv_fh) = "roAssociativeArray" and type(colortv_fi) = "roAssociativeArray" then
if colortv_fh.equals = invalid or colortv_fi.equals = invalid then
print "Objects have to implement 'equals' method in order to be comparable"
end if
return colortv_fh.equals(colortv_fi)
end if
return colortv_fh = colortv_fi
end function
function colortv_br(colortv_bb as String, colortv_fj as Object) as String
colortv_fk = colortv_fj.keys()
colortv_bb = colortv_bb + "?"
for each colortv_du in colortv_fk
colortv_bb = colortv_bb + colortv_du + "=" + colortv_fj[colortv_du] + "&"
end for
colortv_bb = colortv_bb.left(colortv_bb.len() - 1)
return colortv_bb
end function
function colortv_cb() as Dynamic
colortv_fl = CreateObject("roDeviceInfo")
colortv_eq = CreateObject("roAppInfo")
colortv_ca = {
"deviceModel": colortv_fl.GetModel()
"systemVersion": colortv_fl.GetVersion()
"systemName": colortv_fl.GetModelDetails().VendorName
"identifierForAds": colortv_fl.GetAdvertisingId()
"identifierForVendor": colortv_fl.GetPublisherId()
"language": colortv_fl.GetCurrentLocale()
"timezone": colortv_fl.GetTimeZone()
"appName": colortv_eq.GetTitle()
"appVersion": colortv_eq.GetVersion()
"sdkVersion": GetColorTVSDKVersion()
}
return colortv_ca
end function
function colortv_cm() as Dynamic
colortv_fm = colortv_bv("pollingUrls", "colortv")
if colortv_fm = invalid then
return []
end if
colortv_fn = ParseJson(colortv_fm)
colortv_fo = colortv_fn.Keys()
colortv_cp = []
colortv_fp = 24 * 60 * 60 * 1000
colortv_fq = false
for each colortv_du in colortv_fo
colortv_fr = colortv_eu(colortv_du)
if colortv_fr <> invalid then
if colortv_fr + colortv_fp < colortv_er() then
colortv_fq = true
colortv_fn.delete(colortv_du)
else
colortv_cp.push(colortv_fn[colortv_du])
end if
end if
end for
if colortv_fq then
colortv_fs(colortv_fn)
end if
return colortv_cp
end function
function colortv_fs(colortv_fn)
colortv_ft = FormatJson(colortv_fn)
colortv_bx("pollingUrls", colortv_ft, "colortv")
end function
sub colortv_cw(colortv_bb)
colortv_fm = colortv_bv("pollingUrls", "colortv")
if colortv_fm = invalid then
return
end if
colortv_fn = ParseJson(colortv_fm)
colortv_fo = colortv_fn.Keys()
for each colortv_du in colortv_fo
if colortv_fn[colortv_du] = colortv_bb then
colortv_fn.delete(colortv_du)
end if
end for
colortv_fs(colortv_fn)
end sub
function ColorTvSdk(colortv_e as String) as Object
colortv_fu = ColorTVSdkGetInstance()
if colortv_fu <> invalid then
print "Color TV SDK has already been initialized"
return colortv_fu
end if
print "Color TV SDK initialized with appid " + colortv_e
colortv_c = {
colortv_e: colortv_e
sdkVersion: GetColorTVSDKVersion()
colortv_eg: false
registerAdCallbacks: colortv_fv
registerContentRecommendationCallbacks: colortv_fw
registerUpNextCallbacks: colortv_fx
setDebugMode: colortv_fy
colortv_fz: colortv_a(colortv_e)
colortv_r: colortv_ga
colortv_gb: {}
loadAd: colortv_gc
colortv_bj: colortv_gd
showAd: colortv_ge
colortv_gf: colortv_gg
colortv_gh: colortv_gi
colortv_gj: colortv_gk
colortv_gl: colortv_gm
colortv_j: colortv_gn
colortv_go: colortv_gp
colortv_z: colortv_gq
colortv_gr: []
timerTick: colortv_gs
colortv_ck: colortv_gt
colortv_gu: colortv_gv
setUserAge: colortv_gw
setUserGender: colortv_gx
setUserKeywords: colortv_gy
colortv_gz: colortv_ha
colortv_hb: colortv_hc
colortv_hd: {}
loadContentRecommendation: colortv_he
colortv_dq: colortv_hf
colortv_hg: colortv_hh
showContentRecommendation: colortv_hi
trackVideoEvents: colortv_hj
loadUpNext: colortv_hk
loadUpNextScenegraph: colortv_hl
loadUpNextCanvas: colortv_hm
colortv_dr: colortv_hn
colortv_ho: colortv_hp
colortv_hq: colortv_hr
colortv_hs: false
colortv_ht: false
colortv_hu: false
upNextEventOccurred: colortv_hv
colortv_hw: colortv_hx
colortv_hy: colortv_hz
colortv_ia: colortv_ib
colortv_ic: colortv_id
colortv_ie: colortv_if
colortv_ig: colortv_ih
shouldCloseUpNextCanvas: colortv_ii
colortv_ij: colortv_ik
}
GetGlobalAA()["colorTvSdkInstance"] = colortv_c
colortv_c.colortv_r()
colortv_c.colortv_fz.colortv_t()
colortv_c.colortv_gu()
return colortv_c
end function
function colortv_fv(colortv_il as Object)
m.colortv_il = colortv_il
m.colortv_z()
end function
function colortv_fw(colortv_im)
m.colortv_im = colortv_im
end function
function colortv_fx(colortv_in as Object)
m.colortv_in = colortv_in
end function
function colortv_fy(colortv_eg as Boolean)
m.colortv_eg = colortv_eg
end function
function colortv_ga()
colortv_dd = CreateObject("roDeviceInfo")
colortv_bu = colortv_dd.GetAdvertisingId()
m.colortv_fz.colortv_r(m.colortv_e, colortv_bu, m.sdkVersion)
end function
function colortv_gc(colortv_ba as String) as Void
colortv_bh("loading ad for placement " + colortv_ba)
if m.colortv_gb.DoesExist(colortv_ba) then
colortv_bh("Ad for placement: " + colortv_ba + " is already loaded")
if m.colortv_il <> invalid and m.colortv_il["adLoaded"] <> invalid then
m.colortv_il["adLoaded"](colortv_ba)
end if
return
end if
m.colortv_fz.colortv_f(colortv_ba)
end function
function colortv_gd(colortv_io as Object, colortv_ba as String) as Void
if colortv_io.DoesExist("error") then
m.colortv_gf(colortv_ba, colortv_io["error"], colortv_io["errorMessage"])
else
colortv_bh("Ad has been loaded for placement: " + colortv_ba)
m.colortv_gb.AddReplace(colortv_ba, colortv_io)
if m.colortv_il <> invalid and m.colortv_il["adLoaded"] <> invalid then
m.colortv_il["adLoaded"](colortv_ba)
end if
end if
end function
sub colortv_ge(colortv_ba as String)
if not colortv_ip(colortv_ba, m.colortv_gb)
m.colortv_gb.delete(colortv_ba)
return
end if
colortv_io = m.colortv_gb[colortv_ba]
m.colortv_gb.delete(colortv_ba)
if colortv_io["type"] = "discovery" then
for colortv_ey = 0 to colortv_io["ads"].count() - 1
if colortv_io["ads"][colortv_ey]["pollingUrl"] <> invalid then
colortv_iq(colortv_io["ads"][colortv_ey]["pollingUrl"])
end if
end for
else
colortv_iq(colortv_io["ads"][0]["pollingUrl"])
end if
if colortv_io["type"] = "video" or colortv_io["ads"][0]["markupUrl"] <> invalid then
colortv_ir = colortv_is(colortv_io, m.colortv_fz, m.colortv_il)
if colortv_ir = invalid then
m.colortv_gf(colortv_ba, "INTERNAL_SDK_ERROR", "Can't play video ad with URL: " + colortv_io["ads"][0]["markupUrl"])
return
end if
colortv_ir.colortv_it()
end if
if colortv_io["type"] <> "video" and not colortv_iu(colortv_io) then
colortv_iv = CreateObject("roSGScreen")
colortv_iw = m.colortv_gh(colortv_iv, colortv_io["type"])
colortv_iv.show()
m.colortv_gj(colortv_iw, colortv_io)
colortv_iw["dataModel"] = colortv_io
while true
colortv_ix = wait(GetColorTVSDKTimerInterval(), m.colortv_bs)
colortv_iy = type(colortv_ix)
if colortv_iy = "roSGScreenEvent"
if colortv_ix.isScreenClosed() then
exit while
end if
else if colortv_iy = "roSGNodeEvent"
if m.colortv_gl(colortv_ix, colortv_io, colortv_iw) then
exit while
end if
end if
m.timerTick()
end while
if m.colortv_il <> invalid then
m.colortv_fz.colortv_z(m.colortv_il["currencyEarned"])
end if
end if
end sub
function colortv_gg(colortv_ba as String, colortv_iz as String, colortv_ja as String)
if m.colortv_il <> invalid and m.colortv_il["adError"] <> invalid then
colortv_bi = {
"placement": colortv_ba
"errorCode": colortv_iz
"errorMessage": colortv_ja
}
m.colortv_il["adError"](colortv_bi)
else
colortv_bh("Ad error has occurred for placement: """ + colortv_ba + """ with code: """ + colortv_iz + """ and message: """ + colortv_ja + """")
end if
end function
function colortv_gi(colortv_iv as Object, colortv_jb as String)
m.colortv_bs = CreateObject("roMessagePort")
colortv_iv.setMessagePort(m.colortv_bs)
colortv_iw = colortv_iv.CreateScene("colortv_" + colortv_jb)
return colortv_iw
end function
function colortv_gk(colortv_iw as Object, colortv_jc as Object)
if colortv_iw.findNode("colorTvAdEvents") <> invalid then
colortv_iw.findNode("colorTvAdEvents").observeField("closeAd", m.colortv_bs)
colortv_iw.findNode("colorTvAdEvents").observeField("adShown", m.colortv_bs)
end if
if colortv_jc["type"] = "engagement" or colortv_jc["type"] = "interstitial" then
colortv_jd = colortv_jc["ads"][0]["actionButton"]["actionType"]
if colortv_je(colortv_jd) then
colortv_iw.findNode("colorTvSubscriptionEvents").observeField("subscribed", m.colortv_bs)
else if colortv_jf(colortv_jd) then
colortv_iw.findNode("colorTvAppstoreEvents").observeField("clicked", m.colortv_bs)
end if
else if colortv_jc["type"] = "discovery" then
colortv_iw.findNode("colorTvGridEvents").observeField("closed", m.colortv_bs)
colortv_iw.findNode("colorTvGridEvents").observeField("impression", m.colortv_bs)
colortv_iw.findNode("colorTvGridEvents").observeField("moreDataUrl", m.colortv_bs)
colortv_iw.findNode("colorTvDiscoveryCenterEvents").observeField("clicked", m.colortv_bs)
colortv_iw.findNode("colorTvDiscoveryCenterEvents").observeField("subscribed", m.colortv_bs)
end if
end function
function colortv_gm(colortv_ix as Object, colortv_io as Object, colortv_iw as Object) as Boolean
colortv_ba = colortv_io["placement"]
if colortv_ix.getNode() = "colorTvAdEvents" then
if colortv_ix.getField() = "closeAd" then
if m.colortv_il <> invalid and m.colortv_il["adClosed"] <> invalid and colortv_ba <> invalid then
m.colortv_il["adClosed"](colortv_ba)
end if
return true
else if colortv_ix.getField() = "adShown" then
m.colortv_fz.colortv_p(colortv_io["ads"][0]["impressionUrl"])
end if
else if colortv_ix.getNode() = "colorTvSubscriptionEvents" then
if colortv_ix.getField() = "subscribed" then
m.colortv_go(colortv_io, colortv_io["ads"][0], colortv_ix.getData())
end if
else if colortv_ix.getNode() = "colorTvAppstoreEvents" then
if colortv_ix.getField() = "clicked" then
m.colortv_fz.colortv_p(colortv_io["ads"][0]["clickTracker"])
if m.colortv_il <> invalid and m.colortv_il["adClosed"] <> invalid then
m.colortv_il["adClosed"](colortv_ba)
end if
colortv_jg = colortv_io["ads"][0]
if colortv_jg["type"] = "appstore" then
if colortv_jg["clickData"]["contentId"] <> invalid then
m.colortv_fz.colortv_ao(colortv_jg["clickData"]["channelId"], colortv_jg["clickData"]["contentId"])
else
m.colortv_fz.colortv_ak(colortv_jg["clickData"]["channelId"])
end if
else if colortv_jg["type"] = "content"
m.colortv_fz.colortv_ao(colortv_jg["clickData"]["channelId"], colortv_jg["clickData"]["contentId"])
end if
return true
end if
else if colortv_ix.getNode() = "colorTvGridEvents" then
if colortv_ix.getField() = "impression" and colortv_ix.getData() <> ""
m.colortv_fz.colortv_p(colortv_ix.getData())
else if colortv_ix.getField() = "moreDataUrl" and colortv_ix.getData() <> "" then
m.colortv_j(colortv_iw, colortv_ix.getData())
else if colortv_ix.getField() = "closed" then
if m.colortv_il <> invalid and m.colortv_il["adClosed"] <> invalid and colortv_ba <> invalid then
m.colortv_il["adClosed"](colortv_ba)
end if
return true
end if
else if colortv_ix.getNode() = "colorTvDiscoveryCenterEvents" then
if colortv_ix.getField() = "subscribed" then
colortv_jh = colortv_ix.getData()["clickedItemModel"]
colortv_ji = colortv_ix.getData()["inputValue"]
m.colortv_go(colortv_io, colortv_jh, colortv_ji)
else if colortv_ix.getField() = "clicked"
colortv_jg = colortv_ix.getData()
if colortv_jg["clickTracker"] <> invalid then
m.colortv_fz.colortv_p(colortv_jg["clickTracker"])
end if
if m.colortv_il <> invalid and m.colortv_il["adClosed"] <> invalid then
m.colortv_il["adClosed"](colortv_ba)
end if
if colortv_jg["type"] = "appstore" then
if colortv_jg["clickData"]["contentId"] <> invalid then
m.colortv_fz.colortv_ao(colortv_jg["clickData"]["channelId"], colortv_jg["clickData"]["contentId"])
else
m.colortv_fz.colortv_ak(colortv_jg["clickData"]["channelId"])
end if
else if colortv_jg["type"] = "content"
m.colortv_fz.colortv_ao(colortv_jg["clickData"]["channelId"], colortv_jg["clickData"]["contentId"])
end if
return true
end if
end if
return false
end function
function colortv_gn(colortv_iw as Dynamic, colortv_jj as String)
colortv_jk = m.colortv_fz.colortv_j(colortv_jj)
if colortv_jk <> invalid then
if colortv_iw["dataModel"]["ads"] <> invalid then
colortv_jl = colortv_iw["dataModel"]["ads"]
colortv_jl.append(colortv_jk["ads"])
colortv_jk["ads"] = colortv_jl
colortv_iw["dataModel"] = colortv_jk
else if colortv_iw["dataModel"].colortv_jm <> invalid then
colortv_jl = colortv_iw["dataModel"].colortv_jm
colortv_jl.append(colortv_jk.colortv_jm)
colortv_jk.colortv_jm = colortv_jl
colortv_iw["dataModel"] = colortv_jk
end if
end if
colortv_iw.findNode("colorTvGridEvents")["moreDataUrl"] = ""
end function
function colortv_gp(colortv_jn as Dynamic, colortv_jg as Dynamic, colortv_jo as String) as Void
colortv_jn.colortv_jp(colortv_jo)
m.colortv_fz.colortv_n(colortv_jg["clickTracker"], colortv_jo, colortv_jg["type"])
if colortv_jg["clickUrl"] <> invalid then
m.colortv_fz.colortv_n(colortv_jg["clickUrl"], colortv_jo, colortv_jg["type"])
else if colortv_jg["clickData"]["clickUrl"] <> invalid then
m.colortv_fz.colortv_n(colortv_jg["clickData"]["clickUrl"], colortv_jo, colortv_jg["type"])
end if
end function
function colortv_gq()
if m.colortv_il <> invalid then
m.colortv_fz.colortv_z(m.colortv_il["currencyEarned"])
end if
end function
sub colortv_gs()
colortv_jq = []
for each colortv_jr in m.colortv_gr
if colortv_jr.colortv_js() then
colortv_jq.push(colortv_jr)
end if
end for
for each colortv_cn in colortv_jq
m.colortv_gr.delete( colortv_fd(colortv_cn, m.colortv_gr) )
end for
end sub
function colortv_gt(colortv_cn as Dynamic) as Void
m.colortv_gr.push(colortv_cn)
end function
function colortv_gv()
colortv_jt = m.colortv_fz.colortv_am()
colortv_ju = colortv_jt.keys()
colortv_jv = colortv_jw()
colortv_bx("installedApps", FormatJson(colortv_jt), "colortv")
colortv_jx = []
for each colortv_jy in colortv_jv
for each colortv_du in colortv_jt.keys()
if colortv_du = colortv_jy then
colortv_jx.push(colortv_du)
end if
end for
end for
for each colortv_e in colortv_jx
colortv_jz = colortv_fd(colortv_e, colortv_ju)
colortv_ju.delete(colortv_jz)
end for
colortv_bh("Apps that weren't saved yet: " + FormatJson(colortv_ju))
m.colortv_fz.colortv_ai(colortv_ju)
end function
sub colortv_gw(colortv_ka)
if Type(colortv_ka) = "roInt" Or Type(colortv_ka) = "roInteger" or Type(colortv_ka) = "Integer"
colortv_ka = colortv_ka.toStr()
else if not ((Type(colortv_ka) = "roString" Or Type(colortv_ka) = "String") and colortv_ew(colortv_ka)) then
print "WARNING: Value passed as user age is not a number"
return
end if
colortv_bx("userAge", colortv_ka, "colortv")
end sub
sub colortv_gx(colortv_kb as String)
if not (LCase(colortv_kb) = "male" or LCase(colortv_kb) = "female") then
print "WARNING: Value passed as user gender is neither male nor female"
return
end if
colortv_bx("userGender", LCase(colortv_kb), "colortv")
end sub
sub colortv_gy(colortv_kc as String)
colortv_bx("userKeywords", colortv_kc, "colortv")
end sub
function colortv_hc(colortv_kd as String, colortv_bp as String) as Void
colortv_bh("Saving: " + colortv_kd + ", " + colortv_bp)
colortv_bx("subscription_" + colortv_bp, colortv_kd, "colortv")
end function
function colortv_ha(colortv_bp as String) as Dynamic
return colortv_bv("subscription_" + colortv_bp, "colortv")
end function
sub colortv_he(colortv_ba, colortv_ke="" as String)
if m.colortv_hu and colortv_ba = "VideoEnd" then
m.colortv_hu = false
colortv_bh("UpNext should play instead of content recommendation")
return
end if
colortv_bh("loading content recommendation for placement " + colortv_ba)
if m.colortv_hd.DoesExist(colortv_ba) and m.colortv_hd[colortv_ba]["previousVideoId"] = colortv_ke then
colortv_bh("Content recommendation for placement: " + colortv_ba + " is already loaded")
if m.colortv_im <> invalid and m.colortv_im["contentRecommendationLoaded"] <> invalid then
m.colortv_im["contentRecommendationLoaded"](colortv_ba)
end if
return
end if
m.colortv_fz.colortv_aq(colortv_ba, colortv_ke)
end sub
function colortv_hf(colortv_kf as Object, colortv_ba as String) as Void
if colortv_kf.DoesExist("error") then
m.colortv_hg(colortv_ba, colortv_kf["errorCode"].toStr(), colortv_kf["error"])
else
colortv_bh("Content recommendation has been loaded for placement: " + colortv_ba)
m.colortv_hd.AddReplace(colortv_ba, colortv_kf)
if m.colortv_im <> invalid and m.colortv_im["contentRecommendationLoaded"] <> invalid then
m.colortv_im["contentRecommendationLoaded"](colortv_ba)
end if
end if
end function
function colortv_hh(colortv_ba as String, colortv_iz as String, colortv_ja as String)
if m.colortv_im <> invalid and m.colortv_im["contentRecommendationError"] <> invalid then
colortv_bi = {
"placement": colortv_ba
"errorCode": colortv_iz
"errorMessage": colortv_ja
}
m.colortv_im["contentRecommendationError"](colortv_bi)
else
colortv_bh("Content recommendation error has occurred for placement: """ + colortv_ba + """ with code: """ + colortv_iz + """ and message: """ + colortv_ja + """")
end if
end function
sub colortv_hi(colortv_ba as String)
if not colortv_kg(colortv_ba, m.colortv_hd)
m.colortv_hd.delete(colortv_ba)
return
end if
colortv_kf = m.colortv_hd[colortv_ba]
m.colortv_hd.delete(colortv_ba)
colortv_iv = CreateObject("roSGScreen")
colortv_iw = m.colortv_gh(colortv_iv, "contentRecommendation")
colortv_iv.show()
colortv_iw.findNode("colorTvGridEvents").observeField("moreDataUrl", m.colortv_bs)
colortv_iw.findNode("colorTvGridEvents").observeField("impression", m.colortv_bs)
colortv_iw.findNode("colorTvGridEvents").observeField("closed", m.colortv_bs)
colortv_iw.findNode("colorTvContentRecommendationEvents").observeField("clicked", m.colortv_bs)
colortv_iw.findNode("colorTvContentRecommendationEvents").observeField("favourite", m.colortv_bs)
colortv_iw.findNode("colorTvDiscoveryCenterEvents").observeField("clicked", m.colortv_bs)
colortv_iw.findNode("colorTvDiscoveryCenterEvents").observeField("subscribed", m.colortv_bs)
for colortv_ey = 0 to colortv_kf["recommendations"].count() - 1
if colortv_kf["recommendations"][colortv_ey]["pollingUrl"] <> invalid then
colortv_iq(colortv_kf["recommendations"][colortv_ey]["pollingUrl"])
end if
end for
colortv_iw["dataModel"] = colortv_kf
while true
colortv_ix = wait(GetColorTVSDKTimerInterval(), m.colortv_bs)
colortv_iy = type(colortv_ix)
if colortv_iy = "roSGScreenEvent"
if colortv_ix.isScreenClosed() then
exit while
end if
else if colortv_iy = "roSGNodeEvent"
if colortv_ix.getNode() = "colorTvContentRecommendationEvents" then
if colortv_ix.getField() = "clicked" then
colortv_jg = colortv_ix.getData()
if colortv_jg["clickTracker"] <> invalid then
m.colortv_fz.colortv_p(colortv_jg["clickTracker"])
end if
if m.colortv_im <> invalid and m.colortv_im["contentRecommendationClicked"] <> invalid then
colortv_dt = {
"videoId": colortv_jg["partnerVideoId"]
"videoUrl": colortv_jg["url"]
}
m.colortv_im["contentRecommendationClicked"](colortv_ba, colortv_dt)
end if
exit while
else if colortv_ix.getField() = "favourite" and colortv_ix.getData() <> "" then
m.colortv_fz.colortv_aw(colortv_ix.getData())
end if
else if colortv_ix.getNode() = "colorTvGridEvents" then
if colortv_ix.getField() = "impression" and colortv_ix.getData() <> ""
m.colortv_fz.colortv_p(colortv_ix.getData())
else if colortv_ix.getField() = "moreDataUrl" and colortv_ix.getData() <> "" then
m.colortv_j(colortv_iw, colortv_ix.getData())
else if colortv_ix.getField() = "closed" then
if m.colortv_im <> invalid and m.colortv_im["contentRecommendationClosed"] <> invalid then
m.colortv_im["contentRecommendationClosed"](colortv_ba)
end if
exit while
end if
else if colortv_ix.getNode() = "colorTvDiscoveryCenterEvents" then
if colortv_ix.getField() = "subscribed" then
colortv_jh = colortv_ix.getData()["clickedItemModel"]
colortv_ji = colortv_ix.getData()["inputValue"]
m.colortv_go(colortv_kf, colortv_jh, colortv_ji)
else if colortv_ix.getField() = "clicked"
colortv_jg = colortv_ix.getData()
if colortv_jg["clickTracker"] <> invalid then
m.colortv_fz.colortv_p(colortv_jg["clickTracker"])
end if
if m.colortv_im <> invalid and m.colortv_im["contentRecommendationClosed"] <> invalid then
m.colortv_im["contentRecommendationClosed"](colortv_ba)
end if
if colortv_jg["type"] = "appstore" then
if colortv_jg["clickData"]["contentId"] <> invalid then
m.colortv_fz.colortv_ao(colortv_jg["clickData"]["channelId"], colortv_jg["clickData"]["contentId"])
else
m.colortv_fz.colortv_ak(colortv_jg["clickData"]["channelId"])
end if
else if colortv_jg["type"] = "content"
m.colortv_fz.colortv_ao(colortv_jg["clickData"]["channelId"], colortv_jg["clickData"]["contentId"])
end if
exit while
end if
end if
end if
m.timerTick()
end while
colortv_iv.close()
end sub
sub colortv_hj(colortv_do as String, colortv_ds as Object)
if colortv_do = invalid then
return
end if
if type(colortv_ds) = "roSGNodeEvent" then
if colortv_ds.getField() = "state" then
if colortv_ds.getData() = "playing" then
if m.colortv_kh = invalid or not (m.colortv_kh.colortv_ki <> invalid and m.colortv_kh.colortv_ki) then
if m.colortv_kh = invalid then
m.colortv_kh = {}
end if
m.colortv_kh.colortv_ki = true
m.colortv_kh["positionSeconds"] = 0
m.colortv_fz.colortv_ay(colortv_do, "VIDEO_STARTED", m.colortv_kh)
else
m.colortv_kj = true
end if
else if colortv_ds.getData() = "stopped"  and m.colortv_kh <> invalid then
m.colortv_fz.colortv_ay(colortv_do, "VIDEO_STOPPED", m.colortv_kh)
m.colortv_kh = invalid
else if colortv_ds.getData() = "paused" then
m.colortv_fz.colortv_ay(colortv_do, "VIDEO_PAUSED", m.colortv_kh)
else if colortv_ds.getData() = "finished"
m.colortv_fz.colortv_ay(colortv_do, "VIDEO_COMPLETED", m.colortv_kh)
m.colortv_kh = invalid
if m.colortv_hs and not m.colortv_ht then
m.colortv_ij()
end if
end if
else if colortv_ds.getField() = "position" then
colortv_kk% = colortv_ds.getData()
if m.colortv_kj <> invalid and m.colortv_kj then
m.colortv_kj = false
if m.colortv_kh <> invalid and colortv_kk% - m.colortv_kh["positionSeconds"] > 1 then
m.colortv_kh["positionSeconds"] = colortv_kk%
end if
m.colortv_fz.colortv_ay(colortv_do, "VIDEO_RESUMED", m.colortv_kh)
end if
if m.colortv_kh = invalid then
m.colortv_kh = {}
end if
m.colortv_kh["positionSeconds"] = colortv_kk%
m.colortv_hq(colortv_kk%)
end if
else if type(colortv_ds) = "roVideoPlayerEvent" or type(colortv_ds) = "roVideoScreenEvent" then
if colortv_ds.isStreamStarted() then
if m.colortv_kj = invalid or m.colortv_kj = false then
m.colortv_kh = { "positionSeconds": colortv_ds.getIndex() }
m.colortv_fz.colortv_ay(colortv_do, "VIDEO_STARTED", m.colortv_kh)
end if
else if colortv_ds.isPlaybackPosition() then
m.colortv_kh = { "positionSeconds": colortv_ds.getIndex() }
if m.colortv_kj <> invalid and m.colortv_kj then
m.colortv_kj = false
m.colortv_fz.colortv_ay(colortv_do, "VIDEO_RESUMED", m.colortv_kh)
end if
m.colortv_hq(colortv_ds.getIndex())
m.colortv_ic(colortv_ds.getIndex())
else if colortv_ds.isFullResult() then
m.colortv_fz.colortv_ay(colortv_do, "VIDEO_COMPLETED", m.colortv_kh)
m.colortv_kh = invalid
if m.colortv_hs and not m.colortv_ht then
m.colortv_ij()
end if
else if colortv_ds.isPartialResult() and m.colortv_kh <> invalid then
m.colortv_fz.colortv_ay(colortv_do, "VIDEO_STOPPED", m.colortv_kh)
m.colortv_kh = invalid
else if colortv_ds.isPaused() then
m.colortv_kj = true
m.colortv_fz.colortv_ay(colortv_do, "VIDEO_PAUSED", m.colortv_kh)
else if colortv_ds.isResumed() then
m.colortv_kj = false
m.colortv_fz.colortv_ay(colortv_do, "VIDEO_RESUMED", m.colortv_kh)
end if
else if type(colortv_ds) = "String" or type(colortv_ds) = "roString" then
if colortv_ds = "interrupted" and m.colortv_kh <> invalid then
m.colortv_fz.colortv_ay(colortv_do, "VIDEO_STOPPED", m.colortv_kh)
m.colortv_kh = invalid
end if
end if
end sub
sub colortv_hl(colortv_kl, colortv_bs, colortv_km=10 as Integer, colortv_ke="" as String)
m.loadUpNext(colortv_kl, colortv_bs, colortv_km, colortv_ke)
end sub
sub colortv_hk(colortv_kl, colortv_bs, colortv_km as Integer, colortv_ke as String, colortv_kn=invalid)
m.colortv_ko = colortv_kl
m.colortv_kp = colortv_kn
m.colortv_kq = colortv_bs
m.colortv_km = colortv_km + 1
m.colortv_kr = true
m.colortv_ht = false
colortv_bh("loading up next")
colortv_ba = "VideoEnd"
if m.colortv_hd.DoesExist(colortv_ba) and m.colortv_hd[colortv_ba]["previousVideoId"] = colortv_ke then
colortv_bh("Up next is already loaded")
if m.colortv_in <> invalid and m.colortv_in["upNextLoaded"] <> invalid then
m.colortv_in["upNextLoaded"]()
end if
return
end if
m.colortv_fz.colortv_au("VideoEnd", colortv_ke)
end sub
sub colortv_hm(colortv_kl, colortv_kn, colortv_bs, colortv_km=10 as Integer, colortv_ke="" as String)
m.loadUpNext(colortv_kl, colortv_bs, colortv_km, colortv_ke, colortv_kn)
end sub
function colortv_hn(colortv_ks as Object, colortv_ba as String)
if colortv_ks.DoesExist("error") then
m.colortv_ho(colortv_ba, colortv_ks["errorCode"].toStr(), colortv_ks["error"])
else
colortv_bh("Up next has been loaded")
m.colortv_hd.AddReplace(colortv_ba, colortv_ks)
if m.colortv_in <> invalid and m.colortv_in["upNextLoaded"] <> invalid then
m.colortv_in["upNextLoaded"]()
end if
end if
end function
function colortv_hp(colortv_ba as String, colortv_iz as String, colortv_ja as String)
if m.colortv_in <> invalid and m.colortv_in["upNextError"] <> invalid then
colortv_bi = {
"placement": colortv_ba
"errorCode": colortv_iz
"errorMessage": colortv_ja
}
m.colortv_in["upNextError"](colortv_bi)
else
colortv_bh("Up next error has occurred with code: """ + colortv_iz + """ and message: """ + colortv_ja + """")
end if
end function
function colortv_hr(colortv_kt as Integer)
if m.colortv_hd.DoesExist("VideoEnd") and m.colortv_ko <> invalid and not m.colortv_hs and not m.colortv_ht then
if type(m.colortv_ko) = "roSGNode" then
colortv_ku = m.colortv_ko["duration"]
else
colortv_ku = m.colortv_ko.getPlaybackDuration()
end if
if colortv_ku > 0 and colortv_ku - colortv_kt < m.colortv_km then
if not m.colortv_kr then
m.colortv_hw(m.colortv_hd["VideoEnd"]["recommendations"][0])
m.colortv_fz.colortv_p(m.colortv_kv["impressionUrl"])
else
m.colortv_kr = false
end if
end if
end if
if m.colortv_hs and not m.colortv_ht and type(m.colortv_ko) = "roVideoPlayer" and m.colortv_ko.getPlaybackDuration() - colortv_kt > m.colortv_km then
m.colortv_ie()
end if
end function
function colortv_hx(colortv_kw)
m.colortv_kv = colortv_kw
if type(m.colortv_ko) = "roSGNode" then
m.colortv_hy()
else
m.colortv_ia()
end if
end function
function colortv_hz()
m.colortv_kx = createObject("roSGNode", "colortv_up_next")
m.colortv_ko.appendChild(m.colortv_kx)
m.colortv_kx["timeBeforeVideoEnds"] = m.colortv_km
m.colortv_kx["videoNodeReference"] = m.colortv_ko
m.colortv_kx["id"] = "colortv_up_next"
m.colortv_kx["dataModel"] = m.colortv_kv
m.colortv_kx["show"] = true
m.colortv_kx.setFocus(true)
m.colortv_kx.observeField("cancelled", m.colortv_kq)
m.colortv_kx.observeField("videoMoved", m.colortv_kq)
m.colortv_hs = true
end function
function colortv_ib()
m.colortv_ky = colortv_kz(m.colortv_kp)
m.colortv_ky.colortv_hw(m.colortv_kv)
m.colortv_hs = true
end function
function colortv_id(colortv_kt)
if m.colortv_hs and not m.colortv_ht and m.colortv_ky <> invalid then
m.colortv_ky.colortv_la(colortv_kt, m.colortv_ko.getPlaybackDuration())
end if
end function
function colortv_ii(colortv_ix)
colortv_lb = false
if type(colortv_ix) = "roImageCanvasEvent" and colortv_ix.isRemoteKeyPressed() and colortv_ix.GetIndex() = 2 or colortv_ix.GetIndex() = 0 and m.colortv_hs then
m.colortv_ie()
m.colortv_ht = true
colortv_lb = true
end if
return colortv_lb
end function
function colortv_if()
m.colortv_kr = true
m.colortv_hs = false
if type(m.colortv_ko) = "roSGNode" then
m.colortv_ig()
else
m.colortv_ky.colortv_ie()
end if
end function
function colortv_ih()
m.colortv_ko.removeChild(m.colortv_kx)
m.colortv_ko.setFocus(true)
end function
function colortv_hv(colortv_ds)
if type(colortv_ds) = "roSGNodeEvent" then
if colortv_ds.getField() = "cancelled"
m.colortv_ie()
m.colortv_ht = true
else if colortv_ds.getField() = "videoMoved" and m.colortv_hs
m.colortv_ie()
end if
end if
end function
function colortv_ik()
m.colortv_hs = false
m.colortv_hu = true
m.colortv_ko = invalid
m.colortv_hd.delete("VideoEnd")
colortv_dt = {}
colortv_dt["videoId"] = m.colortv_kv["partnerVideoId"]
colortv_dt["videoUrl"] = m.colortv_kv["url"]
m.colortv_fz.colortv_p(m.colortv_kv["clickTracker"])
if m.colortv_in <> invalid and m.colortv_in["upNextClicked"] <> invalid then
m.colortv_in["upNextClicked"](colortv_dt)
end if
end function
function ColorTVSdkGetInstance()
return GetGlobalAA()["colorTvSdkInstance"]
end function
function GetColorTVSDKVersion() as String
return "1.4.0"
end function
function GetColorTVSDKTimerInterval() as Integer
return 1000
end function
sub colortv_iq(colortv_lc)
if colortv_lc = invalid then
return
end if
colortv_fm = colortv_bv("pollingUrls", "colortv")
if colortv_fm = invalid then
colortv_fm = "{}"
end if
colortv_fn = ParseJson(colortv_fm)
colortv_fn[colortv_er().toStr()] = colortv_lc
colortv_bx("pollingUrls", FormatJson(colortv_fn), "colortv")
end sub
function colortv_jw()
colortv_ld = []
colortv_le = colortv_bv("installedApps", "colortv")
if colortv_le <> invalid
colortv_ld = ParseJson(colortv_le)
end if
return colortv_ld
end function
function colortv_iu(colortv_io) as Boolean
return colortv_io.colortv_lf <> invalid and colortv_io.colortv_lf
end function
function colortv_ip(colortv_ba as String, colortv_gb as Object) as Boolean
if not colortv_gb.DoesExist(colortv_ba) then
colortv_bh("Ad for placement: " + colortv_ba + " isn't loaded. Please call loadAd function first.")
return false
else if not colortv_lg(colortv_gb[colortv_ba]) then
colortv_bh("Ad for placement: " + colortv_ba + " is not valid anymore. Please load the ad again.")
return false
end if
return true
end function
function colortv_kg(colortv_ba as String, colortv_lh as Object) as Boolean
if not colortv_lh.DoesExist(colortv_ba) then
colortv_bh("Content recommendation for placement: " + colortv_ba + " isn't loaded. Please call loadContentRecommendation function first.")
return false
else if not colortv_lg(colortv_lh[colortv_ba]) then
colortv_bh("Content recommendation for placement: " + colortv_ba + " is not valid anymore. Please load the content recommendation again.")
return false
end if
return true
end function
function colortv_lg(colortv_io) as Boolean
colortv_li = CreateObject("roDateTime")
colortv_li.fromIso8601String(colortv_io["validUntil"])
colortv_lj = CreateObject("roDateTime")
return colortv_li.asSeconds() > colortv_lj.asSeconds()
end function
function colortv_je(colortv_lk as String) as Boolean
return colortv_lk = "CLICK_TO_SMS" or colortv_lk = "CLICK_TO_CALL" or colortv_lk = "CLICK_TO_EMAIL"
end function
function colortv_jf(colortv_lk as String) as Boolean
return colortv_lk = "CLICK_TO_APPSTORE" or colortv_lk = "CLICK_TO_CONTENT"
end function
function colortv_bl(colortv_cc as String) as Object
colortv_c = ParseJson(colortv_cc)
if not colortv_c.DoesExist("error") then
colortv_ll = CreateObject("roDateTime")
colortv_ll.fromSeconds(colortv_ll.asSeconds() + colortv_c["validFor"])
colortv_c["validUntil"] = colortv_ll.toIsoString()
colortv_c.colortv_jp = colortv_lm
colortv_c["storedPhoneNumber"] = colortv_ln("phone")
colortv_c["storedEmailAddress"] = colortv_ln("email")
end if
return colortv_c
end function
function colortv_ln(colortv_bp)
return ColorTVSdkGetInstance().colortv_gz(colortv_bp)
end function
function colortv_lm(colortv_lo as String) as Void
if colortv_lo = invalid then
return
end if
colortv_lp = CreateObject("roRegex", "\A[^@]+@[^@]+\z", "")
colortv_lq = CreateObject("roRegex", "[\(]?[0-9]{3}[\)]?[ ]?[-]?[ ]?[0-9]{3}[ ]?[-]?[ ]?[0-9]{3,4}", "")
colortv_lr = invalid
if colortv_lp.isMatch(colortv_lo) then
colortv_lr = "email"
else if colortv_lq.isMatch(colortv_lo)
colortv_lr = "phone"
end if
if colortv_lr = invalid then
return
end if
colortv_ls = ColorTVSdkGetInstance()
colortv_ls.colortv_hb(colortv_lo, colortv_lr)
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
function colortv_ci(colortv_lt as Double, colortv_fj as Dynamic, colortv_co as Function)
colortv_c = {
colortv_co: colortv_co,
colortv_fj: colortv_fj,
colortv_js: colortv_lu,
equals: colortv_lv
}
colortv_c.colortv_lw = colortv_er() + colortv_lt
return colortv_c
end function
function colortv_lu() as Boolean
colortv_lx = colortv_er()
if colortv_lx < m.colortv_lw then
return false
end if
if m.colortv_fj.isEmpty() then
m.colortv_co()
else
m.colortv_co(m.colortv_fj)
end if
return true
end function
function colortv_lv(colortv_ly as Dynamic) as Boolean
return m.colortv_lw = colortv_ly.colortv_lw and m.colortv_co = colortv_ly.colortv_co
end function
function colortv_kz(colortv_kn)
colortv_lz = createObject("roFontRegistry")
colortv_lz.register("pkg:/fonts/colortv/ABeeZee-Regular.otf")
colortv_ma = 720 / 1080
colortv_mb = int(960.0 * colortv_ma)
colortv_mc = int(894.0 * colortv_ma)
colortv_c = {
colortv_lz: colortv_lz
colortv_kn: colortv_kn
colortv_mb: colortv_mb
colortv_mc: colortv_mc
colortv_ma: colortv_ma
colortv_md: false
colortv_hw: colortv_me
colortv_mf: colortv_mg
colortv_ie: colortv_mh
colortv_la: colortv_mi
colortv_mj: colortv_mk
colortv_ml: colortv_mm
colortv_mn: colortv_mo
colortv_mp: colortv_mq
colortv_mr: colortv_ms
colortv_mt: colortv_mu
}
return colortv_c
end function
function colortv_me(colortv_kw)
m.colortv_mf(colortv_kw)
m.colortv_kn.SetLayer(10028, m.colortv_mv)
m.colortv_kn.SetLayer(10024, m.colortv_mw)
m.colortv_kn.SetLayer(10025, m.colortv_mx)
m.colortv_kn.SetLayer(10026, m.colortv_my)
m.colortv_kn.SetLayer(10027, m.colortv_mz)
end function
function colortv_mg(colortv_kw)
m.colortv_mw = m.colortv_mj()
m.colortv_mx = m.colortv_ml()
m.colortv_my = m.colortv_mn(colortv_kw["title"].trim())
m.colortv_mz = m.colortv_mr(colortv_kw["description"].trim())
m.colortv_mv = m.colortv_mt(colortv_kw["thumbnailUrl"])
end function
function colortv_mh()
for colortv_ey = 10024 to 10030
m.colortv_kn.clearLayer(colortv_ey)
end for
end function
function colortv_mi(colortv_lj, colortv_na)
if not m.colortv_md then
m.colortv_md = true
m.colortv_nb = colortv_na - colortv_lj
end if
colortv_nc% = m.colortv_mb + 555.0 * m.colortv_ma
colortv_nd% = m.colortv_mc + 25.0 * m.colortv_ma
colortv_ne% = 50.0 * m.colortv_ma
colortv_nf% = 50.0 * m.colortv_ma
colortv_ng = colortv_el(255, 255, 255)
colortv_nh = (colortv_na - colortv_lj).toStr()
colortv_ni = m.colortv_lz.get("ABeeZee", int(17.0*m.colortv_ma), false, false)
colortv_nj = {
"TargetRect": {
"x": colortv_nc%
"y": colortv_nd%
"w": colortv_ne%
"h": colortv_nf%
}
"Text": colortv_nh
"TextAttrs":{
"Color" : colortv_ng,
"Font" : colortv_ni,
"HAlign" : "HCenter",
"VAlign" : "VCenter",
"Direction" : "LeftToRight"
}
}
colortv_nk! = (m.colortv_nb - (colortv_na - colortv_lj)) / m.colortv_nb
if colortv_nk! >= 1 then
colortv_nl = "colortv_timer_16"
else if colortv_nk! >= 0.93 then
colortv_nl = "colortv_timer_15"
else if colortv_nk! >= 0.86 then
colortv_nl = "colortv_timer_14"
else if colortv_nk! >= 0.8 then
colortv_nl = "colortv_timer_13"
else if colortv_nk! >= 0.73 then
colortv_nl = "colortv_timer_12"
else if colortv_nk! >= 0.66 then
colortv_nl = "colortv_timer_11"
else if colortv_nk! >= 0.6 then
colortv_nl = "colortv_timer_10"
else if colortv_nk! >= 0.53 then
colortv_nl = "colortv_timer_9"
else if colortv_nk! >= 0.46 then
colortv_nl = "colortv_timer_8"
else if colortv_nk! >= 0.4 then
colortv_nl = "colortv_timer_7"
else if colortv_nk! >= 0.33 then
colortv_nl = "colortv_timer_6"
else if colortv_nk! >= 0.26 then
colortv_nl = "colortv_timer_5"
else if colortv_nk! >= 0.2 then
colortv_nl = "colortv_timer_4"
else if colortv_nk! >= 0.13 then
colortv_nl = "colortv_timer_3"
else if colortv_nk! >= 0.066 then
colortv_nl = "colortv_timer_2"
else
colortv_nl = "colortv_timer_1"
end if
colortv_nm = {
"Url": "pkg:/images/colortv/timer/" + colortv_nl + ".png"
"TargetRect": {
"x": colortv_nc%
"y": colortv_nd%
"w": colortv_ne%
"h": colortv_nf%
}
}
m.colortv_kn.SetLayer(10029, colortv_nm)
m.colortv_kn.SetLayer(10030, colortv_nj)
end function
function colortv_mk()
return {
"TargetRect": {
"x": m.colortv_mb
"y": m.colortv_mc
"w": int(4.0 * m.colortv_ma)
"h": int(154.0 * m.colortv_ma)
}
"color": "#ffcc0000"
}
end function
function colortv_mm()
return {
"TargetRect": {
"x": m.colortv_mb + int(4.0 * m.colortv_ma)
"y": m.colortv_mc
"w": int(626.0 * m.colortv_ma)
"h": int(154.0 * m.colortv_ma)
}
"color": "#ff000000"
}
end function
function colortv_mo(colortv_nn)
colortv_no = m.colortv_lz.getFont("ABeeZee", int(26.0*m.colortv_ma), false, false)
colortv_np = m.colortv_lz.get("ABeeZee", int(26.0*m.colortv_ma), false, false)
colortv_nq = m.colortv_mp(colortv_nn, colortv_no, 505.0 * m.colortv_ma)
return {
"TargetRect": {
"x": m.colortv_mb + int(24.0 * m.colortv_ma)
"y": m.colortv_mc + int(32.0 * m.colortv_ma)
"w": int(550.0 * m.colortv_ma)
"h": int(26.0 * m.colortv_ma)
}
"Text": colortv_nq
"TextAttrs":{
"Color" : "#ffffffff",
"Font" : colortv_np,
"HAlign" : "Left",
"VAlign" : "Top",
"TextDirection": "LeftToRight"
}
}
end function
function colortv_mq(colortv_nr, colortv_ns, colortv_nt)
if colortv_ns.GetOneLineWidth(colortv_nr, 10000) < colortv_nt
return colortv_nr
else
while colortv_ns.GetOneLineWidth(colortv_nr + "...", 10000) > colortv_nt
colortv_nr = left(colortv_nr, len(colortv_nr) - 1)
end while
end if
return colortv_nr + "...     "
end function
function colortv_ms(colortv_nu)
colortv_nv = m.colortv_lz.getFont("ABeeZee", int(17.0*m.colortv_ma), false, false)
colortv_nw = m.colortv_lz.get("ABeeZee", int(17.0*m.colortv_ma), false, false)
colortv_nx = m.colortv_mp(colortv_nu, colortv_nv, 1500.0 * m.colortv_ma)
return {
"TargetRect": {
"x": m.colortv_mb + int(24.0 * m.colortv_ma)
"y": m.colortv_mc + int(69.0 * m.colortv_ma)
"w": int(550.0 * m.colortv_ma)
"h": int(51.0 * m.colortv_ma)
}
"Text": colortv_nx
"TextAttrs":{
"Color" : "#ffffffff",
"Font" : colortv_nw,
"HAlign" : "Left",
"VAlign" : "Top",
"TextDirection": "LeftToRight"
}
}
end function
function colortv_mu(colortv_ny)
if colortv_ny = invalid then
colortv_ny = "pkg:/images/colortv/color_tv_grid_bg_placeholder.jpg"
end if
return {
"Url": colortv_ny
"TargetRect": {
"x": m.colortv_mb + int(629.0 * m.colortv_ma)
"y": m.colortv_mc
"w": int(308.0 * m.colortv_ma)
"h": int(154.0 * m.colortv_ma)
}
}
end function
function colortv_is(colortv_io as Object, colortv_fz as Object, colortv_il as Object) as Object
colortv_nz = NWM_VAST()
colortv_oa = colortv_nz.GetPrerollFromURL(colortv_io["ads"][0]["markupUrl"])
if colortv_oa = invalid then
return invalid
end if
colortv_c = {
colortv_it: colortv_ob
colortv_oc: colortv_od
colortv_oe: colortv_of
colortv_og: colortv_oh
colortv_oi: colortv_oj
colortv_ok: colortv_ol
colortv_om: colortv_on
colortv_oo: colortv_op
colortv_oq: colortv_or
colortv_os: colortv_ot
colortv_oa: colortv_oa
colortv_io: colortv_io
colortv_il: colortv_il
colortv_fz: colortv_fz
}
return colortv_c
end function
function colortv_ob() as Void
colortv_kn = m.colortv_oc()
colortv_kn.Show()
colortv_ou = m.colortv_oe()
colortv_ou.Play()
if m.colortv_io["type"] <> "video"
m.colortv_og(colortv_kn)
end if
while true
colortv_ix = wait(GetColorTVSDKTimerInterval(), m.colortv_bs)
colortv_iy = type(colortv_ix)
if colortv_iy = "roSGScreenEvent"
if colortv_ix.isScreenClosed() then
exit while
end if
else if colortv_iy = "roSGNodeEvent"
if colortv_ix.getNode() = "colorTvAdEvents" then
if colortv_ix.getField() = "closeAd" then
exit while
end if
end if
else if type(colortv_ix) = "roVideoPlayerEvent"
if colortv_ix.isFullResult()
exit while
else if colortv_ix.isPartialResult()
exit while
else if colortv_ix.isRequestFailed()
ColorTVSdkGetInstance().colortv_gf(m.colortv_io["placement"], "INTERNAL_SDK_ERROR", colortv_ix.getMessage())
exit while
else if colortv_ix.isStatusMessage() and colortv_ix.GetMessage() = "start of play"
m.colortv_oi(colortv_kn)
else if colortv_ix.isPlaybackPosition()
m.colortv_ok(colortv_kn, colortv_ix.GetIndex(), m.colortv_oa["length"])
m.colortv_om(colortv_ix.getIndex())
end if
else if type(colortv_ix) = "roImageCanvasEvent" and colortv_ix.isRemoteKeyPressed()
if m.colortv_oo(colortv_ix.GetIndex(), colortv_ou) then
exit while
end if
end if
ColorTVSdkGetInstance().timerTick()
end while
end function
function colortv_od()
m.colortv_bs = CreateObject("roMessagePort")
colortv_kn = CreateObject("roImageCanvas")
colortv_kn.SetMessagePort(m.colortv_bs)
colortv_kn.SetLayer(1, {"color": "#000000"})
return colortv_kn
end function
function colortv_of()
colortv_dd = CreateObject("roDeviceInfo")
colortv_ou = CreateObject("roVideoPlayer")
colortv_ou.SetMessagePort(m.colortv_bs)
colortv_ou.SetDestinationRect({colortv_ov:colortv_dd.GetDisplaySize().colortv_ov,colortv_ow:colortv_dd.GetDisplaySize().colortv_ow,colortv_ox:0,colortv_oy:0})
colortv_ou.SetPositionNotificationPeriod(1)
colortv_ou.AddContent(m.colortv_oa)
return colortv_ou
end function
function colortv_oj(colortv_kn as Object)
colortv_kn.ClearLayer(2)
colortv_kn.SetLayer(1, {"color": "#00000000", "CompositionMode": "Source"})
end function
function colortv_on(colortv_oz)
for each colortv_pa in m.colortv_oa["trackingEvents"]
if colortv_pa["time"] = colortv_oz
colortv_pb(colortv_pa)
end if
end for
end function
function colortv_op(colortv_pc, colortv_ou) as Boolean
if colortv_pc = 2 or colortv_pc = 0  'colortv_pd or colortv_pe
m.colortv_os()
return true
else if colortv_pc = 6 and m.colortv_io["type"] <> "video"
colortv_ou.pause()
if colortv_je(m.colortv_io["ads"][0]["actionButton"]["actionType"]) then
if m.colortv_oq() then
m.colortv_os()
m.colortv_io.colortv_lf = true
return true
else
colortv_ou.resume()
end if
else if m.colortv_io["ads"][0]["actionButton"]["actionType"] = "CLICK_TO_APPSTORE"
m.colortv_os()
m.colortv_io.colortv_lf = true
colortv_jg = m.colortv_io["ads"][0]
m.colortv_fz.colortv_p(colortv_jg["clickTracker"])
if colortv_jg["clickData"]["contentId"] <> invalid then
m.colortv_fz.colortv_ao(colortv_jg["clickData"]["channelId"], colortv_jg["clickData"]["contentId"])
else
m.colortv_fz.colortv_ak(colortv_jg["clickData"]["channelId"])
end if
return true
else if m.colortv_io["ads"][0]["actionButton"]["actionType"] = "CLICK_TO_CONTENT"
m.colortv_os()
colortv_jg = m.colortv_io["ads"][0]
m.colortv_io.colortv_lf = true
m.colortv_fz.colortv_ao(colortv_jg["clickData"]["channelId"], colortv_jg["clickData"]["contentId"])
return true
end if
end if
return false
end function
function colortv_ot()
for each colortv_pa in m.colortv_oa["trackingEvents"]
if colortv_pa["event"] = "CLOSE"
colortv_pb(colortv_pa)
end if
end for
if m.colortv_il <> invalid and m.colortv_il["adClosed"] <> invalid then
m.colortv_il["adClosed"](m.colortv_io["placement"])
end if
end function
sub colortv_oh(colortv_kn as Object)
colortv_pf = 720.0 / 1080.0
colortv_pg% = 1356.0 * colortv_pf
colortv_ph% = 902.0 * colortv_pf
colortv_pi% = 400.0 * colortv_pf
colortv_pj% = 100.0 * colortv_pf
colortv_pk = invalid
colortv_pl = m.colortv_io["ads"][0]
if colortv_je(colortv_pl["actionButton"]["actionType"]) then
colortv_pm% = colortv_pg% + 30 * colortv_pf
colortv_pn% = colortv_ph% + 4 * colortv_pf
colortv_po% = colortv_pg% + 30.0 * colortv_pf
colortv_pp% = colortv_ph% + 30.0 * colortv_pf
colortv_pq% = 40.0 * colortv_pf
colortv_pr% = 40.0 * colortv_pf
if colortv_pl["actionButton"]["actionType"] = "CLICK_TO_EMAIL" then
colortv_ps = "color_tv_icon_mail"
else if colortv_pl["actionButton"]["actionType"] = "CLICK_TO_CALL" then
colortv_ps = "color_tv_icon_phone"
else
colortv_ps = "color_tv_icon_sms"
end if
colortv_pk = {
"Url": "pkg:/images/colortv/" + colortv_ps + ".png"
"TargetRect": {
"x": colortv_po%
"y": colortv_pp%
"w": colortv_pr%
"h": colortv_pq%
}
}
else
colortv_pm% = colortv_pg%
colortv_pn% = colortv_ph%
end if
colortv_pt = colortv_el(colortv_pl["actionButton"]["backgroundRed"], colortv_pl["actionButton"]["backgroundGreen"], colortv_pl["actionButton"]["backgroundBlue"])
colortv_pu = colortv_el(colortv_pl["actionButton"]["textRed"], colortv_pl["actionButton"]["textGreen"], colortv_pl["actionButton"]["textBlue"])
colortv_pv = {
"TargetRect": {
"x": colortv_pm%
"y": colortv_pn%
"w": colortv_pi%
"h": colortv_pj%
}
"Text": colortv_pl["actionButton"]["text"]
"TextAttrs":{
"Color" : colortv_pu,
"Font" : "Small",
"HAlign" : "HCenter",
"VAlign" : "VCenter",
"Direction" : "LeftToRight"
}
}
colortv_pw = {
"TargetRect": {
"x": colortv_pg%
"y": colortv_ph%
"w": colortv_pi%
"h": colortv_pj%
}
"color": colortv_pt
}
colortv_kn.SetLayer(20, colortv_pv)
colortv_kn.SetLayer(19, colortv_pw)
if colortv_pk <> invalid then
colortv_kn.SetLayer(21, colortv_pk)
end if
end sub
sub colortv_ol(colortv_kn as Object, colortv_lj as Integer, colortv_na as Integer)
colortv_pf = 720.0 / 1080.0
colortv_px% = 100.0 * colortv_pf
colortv_py% = 906.0 * colortv_pf
colortv_nd% = 902.0 * colortv_pf
colortv_pz% = 100.0 * colortv_pf
colortv_qa% = 100.0 * colortv_pf
colortv_ng = colortv_el(255, 255, 255)
colortv_nh = (colortv_na - colortv_lj).toStr()
colortv_nj = {
"TargetRect": {
"x": colortv_px%
"y": colortv_py%
"w": colortv_pz%
"h": colortv_qa%
}
"Text": colortv_nh
"TextAttrs":{
"Color" : colortv_ng,
"Font" : "Small",
"HAlign" : "HCenter",
"VAlign" : "VCenter",
"Direction" : "LeftToRight"
}
}
colortv_nk! = (colortv_na - colortv_lj) / colortv_na
if colortv_nk! >= 1 then
colortv_nl = "colortv_timer_1"
else if colortv_nk! >= 0.93 then
colortv_nl = "colortv_timer_2"
else if colortv_nk! >= 0.86 then
colortv_nl = "colortv_timer_3"
else if colortv_nk! >= 0.8 then
colortv_nl = "colortv_timer_4"
else if colortv_nk! >= 0.73 then
colortv_nl = "colortv_timer_5"
else if colortv_nk! >= 0.66 then
colortv_nl = "colortv_timer_6"
else if colortv_nk! >= 0.6 then
colortv_nl = "colortv_timer_7"
else if colortv_nk! >= 0.53 then
colortv_nl = "colortv_timer_8"
else if colortv_nk! >= 0.46 then
colortv_nl = "colortv_timer_9"
else if colortv_nk! >= 0.4 then
colortv_nl = "colortv_timer_10"
else if colortv_nk! >= 0.33 then
colortv_nl = "colortv_timer_11"
else if colortv_nk! >= 0.26 then
colortv_nl = "colortv_timer_12"
else if colortv_nk! >= 0.2 then
colortv_nl = "colortv_timer_13"
else if colortv_nk! >= 0.13 then
colortv_nl = "colortv_timer_14"
else if colortv_nk! >= 0.066 then
colortv_nl = "colortv_timer_15"
else
colortv_nl = "colortv_timer_16"
end if
colortv_nm = {
"Url": "pkg:/images/colortv/timer/" + colortv_nl + ".png"
"TargetRect": {
"x": colortv_px%
"y": colortv_nd%
"w": colortv_pz%
"h": colortv_qa%
}
}
colortv_kn.SetLayer(22, colortv_nm)
colortv_kn.SetLayer(23, colortv_nj)
end sub
function colortv_or()
colortv_iv = CreateObject("roSGScreen")
colortv_bs = CreateObject("roMessagePort")
colortv_iv.setMessagePort(colortv_bs)
colortv_iw = colortv_iv.CreateScene("colortv_subscriptionWindowWrapper")
colortv_iv.show()
colortv_iw.findNode("colorTvSubscriptionEvents").observeField("subscribed", colortv_bs)
colortv_iw.findNode("colorTvSubscriptionEvents").observeField("closed", colortv_bs)
colortv_iw.findNode("colorTvAdEvents").observeField("closeAd", colortv_bs)
colortv_iw["dataModel"] = m.colortv_io
while true
colortv_ix = wait(GetColorTVSDKTimerInterval(), colortv_bs)
colortv_iy = type(colortv_ix)
if colortv_iy = "roSGNodeEvent"
if colortv_ix.getNode() = "colorTvSubscriptionEvents" then
if colortv_ix.getField() = "subscribed" then
ColorTVSdkGetInstance().colortv_go(m.colortv_io, m.colortv_io["ads"][0], colortv_ix.getData())
else if colortv_ix.getField() = "closed"
return false
end if
else if colortv_ix.getNode() = "colorTvAdEvents" then
if colortv_ix.getField() = "closeAd" then
return true
end if
end if
end if
ColorTVSdkGetInstance().timerTick()
end while
end function
function colortv_pb(colortv_pa)
colortv_dp = true
colortv_qb = 3000
colortv_qc = CreateObject("roTimespan")
colortv_qc.Mark()
colortv_bs = CreateObject("roMessagePort")
colortv_qd = CreateObject("roURLTransfer")
colortv_qd.SetCertificatesFile("common:/certs/ca-bundle.crt")
colortv_qd.SetPort(colortv_bs)
colortv_qd.SetURL(colortv_pa["url"])
colortv_bh("~~~TRACKING: " + colortv_qd.GetURL())
if colortv_qd.AsyncGetToString()
colortv_ds = wait(colortv_qb, colortv_bs)
if colortv_ds = invalid
colortv_qd.AsyncCancel()
colortv_dp = false
else
colortv_bh("Req finished: " + colortv_qc.TotalMilliseconds().ToStr())
colortv_bh(colortv_ds.GetResponseCode().ToStr())
colortv_bh(colortv_ds.GetFailureReason())
end if
end if
return colortv_dp
end function