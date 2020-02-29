-- 进入游戏 开始冒险
function Unit.State.SystemGameJoin()
    local a1 = Ares2.Find.MultiColor(feature.游戏进入页.老账号_公告);
    local a2 = Ares2.Find.MultiColor(feature.游戏进入页.老账号_开始冒险);
        
    local b1 = Ares2.Find.MultiColor(feature.游戏进入页.新账号_骰子);
    
    Ares2.Sleep(2);

	if Unit.Param.SystemGameJoin.RetryTimes > 30 then
        KillGame();
        return "OpenGame"
    end
    
    if a2 == true then 
		-- 进入游戏
		Ares2.MessageBox("老账号");
        -- 点开始冒险按钮
        Ares2.TapFormFeature(feature.游戏进入页.老帐号_开始冒险_点击);
        return "SystemGameStart_Old";
        -- 开始冒险
        
	elseif b1 == true then 
		Ares2.MessageBox("新账号");
        Ares2.TapFormFeature(feature.游戏进入页.新账号_开始游戏_点击);
        return "SystemGameStart_New";
        
	else
		Ares2.MessageBox("正在等待开始冒险")
        Unit.Param.SystemGameJoin.RetryTimes = Unit.Param.SystemGameJoin.RetryTimes + 1;
        return "SystemGameJoin";
	end
end


Unit.Param.SystemGameJoin={
	RetryTimes = 0;
};


-- 正式开始游戏 老账号
function Unit.State.SystemGameStart_Old()
    Ares.Sleep(2);
	local a1 = Ares.FindMultiColorWithTap(feature.游戏进入页.老账号_公告);
    local a2 = Ares.FindMultiColorWithTap(feature.游戏进入页.老账号_开始冒险);

    if a1 == true or a2 == true then
        return "SystemGameJoin";
    end
    
    return "HandleTasks";
	
end

Unit.Param.SystemGameStart_Old={
	
};


Unit.Param.SystemGameJoin={
	RetryTimes = 0;
};


-- 正式开始游戏 老账号
function Unit.State.SystemGameStart_New()
    Ares.Sleep(2);
	local a1 = Ares.FindMultiColorWithTap(feature.游戏进入页.新账号_骰子);

    if a1 == true then
        return "SystemGameJoin";
    end
    
    return "TaskMainLine";
	
end

Unit.Param.SystemGameStart_New={
	
};
