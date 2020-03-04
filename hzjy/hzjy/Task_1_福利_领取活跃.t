-- taskid  1

function LingQuHuoYue()
--	if	CheckTaskStatus(1) then
--		Ares2.MessageBox("活跃领取完毕")
--		return false
--	end
    -- 点击领取活跃按钮
	Ares.TapFormFeature(feature.日常.图标);
    local retryTimes = 0;
    while true do
        -- 验证有没有待领取的活跃值
        if retryTimes > 20 then
			Ares2.MessageBox("活跃领取异常，程序退出")
			break;
		end
        
		if Ares2.Find.MultiColor(feature.日常.不可领取) == false then
           Ares2.TapFormFeature(feature.日常.领取);
		else
			Ares2.MessageBox("活跃领取完毕")
			break;
		end
        retryTimes = retryTimes + 1;
    end
    
    if retryTimes < 20 then 
        -- 领取活跃奖励
		Ares2.TapFormFeature(feature.日常.jiangli1);
		Ares2.TapFormFeature(feature.日常.jiangli2);
		Ares2.TapFormFeature(feature.日常.jiangli3);
		Ares2.TapFormFeature(feature.日常.jiangli4);
		Ares2.TapFormFeature(feature.日常.jiangli5);
	end
    -- Ares.TapFormFeature(feature.日常.关闭);
    
    -- ChangeTaskStatus(1);
end