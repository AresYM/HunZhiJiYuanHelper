function ZhongLiBoss()
    if	CheckTaskStatus(6) then
		Ares2.MessageBox("中立BOSS挑战完毕")
		return false
	end
    local thisTimes = 0;
    while true do
        -- 在游戏首页 点boss按钮
		if CheckIsGameIndexPage() == true then 
			Ares2.TapFormFeature(feature.BOSS.图标);
             -- 切换神殿页签
			Ares2.TapFormFeature(feature.BOSS.中立.图标);
		else
            -- 检测一些异常提示框
			Ares2.Find.MultiColor(feature.异常处理.提示1,true)
   
        end 
        
		XM.Swipe(360,880,360,540,4,1000);
		XM.Swipe(360,880,360,540,4,1000);
        Ares2.Sleep(1)
        
                
        local isFind = false;
        local retryTimes = 1;
        local isOver = false;
        while retryTimes < 5 do
            retryTimes = retryTimes + 1
            -- 找挑战按钮
			if Ares2.Find.MultiColor(feature.BOSS.中立.挑战按钮,true) then 
				Ares2.Sleep(1);
				if Ares2.Find.MultiColor(feature.BOSS.中立.挑战提示取消) == true 
						and Ares2.Find.MultiColor(feature.BOSS.中立.挑战提示) == false then
					Ares2.MessageBox("中立BOSS挑战结束");
                    
					ChangeTaskStatus(6);
                    isOver = true;
					Ares2.Sleep(1)
					Ares2.Find.MultiColor(feature.BOSS.中立.挑战提示取消,true)
					break;
				end
				-- 挑战提示
				if Ares2.Find.MultiColor(feature.BOSS.中立.挑战提示) == true then
					Ares2.Sleep(2);
					Ares2.TapFormFeature(feature.BOSS.中立.挑战提示确定)
				end
				isFind = true;
				Ares2.Sleep(5);
				break;
			else 
				XM.Swipe(360,780,360,880,4,1000);
			end
        end
        
        
        if isFind == true then 
			while true do
                Ares2.Sleep(1);
                if Ares2.Find.MultiColor(feature.BOSS.中立.点券加血) == true then
					if Ares2.Find.MultiColor(feature.BOSS.中立.免费加血,true) == true then
                        Ares2.Sleep(1);
                        Ares2.TapFormFeature(feature.BOSS.中立.免费加血确认)
					end 
					Ares2.MessageBox("中立BOSS挑战中");
				else
                    thisTimes = thisTimes + 1;
					Ares2.MessageBox("中立BOSS挑战成功");
                    local numbers = 20;
                    while numbers>0 do
                        Ares2.MessageBox("中立BOSS挑战倒计时："..numbers);
                        numbers = numbers - 1;
                    end
                    break;
				end
            end
        end
        
        if isOver == true then
            break;
		end
        
        if checkgetselected("task_zhongliboss_once") == true then 
            break;
		end 
    end
end