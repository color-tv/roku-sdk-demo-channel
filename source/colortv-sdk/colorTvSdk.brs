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
}
return colortv_c
end function
function colortv_g(colortv_aw as String) as Void
colortv_ax = m.colortv_d + "/ad/req"
colortv_ay = "GET"
colortv_az = {
"app": m.colortv_e
"placement": colortv_aw
}
colortv_ba = m.colortv_l(colortv_ax, colortv_ay, colortv_az)
colortv_bb = colortv_ba.GetResponseCode()
colortv_bc = (colortv_bb = 200)
colorTvSdk = ColorTVSdkGetInstance()
if not colortv_bc then
colortv_bd("Failure reason: " + colortv_ba.GetFailureReason())
colortv_be = {
"errorMessage": colortv_ba.GetFailureReason()
"error": colortv_bb.toStr()
}
colorTvSdk.colortv_bf(colortv_be, colortv_aw)
else
colortv_bg = colortv_bh(colortv_ba.GetString())
if colortv_bg["type"] = "discovery" then
colortv_bi = m.colortv_h(colortv_aw)
colortv_bg["featuredAd"] = colortv_bi
end if
colorTvSdk.colortv_bf(colortv_bg, colortv_aw)
end if
end function
function colortv_i(colortv_aw as String) as Object
colortv_ax = m.colortv_d + "/ad/req"
colortv_ay = "GET"
colortv_az = {
"app": m.colortv_e
"placement": colortv_aw
"type": "featured"
}
colortv_ba = m.colortv_l(colortv_ax, colortv_ay, colortv_az)
colortv_bb = colortv_ba.GetResponseCode()
colortv_bc = (colortv_bb = 200)
colorTvSdk = ColorTVSdkGetInstance()
colortv_bj = ParseJson(colortv_ba.getString())
if colortv_bc and colortv_bj["error"] = invalid and colortv_bj["ads"] <> invalid then
return colortv_bj["ads"][0]
end if
return invalid
end function
function colortv_k(colortv_ax as String)
colortv_ba = m.colortv_l(colortv_ax, "GET", invalid)
colortv_bb = colortv_ba.GetResponseCode()
colortv_bc = (colortv_bb = 200)
colorTvSdk = ColorTVSdkGetInstance()
colortv_bj = colortv_bh(colortv_ba.getString())
if colortv_bc and colortv_bj["error"] = invalid and (colortv_bj["ads"] <> invalid or colortv_bj["recommendations"] <> invalid) then
return colortv_bj
end if
return invalid
end function
function colortv_o(colortv_ax as String, colortv_bk as String, colortv_bl as String)
colortv_az = "{""" + colortv_bl + """:""" + colortv_bk + """}"
colortv_ba = m.colortv_l(colortv_ax, "POST", colortv_az)
end function
function colortv_m(colortv_ax as String, colortv_ay as String, colortv_az as Dynamic)
colortv_bm = CreateObject("roUrlTransfer")
if colortv_ay = "GET" and colortv_az <> invalid and colortv_az.count() > 0 then
colortv_ax = colortv_bn(colortv_ax, colortv_az)
end if
colortv_bd("URL: " + colortv_ax)
colortv_bm.setUrl(colortv_ax)
colortv_bm.setRequest(colortv_ay)
colortv_bm.retainBodyOnError(true)
colortv_bm.SetCertificatesFile ("common:/certs/ca-bundle.crt")
colortv_bo = CreateObject("roMessagePort")
colortv_bm.SetPort(colortv_bo)
if m.colortv_bp <> invalid then
colortv_bm.addHeader("CTV-SessionId", m.colortv_bp["sessionId"])
end if
if colortv_ay = "GET" or colortv_ay = "PUT" then
colortv_bm.AsyncGetToString()
else if colortv_ay = "POST" then
colortv_bm.addHeader("Content-Type", "application/json")
colortv_bm.AsyncPostFromString(colortv_az)
else
colortv_bd("Request method not supported: " + colortv_ay)
return invalid
end if
colortv_ba =  wait(0,colortv_bo)
colortv_bd("Response code: " + StrI(colortv_ba.GetResponseCode()))
colortv_bd("Response body: " + colortv_ba.GetString())
return colortv_ba
end function
function colortv_q(colortv_ax as String)
m.colortv_l(colortv_ax, "GET", invalid)
end function
sub colortv_s(colortv_e as String, colortv_bq as String, sdkVersion as String)
if colortv_br("installed", "colortv") <> invalid then
return
end if
colortv_bd("Registering app install for version " + colortv_bs())
colortv_bt("installed", "true", "colortv")
colortv_az = "{""sdkVersion"":""" + sdkVersion + """, ""appVersion"":""" + colortv_bs() + """}"
colortv_bu = m.colortv_d + "/app/inst/" + colortv_e + "?deviceid=" + colortv_bq
colortv_ba = m.colortv_l(colortv_bu, "POST", colortv_az)
end sub
function colortv_u() as Void
colortv_bd("Starting session")
colortv_ax = m.colortv_d + "/app/sess/" + m.colortv_e
colortv_bv = colortv_bn(colortv_ax, {"state" : "start"})
colortv_bw = colortv_bx()
m.colortv_ag(colortv_bw)
colortv_by = FormatJson(colortv_bw)
colortv_ba = m.colortv_l(colortv_bv, "POST", colortv_by)
m.colortv_bp = colortv_bz(colortv_ba.GetString())
m.colortv_x()
end function
sub colortv_y()
colortv_ca = ColorTVSdkGetInstance()
colortv_cb = colortv_cc()
if m.colortv_bp <> invalid then
colortv_cb = m.colortv_bp["pingInterval"] * 1000
end if
colortv_cd = colortv_ce(colortv_cb , {colortv_c: m}, function(colortv_cf as Dynamic) as Void
colortv_cf.colortv_c.colortv_v()
end function)
colortv_ca.colortv_cg(colortv_cd)
end sub
sub colortv_w()
if m.colortv_bp = invalid then
m.colortv_t()
return
end if
colortv_ax = m.colortv_d + "/app/sess/"
colortv_bw = colortv_bx()
m.colortv_ag(colortv_bw)
colortv_by = FormatJson(colortv_bw)
colortv_ba = m.colortv_l(colortv_ax, "PUT", colortv_by)
m.colortv_bp = colortv_bz(colortv_ba.GetString())
m.colortv_x()
end sub
sub colortv_aa(colortv_ch)
if colortv_ch <> invalid then
if colortv_ci().count() <> 0 then
if not m.colortv_af then
m.colortv_af = true
m.colortv_ad(colortv_ch)
end if
end if
end if
end sub
sub colortv_ae(colortv_ch)
colortv_ca = ColorTVSdkGetInstance()
colortv_cb = 5 * 1000
colortv_cj = colortv_ce(colortv_cb , {colortv_c: m, colortv_ck: colortv_ch}, function(colortv_cf as Dynamic) as Void
colortv_cf.colortv_c.colortv_ab(colortv_cf.colortv_ck)
colortv_cf.colortv_c.colortv_af = false
end function)
colortv_ca.colortv_cg(colortv_cj)
end sub
sub colortv_ac(colortv_ch)
colortv_cl = colortv_ci()
if colortv_cl.count() = 0 then
colortv_bd("No urls to poll currency")
return
end if
colortv_cm = []
colortv_cn = []
colortv_bo = CreateObject("roMessagePort")
for each colortv_ax in colortv_cl
colortv_bd("polling for currency for url: " + colortv_ax)
colortv_bm = CreateObject("roUrlTransfer")
colortv_bm.setUrl(colortv_ax)
colortv_bm.setRequest("GET")
colortv_bm.retainBodyOnError(true)
colortv_bm.SetCertificatesFile ("common:/certs/ca-bundle.crt")
colortv_bm.SetPort(colortv_bo)
if m.colortv_bp <> invalid then
colortv_bm.addHeader("CTV-SessionId", m.colortv_bp["sessionId"])
end if
colortv_cm.push(colortv_bm)
colortv_cn.push({colortv_ax: colortv_ax, id: colortv_bm.getIdentity()})
end for
for each colortv_co in colortv_cm
colortv_co.AsyncGetToString()
end for
colortv_cp = []
for each colortv_co in colortv_cm
colortv_ba =  wait(0,colortv_bo)
colortv_cp.push(colortv_ba)
end for
for each colortv_ba in colortv_cp
colortv_ax = ""
for each colortv_cq in colortv_cn
if colortv_cq.id = colortv_ba.getSourceIdentity() then
colortv_ax = colortv_cq.colortv_ax
exit for
end if
end for
colortv_bd("Response code for url " + colortv_ax + ": " + StrI(colortv_ba.GetResponseCode()))
colortv_bd("Response body: " + colortv_ba.GetString())
colortv_bb = colortv_ba.GetResponseCode()
colortv_bc = (colortv_bb = 200)
if colortv_bc then
colortv_cr = ParseJson(colortv_ba.GetString())
if colortv_cr["status"] = "true" then
colortv_cs(colortv_ax)
if colortv_ch <> invalid then
colortv_ch(colortv_cr["currencyType"], colortv_cr["currencyAmount"].toInt(), colortv_cr["placement"])
else
colortv_bd("Currency polling succeeded, result: {placement: " + colortv_cr["placement"] + ", currencyType: " + colortv_cr["currencyType"] + ", currencyAmount: " + colortv_cr["currencyAmount"] + "}")
end if
end if
end if
end for
end sub
sub colortv_ah(colortv_ct)
colortv_cu = colortv_br("userAge", "colortv")
colortv_cv = colortv_br("userGender", "colortv")
colortv_cw = colortv_br("userKeywords", "colortv")
colortv_cx = {}
if colortv_cu <> invalid then
colortv_cx["userAge"] = colortv_cu
end if
if colortv_cv <> invalid then
colortv_cx["userGender"] = colortv_cv
end if
if colortv_cw <> invalid then
colortv_cx["userKeywords"] = colortv_cw
end if
if colortv_cx.count() = 0 then return
colortv_ct["user"] = colortv_cx
end sub
function colortv_aj(colortv_cy)
colortv_bu = m.colortv_d + "/ad/info/" + m.colortv_e
colortv_cz = CreateObject("roDeviceInfo")
colortv_bq = colortv_cz.GetAdvertisingId()
for each colortv_e in colortv_cy
colortv_az = {
"identifierForAds": colortv_bq
"rokuAppId": colortv_e
}
m.colortv_l(colortv_bu, "POST", FormatJson(colortv_az))
end for
end function
sub colortv_al(colortv_e as String)
colortv_da = colortv_db()
colortv_ax = "http://" + colortv_da + ":8060/install/" + colortv_e
m.colortv_l(colortv_ax, "POST", "")
end sub
sub colortv_ap(colortv_e as String, colortv_dc as String)
colortv_dd = m.colortv_am()
if colortv_e = "11" or colortv_dd.doesExist(colortv_e) then
colortv_de = "launch"
else
colortv_de = "install"
end if
colortv_da = colortv_db()
colortv_ax = "http://" + colortv_da + ":8060/" + colortv_de + "/" + colortv_e + "?contentID=" + colortv_dc
m.colortv_l(colortv_ax, "POST", "")
end sub
function colortv_an() as Object
colortv_da = colortv_db()
colortv_ax = "http://" + colortv_da + ":8060/query/apps"
colortv_cr = m.colortv_l(colortv_ax, "GET", invalid)
colortv_df = CreateObject("roXMLElement")
if not colortv_df.Parse(colortv_cr) then
return {}
else
colortv_dg = {}
colortv_dh = colortv_df.getbody()
colortv_dh.ResetIndex()
colortv_di = colortv_dh.GetIndex()
while colortv_di <> invalid
colortv_dj = {
"name": colortv_di.getBody()
"type": colortv_di.getAttributes()["type"]
"version": colortv_di.getAttributes()["version"]
"id": colortv_di.getAttributes()["id"]
}
colortv_dg.AddReplace(colortv_di.getAttributes()["id"], colortv_dj)
colortv_di = colortv_dh.GetIndex()
end while
return colortv_dg
end if
end function
function colortv_ar(colortv_aw as String, colortv_dk="" as String) as Void
colortv_ax = m.colortv_d + "/ct/rec/" + m.colortv_e + "/" + colortv_aw
if colortv_dk <> invalid and colortv_dk <> "" then
colortv_ax += "?videoId="
colortv_ax += colortv_dk
end if
colortv_ay = "GET"
colortv_ba = m.colortv_l(colortv_ax, colortv_ay, invalid)
colortv_bb = colortv_ba.GetResponseCode()
colortv_bc = (colortv_bb = 200)
colorTvSdk = ColorTVSdkGetInstance()
if not colortv_bc then
colortv_bd("Failure reason: " + colortv_ba.GetFailureReason())
colortv_be = {
"errorMessage": colortv_ba.GetFailureReason()
"error": colortv_bb.toStr()
}
colorTvSdk.colortv_dl(colortv_be, colortv_aw)
else
colortv_dm = colortv_bh(colortv_ba.GetString())
colorTvSdk.colortv_dl(colortv_dm, colortv_aw)
end if
end function
function colortv_at(colortv_ax as String)
colortv_bw = colortv_bx()
m.colortv_ag(colortv_bw)
colortv_by = FormatJson(colortv_bw)
m.colortv_l(colortv_ax, "POST", colortv_by)
end function
function colortv_av(colortv_dk as String, colortv_dn as String, colortv_az as Object)
colortv_ax = m.colortv_d + "/ct/evt/" + m.colortv_e + "/" + colortv_dk
colortv_ay = "POST"
if colortv_az = invalid then
colortv_az = {}
end if
colortv_do = {
"videoId": colortv_dk
"eventType": colortv_dn
}
colortv_az.append(colortv_do)
colortv_ba = m.colortv_l(colortv_ax, colortv_ay, FormatJson(colortv_az))
colortv_bb = colortv_ba.GetResponseCode()
colortv_bc = (colortv_bb = 200)
if not colortv_bc then
colortv_bd("Failed to report video tracking event because of: " + colortv_ba.GetFailureReason())
end if
end function
Function colortv_br(colortv_dp, colortv_dq=invalid)
if colortv_dq = invalid then colortv_dq = "Default"
colortv_dr = CreateObject("roRegistrySection", colortv_dq)
if colortv_dr.Exists(colortv_dp) then return colortv_dr.Read(colortv_dp)
return invalid
End Function
Function colortv_bt(colortv_dp, colortv_ds, colortv_dq=invalid)
if colortv_dq = invalid then colortv_dq = "Default"
colortv_dr = CreateObject("roRegistrySection", colortv_dq)
colortv_dr.Write(colortv_dp, colortv_ds)
colortv_dr.Flush() 'colortv_dt colortv_du
End Function
Function colortv_dv(colortv_dp, colortv_dq=invalid)
if colortv_dq = invalid then colortv_dq = "Default"
colortv_dr = CreateObject("roRegistrySection", colortv_dq)
colortv_dr.Delete(colortv_dp)
colortv_dr.Flush() 'colortv_dt colortv_du
End Function
Function isvalidstr(colortv_dw As Dynamic) As String
if colortv_dx(colortv_dw) return colortv_dw
return ""
End Function
Function colortv_dy(colortv_dw as dynamic) As Boolean
if colortv_dw = invalid return false
if GetInterface(colortv_dw, "ifString") = invalid return false
return true
End Function
Function colortv_dx(colortv_dw)
if colortv_dz(colortv_dw) return false
return true
End Function
Function colortv_dz(colortv_dw)
if colortv_dw = invalid return true
if not colortv_dy(colortv_dw) return true
if Len(colortv_dw) = 0 return true
return false
End Function
Sub colortv_bd(colortv_ea As Dynamic)
if ColorTVSdkGetInstance().colortv_eb then
colortv_ec = CreateObject("roDateTime")
print StrI(colortv_ec.getDayOfMonth()).Trim() + "." + StrI(colortv_ec.getMonth()).Trim() + "." StrI(colortv_ec.getYear()).Trim() + " " + StrI(colortv_ec.getHours()).Trim() + ":" + StrI(colortv_ec.getMinutes()).Trim() + ":" + StrI(colortv_ec.getSeconds()).Trim() + ":" + StrI(colortv_ec.getMilliseconds()).Trim() + ": " + colortv_ea.toStr().Trim()
end if
End Sub
function colortv_ed(colortv_ee as Integer) as String
if colortv_ee < 0 then
colortv_ee = 0
end if
colortv_ef = StrI(colortv_ee, 16)
if(colortv_ee < 16) then
colortv_ef = "0" + colortv_ef
end if
return colortv_ef
end function
function colortv_eg(colortv_eh as Integer, colortv_ei as Integer, colortv_ej as Integer) as String
colortv_ek = "#ff" + colortv_ed(colortv_eh) + colortv_ed(colortv_ei) + colortv_ed(colortv_ej)
return colortv_ek
end function
function colortv_bs() as String
colortv_el = CreateObject("roAppInfo")
return colortv_el.GetVersion()
end function
function colortv_em() as LongInteger
colortv_en = CreateObject("roDateTime")
colortv_eo& = colortv_en.asSeconds() * 1000&
colortv_eo& += colortv_en.getMilliseconds()
return colortv_eo&
end function
function colortv_ep(colortv_eq as String) as LongInteger
if not colortv_er(colortv_eq) then
return invalid
end if
colortv_es = 0&
for colortv_et = 0 to colortv_eq.len() - 1
colortv_es += colortv_eq.mid(colortv_eq.len() - 1 - colortv_et, 1).toInt() * 10&^colortv_et
end for
return colortv_es
end function
function colortv_er(colortv_eu) as Boolean
colortv_ev = CreateObject("roRegex", "^\d+$", "")
return colortv_ev.isMatch(colortv_eu)
end function
function colortv_db() as String
colortv_cz = CreateObject("roDeviceInfo")
colortv_ew = colortv_cz.getIpAddrs()
colortv_ex = colortv_ew.keys()
for each colortv_dp in colortv_ex
return colortv_ew[colortv_dp]
end for
return invalid
end function
function colortv_ey(colortv_ez, colortv_fa)
for colortv_et = 0 to colortv_fa.count() - 1
if colortv_fb(colortv_ez, colortv_fa[colortv_et]) then
return colortv_et
end if
end for
return invalid
end function
function colortv_fb(colortv_fc, colortv_fd)
if type(colortv_fc) = "roAssociativeArray" and type(colortv_fd) = "roAssociativeArray" then
if colortv_fc.equals = invalid or colortv_fd.equals = invalid then
print "Objects have to implement 'equals' method in order to be comparable"
end if
return colortv_fc.equals(colortv_fd)
end if
return colortv_fc = colortv_fd
end function
function colortv_bn(colortv_ax as String, colortv_fe as Object) as String
colortv_ff = colortv_fe.keys()
colortv_ax = colortv_ax + "?"
for each colortv_dp in colortv_ff
colortv_ax = colortv_ax + colortv_dp + "=" + colortv_fe[colortv_dp] + "&"
end for
colortv_ax = colortv_ax.left(colortv_ax.len() - 1)
return colortv_ax
end function
function colortv_bx() as Dynamic
colortv_fg = CreateObject("roDeviceInfo")
colortv_el = CreateObject("roAppInfo")
colortv_bw = {
"deviceModel": colortv_fg.GetModel()
"systemVersion": colortv_fg.GetVersion()
"systemName": colortv_fg.GetModelDetails().VendorName
"identifierForAds": colortv_fg.GetAdvertisingId()
"identifierForVendor": colortv_fg.GetPublisherId()
"language": colortv_fg.GetCurrentLocale()
"timezone": colortv_fg.GetTimeZone()
"appName": colortv_el.GetTitle()
"appVersion": colortv_el.GetVersion()
"sdkVersion": GetColorTVSDKVersion()
}
return colortv_bw
end function
function colortv_ci() as Dynamic
colortv_fh = colortv_br("pollingUrls", "colortv")
if colortv_fh = invalid then
return []
end if
colortv_fi = ParseJson(colortv_fh)
colortv_fj = colortv_fi.Keys()
colortv_cl = []
colortv_fk = 24 * 60 * 60 * 1000
colortv_fl = false
for each colortv_dp in colortv_fj
colortv_fm = colortv_ep(colortv_dp)
if colortv_fm <> invalid then
if colortv_fm + colortv_fk < colortv_em() then
colortv_fl = true
colortv_fi.delete(colortv_dp)
else
colortv_cl.push(colortv_fi[colortv_dp])
end if
end if
end for
if colortv_fl then
colortv_fn(colortv_fi)
end if
return colortv_cl
end function
function colortv_fn(colortv_fi)
colortv_fo = FormatJson(colortv_fi)
colortv_bt("pollingUrls", colortv_fo, "colortv")
end function
sub colortv_cs(colortv_ax)
colortv_fh = colortv_br("pollingUrls", "colortv")
if colortv_fh = invalid then
return
end if
colortv_fi = ParseJson(colortv_fh)
colortv_fj = colortv_fi.Keys()
for each colortv_dp in colortv_fj
if colortv_fi[colortv_dp] = colortv_ax then
colortv_fi.delete(colortv_dp)
end if
end for
colortv_fn(colortv_fi)
end sub
function ColorTvSdk(colortv_e as String) as Object
colortv_fp = ColorTVSdkGetInstance()
if colortv_fp <> invalid then
print "Color TV SDK has already been initialized"
return colortv_fp
end if
print "Color TV SDK initialized with appid " + colortv_e
colortv_c = {
colortv_e: colortv_e
sdkVersion: GetColorTVSDKVersion()
colortv_eb: false
registerAdCallbacks: colortv_fq
registerContentRecommendationCallbacks: colortv_fr
setDebugMode: colortv_fs
colortv_ft: colortv_a(colortv_e)
colortv_r: colortv_fu
colortv_fv: {}
loadAd: colortv_fw
colortv_bf: colortv_fx
showAd: colortv_fy
colortv_fz: colortv_ga
colortv_gb: colortv_gc
colortv_gd: colortv_ge
colortv_gf: colortv_gg
colortv_j: colortv_gh
colortv_gi: colortv_gj
colortv_z: colortv_gk
colortv_gl: []
timerTick: colortv_gm
colortv_cg: colortv_gn
colortv_go: colortv_gp
setUserAge: colortv_gq
setUserGender: colortv_gr
setUserKeywords: colortv_gs
colortv_gt: colortv_gu
colortv_gv: colortv_gw
colortv_gx: {}
loadContentRecommendation: colortv_gy
colortv_dl: colortv_gz
colortv_ha: colortv_hb
showContentRecommendation: colortv_hc
trackVideoEvents: colortv_hd
}
GetGlobalAA()["colorTvSdkInstance"] = colortv_c
colortv_c.colortv_r()
colortv_c.colortv_ft.colortv_t()
colortv_c.colortv_go()
return colortv_c
end function
function colortv_fq(colortv_he as Object)
m.colortv_he = colortv_he
m.colortv_z()
end function
function colortv_fr(colortv_hf)
m.colortv_hf = colortv_hf
end function
function colortv_fs(colortv_eb as Boolean)
m.colortv_eb = colortv_eb
end function
function colortv_fu()
colortv_cz = CreateObject("roDeviceInfo")
colortv_bq = colortv_cz.GetAdvertisingId()
m.colortv_ft.colortv_r(m.colortv_e, colortv_bq, m.sdkVersion)
end function
function colortv_fw(colortv_aw as String) as Void
colortv_bd("loading ad for placement " + colortv_aw)
if m.colortv_fv.DoesExist(colortv_aw) then
colortv_bd("Ad for placement: " + colortv_aw + " is already loaded")
if m.colortv_he <> invalid and m.colortv_he["adLoaded"] <> invalid then
m.colortv_he["adLoaded"](colortv_aw)
end if
return
end if
m.colortv_ft.colortv_f(colortv_aw)
end function
function colortv_fx(colortv_hg as Object, colortv_aw as String) as Void
if colortv_hg.DoesExist("error") then
m.colortv_fz(colortv_aw, colortv_hg["error"], colortv_hg["errorMessage"])
else
colortv_bd("Ad has been loaded for placement: " + colortv_aw)
m.colortv_fv.AddReplace(colortv_aw, colortv_hg)
if m.colortv_he <> invalid and m.colortv_he["adLoaded"] <> invalid then
m.colortv_he["adLoaded"](colortv_aw)
end if
end if
end function
sub colortv_fy(colortv_aw as String)
if not colortv_hh(colortv_aw, m.colortv_fv)
m.colortv_fv.delete(colortv_aw)
return
end if
colortv_hg = m.colortv_fv[colortv_aw]
m.colortv_fv.delete(colortv_aw)
if colortv_hg["type"] = "discovery" then
for colortv_et = 0 to colortv_hg["ads"].count() - 1
if colortv_hg["ads"][colortv_et]["pollingUrl"] <> invalid then
colortv_hi(colortv_hg["ads"][colortv_et]["pollingUrl"])
end if
end for
else
colortv_hi(colortv_hg["ads"][0]["pollingUrl"])
end if
if colortv_hg["type"] = "video" or colortv_hg["ads"][0]["markupUrl"] <> invalid then
colortv_hj = colortv_hk(colortv_hg, m.colortv_ft, m.colortv_he)
if colortv_hj = invalid then
m.colortv_fz(colortv_aw, "INTERNAL_SDK_ERROR", "Can't play video ad with URL: " + colortv_hg["ads"][0]["markupUrl"])
return
end if
colortv_hj.colortv_hl()
end if
if colortv_hg["type"] <> "video" and not colortv_hm(colortv_hg) then
colortv_hn = CreateObject("roSGScreen")
colortv_ho = m.colortv_gb(colortv_hn, colortv_hg["type"])
colortv_hn.show()
m.colortv_gd(colortv_ho, colortv_hg)
colortv_ho["dataModel"] = colortv_hg
while true
colortv_hp = wait(GetColorTVSDKTimerInterval(), m.colortv_bo)
colortv_hq = type(colortv_hp)
if colortv_hq = "roSGScreenEvent"
if colortv_hp.isScreenClosed() then
exit while
end if
else if colortv_hq = "roSGNodeEvent"
if m.colortv_gf(colortv_hp, colortv_hg, colortv_ho) then
exit while
end if
end if
m.timerTick()
end while
if m.colortv_he <> invalid then
m.colortv_ft.colortv_z(m.colortv_he["currencyEarned"])
end if
end if
end sub
function colortv_ga(colortv_aw as String, colortv_hr as String, colortv_hs as String)
if m.colortv_he <> invalid and m.colortv_he["adError"] <> invalid then
colortv_be = {
"placement": colortv_aw
"errorCode": colortv_hr
"errorMessage": colortv_hs
}
m.colortv_he["adError"](colortv_be)
else
colortv_bd("Ad error has occured for placement: """ + colortv_aw + """ with code: """ + colortv_hr + """ and message: """ + colortv_hs + """")
end if
end function
function colortv_gc(colortv_hn as Object, colortv_ht as String)
m.colortv_bo = CreateObject("roMessagePort")
colortv_hn.setMessagePort(m.colortv_bo)
colortv_ho = colortv_hn.CreateScene("colortv_" + colortv_ht)
return colortv_ho
end function
function colortv_ge(colortv_ho as Object, colortv_hu as Object)
if colortv_ho.findNode("colorTvAdEvents") <> invalid then
colortv_ho.findNode("colorTvAdEvents").observeField("closeAd", m.colortv_bo)
colortv_ho.findNode("colorTvAdEvents").observeField("adShown", m.colortv_bo)
end if
if colortv_hu["type"] = "engagement" or colortv_hu["type"] = "interstitial" then
colortv_hv = colortv_hu["ads"][0]["actionButton"]["actionType"]
if colortv_hw(colortv_hv) then
colortv_ho.findNode("colorTvSubscriptionEvents").observeField("subscribed", m.colortv_bo)
else if colortv_hx(colortv_hv) then
colortv_ho.findNode("colorTvAppstoreEvents").observeField("clicked", m.colortv_bo)
end if
else if colortv_hu["type"] = "discovery" then
colortv_ho.findNode("colorTvGridEvents").observeField("closed", m.colortv_bo)
colortv_ho.findNode("colorTvGridEvents").observeField("impression", m.colortv_bo)
colortv_ho.findNode("colorTvGridEvents").observeField("moreDataUrl", m.colortv_bo)
colortv_ho.findNode("colorTvDiscoveryCenterEvents").observeField("clicked", m.colortv_bo)
colortv_ho.findNode("colorTvDiscoveryCenterEvents").observeField("subscribed", m.colortv_bo)
end if
end function
function colortv_gg(colortv_hp as Object, colortv_hg as Object, colortv_ho as Object) as Boolean
colortv_aw = colortv_hg["placement"]
if colortv_hp.getNode() = "colorTvAdEvents" then
if colortv_hp.getField() = "closeAd" then
if m.colortv_he <> invalid and m.colortv_he["adClosed"] <> invalid and colortv_aw <> invalid then
m.colortv_he["adClosed"](colortv_aw)
end if
return true
else if colortv_hp.getField() = "adShown" then
m.colortv_ft.colortv_p(colortv_hg["ads"][0]["impressionUrl"])
end if
else if colortv_hp.getNode() = "colorTvSubscriptionEvents" then
if colortv_hp.getField() = "subscribed" then
m.colortv_gi(colortv_hg, colortv_hg["ads"][0], colortv_hp.getData())
end if
else if colortv_hp.getNode() = "colorTvAppstoreEvents" then
if colortv_hp.getField() = "clicked" then
m.colortv_ft.colortv_p(colortv_hg["ads"][0]["clickTracker"])
if m.colortv_he <> invalid and m.colortv_he["adClosed"] <> invalid then
m.colortv_he["adClosed"](colortv_aw)
end if
colortv_hy = colortv_hg["ads"][0]
if colortv_hy["type"] = "appstore" then
if colortv_hy["clickData"]["contentId"] <> invalid then
m.colortv_ft.colortv_ao(colortv_hy["clickData"]["channelId"], colortv_hy["clickData"]["contentId"])
else
m.colortv_ft.colortv_ak(colortv_hy["clickData"]["channelId"])
end if
else if colortv_hy["type"] = "content"
m.colortv_ft.colortv_ao(colortv_hy["clickData"]["channelId"], colortv_hy["clickData"]["contentId"])
end if
return true
end if
else if colortv_hp.getNode() = "colorTvGridEvents" then
if colortv_hp.getField() = "impression" and colortv_hp.getData() <> ""
m.colortv_ft.colortv_p(colortv_hp.getData())
else if colortv_hp.getField() = "moreDataUrl" and colortv_hp.getData() <> "" then
m.colortv_j(colortv_ho, colortv_hp.getData())
else if colortv_hp.getField() = "closed" then
if m.colortv_he <> invalid and m.colortv_he["adClosed"] <> invalid and colortv_aw <> invalid then
m.colortv_he["adClosed"](colortv_aw)
end if
return true
end if
else if colortv_hp.getNode() = "colorTvDiscoveryCenterEvents" then
if colortv_hp.getField() = "subscribed" then
colortv_hz = colortv_hp.getData()["clickedItemModel"]
colortv_ia = colortv_hp.getData()["inputValue"]
m.colortv_gi(colortv_hg, colortv_hz, colortv_ia)
else if colortv_hp.getField() = "clicked"
colortv_hy = colortv_hp.getData()
if colortv_hy["clickTracker"] <> invalid then
m.colortv_ft.colortv_p(colortv_hy["clickTracker"])
end if
if m.colortv_he <> invalid and m.colortv_he["adClosed"] <> invalid then
m.colortv_he["adClosed"](colortv_aw)
end if
if colortv_hy["type"] = "appstore" then
if colortv_hy["clickData"]["contentId"] <> invalid then
m.colortv_ft.colortv_ao(colortv_hy["clickData"]["channelId"], colortv_hy["clickData"]["contentId"])
else
m.colortv_ft.colortv_ak(colortv_hy["clickData"]["channelId"])
end if
else if colortv_hy["type"] = "content"
m.colortv_ft.colortv_ao(colortv_hy["clickData"]["channelId"], colortv_hy["clickData"]["contentId"])
end if
return true
end if
end if
return false
end function
function colortv_gh(colortv_ho as Dynamic, colortv_ib as String)
colortv_ic = m.colortv_ft.colortv_j(colortv_ib)
if colortv_ic <> invalid then
if colortv_ho["dataModel"]["ads"] <> invalid then
colortv_id = colortv_ho["dataModel"]["ads"]
colortv_id.append(colortv_ic["ads"])
colortv_ic["ads"] = colortv_id
colortv_ho["dataModel"] = colortv_ic
else if colortv_ho["dataModel"].colortv_ie <> invalid then
colortv_id = colortv_ho["dataModel"].colortv_ie
colortv_id.append(colortv_ic.colortv_ie)
colortv_ic.colortv_ie = colortv_id
colortv_ho["dataModel"] = colortv_ic
end if
end if
colortv_ho.findNode("colorTvGridEvents")["moreDataUrl"] = ""
end function
function colortv_gj(colortv_if as Dynamic, colortv_hy as Dynamic, colortv_ig as String) as Void
colortv_if.colortv_ih(colortv_ig)
m.colortv_ft.colortv_n(colortv_hy["clickTracker"], colortv_ig, colortv_hy["type"])
if colortv_hy["clickUrl"] <> invalid then
m.colortv_ft.colortv_n(colortv_hy["clickUrl"], colortv_ig, colortv_hy["type"])
else if colortv_hy["clickData"]["clickUrl"] <> invalid then
m.colortv_ft.colortv_n(colortv_hy["clickData"]["clickUrl"], colortv_ig, colortv_hy["type"])
end if
end function
function colortv_gk()
if m.colortv_he <> invalid then
m.colortv_ft.colortv_z(m.colortv_he["currencyEarned"])
end if
end function
sub colortv_gm()
colortv_ii = []
for each colortv_ij in m.colortv_gl
if colortv_ij.colortv_ik() then
colortv_ii.push(colortv_ij)
end if
end for
for each colortv_cj in colortv_ii
m.colortv_gl.delete( colortv_ey(colortv_cj, m.colortv_gl) )
end for
end sub
function colortv_gn(colortv_cj as Dynamic) as Void
m.colortv_gl.push(colortv_cj)
end function
function colortv_gp()
colortv_il = m.colortv_ft.colortv_am()
colortv_im = colortv_il.keys()
colortv_in = colortv_io()
colortv_bt("installedApps", FormatJson(colortv_il), "colortv")
colortv_ip = []
for each colortv_iq in colortv_in
for each colortv_dp in colortv_il.keys()
if colortv_dp = colortv_iq then
colortv_ip.push(colortv_dp)
end if
end for
end for
for each colortv_e in colortv_ip
colortv_ir = colortv_ey(colortv_e, colortv_im)
colortv_im.delete(colortv_ir)
end for
colortv_bd("Apps that weren't saved yet: " + FormatJson(colortv_im))
m.colortv_ft.colortv_ai(colortv_im)
end function
sub colortv_gq(colortv_is)
if Type(colortv_is) = "roInt" Or Type(colortv_is) = "roInteger" or Type(colortv_is) = "Integer"
colortv_is = colortv_is.toStr()
else if not ((Type(colortv_is) = "roString" Or Type(colortv_is) = "String") and colortv_er(colortv_is)) then
print "WARNING: Value passed as user age is not a number"
return
end if
colortv_bt("userAge", colortv_is, "colortv")
end sub
sub colortv_gr(colortv_it as String)
if not (LCase(colortv_it) = "male" or LCase(colortv_it) = "female") then
print "WARNING: Value passed as user gender is neither male nor female"
return
end if
colortv_bt("userGender", LCase(colortv_it), "colortv")
end sub
sub colortv_gs(colortv_iu as String)
colortv_bt("userKeywords", colortv_iu, "colortv")
end sub
function colortv_gw(colortv_iv as String, colortv_bl as String) as Void
colortv_bd("Saving: " + colortv_iv + ", " + colortv_bl)
colortv_bt("subscription_" + colortv_bl, colortv_iv, "colortv")
end function
function colortv_gu(colortv_bl as String) as Dynamic
return colortv_br("subscription_" + colortv_bl, "colortv")
end function
sub colortv_gy(colortv_aw, colortv_iw="" as String)
colortv_bd("loading content recommendation for placement " + colortv_aw)
if m.colortv_gx.DoesExist(colortv_aw) then
colortv_bd("Content recommendation for placement: " + colortv_aw + " is already loaded")
if m.colortv_hf <> invalid and m.colortv_hf["contentRecommendationLoaded"] <> invalid then
m.colortv_hf["contentRecommendationLoaded"](colortv_aw)
end if
return
end if
m.colortv_ft.colortv_aq(colortv_aw, colortv_iw)
end sub
function colortv_gz(colortv_ix as Object, colortv_aw as String) as Void
if colortv_ix.DoesExist("error") then
m.colortv_ha(colortv_aw, colortv_ix["errorCode"].toStr(), colortv_ix["error"])
else
colortv_bd("Content recommendation has been loaded for placement: " + colortv_aw)
m.colortv_gx.AddReplace(colortv_aw, colortv_ix)
if m.colortv_hf <> invalid and m.colortv_hf["contentRecommendationLoaded"] <> invalid then
m.colortv_hf["contentRecommendationLoaded"](colortv_aw)
end if
end if
end function
function colortv_hb(colortv_aw as String, colortv_hr as String, colortv_hs as String)
if m.colortv_hf <> invalid and m.colortv_hf["contentRecommendationError"] <> invalid then
colortv_be = {
"placement": colortv_aw
"errorCode": colortv_hr
"errorMessage": colortv_hs
}
m.colortv_hf["contentRecommendationError"](colortv_be)
else
colortv_bd("Content recommendation error has occured for placement: """ + colortv_aw + """ with code: """ + colortv_hr + """ and message: """ + colortv_hs + """")
end if
end function
sub colortv_hc(colortv_aw as String)
if not colortv_iy(colortv_aw, m.colortv_gx)
m.colortv_gx.delete(colortv_aw)
return
end if
colortv_ix = m.colortv_gx[colortv_aw]
m.colortv_gx.delete(colortv_aw)
colortv_hn = CreateObject("roSGScreen")
colortv_ho = m.colortv_gb(colortv_hn, "contentRecommendation")
colortv_hn.show()
colortv_ho.findNode("colorTvGridEvents").observeField("moreDataUrl", m.colortv_bo)
colortv_ho.findNode("colorTvGridEvents").observeField("impression", m.colortv_bo)
colortv_ho.findNode("colorTvGridEvents").observeField("closed", m.colortv_bo)
colortv_ho.findNode("colorTvContentRecommendationEvents").observeField("clicked", m.colortv_bo)
colortv_ho.findNode("colorTvContentRecommendationEvents").observeField("favourite", m.colortv_bo)
colortv_ho.findNode("colorTvDiscoveryCenterEvents").observeField("clicked", m.colortv_bo)
colortv_ho.findNode("colorTvDiscoveryCenterEvents").observeField("subscribed", m.colortv_bo)
for colortv_et = 0 to colortv_ix["recommendations"].count() - 1
if colortv_ix["recommendations"][colortv_et]["pollingUrl"] <> invalid then
colortv_hi(colortv_ix["recommendations"][colortv_et]["pollingUrl"])
end if
end for
colortv_ho["dataModel"] = colortv_ix
while true
colortv_hp = wait(GetColorTVSDKTimerInterval(), m.colortv_bo)
colortv_hq = type(colortv_hp)
if colortv_hq = "roSGScreenEvent"
if colortv_hp.isScreenClosed() then
exit while
end if
else if colortv_hq = "roSGNodeEvent"
if colortv_hp.getNode() = "colorTvContentRecommendationEvents" then
if colortv_hp.getField() = "clicked" then
colortv_hy = colortv_hp.getData()
if colortv_hy["clickTracker"] <> invalid then
m.colortv_ft.colortv_p(colortv_hy["clickTracker"])
end if
if m.colortv_hf <> invalid and m.colortv_hf["contentRecommendationClicked"] <> invalid then
m.colortv_hf["contentRecommendationClicked"](colortv_aw, colortv_hy["partnerVideoId"])
end if
exit while
else if colortv_hp.getField() = "favourite" and colortv_hp.getData() <> "" then
m.colortv_ft.colortv_as(colortv_hp.getData())
end if
else if colortv_hp.getNode() = "colorTvGridEvents" then
if colortv_hp.getField() = "impression" and colortv_hp.getData() <> ""
m.colortv_ft.colortv_p(colortv_hp.getData())
else if colortv_hp.getField() = "moreDataUrl" and colortv_hp.getData() <> "" then
m.colortv_j(colortv_ho, colortv_hp.getData())
else if colortv_hp.getField() = "closed" then
if m.colortv_hf <> invalid and m.colortv_hf["contentRecommendationClosed"] <> invalid then
m.colortv_hf["contentRecommendationClosed"](colortv_aw)
end if
exit while
end if
else if colortv_hp.getNode() = "colorTvDiscoveryCenterEvents" then
if colortv_hp.getField() = "subscribed" then
colortv_hz = colortv_hp.getData()["clickedItemModel"]
colortv_ia = colortv_hp.getData()["inputValue"]
m.colortv_gi(colortv_ix, colortv_hz, colortv_ia)
else if colortv_hp.getField() = "clicked"
colortv_hy = colortv_hp.getData()
if colortv_hy["clickTracker"] <> invalid then
m.colortv_ft.colortv_p(colortv_hy["clickTracker"])
end if
if m.colortv_hf <> invalid and m.colortv_hf["contentRecommendationClosed"] <> invalid then
m.colortv_hf["contentRecommendationClosed"](colortv_aw)
end if
if colortv_hy["type"] = "appstore" then
if colortv_hy["clickData"]["contentId"] <> invalid then
m.colortv_ft.colortv_ao(colortv_hy["clickData"]["channelId"], colortv_hy["clickData"]["contentId"])
else
m.colortv_ft.colortv_ak(colortv_hy["clickData"]["channelId"])
end if
else if colortv_hy["type"] = "content"
m.colortv_ft.colortv_ao(colortv_hy["clickData"]["channelId"], colortv_hy["clickData"]["contentId"])
end if
exit while
end if
end if
end if
m.timerTick()
end while
end sub
function colortv_hd(colortv_dk as String, colortv_dn as Object)
if type(colortv_dn) = "roSGNodeEvent" then
if colortv_dn.getField() = "state" then
if colortv_dn.getData() = "playing" and (m.colortv_iz = invalid or not m.colortv_iz.colortv_ja) then
if m.colortv_iz = invalid then
m.colortv_iz = {}
end if
m.colortv_iz.colortv_ja = true
m.colortv_iz["watchedSeconds"] = 0
m.colortv_ft.colortv_au(colortv_dk, "VIDEO_STARTED", m.colortv_iz)
else if colortv_dn.getData() = "stopped"  and m.colortv_iz <> invalid then
m.colortv_ft.colortv_au(colortv_dk, "VIDEO_STOPPED", m.colortv_iz)
m.colortv_iz = invalid
else if colortv_dn.getData() = "finished"
m.colortv_ft.colortv_au(colortv_dk, "VIDEO_COMPLETED", m.colortv_iz)
m.colortv_iz = invalid
end if
else if colortv_dn.getField() = "position" then
colortv_jb% = colortv_dn.getData()
if m.colortv_iz = invalid then
m.colortv_iz = {}
end if
m.colortv_iz["watchedSeconds"] = colortv_jb%
end if
else if type(colortv_dn) = "roVideoPlayerEvent" or type(colortv_dn) = "roVideoScreenEvent" then
if colortv_dn.isStreamStarted() then
if m.colortv_jc = invalid or m.colortv_jc = false then
m.colortv_iz = { "watchedSeconds": colortv_dn.getIndex() }
m.colortv_ft.colortv_au(colortv_dk, "VIDEO_STARTED", m.colortv_iz)
end if
else if colortv_dn.isPlaybackPosition() then
if m.colortv_jc <> invalid and m.colortv_jc then
m.colortv_jc = false
colortv_jd = 0
if m.colortv_iz <> invalid and m.colortv_iz["watchedSeconds"] <> invalid then
colortv_jd = m.colortv_iz["watchedSeconds"]
end if
colortv_je = colortv_dn.getIndex()
colortv_jf = {"startSkipped": colortv_jd, "endSkipped": colortv_je}
m.colortv_ft.colortv_au(colortv_dk, "VIDEO_SKIPPED", colortv_jf)
end if
m.colortv_iz = { "watchedSeconds": colortv_dn.getIndex() }
else if colortv_dn.isFullResult() then
m.colortv_ft.colortv_au(colortv_dk, "VIDEO_COMPLETED", m.colortv_iz)
m.colortv_iz = invalid
else if colortv_dn.isPartialResult() and m.colortv_iz <> invalid then
m.colortv_ft.colortv_au(colortv_dk, "VIDEO_STOPPED", m.colortv_iz)
m.colortv_iz = invalid
else if colortv_dn.isPaused() then
m.colortv_jc = true
else if colortv_dn.isResumed() then
m.colortv_jc = false
m.colortv_ft.colortv_au(colortv_dk, "VIDEO_PAUSED", m.colortv_iz)
m.colortv_ft.colortv_au(colortv_dk, "VIDEO_RESUMED", m.colortv_iz)
end if
else if type(colortv_dn) = "String" or type(colortv_dn) = "roString" then
if colortv_dn = "interrupted" and m.colortv_iz <> invalid then
m.colortv_ft.colortv_au(colortv_dk, "VIDEO_STOPPED", m.colortv_iz)
m.colortv_iz = invalid
end if
end if
end function
function ColorTVSdkGetInstance()
return GetGlobalAA()["colorTvSdkInstance"]
end function
function GetColorTVSDKVersion() as String
return "1.2.2"
end function
function GetColorTVSDKTimerInterval() as Integer
return 1000
end function
sub colortv_hi(colortv_jg)
if colortv_jg = invalid then
return
end if
colortv_fh = colortv_br("pollingUrls", "colortv")
if colortv_fh = invalid then
colortv_fh = "{}"
end if
colortv_fi = ParseJson(colortv_fh)
colortv_fi[colortv_em().toStr()] = colortv_jg
colortv_bt("pollingUrls", FormatJson(colortv_fi), "colortv")
end sub
function colortv_io()
colortv_jh = []
colortv_ji = colortv_br("installedApps", "colortv")
if colortv_ji <> invalid
colortv_jh = ParseJson(colortv_ji)
end if
return colortv_jh
end function
function colortv_hm(colortv_hg) as Boolean
return colortv_hg.colortv_jj <> invalid and colortv_hg.colortv_jj
end function
function colortv_hh(colortv_aw as String, colortv_fv as Object) as Boolean
if not colortv_fv.DoesExist(colortv_aw) then
colortv_bd("Ad for placement: " + colortv_aw + " isn't loaded. Please call loadAd function first.")
return false
else if not colortv_jk(colortv_fv[colortv_aw]) then
colortv_bd("Ad for placement: " + colortv_aw + " is not valid anymore. Please load the ad again.")
return false
end if
return true
end function
function colortv_iy(colortv_aw as String, colortv_jl as Object) as Boolean
if not colortv_jl.DoesExist(colortv_aw) then
colortv_bd("Content recommendation for placement: " + colortv_aw + " isn't loaded. Please call loadContentRecommendation function first.")
return false
else if not colortv_jk(colortv_jl[colortv_aw]) then
colortv_bd("Content recommendation for placement: " + colortv_aw + " is not valid anymore. Please load the content recommendation again.")
return false
end if
return true
end function
function colortv_jk(colortv_hg) as Boolean
colortv_jm = CreateObject("roDateTime")
colortv_jm.fromIso8601String(colortv_hg["validUntil"])
colortv_jn = CreateObject("roDateTime")
return colortv_jm.asSeconds() > colortv_jn.asSeconds()
end function
function colortv_hw(colortv_jo as String) as Boolean
return colortv_jo = "CLICK_TO_SMS" or colortv_jo = "CLICK_TO_CALL" or colortv_jo = "CLICK_TO_EMAIL"
end function
function colortv_hx(colortv_jo as String) as Boolean
return colortv_jo = "CLICK_TO_APPSTORE" or colortv_jo = "CLICK_TO_CONTENT"
end function
function colortv_bh(colortv_by as String) as Object
colortv_c = ParseJson(colortv_by)
if not colortv_c.DoesExist("error") then
colortv_jp = CreateObject("roDateTime")
colortv_jp.fromSeconds(colortv_jp.asSeconds() + colortv_c["validFor"])
colortv_c["validUntil"] = colortv_jp.toIsoString()
colortv_c.colortv_ih = colortv_jq
colortv_c["storedPhoneNumber"] = colortv_jr("phone")
colortv_c["storedEmailAddress"] = colortv_jr("email")
end if
return colortv_c
end function
function colortv_jr(colortv_bl)
return ColorTVSdkGetInstance().colortv_gt(colortv_bl)
end function
function colortv_jq(colortv_js as String) as Void
if colortv_js = invalid then
return
end if
colortv_jt = CreateObject("roRegex", "\A[^@]+@[^@]+\z", "")
colortv_ju = CreateObject("roRegex", "[\(]?[0-9]{3}[\)]?[ ]?[-]?[ ]?[0-9]{3}[ ]?[-]?[ ]?[0-9]{3,4}", "")
colortv_jv = invalid
if colortv_jt.isMatch(colortv_js) then
colortv_jv = "email"
else if colortv_ju.isMatch(colortv_js)
colortv_jv = "phone"
end if
if colortv_jv = invalid then
return
end if
colortv_jw = ColorTVSdkGetInstance()
colortv_jw.colortv_gv(colortv_js, colortv_jv)
end function
function colortv_bz(colortv_by) as Object
if colortv_by = invalid or Len(colortv_by) = 0
return invalid
end if
colortv_c = ParseJson(colortv_by)
if colortv_c = invalid then
return invalid
end if
if colortv_c["pingInterval"] = invalid then
colortv_c["pingInterval"] = colortv_cc()
end if
return colortv_c
end function
function colortv_cc()
return 60 * 1000
end function
function colortv_ce(colortv_jx as Double, colortv_fe as Dynamic, colortv_ck as Function)
colortv_c = {
colortv_ck: colortv_ck,
colortv_fe: colortv_fe,
colortv_ik: colortv_jy,
equals: colortv_jz
}
colortv_c.colortv_ka = colortv_em() + colortv_jx
return colortv_c
end function
function colortv_jy() as Boolean
colortv_kb = colortv_em()
if colortv_kb < m.colortv_ka then
return false
end if
if m.colortv_fe.isEmpty() then
m.colortv_ck()
else
m.colortv_ck(m.colortv_fe)
end if
return true
end function
function colortv_jz(colortv_kc as Dynamic) as Boolean
return m.colortv_ka = colortv_kc.colortv_ka and m.colortv_ck = colortv_kc.colortv_ck
end function
function colortv_hk(colortv_hg as Object, colortv_ft as Object, colortv_he as Object) as Object
colortv_kd = NWM_VAST()
colortv_ke = colortv_kd.GetPrerollFromURL(colortv_hg["ads"][0]["markupUrl"])
if colortv_ke = invalid then
return invalid
end if
colortv_c = {
colortv_hl: colortv_kf
colortv_kg: colortv_kh
colortv_ki: colortv_kj
colortv_kk: colortv_kl
colortv_km: colortv_kn
colortv_ko: colortv_kp
colortv_kq: colortv_kr
colortv_ks: colortv_kt
colortv_ku: colortv_kv
colortv_kw: colortv_kx
colortv_ke: colortv_ke
colortv_hg: colortv_hg
colortv_he: colortv_he
colortv_ft: colortv_ft
}
return colortv_c
end function
function colortv_kf() as Void
colortv_ky = m.colortv_kg()
colortv_ky.Show()
colortv_kz = m.colortv_ki()
colortv_kz.Play()
if m.colortv_hg["type"] <> "video"
m.colortv_kk(colortv_ky)
end if
while true
colortv_hp = wait(GetColorTVSDKTimerInterval(), m.colortv_bo)
colortv_hq = type(colortv_hp)
if colortv_hq = "roSGScreenEvent"
if colortv_hp.isScreenClosed() then
exit while
end if
else if colortv_hq = "roSGNodeEvent"
if colortv_hp.getNode() = "colorTvAdEvents" then
if colortv_hp.getField() = "closeAd" then
exit while
end if
end if
else if type(colortv_hp) = "roVideoPlayerEvent"
if colortv_hp.isFullResult()
exit while
else if colortv_hp.isPartialResult()
exit while
else if colortv_hp.isRequestFailed()
ColorTVSdkGetInstance().colortv_fz(m.colortv_hg["placement"], "INTERNAL_SDK_ERROR", colortv_hp.getMessage())
exit while
else if colortv_hp.isStatusMessage() and colortv_hp.GetMessage() = "start of play"
m.colortv_km(colortv_ky)
else if colortv_hp.isPlaybackPosition()
m.colortv_ko(colortv_ky, colortv_hp.GetIndex(), m.colortv_ke["length"])
m.colortv_kq(colortv_hp.getIndex())
end if
else if type(colortv_hp) = "roImageCanvasEvent" and colortv_hp.isRemoteKeyPressed()
if m.colortv_ks(colortv_hp.GetIndex(), colortv_kz) then
exit while
end if
end if
ColorTVSdkGetInstance().timerTick()
end while
end function
function colortv_kh()
m.colortv_bo = CreateObject("roMessagePort")
colortv_ky = CreateObject("roImageCanvas")
colortv_ky.SetMessagePort(m.colortv_bo)
colortv_ky.SetLayer(1, {"color": "#000000"})
return colortv_ky
end function
function colortv_kj()
colortv_cz = CreateObject("roDeviceInfo")
colortv_kz = CreateObject("roVideoPlayer")
colortv_kz.SetMessagePort(m.colortv_bo)
colortv_kz.SetDestinationRect({colortv_la:colortv_cz.GetDisplaySize().colortv_la,colortv_lb:colortv_cz.GetDisplaySize().colortv_lb,colortv_lc:0,colortv_ld:0})
colortv_kz.SetPositionNotificationPeriod(1)
colortv_kz.AddContent(m.colortv_ke)
return colortv_kz
end function
function colortv_kn(colortv_ky as Object)
colortv_ky.ClearLayer(2)
colortv_ky.SetLayer(1, {"color": "#00000000", "CompositionMode": "Source"})
end function
function colortv_kr(colortv_le)
for each colortv_lf in m.colortv_ke["trackingEvents"]
if colortv_lf["time"] = colortv_le
colortv_lg(colortv_lf)
end if
end for
end function
function colortv_kt(colortv_lh, colortv_kz) as Boolean
if colortv_lh = 2 or colortv_lh = 0  'colortv_li or colortv_lj
m.colortv_kw()
return true
else if colortv_lh = 6 and m.colortv_hg["type"] <> "video"
colortv_kz.pause()
if colortv_hw(m.colortv_hg["ads"][0]["actionButton"]["actionType"]) then
if m.colortv_ku() then
m.colortv_kw()
m.colortv_hg.colortv_jj = true
return true
else
colortv_kz.resume()
end if
else if m.colortv_hg["ads"][0]["actionButton"]["actionType"] = "CLICK_TO_APPSTORE"
m.colortv_kw()
m.colortv_hg.colortv_jj = true
colortv_hy = m.colortv_hg["ads"][0]
m.colortv_ft.colortv_p(colortv_hy["clickTracker"])
if colortv_hy["clickData"]["contentId"] <> invalid then
m.colortv_ft.colortv_ao(colortv_hy["clickData"]["channelId"], colortv_hy["clickData"]["contentId"])
else
m.colortv_ft.colortv_ak(colortv_hy["clickData"]["channelId"])
end if
return true
else if m.colortv_hg["ads"][0]["actionButton"]["actionType"] = "CLICK_TO_CONTENT"
m.colortv_kw()
colortv_hy = m.colortv_hg["ads"][0]
m.colortv_hg.colortv_jj = true
m.colortv_ft.colortv_ao(colortv_hy["clickData"]["channelId"], colortv_hy["clickData"]["contentId"])
return true
end if
end if
return false
end function
function colortv_kx()
for each colortv_lf in m.colortv_ke["trackingEvents"]
if colortv_lf["event"] = "CLOSE"
colortv_lg(colortv_lf)
end if
end for
if m.colortv_he <> invalid and m.colortv_he["adClosed"] <> invalid then
m.colortv_he["adClosed"](m.colortv_hg["placement"])
end if
end function
sub colortv_kl(colortv_ky as Object)
colortv_lk = 720.0 / 1080.0
colortv_ll% = 1356.0 * colortv_lk
colortv_lm% = 902.0 * colortv_lk
colortv_ln% = 400.0 * colortv_lk
colortv_lo% = 100.0 * colortv_lk
colortv_lp = invalid
colortv_lq = m.colortv_hg["ads"][0]
if colortv_hw(colortv_lq["actionButton"]["actionType"]) then
colortv_lr% = colortv_ll% + 30 * colortv_lk
colortv_ls% = colortv_lm% + 4 * colortv_lk
colortv_lt% = colortv_ll% + 30.0 * colortv_lk
colortv_lu% = colortv_lm% + 30.0 * colortv_lk
colortv_lv% = 40.0 * colortv_lk
colortv_lw% = 40.0 * colortv_lk
if colortv_lq["actionButton"]["actionType"] = "CLICK_TO_EMAIL" then
colortv_lx = "color_tv_icon_mail"
else if colortv_lq["actionButton"]["actionType"] = "CLICK_TO_CALL" then
colortv_lx = "color_tv_icon_phone"
else
colortv_lx = "color_tv_icon_sms"
end if
colortv_lp = {
"Url": "pkg:/images/colortv/" + colortv_lx + ".png"
"TargetRect": {
"x": colortv_lt%
"y": colortv_lu%
"w": colortv_lw%
"h": colortv_lv%
}
}
else
colortv_lr% = colortv_ll%
colortv_ls% = colortv_lm%
end if
colortv_ly = colortv_eg(colortv_lq["actionButton"]["backgroundRed"], colortv_lq["actionButton"]["backgroundGreen"], colortv_lq["actionButton"]["backgroundBlue"])
colortv_lz = colortv_eg(colortv_lq["actionButton"]["textRed"], colortv_lq["actionButton"]["textGreen"], colortv_lq["actionButton"]["textBlue"])
colortv_ma = {
"TargetRect": {
"x": colortv_lr%
"y": colortv_ls%
"w": colortv_ln%
"h": colortv_lo%
}
"Text": colortv_lq["actionButton"]["text"]
"TextAttrs":{
"Color" : colortv_lz,
"Font" : "Small",
"HAlign" : "HCenter",
"VAlign" : "VCenter",
"Direction" : "LeftToRight"
}
}
colortv_mb = {
"TargetRect": {
"x": colortv_ll%
"y": colortv_lm%
"w": colortv_ln%
"h": colortv_lo%
}
"color": colortv_ly
}
colortv_ky.SetLayer(20, colortv_ma)
colortv_ky.SetLayer(19, colortv_mb)
if colortv_lp <> invalid then
colortv_ky.SetLayer(21, colortv_lp)
end if
end sub
sub colortv_kp(colortv_ky as Object, colortv_jn as Integer, colortv_mc as Integer)
colortv_lk = 720.0 / 1080.0
colortv_md% = 100.0 * colortv_lk
colortv_me% = 906.0 * colortv_lk
colortv_mf% = 902.0 * colortv_lk
colortv_mg% = 100.0 * colortv_lk
colortv_mh% = 100.0 * colortv_lk
colortv_mi = colortv_eg(255, 255, 255)
colortv_mj = (colortv_mc - colortv_jn).toStr()
colortv_mk = {
"TargetRect": {
"x": colortv_md%
"y": colortv_me%
"w": colortv_mg%
"h": colortv_mh%
}
"Text": colortv_mj
"TextAttrs":{
"Color" : colortv_mi,
"Font" : "Small",
"HAlign" : "HCenter",
"VAlign" : "VCenter",
"Direction" : "LeftToRight"
}
}
colortv_ml! = (colortv_mc - colortv_jn) / colortv_mc
if colortv_ml! >= 1 then
colortv_mm = "colortv_timer_1"
else if colortv_ml! >= 0.93 then
colortv_mm = "colortv_timer_2"
else if colortv_ml! >= 0.86 then
colortv_mm = "colortv_timer_3"
else if colortv_ml! >= 0.8 then
colortv_mm = "colortv_timer_4"
else if colortv_ml! >= 0.73 then
colortv_mm = "colortv_timer_5"
else if colortv_ml! >= 0.66 then
colortv_mm = "colortv_timer_6"
else if colortv_ml! >= 0.6 then
colortv_mm = "colortv_timer_7"
else if colortv_ml! >= 0.53 then
colortv_mm = "colortv_timer_8"
else if colortv_ml! >= 0.46 then
colortv_mm = "colortv_timer_9"
else if colortv_ml! >= 0.4 then
colortv_mm = "colortv_timer_10"
else if colortv_ml! >= 0.33 then
colortv_mm = "colortv_timer_11"
else if colortv_ml! >= 0.26 then
colortv_mm = "colortv_timer_12"
else if colortv_ml! >= 0.2 then
colortv_mm = "colortv_timer_13"
else if colortv_ml! >= 0.13 then
colortv_mm = "colortv_timer_14"
else if colortv_ml! >= 0.066 then
colortv_mm = "colortv_timer_15"
else
colortv_mm = "colortv_timer_16"
end if
colortv_mn = {
"Url": "pkg:/images/colortv/timer/" + colortv_mm + ".png"
"TargetRect": {
"x": colortv_md%
"y": colortv_mf%
"w": colortv_mg%
"h": colortv_mh%
}
}
colortv_ky.SetLayer(22, colortv_mn)
colortv_ky.SetLayer(23, colortv_mk)
end sub
function colortv_kv()
colortv_hn = CreateObject("roSGScreen")
colortv_bo = CreateObject("roMessagePort")
colortv_hn.setMessagePort(colortv_bo)
colortv_ho = colortv_hn.CreateScene("colortv_subscriptionWindowWrapper")
colortv_hn.show()
colortv_ho.findNode("colorTvSubscriptionEvents").observeField("subscribed", colortv_bo)
colortv_ho.findNode("colorTvSubscriptionEvents").observeField("closed", colortv_bo)
colortv_ho.findNode("colorTvAdEvents").observeField("closeAd", colortv_bo)
colortv_ho["dataModel"] = m.colortv_hg
while true
colortv_hp = wait(GetColorTVSDKTimerInterval(), colortv_bo)
colortv_hq = type(colortv_hp)
if colortv_hq = "roSGNodeEvent"
if colortv_hp.getNode() = "colorTvSubscriptionEvents" then
if colortv_hp.getField() = "subscribed" then
ColorTVSdkGetInstance().colortv_gi(m.colortv_hg, m.colortv_hg["ads"][0], colortv_hp.getData())
else if colortv_hp.getField() = "closed"
return false
end if
else if colortv_hp.getNode() = "colorTvAdEvents" then
if colortv_hp.getField() = "closeAd" then
return true
end if
end if
end if
ColorTVSdkGetInstance().timerTick()
end while
end function
function colortv_lg(colortv_lf)
colortv_mo = true
colortv_mp = 3000
colortv_mq = CreateObject("roTimespan")
colortv_mq.Mark()
colortv_bo = CreateObject("roMessagePort")
colortv_mr = CreateObject("roURLTransfer")
colortv_mr.SetCertificatesFile("common:/certs/ca-bundle.crt")
colortv_mr.SetPort(colortv_bo)
colortv_mr.SetURL(colortv_lf["url"])
colortv_bd("~~~TRACKING: " + colortv_mr.GetURL())
if colortv_mr.AsyncGetToString()
colortv_dn = wait(colortv_mp, colortv_bo)
if colortv_dn = invalid
colortv_mr.AsyncCancel()
colortv_mo = false
else
colortv_bd("Req finished: " + colortv_mq.TotalMilliseconds().ToStr())
colortv_bd(colortv_dn.GetResponseCode().ToStr())
colortv_bd(colortv_dn.GetFailureReason())
end if
end if
return colortv_mo
end function