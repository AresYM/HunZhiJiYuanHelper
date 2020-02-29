Ares2 = (function()
    local _ares = {};
    _ares.ShowLog = true;
    _ares.CharacterLibraryName = "hzjy";
    
    
    _ares.RootPath = "";
    
        
    _ares.Sleep = function(seconds)
        if seconds == nil or seconds == 0 then
            seconds = 1
        end
        sleep(seconds * 1000);
    end
    
    _ares.Json = (function()
        local json = {_version = "0.1.2"}
        local encode
        local escape_char_map = {
            ["\\"] = "\\\\",
            ["\""] = "\\\"",
            ["\b"] = "\\b",
            ["\f"] = "\\f",
            ["\n"] = "\\n",
            ["\r"] = "\\r",
            ["\t"] = "\\t",
        }
        local escape_char_map_inv = {["\\/"] = "/"}
        for k, v in pairs(escape_char_map) do
            escape_char_map_inv[v] = k
        end
        local function escape_char(c)
            return escape_char_map[c] or string.format("\\u%04x", c:byte())
        end
        local function encode_nil(val)
            return "null"
        end
        local function encode_table(val, stack)
            local res = {}
            stack = stack or {}
            -- Circular reference?
            if stack[val] then error("circular reference") end
            stack[val] = true
            if rawget(val, 1) ~= nil or next(val) == nil then
                -- Treat as array -- check keys are valid and it is not sparse
                local n = 0
                for k in pairs(val) do
                    if type(k) ~= "number" then
                        error("invalid table: mixed or invalid key types")
                    end
                    n = n + 1
                end
                if n ~= #val then
                    error("invalid table: sparse array")
                end
                -- Encode
                for i, v in ipairs(val) do
                    table.insert(res, encode(v, stack))
                end
                stack[val] = nil
                return "[" .. table.concat(res, ",") .. "]"
            
            else
                -- Treat as an object
                for k, v in pairs(val) do
                    if type(k) ~= "string" then
                        error("invalid table: mixed or invalid key types")
                    end
                    table.insert(res, encode(k, stack) .. ":" .. encode(v, stack))
                end
                stack[val] = nil
                return "{" .. table.concat(res, ",") .. "}"
            end
        end
        
        
        local function encode_string(val)
            return '"' .. val:gsub('[%z\1-\31\\"]', escape_char) .. '"'
        end
        
        
        local function encode_number(val)
            -- Check for NaN, -inf and inf
            if val ~= val or val <= -math.huge or val >= math.huge then
                error("unexpected number value '" .. tostring(val) .. "'")
            end
            return string.format("%.14g", val)
        end
        
        
        local type_func_map = {
            ["nil"] = encode_nil,
            ["table"] = encode_table,
            ["string"] = encode_string,
            ["number"] = encode_number,
            ["boolean"] = tostring,
        }
        
        
        encode = function(val, stack)
            local t = type(val)
            local f = type_func_map[t]
            if f then
                return f(val, stack)
            end
            error("unexpected type '" .. t .. "'")
        end
        
        
        function json.encode(val)
            return (encode(val))
        end
        
        
        -------------------------------------------------------------------------------
        -- Decode
        -------------------------------------------------------------------------------
        local parse
        
        local function create_set(...)
            local res = {}
            for i = 1, select("#", ...) do
                res[select(i, ...)] = true
            end
            return res
        end
        
        local space_chars = create_set(" ", "\t", "\r", "\n")
        local delim_chars = create_set(" ", "\t", "\r", "\n", "]", "}", ",")
        local escape_chars = create_set("\\", "/", '"', "b", "f", "n", "r", "t", "u")
        local literals = create_set("true", "false", "null")
        
        local literal_map = {
            ["true"] = true,
            ["false"] = false,
            ["null"] = nil,
        }
        
        
        local function next_char(str, idx, set, negate)
            for i = idx, #str do
                if set[str:sub(i, i)] ~= negate then
                    return i
                end
            end
            return #str + 1
        end
        
        
        local function decode_error(str, idx, msg)
            local line_count = 1
            local col_count = 1
            for i = 1, idx - 1 do
                col_count = col_count + 1
                if str:sub(i, i) == "\n" then
                    line_count = line_count + 1
                    col_count = 1
                end
            end
            error(string.format("%s at line %d col %d", msg, line_count, col_count))
        end
        
        
        local function codepoint_to_utf8(n)
            -- http://scripts.sil.org/cms/scripts/page.php?site_id=nrsi&id=iws-appendixa
            local f = math.floor
            if n <= 0x7f then
                return string.char(n)
            elseif n <= 0x7ff then
                return string.char(f(n / 64) + 192, n % 64 + 128)
            elseif n <= 0xffff then
                return string.char(f(n / 4096) + 224, f(n % 4096 / 64) + 128, n % 64 + 128)
            elseif n <= 0x10ffff then
                return string.char(f(n / 262144) + 240, f(n % 262144 / 4096) + 128,
                    f(n % 4096 / 64) + 128, n % 64 + 128)
            end
            error(string.format("invalid unicode codepoint '%x'", n))
        end
        local function parse_unicode_escape(s)
            local n1 = tonumber(s:sub(3, 6), 16)
            local n2 = tonumber(s:sub(9, 12), 16)
            -- Surrogate pair?
            if n2 then
                return codepoint_to_utf8((n1 - 0xd800) * 0x400 + (n2 - 0xdc00) + 0x10000)
            else
                return codepoint_to_utf8(n1)
            end
        end
        local function parse_string(str, i)
            local has_unicode_escape = false
            local has_surrogate_escape = false
            local has_escape = false
            local last
            for j = i + 1, #str do
                local x = str:byte(j)
                
                if x < 32 then
                    decode_error(str, j, "control character in string")
                end
                
                if last == 92 then -- "\\" (escape char)
                    if x == 117 then -- "u" (unicode escape sequence)
                        local hex = str:sub(j + 1, j + 5)
                        if not hex:find("%x%x%x%x") then
                            decode_error(str, j, "invalid unicode escape in string")
                        end
                        if hex:find("^[dD][89aAbB]") then
                            has_surrogate_escape = true
                        else
                            has_unicode_escape = true
                        end
                    else
                        local c = string.char(x)
                        if not escape_chars[c] then
                            decode_error(str, j, "invalid escape char '" .. c .. "' in string")
                        end
                        has_escape = true
                    end
                    last = nil
                
                elseif x == 34 then -- '"' (end of string)
                    local s = str:sub(i + 1, j - 1)
                    if has_surrogate_escape then
                        s = s:gsub("\\u[dD][89aAbB]..\\u....", parse_unicode_escape)
                    end
                    if has_unicode_escape then
                        s = s:gsub("\\u....", parse_unicode_escape)
                    end
                    if has_escape then
                        s = s:gsub("\\.", escape_char_map_inv)
                    end
                    return s, j + 1
                
                else
                    last = x
                end
            end
            decode_error(str, i, "expected closing quote for string")
        end
        local function parse_number(str, i)
            local x = next_char(str, i, delim_chars)
            local s = str:sub(i, x - 1)
            local n = tonumber(s)
            if not n then
                decode_error(str, i, "invalid number '" .. s .. "'")
            end
            return n, x
        end
        local function parse_literal(str, i)
            local x = next_char(str, i, delim_chars)
            local word = str:sub(i, x - 1)
            if not literals[word] then
                decode_error(str, i, "invalid literal '" .. word .. "'")
            end
            return literal_map[word], x
        end
        local function parse_array(str, i)
            local res = {}
            local n = 1
            i = i + 1
            while 1 do
                local x
                i = next_char(str, i, space_chars, true)
                -- Empty / end of array?
                if str:sub(i, i) == "]" then
                    i = i + 1
                    break
                end
                -- Read token
                x, i = parse(str, i)
                res[n] = x
                n = n + 1
                -- Next token
                i = next_char(str, i, space_chars, true)
                local chr = str:sub(i, i)
                i = i + 1
                if chr == "]" then break end
                if chr ~= "," then decode_error(str, i, "expected ']' or ','") end
            end
            return res, i
        end
        local function parse_object(str, i)
            local res = {}
            i = i + 1
            while 1 do
                local key, val
                i = next_char(str, i, space_chars, true)
                -- Empty / end of object?
                if str:sub(i, i) == "}" then
                    i = i + 1
                    break
                end
                -- Read key
                if str:sub(i, i) ~= '"' then
                    decode_error(str, i, "expected string for key")
                end
                key, i = parse(str, i)
                -- Read ':' delimiter
                i = next_char(str, i, space_chars, true)
                if str:sub(i, i) ~= ":" then
                    decode_error(str, i, "expected ':' after key")
                end
                i = next_char(str, i + 1, space_chars, true)
                -- Read value
                val, i = parse(str, i)
                -- Set
                res[key] = val
                -- Next token
                i = next_char(str, i, space_chars, true)
                local chr = str:sub(i, i)
                i = i + 1
                if chr == "}" then break end
                if chr ~= "," then decode_error(str, i, "expected '}' or ','") end
            end
            return res, i
        end
        local char_func_map = {
            ['"'] = parse_string,
            ["0"] = parse_number,
            ["1"] = parse_number,
            ["2"] = parse_number,
            ["3"] = parse_number,
            ["4"] = parse_number,
            ["5"] = parse_number,
            ["6"] = parse_number,
            ["7"] = parse_number,
            ["8"] = parse_number,
            ["9"] = parse_number,
            ["-"] = parse_number,
            ["t"] = parse_literal,
            ["f"] = parse_literal,
            ["n"] = parse_literal,
            ["["] = parse_array,
            ["{"] = parse_object,
        }
        parse = function(str, idx)
            local chr = str:sub(idx, idx)
            local f = char_func_map[chr]
            if f then
                return f(str, idx)
            end
            decode_error(str, idx, "unexpected character '" .. chr .. "'")
        end
        
        
        function json.decode(str)
            if type(str) ~= "string" then
                error("expected argument of type string, got " .. type(str))
            end
            local res, idx = parse(str, next_char(str, 1, space_chars, true))
            idx = next_char(str, idx, space_chars, true)
            if idx <= #str then
                decode_error(str, idx, "trailing garbage")
            end
            return res
        end
        json.Decode = json.decode;
        json.Parse = json.decode;
        
        return json
    end)();
    
    _ares.Http = (function()
        local http = {};
        http.Get = function(url)
            local response = httprequest("get", url, "", "utf-8");
            response = _ares.Json.Decode(response);
            return response;
        end
        
        
        http.UrlEncode = function(s)
            s = string.gsub(s, "([^%w%.%- ])", function(c)
                return string.format("%%%02X", string.byte(c)) end)
            return string.gsub(s, " ", "+")
        end
        
        http.UrlDecode = function(s)
            s = string.gsub(s, '%%(%x%x)', function(h)
                return string.char(tonumber(h, 16)) end)
            return s
        end
        return http;
    
    end)();
    
    
    _ares.KeepScreen = function(id)
        id = id or 0;
        releasecapture(id)
        keepcapture(id)
    end
    _ares.ScreenLock=function(id)
        id = id or 0;
        keepcapture(id)
    end

    _ares.ScreenUnLock = function (id)
        id = id or 0;
        releasecapture(id)
    end
    
    -- 防封点击
    _ares.Tap = function(x, y, repeatTimes)
        local offset = math.random(-2, 2);
        local _x = x + 2; -- + offset;
        local _y = y + 2; -- + offset;
        if Ares.ShowLog then
            lineprint("随机点击结果【x：" .. x .. "】【y：" .. y .. "】【偏移值：" .. offset .. "】")
        end
        if repeatTimes ~= nil and repeatTimes > 1 then
            for i = 1, repeatTimes, 1 do
                tap(_x, _y);
                Ares.Sleep(1);
                if Ares.ShowLog then
                    lineprint("已点击" .. i .. "次");
                end
            end
        else
            tap(_x, _y);
        end
        sleep(1000)
    end;
    
    _ares.LongTap = function(x, y, seconds, id)
        id = id or 0;
        seconds = seconds or 1;
        touchdown(x, y, id);
        if seconds == nil or seconds == "" then
            seconds = 1;
        end
        if seconds ~= 0 then
            Ares.Sleep(seconds)
        end
        touchup(id)
    end

    _ares.Swipe = function (x1,y1,x2,y2,id,R) --滑动
        R = R or 5
        local r 
        if id == 3 then 
            r = R
        else
            r = rnd(-1*R, R)
        end
        id = id or 1
        if id == 1 then	--随机滑动
            touchdown(x1 + r, y1 + r, 0)
            _ares.Sleep(3)
            touchmove(x2 + r, y2 + r, 0)
            _ares.Sleep(0.1)
            touchup(0)
        elseif id == 2 then	--捏合滑动
            local g1, g2
            x1 = x1 + r
            y1 = y1 + r
            x2 = x2 + r
            y2 = y2 + r
            touchdown(x1, y1, 0)
            touchdown(x2, y2, 1)
            g1 = ((x2 - x1) / 2) + x1
            g2 = ((y2 - y1) / 2) + y1
            touchmove(g1, g2, 0)
            touchmove(g1, g2, 1)
            touchup(0)
            touchup(1)
        elseif id == 3 then	--长按滑动
            touchdown(x1, y1, 0)
            _ares.Sleep(r)
            touchmove(x2, y2, 0)
            touchup(0)
        elseif id == 4 then	--匀速滑动
            local diff1 = x1-x2
            local diff2  = y1-y2
            R = R or 1
            if R < 1 then
               R = 1 
            end
            local time = (R-0.1)/0.3
            local count1 = diff1/time
            local count2 = diff2/time
            singletouchdown(x1,y1)
            for i = 1,time do
                singletouchmove(x1-(count1*(i-1)),y1-(count2*(i-1)),x1-(count1*(i)),y1-(count2*(i)))
            end
            _ares.Sleep(R)
            singletouchup(x2,y2)
        end
    end
    
    -- 配置项点击
    _ares.TapFormFeature = function(param)
        if param[4] == true then
            _ares.LongTap(param[1], param[2], param[3], param[5])
        else
            _ares.Tap(param[1], param[2], param[3])
        end
    end
    
    
    
    _ares.Find = (function()
        local find = {};
        find.MultiColor = function(param, isTap)
            local x = -1 y = -1 ret = -1;
            local sim = param[8];
            if sim == nil or sim == "" then
                sim = 0.9
            end
            local scanType = param[9];
            if scanType == nil or scanType == "" then
                scanType = 0
            end
            _ares.KeepScreen();
            x, y, ret = findmulticolor(param[2], param[3], param[4], param[5], param[6], param[7], sim, scanType)
            if _ares.ShowLog then
                lineprint("多颜色查找结果【目标：" .. param[1] .. "】【x：" .. x .. "】【y：" .. y .. "】")
            end
            if x > 0 and y > 0 then
                if isTap == true then
                    _ares.Tap(x, y);
                end
                return true, x, y
            else
                return false, -1, -1;
            end
        end;
        
        find.SingleColor = function(param, isTap)
            local x = -1 y = -1 ret = -1;
            local sim = param[7];
            if sim == nil or sim == "" then
                sim = 0.9
            end
            local scanType = param[8];
            if scanType == nil or scanType == "" then
                scanType = 0
            end
            _ares.KeepScreen();
            x, y, ret = findcolor(param[2], param[3], param[4], param[5], param[6], sim, scanType)
            if _ares.ShowLog then
                lineprint("多颜色查找结果【目标：" .. param[1] .. "】【x：" .. x .. "】【y：" .. y .. "】")
            end
            if x > 0 and y > 0 then
                if isTap == true then
                    _ares.Tap(x, y);
                end
                return true, x, y
            else
                return false, -1, -1;
            end
        end;
        
        find.Text = function(param, isTap, characterLibraryName)
            _ares.KeepScreen();

            local x = -1 y = -1 ret = -1; -- 找字
            local sim = param[7];
            if sim == nil or sim == "" then
                sim = 0.9
            end
            if characterLibraryName == nil then
                characterLibraryName = _ares.CharacterLibraryName;
            end
            setdict(_ares.RootPath .. characterLibraryName .. ".txt", 0);
            usedict(0);
            x, y, ret = findtext(param[1], param[2], param[3], param[4], param[5], param[6], sim);
            if _ares.ShowLog then
                lineprint("文字查找结果【目标：" .. param[5] .. "】【x：" .. x .. "】【y：" .. y .. "】")
            end
            if x > 0 and y > 0 then
                if isTap == true then
                    _ares.Tap(x, y);
                end
                return true, x, y
            else
                return false, -1, -1;
            end
        end
        
        return find;
    end)();
    
    _ares.Ext = (function()
        local ext = {};
        ext.Split = function(szFullString, szSeparator)
            local nFindStartIndex = 1
            local nSplitIndex = 1
            local nSplitArray = {}
            while true do
                local nFindLastIndex = string.find(szFullString, szSeparator, nFindStartIndex)
                if not nFindLastIndex then
                    nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, string.len(szFullString))
                    break
                end
                nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, nFindLastIndex - 1)
                nFindStartIndex = nFindLastIndex + string.len(szSeparator)
                nSplitIndex = nSplitIndex + 1
            end
            return nSplitArray
        end
        
        return ext;
    end)();
    

    _ares.MessageBox = function(message, seconds)
        if seconds == nil then
            seconds = 1
        end
        messageboxex(message, seconds * 1000, 10, 1280, 0, 25);
        _ares.Sleep(seconds);
        messageboxex("", 0, 0, 0, 0, 0);
    end
    
    _ares.GetResourcePath = function()
        local fullPath = getrcpath("rc:main.png");
        if fullPath == nil then
            if _ares.ShowLog then
                lineprint("获取根目录结果：没有获取到")
            end
            return nil;
        end
        local pathSplits = _ares.Ext.Split(fullPath, "/");
        local splitsLength = table.getn(pathSplits);
        local sourcePath = "";
        for i = 0, splitsLength - 1, 1 do
            if pathSplits[i] ~= nil then
                sourcePath = sourcePath .. pathSplits[i] .. "/";
            end
        end
        if Ares.ShowLog then
            lineprint("获取根目录结果：" .. sourcePath)
        end
        return sourcePath;
    end
    -- 初始化函数 必须要执行一下
    -- 设置资源根目录
    _ares.RootPath = Ares.GetResourcePath();
    _ares.InitStatus = 1;
    
    return _ares;
end)()

return Ares2;
