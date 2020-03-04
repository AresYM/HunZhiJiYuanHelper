-- 执行任务
function Unit.State.HandleTasks() 
	local taskList = Global.TaskList;
    
	if getselectscheckitemindex("task_mode") == 0 then
        
	elseif getselectscheckitemindex("task_mode") == 1 then
        taskList ={};
        taskList[1] ="收取邮件";
        taskList[2] ="物品拍卖";
        taskList[3] ="切换账号";
	end 
    
    while InitGameIndex(true,false) == false do
        Global.RetryTimes = Global.RetryTimes + 1;
        if Global.RetryTimes > 5 and Global.OpenRetry == true then
			lineprint("重试次数："..Global.RetryTimes);
			Global.RetryTimes = 0;
			KillGame();
			sleep(3000);
			return "OpenGame";
		end
	end
   
	local currentTaskName = "";
    local taskListLen = #taskList;

	if Global.CurrentTask == nil or Global.CurrentTask == "" then 
		Global.CurrentTask = 1;
	else
        if Global.CurrentTask + 1 > taskListLen then
			Global.CurrentTask = 1;
		else
			Global.CurrentTask = Global.CurrentTask + 1;
		end
    end
    
    currentTaskName = taskList[Global.CurrentTask]
    
    if currentTaskName == nil then
        return "HandleTasks";
    end

	Ares.MessageBox("下一个任务是："..currentTaskName);
    
    
    if checkgetselected("dev_task") == true then
        local xxx = editgettext("textTask");
        if xxx ~= nil and xxx ~= "-1" then 
			currentTaskName = 	xxx;
		end
    end
    
	if currentTaskName == "批量熔炼" then
        PiLiangRongLian();
		return "HandleTasks"
    elseif 	currentTaskName == "装备强化" then
        ZhuangBeiQiangHua();
        return "HandleTasks"
    elseif 	currentTaskName == "角色加点" then
        JueSeJiaDian();
        return "HandleTasks"
    elseif 	currentTaskName == "收取邮件" then
        ShouQuYouJian();
        return "HandleTasks"
    elseif 	currentTaskName == "签到领奖" then
        QianDaoLingJiang();
        return "HandleTasks"
    elseif 	currentTaskName == "野战" then
        YeZhan();
        return "HandleTasks"
    elseif 	currentTaskName == "竞技" then
        JingJi();
        return "HandleTasks"
    elseif 	currentTaskName == "VIPBOSS" then
        VipBoss();
        return "HandleTasks"
    elseif 	currentTaskName == "神殿BOSS" then
        ShenDianBoss();
        return "HandleTasks"
    elseif 	currentTaskName == "中立BOSS" then
        ZhongLiBoss();
        return "HandleTasks"
    elseif 	currentTaskName == "人物升级" then
        RenWuShengJi();
        return "HandleTasks"
   elseif 	currentTaskName == "试炼塔" then
        ShiLianTa();
        return "HandleTasks" 
        
	elseif currentTaskName == "装备副本" or currentTaskName == "经验副本" or currentTaskName == "魂卡副本" or currentTaskName == "雷霆岛" then
		FuBenZhengHeBan();
		return "HandleTasks"   
    
    elseif 	currentTaskName == "工会护送" then
        GongHuiHuSong();
        return "HandleTasks" 
	elseif 	currentTaskName == "水晶遗迹" then
        ShuiJingYiJi();
        return "HandleTasks"
    elseif 	currentTaskName == "宠物兑换" then
        ChongWuDuiHuan();
        return "HandleTasks"
    elseif 	currentTaskName == "领取活跃" then
        LingQuHuoYue();
        return "HandleTasks"
    elseif 	currentTaskName == "物品拍卖" then
        WuPinPaiMai();
        return "HandleTasks"
    elseif 	currentTaskName == "物品使用" then
        WuPinShiYong();
        return "HandleTasks"
    elseif 	currentTaskName == "跨服喊话" then
        KuaFuHanHua();
        return "HandleTasks"
    elseif 	currentTaskName == "切换账号" then
        local changeResult =ChangeAccount();
        return changeResult;
    else
        return "Success"
    end
    
	return "Success"
