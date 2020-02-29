function LingQuHuoYue()
    -- 点击领取活跃按钮
	Ares.TapFormFeature(feature.task.huoyue.icon);
    local retryTimes = 0;
    while true do
        -- 验证有没有待领取的活跃值
        local x = -1 y = -1;
		XM.KeepScreen(0);
        x,y = Ares.FindMultiColor(feature.task.huoyue.bukelingqu);
        sleep(1000);
        -- 点击领取
		if x<0 and y<0 then
			Ares.TapFormFeature(feature.task.huoyue.lingqu);
            if retryTimes > 20 then
                Ares.MessageBox("活跃领取异常，程序退出")
                break;
			end
		else
			Ares.MessageBox("活跃领取完毕")
			break;
        end
        retryTimes = retryTimes + 1;
    end
    if retryTimes < 20 then 
        -- 领取活跃奖励
		Ares.TapFormFeature(feature.task.huoyue.jiangli1);
		Ares.TapFormFeature(feature.task.huoyue.jiangli2);
		Ares.TapFormFeature(feature.task.huoyue.jiangli3);
		Ares.TapFormFeature(feature.task.huoyue.jiangli4);
		Ares.TapFormFeature(feature.task.huoyue.jiangli5);
	end

	
    
end