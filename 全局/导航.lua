--[[
    正则: 导航到?(附近的)?% , 带我去(附近的)?%

    目前仅支持调用百度地图和高德地图进行导航
]]
if runtime.DEBUG then
    -- args = {"北京"}
    -- args = {"浙江杭州"}
    runtime.command = "导航到附近的美食"
    args = {"附近的美食"}
end
site = args[1]

--使用百度地图导航
function navWithBaidu()
    local intent = Intent()
    intent.data = Uri.parse("baidumap://map/direction?destination=" .. site .. "&src=andr.baidu.openAPIdemo")
    intent.addFlags(Intent.FLAG_ACTIVITY_NEW_DOCUMENT) -- 即使在APP内,也可跳转
    app.startActivity(intent)
end

--使用百度地图搜索附近
function searchNearbyBaidu()
    local intent = Intent()
    intent.data = Uri.parse("baidumap://map/place/nearby?query=" .. site .. "&src=andr.baidu.openAPIdemo")
    intent.addFlags(Intent.FLAG_ACTIVITY_NEW_DOCUMENT) -- 即使在APP内,也可跳转
    app.startActivity(intent)
end

--使用高德地图导航
function navWithAmap()
    local intent = Intent()
    intent.data = Uri.parse("androidamap://keywordNavi?sourceApplication=softname&keyword=" .. site .. "&style=2")
    intent.setAction(Intent.ACTION_VIEW)
    intent.addCategory(Intent.CATEGORY_DEFAULT)
    intent.addFlags(Intent.FLAG_ACTIVITY_NEW_DOCUMENT) -- 即使在APP内,也可跳转
    app.startActivity(intent)
end

--使用高德地图搜索附近
function searchNearbyAmap()
    local intent = Intent()
    intent.data = Uri.parse("androidamap://arroundpoi?sourceApplication=softname&keywords=" .. site .. "&dev=0")
    intent.setAction(Intent.ACTION_VIEW)
    intent.addCategory(Intent.CATEGORY_DEFAULT)
    intent.addFlags(Intent.FLAG_ACTIVITY_NEW_DOCUMENT) -- 即使在APP内,也可跳转
    app.startActivity(intent)
end

if getAppInfo("com.baidu.BaiduMap") then --安装了百度地图
    if (matchValues(runtime.command, "%附近的%")) then
        searchNearbyBaidu()
    else
        navWithBaidu()
    end
elseif getAppInfo("com.autonavi.minimap") then --安装了高德地图
    if (matchValues(runtime.command, "%附近的%")) then
        searchNearbyAmap()
    else
        navWithAmap()
    end
else
    speak("请安装百度地图或高德地图")
end
