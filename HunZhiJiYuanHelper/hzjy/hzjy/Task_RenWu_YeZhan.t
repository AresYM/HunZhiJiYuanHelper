-- 野战
function YeZhan()
    -- 开始循环匹配
    while true do
        -- 点野战按钮
		Ares.TapFormFeature(feature.task.yezhan.icon);
		
		local retryTimes = 1;
        local isBreak = false;
        
		-- 等待进入野战界面
		while MyFindMultiColor(feature.task.yezhan.success_in) == false do
            if retryTimes >= 10 then
                Ares.TapFormFeature(feature.task.yezhan.icon);
			end
            
            if retryTimes >= 20 then
                isBreak = true;
				Ares.MessageBox("野战寻路异常")
                break;
			end
			Ares.MessageBox("野战寻路中。。。")
            retryTimes = retryTimes + 1;
			sleep(1000)
		end
        
        if isBreak == true then 
			Ares.MessageBox("野战寻路异常,进行下一任务")
            break;
		end 
        
        -- 滑倒最简单的那个
		XM.Swipe(360,880,360,540,4,1000);
        sleep(2000)
        
        -- 点击挑战按钮
        Ares.TapFormFeature(feature.task.yezhan.tiaozhan);
        
        -- 检测是否已经完成了
		if MyFindMultiColor(feature.task.yezhan.complete_all) == true then
            Ares.MessageBox("野战已经完成")
            break;
		end
        
        -- 检测是不是完成了本次竞技
        while  MyFindMultiColor(feature.task.yezhan.success_current) == false do
            Ares.TapFormFeature(feature.task.yezhan.tiaoguo);
            Ares.TapFormFeature(feature.task.yezhan.queding);
            sleep(1000);
        end
    end
end