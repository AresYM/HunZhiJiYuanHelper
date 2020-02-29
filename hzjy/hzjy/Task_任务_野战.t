-- 野战
function YeZhan()
    -- 开始循环匹配
    while true do
        -- 点野战按钮
		local vip6 = Ares2.Find.MultiColor(feature.野战.图标Vip6,true);
		local vip6 = Ares2.Find.MultiColor(feature.野战.图标Vip7,true);
        Ares2.Sleep(1);
        
        -- 滑倒最简单的那个
		Ares2.Swipe(360,880,360,540,4,1);
        
        Ares2.Sleep(2);
        
        -- 点击挑战按钮
        Ares2.TapFormFeature(feature.野战.挑战);
        
        -- 检测是否已经完成了
		if Ares2.Find.MultiColor(feature.野战.全部完成,true) == true then
            Ares2.MessageBox("野战已经完成")
			-- 关闭
			Ares2.TapFormFeature(feature.system.back2);
            break;
		end 
		
		local retryTimes = 1;
        local isBreak = false;
        
        
        while Ares2.Find.MultiColor(feature.野战.跳过,true) == false do
            if retryTimes >= 20 then
                isBreak = true;
				Ares2.MessageBox("野战挑战异常")
                break;
			end
            Ares2.MessageBox("野战寻路中。。。")
            retryTimes = retryTimes + 1;
        end
        
        if isBreak == true then 
			Ares.MessageBox("野战挑战异常,进行下一任务")
            break;
		end 
        
        
        -- 胜利或失败的确定按钮
        
        Ares2.TapFormFeature(feature.野战.关闭结果提示);
        
		-- 等待返回游戏首页
        
        while CheckIsGameIndexPage() == false do
             Ares2.MessageBox("等待野战结束。。。");
             Ares2.Sleep();
        end
        
    end
end