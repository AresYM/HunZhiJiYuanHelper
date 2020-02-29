function GongHuiHuSong()
	-- 点开工会
    Ares.TapFormFeature(feature.task.gonghui.icon);
    sleep(1000);
    -- 点开工会活动
    Ares.TapFormFeature(feature.task.gonghui.huodong.icon)
    sleep(1000);
    
    -- 点开工会护送
    Ares.TapFormFeature(feature.task.gonghui.huodong.husong.icon)
    sleep(1000);
    
    -- 检测状态
    
    -- 开始护送
    if MyFindMultiColor(feature.task.gonghui.huodong.husong.kaishihusong,true) == true then
		
        -- 次数不足验证
        if Ares.FindMultiColorWithTap(feature.task.gonghui.huodong.husong.cishubuzu) == true or Ares.FindMultiColorWithTap(feature.task.gonghui.huodong.husong.cishubuzu_hsz) == true then
            -- 关闭次数不足弹出框
            Ares.TapFormFeature(feature.task.gonghui.huodong.husong.cishubuzu_close);
            Ares.Sleep(1)
            -- 关闭工会任务框
            Ares.TapFormFeature(feature.task.gonghui.huodong.husong.husong_close);
            Ares.Sleep(1)
            -- 退出工会
            Ares.TapFormFeature(feature.system.return_down_icon);
            Ares.Sleep(1)
            
			Ares.MessageBox("护送次数用尽");
            return false;
		end 
        
        Ares.MessageBox("开始护送");
        sleep(1000);
    -- 领取奖励
    elseif MyFindMultiColor(feature.task.gonghui.huodong.husong.lingqujiangli,true) == true then
        sleep(7000);
        -- 开始护送
        MyFindMultiColor(feature.task.gonghui.huodong.husong.kaishihusong,true);
        
		if Ares.FindMultiColorWithTap(feature.task.gonghui.huodong.husong.cishubuzu) == true or Ares.FindMultiColorWithTap(feature.task.gonghui.huodong.husong.cishubuzu_hsz) == true then
            -- 关闭次数不足弹出框
            Ares.TapFormFeature(feature.task.gonghui.huodong.husong.cishubuzu_close);
            Ares.Sleep(1)
            -- 关闭工会任务框
            Ares.TapFormFeature(feature.task.gonghui.huodong.husong.husong_close);
            Ares.Sleep(1)
            -- 退出工会
            Ares.TapFormFeature(feature.system.return_down_icon);
            Ares.Sleep(1)
            
			Ares.MessageBox("护送次数用尽");
            return false;
		end         
        
        Ares.MessageBox("领取奖励")
	else
        Ares.MessageBox("等待进行时间")
    end
    
    -- 关闭所有
	MyFindMultiColor(feature.system.close1,true);
	sleep(1000);
    
	Ares.TapFormFeature(feature.system.return_down_icon);
    
end