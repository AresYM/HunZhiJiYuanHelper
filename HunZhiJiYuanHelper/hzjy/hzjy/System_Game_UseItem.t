function WuPinShiYong()
    -- 打开背包
   Ares.TapFormFeature(feature.task.beibao.icon);
   
	while true do
        Ares.Sleep(1);
        -- 点第一个物品
        Ares.TapFormFeature(feature.task.beibao.paimai.wupin1_click);
        
        -- 验证有没有使用按钮
		if Ares.FindMultiColorWithTap(feature.task.beibao.shiyong.shiyong_click,true) == true then 
            if Ares.FindMultiColorWithTap(feature.task.beibao.shiyong.shiyongchenggong) == true then 
            
				Ares.TapFormFeature(feature.task.beibao.shiyong.guanbitishi);
            
			end
		else
			Ares.MessageBox("物品使用完毕")
			break;
		end
        
    end
   
end