end

Unit.Param.HandleTasks={

};

-- 检测是否有退出按钮
function CheckHasGoOutButton(isGoOut)
	local j = -1 k = -1;
    XM.KeepScreen(0)
	j,k = Ares.FindMultiColor(feature.system.tuichuditu.icon);
	-- 有退出按钮
	if j>0 and k>0 then
		if isGoOut ~= nil and isGoOut == true then
			-- 点退出
			Ares.Tap(j,k);
			-- 点确认退出
			Ares.TapFormFeature(feature.system.tuichuditu.tuichuqueren);
		end
		return true;
	else
		return false;
	end
end

-- 多点找色
function MyFindMultiColor(featureValue,isTap)
	local j = -1 k = -1;
	XM.KeepScreen(0);
	j,k = Ares.FindMultiColor(featureValue);
	-- 剩余次数等于0了
	if j>0 and k>0 then
        if isTap ~= nil and isTap == true then
            Ares.Tap(j,k);
        end
		return true;
	else
		return false;
	end
end

-- 单点找色
function MyFindColor(featureValue,isTap)
	local j = -1 k = -1;
	XM.KeepScreen(0);
	j,k = Ares.FindColor(featureValue);
	-- 剩余次数等于0了
	if j>0 and k>0 then
        if isTap ~= nil and isTap == true then
            Ares.Tap(j,k);
        end
		return true;
	else
		return false;
	end
end

function InsertTaskIntoList(checkboxId,index,value)
    if checkgetselected(checkboxId) == true then
        Global.TaskList[index] = value;
	end
end

function InitTasks()
    Global.TaskList = {};
    local tasks = {
		{id = "task_piliangronglian",value = "批量熔炼"},
		{id = "task_shouquyoujian",value = "收取邮件"},
		{id = "task_wupinpaimai",value = "物品拍卖"},
		{id = "task_renwushengji",value = "人物升级"},
		{id = "task_juesejiadian",value = "角色加点"},
		{id = "task_shuijingyiji",value = "水晶遗迹"},
		{id = "task_zhuangbeiqianghua",value = "装备强化"},
		{id = "task_yezhan",value = "野战"},
		{id = "task_jingji",value = "竞技"},
		{id = "task_vipboss",value = "VIPBOSS"},
		{id = "task_shendianboss",value = "神殿BOSS"},
		{id = "task_zhongliboss",value = "中立BOSS"},
		{id = "task_zhuangbeifuben",value = "装备副本"},
		{id = "task_jingyanfuben",value = "经验副本"},
		{id = "task_hunkafuben",value = "魂卡副本"},
		{id = "task_leitingdao",value = "雷霆岛"},
		{id = "task_renwushengji",value = "人物升级"},
		{id = "task_chongwuduihuan",value = "宠物兑换"},
		{id = "task_gonghuihusong",value = "工会护送"},
		{id = "task_lingquhuoyue",value = "领取活跃"},
		{id = "task_qiandaolingjiang",value = "签到领奖"},
		{id = "task_piliangronglian",value = "批量熔炼"},
		{id = "task_shouquyoujian",value = "收取邮件"},
		{id = "task_wupinpaimai",value = "物品拍卖"},
		{id = "task_wupinshiyong",value = "物品使用"},
		{id = "task_shilianta",value = "试炼塔"},
		{id = "task_kuafuhanhua",value = "跨服喊话"},
		{id = "task_qiehuanzhanghao",value = "切换账号"}
    };
    local index = 1;
    for i=1,#tasks,1 do
        if checkgetselected(tasks[i].id) == true then
			Global.TaskList[index] = tasks[i].value;
            index = index + 1;
		end
    end
    
end