-- 全局函数
Global = {
    ScreenWidth = 0,
    ScreenHeight = 0,
    PackageName = "com.smwl.x7market",
    CurrentAccount = "",
    TaskList = {},
    AccountList = {},
    CurrentTask = "",
    SourcePath = "",
    OpenRetry = false,
    RetryTimes = 0,
    XiaoQiAccounts = {
		List = {},
        CurrentIndex = 1,
        SubCurrentIndex = 1
    },
    ChangeXiaoQiAccount = false;
};

-- 状态机
Unit = {
    State = {},
    Param = {}
};
Unit.State.Name = "";
function ProcessState(processState, processStateTable, processStateParam)
    if processState[processStateTable] ~= nil then
        return processState[processStateTable](processStateParam);
    end
    return "error"
end

-- 检测游戏是否启动成功
function Unit.State.Test()
    -- Unit.State.XiaoQiLogin()
    -- InitXiaoQiLogin();
    
    CloseAllDialogAndBackToIndex();
    
    return "Test";
end

Unit.Param.Test = {};



-- 程序入口
function floatwinrun()
    --引入一个插件
    require("XM");
    require("Ares2")
    local imei = getimei()
    
    Ares.Init();    
    
    -- 设置特征版本
    local mnqType = getselectscheckitemindex("sel_moniqibanben");
    
    if mnqType == 0 then
        feature = feature_leidian;
    elseif mnqType == 1 then
        feature = feature_hongshouzhi;
    end
    
    
    -- 验证口令
    if editgettext("txt_kouling") ~= feature.keys.keyword then
        for i=0,20,1 do
            Ares2.MessageBox("口令错误，请到游戏中找我要")
            Ares2.Sleep();
        end
        return;
	end
    
    -- 验证辅助是否过期
    local curTime = Ares2.Http.Get("http://47.93.240.116/gameapi/GetCurrentTime");
    local sysCurTime = {day=curTime.day, month=curTime.month, year=curTime.year, hour=0, minute=0, second=0}
    if os.time(sysCurTime) > feature.keys.time_key then
        for i=0,20,1 do
            Ares2.MessageBox("辅助初始化错误，应该是被封了")
            Ares2.Sleep();
        end
        return;
    end
    
    -- 任务配置
    InitTasks();
    
    -- 初始换屏幕的宽高
    setrotatescreen();
    
    -- 获取资源根目录
    Global.SourcePath = Ares2.GetResourcePath(); 
    
    -- 测试模式
    if checkgetselected("dev_test") == true then
        Unit.State.Name = "Test";
        -- 任务模式
    elseif checkgetselected("dev_task") == true then 
        Unit.State.Name = "HandleTasks";
        -- 调试模式
    elseif checkgetselected("dev_debug") == true then 
        Unit.State.Name = editgettext("textDebug");
    else 
        if checkgetselected("multiAccount") then
			-- 账号配置
			InitXiaoQiLogin();
			Unit.State.Name = "XiaoQiLogin";
		else
            InitAccounts();
			Unit.State.Name = "OpenGame";
		end
    end 
    
    while true do
        Unit.State.Name = ProcessState(Unit.State,Unit.State.Name,Unit.Param[Unit.State.Name]);
    end
end




-- 正式开始游戏 新账号
function Unit.State.StartGamingNewLogin()
    return "StartGamingNewLogin";
end

Unit.Param.StartGamingNewLogin={

};

 


-- 重启程序
function CheckGameStart()
    KillGame()
    -- 检测是不是在前台
    if XM.Timer("CheckGameStart") then
        local gameName = gettopapppackagenameex();
        if gameName ~= Global.PackageName then
            local isSuccess = sysstartapp(Global.PackageName);
            sleep(3000);
            if isSuccess == 0 then
                messagebox("没有安装游戏")
            end 
        end
    end
end

-- 杀死游戏进程
function KillGame()
    local gameName = gettopapppackagenameex();
    if gameName == Global.PackageName then
        syskillapp(gameName);
    end
end

-- 仅启动游戏
function StartGameOnly()
    local gameName = gettopapppackagenameex();
    if gameName ~= Global.PackageName then
        sysstartapp(Global.PackageName);
    end
end

-- 获取资源目录的路径
function GetSourcePath()
    local fullPath = getrcpath("rc:main.png");
    local pathSplits = XM.Split(fullPath,"/");
    local splitsLength = table.getn(pathSplits);
    local sourcePath = "";
    for i=0,splitsLength-1,1 do
        if pathSplits[i] ~= nil then
            sourcePath = sourcePath..pathSplits[i].."/";
        end
    end
    return sourcePath;
end


