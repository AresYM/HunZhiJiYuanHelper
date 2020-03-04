-- taskid  3
-- 竞技
function JingJi()    
    if	CheckTaskStatus(3) then
		Ares2.MessageBox("竞技完毕")
		return false
	end
    -- 点竞技按钮
	Ares2.TapFormFeature(feature.竞技.图标);
    
    -- 等待进入竞技界面
    while Ares2.Find.MultiColor(feature.竞技.竞技商店) == false do
        Ares2.MessageBox("竞技寻路中。。。")
        Ares2.Sleep(1)
    end
    
    -- 先领取奖励
	Ares2.TapFormFeature(feature.竞技.每日奖励);
	-- 领取
	Ares2.TapFormFeature(feature.竞技.领奖);
	Ares2.TapFormFeature(feature.竞技.领奖);
    
    Ares2.Sleep(2);
    
    
	-- 跳回匹配对手
	Ares2.TapFormFeature(feature.竞技.匹配对手页);
    
    -- 开始循环匹配
    while true do
        
        -- 点击匹配按钮
        Ares2.TapFormFeature(feature.竞技.匹配对手按钮);
        
		-- 检测是否已经完成了
		if Ares2.Find.MultiColor(feature.竞技.次数用尽) then
            Ares2.MessageBox("竞技已经完成");
            
            Ares2.TapFormFeature(feature.竞技.关闭);
            break;
		end 
        local retryTimes = 0;
        local isError = false;
        
        while Ares2.Find.MultiColor(feature.竞技.竞技商店) == false do
            if retryTimes > 30 then 
                isError = true;
                break;
			end 
			Ares2.MessageBox("竞技挑战中。。。")
			Ares2.Sleep(1)
            retryTimes = retryTimes + 1;
		end
        
        if isError then
            Ares2.MessageBox("竞技出错，进行下一任务");
            Ares2.TapFormFeature(feature.竞技.关闭);
            break;
        else
            Ares2.Sleep(2)
		end 
        
    end
    
	Ares2.TapFormFeature(feature.竞技.关闭);
    
    ChangeTaskStatus(3);
    
end
