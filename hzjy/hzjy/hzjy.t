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
    ChangeXiaoQiAccount = false,
    CurrentAccountTitle="default",
    CurrentAccountTaskStatusFile = "",
    TaskStatus = {}
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
    local taskRecordName = Ares2.RootPath.."default1.txt";
    
	local isExists = fileexist(taskRecordName);
        
	lineprint(taskRecordName.."是否存在："..isExists);
	local dayStr = os.date("%Y%m%d");
    
	-- 不存在  创建并初始化内容
	if isExists == 0 then
		local f = fileopen(taskRecordName,"a+");
		filewrite(f,dayStr);
		fileclose(f);
        Global.TaskStatus[1] = dayStr;
	-- 存在 读出内容
	else
		local content =filereadex(taskRecordName)
        local taskStatus = Ares2.Ext.Split(content,"|");
        
        if	taskStatus[1] == dayStr then
			Global.TaskStatus = taskStatus;
        else
            Global.TaskStatus={};
            Global.TaskStatus[1] = dayStr;
        end
	end
    
	XM.Print(Global.TaskStatus)
        
    sleep(1000 * 100000)
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



