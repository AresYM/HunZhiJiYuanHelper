Ares = {};
Ares.InitStatus = -1;
Ares.ShowLog = true;
Ares.RootPath = "";
Ares.CharacterLibraryName = "hzjy";


-- 多点找色 并点击
function Ares.FindMultiColorWithTap(param,isTap)
    Ares.KeepScreen();
    local x = -1 y = -1 ret = -1;
    local sim = param[8];
    if sim == nil or sim == "" then 
        sim = 0.9
    end 
    local scanType = param[9];
    if scanType == nil or scanType == "" then 
        scanType = 0
    end 
    x, y, ret = findmulticolor(param[2],param[3],param[4],param[5],param[6],param[7],sim,scanType)
    if Ares.ShowLog then
        lineprint("多颜色查找结果【目标："..param[1].."】【x："..x.."】【y："..y.."】")  
    end
    if x>0 and y>0 then 
        if isTap == true then 
            Ares.Tap(x,y);
        end
        return true,x,y
    else 
        return false,-1,-1;
    end 
end

function Ares.KeepScreen(id)
    id = id or 0;
    releasecapture(id)
    keepcapture(id)
end


-- 找字 返回字体的坐标值
function Ares.FindText(param,characterLibraryName) -- 123
    
    local x = -1 y = -1 ret = -1; -- 找字
    if characterLibraryName == nil then
        characterLibraryName = Ares.CharacterLibraryName;
    end
    setdict(Ares.RootPath..characterLibraryName..".txt",0);
    
    usedict(0);
    x, y, ret = findtext(param[1],param[2],param[3],param[4],param[5],param[6],param[7]);
    if Ares.ShowLog then
        lineprint("文字查找结果【目标："..param[5].."】【x："..x.."】【y："..y.."】")  
    end
    return x, y, ret;
end

-- 多点找色
function Ares.FindMultiColor(param)
    local x = -1 y = -1 ret = -1;
    local sim = param[8];
    if sim == nil or sim == "" then 
        sim = 0.9
    end 
    
    local scanType = param[9];
    if scanType == nil or scanType == "" then 
        scanType = 0
    end 
    x, y, ret = findmulticolor(param[2],param[3],param[4],param[5],param[6],param[7],sim,scanType)
    if Ares.ShowLog then
        lineprint("多颜色查找结果【目标："..param[1].."】【x："..x.."】【y："..y.."】")  
    end
    return x, y, ret;
end





-- 多点找色
function Ares.FindMultiColorArray(param)
    local sim = param[8];
    if sim == nil or sim == "" then 
        sim = 0.9
    end 
    
    local scanType = param[9];
    if scanType == nil or scanType == "" then 
        scanType = 0
    end 
    local colors = findmulticolorex(param[2],param[3],param[4],param[5],param[6],param[7],sim,scanType);
    if colors == nil then
        return {}
    end
    local colorsArrar  = XM.Split(colors,"|");
    
    for i=1,#colorsArrar,1 do
        colorsArrar[i] = XM.Split(colorsArrar[i],",")
    end
    return colorsArrar;
end

-- 多点找色
function Ares.FindMultiColorEx(param,isTap)
    local x = -1 y = -1 ret = -1;
    x, y, ret = findmulticolor(param[2],param[3],param[4],param[5],param[6],param[7],param[8],param[9])
    if Ares.ShowLog then
        lineprint("多颜色查找结果【目标："..param[1].."】【x："..x.."】【y："..y.."】")  
    end
    
    return x, y, ret;
end

function Ares.FindColor(param)
    local x = -1 y = -1 ret = -1;
    x,y,ret = findcolor(param[2],param[3],param[4],param[5],param[6],param[7],param[8]);
    if Ares.ShowLog then
        lineprint("单颜色查找结果【目标："..param[1].."】【x："..x.."】【y："..y.."】")  
    end
    return x, y, ret;
end

