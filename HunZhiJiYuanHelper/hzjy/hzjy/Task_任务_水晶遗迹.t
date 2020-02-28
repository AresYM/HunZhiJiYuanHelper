function ShuiJingYiJi()
    Ares2.TapFormFeature(feature.水晶遗迹.图标);
    Ares2.MessageBox("寻路中");
    Ares2.Sleep(5);
    
    -- 点击进入
    Ares2.TapFormFeature(feature.水晶遗迹.进入);
    
    
    -- 有奖励的领取奖励
    
    if Ares2.Find.MultiColor(feature.水晶遗迹.领取奖励定位点1) and Ares2.Find.MultiColor(feature.水晶遗迹.领取奖励定位点2) then 
		Ares2.TapFormFeature(feature.水晶遗迹.领取奖励);
        Ares2.Sleep(1);
        Ares2.TapFormFeature(feature.水晶遗迹.关闭领取奖励弹窗);
	end
    
     -- 点女神
	Ares2.Sleep(1);
	Ares2.TapFormFeature(feature.水晶遗迹.女神位置);
	Ares2.Sleep(1);
		
	-- 检测是不是正在采矿中
    if Ares2.Find.MultiColor(feature.水晶遗迹.领取奖励定位点1) then 
        -- 点挖矿
		Ares2.TapFormFeature(feature.水晶遗迹.开始挖矿);
		Ares2.TapFormFeature(feature.水晶遗迹.开始挖矿确认);
	end 
    
    -- 退出挖矿
	Ares2.Sleep(1);
	Ares2.TapFormFeature(feature.水晶遗迹.退出挖矿);
end