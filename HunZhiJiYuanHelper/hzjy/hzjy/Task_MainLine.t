-- 主线任务
function Unit.State.TaskMainLine() 
    Ares.TapFormFeature(主线任务.任务)
    -- 开启旅程按钮
	Ares.FindMultiColorWithTap(主线任务.开始旅程,true);
    Ares.FindMultiColorWithTap(主线任务.赫拉哔哔,true);
    Ares.FindMultiColorWithTap(主线任务.赫拉哔哔2,true);
    Ares.FindMultiColorWithTap(主线任务.人物哔哔2,true);
    Ares.FindMultiColorWithTap(主线任务.人物哔哔1,true);
    
	if Ares.FindMultiColorWithTap(主线任务.穿装备定位1) == true and Ares.FindMultiColorWithTap(主线任务.穿装备定位2) == true then
        Ares.TapFormFeature(主线任务.装备穿戴)
	end
    
    
    
    Ares.FindMultiColorWithTap(主线任务.功能按钮1,true);
    Ares.FindMultiColorWithTap(主线任务.功能按钮2,true);
    Ares.FindMultiColorWithTap(主线任务.功能按钮3,true);
    
    if Ares.FindMultiColorWithTap(主线任务.学习技能1,true) == true then
		Ares.FindMultiColorWithTap(主线任务.功能按钮3,true);
	end
	if Ares.FindMultiColorWithTap(主线任务.学习技能2,true) == true then
		Ares.FindMultiColorWithTap(主线任务.功能按钮3,true);
	end
    
    Ares.FindMultiColorWithTap(主线任务.VIP按钮1,true);
    Ares.FindMultiColorWithTap(主线任务.VIP按钮2,true);
    Ares.FindMultiColorWithTap(主线任务.VIP升级,true);
    
    
    Ares.FindMultiColorWithTap(主线任务.VIPBOSS1,true);
    
    Ares.FindMultiColorWithTap(主线任务.VIPBOSS2,true);
    
    
    if Ares.FindMultiColorWithTap(主线任务.人物加点,true) == true then
		Ares.TapFormFeature(主线任务.人物加点推荐);
        Ares.Sleep(1);
		Ares.TapFormFeature(主线任务.人物加点保存);
	end
    
    
    if Ares.FindMultiColorWithTap(主线任务.宠物激活,true) == true then
        Ares.Sleep(1);
        Ares.TapFormFeature(主线任务.宠物激活确定);
        Ares.Sleep(1);
        Ares.TapFormFeature(主线任务.宠物出战);
        Ares.Sleep(1);
        Ares.TapFormFeature(主线任务.宠物激活确定);
        Ares.Sleep(1);
        Ares.TapFormFeature(主线任务.返回);
	end    
    Ares.FindMultiColorWithTap(主线任务.宠物兑换购买1,true);
    
    
    -- 找黄色按钮 点
    Ares2.Find.SingleColor(主线任务.黄色按钮,true);
    
    
    Ares.Sleep(1)
    
    return "TaskMainLine";
	
end

Unit.Param.TaskMainLine={
	
};