function Ares.FindColorWithTap(param,isTap)
    
    Ares.KeepScreen();
    local x = -1 y = -1 ret = -1;
    x,y,ret = findcolor(param[2],param[3],param[4],param[5],param[6],param[7],param[8]);
    if Ares.ShowLog then
        lineprint("单颜色查找结果【目标："..param[1].."】【x："..x.."】【y："..y.."】")  
    end
    
    if x>0 and y>0 then 
        if isTap == true then 
            Ares.Tap(x,y);
        end
        return true,x,y
    else 
        return false,-1,-1;
    end 
end



function Ares.FindPic(param)
    local x1 = -1 y1 = -1 ret1 = -1; -- 找字
    x1, y1, ret1 = findpic(param[2],param[3],param[4],param[5],Ares.RootPath,param[6],param[7],param[8],param[9]);
    
    if Ares.ShowLog then
        lineprint("图片查找结果【目标："..param[6].."】【x："..x.."】【y："..y.."】".."【path：】"..Ares.RootPath..param[6])  
    end
    return x1, y1, ret1;
end


function  Ares.LongTap(x,y,seconds,id)
    id = id or 0;
    seconds = seconds or 1;
    touchdown(x,y,id);
    if seconds == nil or seconds == "" then
        seconds = 1;
    end
    if seconds ~= 0 then
        Ares.Sleep(seconds)
    end
    touchup(id)
end

-- 防封点击
function Ares.Tap(x,y,repeatTimes)
    local offset = math.random(-2,2);
    local _x = x + 2; -- + offset;
    local _y = y + 2; -- + offset;
    if Ares.ShowLog then
        lineprint("随机点击结果【x："..x.."】【y："..y.."】【偏移值："..offset.."】")
    end
    if repeatTimes ~= nil and repeatTimes > 1 then
        for i=1,repeatTimes,1 do
            tap(_x,_y);
            Ares.Sleep(1);
            if Ares.ShowLog then
                lineprint("已点击"..i.."次");
            end
        end
    else
        tap(_x,_y);
    end
    sleep(1000)
end

-- 配置项点击
function Ares.TapFormFeature(param)
    if param[4] == true then 
        Ares.LongTap(param[1],param[2],param[3],param[5])
    else
        Ares.Tap(param[1],param[2],param[3])
    end
end


function Ares.Sleep(seconds)
    if seconds == nil or seconds == 0 then
        seconds = 1
    end
    sleep(seconds * 1000);
end

-- 获取资源目录的路径
function Ares.GetResourcePath()
    local fullPath = getrcpath("rc:main.png");
    if fullPath == nil then
        if Ares.ShowLog then
            lineprint("获取根目录结果：没有获取到")
        end
        return nil;
    end
    local pathSplits = XM.Split(fullPath,"/");
    local splitsLength = table.getn(pathSplits);
    local sourcePath = "";
    for i=0,splitsLength-1,1 do
        if pathSplits[i] ~= nil then
            sourcePath = sourcePath..pathSplits[i].."/";
        end
    end
    if Ares.ShowLog then
        lineprint("获取根目录结果："..sourcePath)
    end
    return sourcePath;
end

-- httpGet 方法
function Ares.HttpGet(url)	
    local response = httprequest("get",url,"","utf-8"); 
    return response;
end


function Ares.MessageBox(message,seconds)
    if seconds == nil then
        seconds = 1
    end
    messageboxex(message,seconds * 1000,10,1280,0,25);
    Ares.Sleep(seconds);
    messageboxex("",0,0,0,0,0);
end

Ares.Json = {};
 
Ares.Net = {};

function Ares.Net.UrlEncode(s)
    s = string.gsub(s, "([^%w%.%- ])", function(c) 
    return string.format("%%%02X", string.byte(c)) end)    
    return string.gsub(s, " ", "+")
end


function Ares.Net.UrlDecode(s)    
    s = string.gsub(s, '%%(%x%x)', function(h) 
    return string.char(tonumber(h, 16)) end)    
    return s
end


-- 初始化函数 必须要执行一下
function Ares.Init()
    -- 设置资源根目录
    Ares.RootPath = Ares.GetResourcePath();
    Ares.InitStatus = 1;
end
