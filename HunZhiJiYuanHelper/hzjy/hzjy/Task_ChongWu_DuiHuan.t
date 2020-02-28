function ChongWuDuiHuan()
    -- 点开宠物
    Ares.TapFormFeature(feature.task.chongwu.icon)
    -- 点击兑换
    Ares.TapFormFeature(feature.task.chongwu.duihuan.icon);
    
    while true do
		-- 点击刷新
		Ares.TapFormFeature(feature.task.chongwu.duihuan.shuaxin);
        
        -- 验证是不是不能兑换了
        if Ares.FindMultiColorWithTap(feature.task.chongwu.duihuan.finish) == true then
            Ares.MessageBox("宠物兑换完毕");
			Ares.TapFormFeature(feature.system.back2)
			break
        end
        
        
		Ares.TapFormFeature(feature.task.chongwu.duihuan.pos1);
        
        if Ares.FindMultiColorWithTap(feature.task.chongwu.duihuan.jifenbuzu) == true then
            Ares.MessageBox("积分不足，兑换停止");
			Ares.TapFormFeature(feature.system.back2)
			Ares.TapFormFeature(feature.system.back2)
			break
		end 
        
		Ares.TapFormFeature(feature.task.chongwu.duihuan.pos2);
        
        if Ares.FindMultiColorWithTap(feature.task.chongwu.duihuan.jifenbuzu) == true then
            Ares.MessageBox("积分不足，兑换停止");
			Ares.TapFormFeature(feature.system.back2)
			Ares.TapFormFeature(feature.system.back2)
			break
		end 
        
    end
end