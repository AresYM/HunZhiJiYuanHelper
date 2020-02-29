-- 批量熔炼
function PiLiangRongLian()
    -- 点击背包按钮
    Ares2.TapFormFeature(feature.背包.图标);

    Ares2.TapFormFeature(feature.背包.背包页);
    
    -- 点击批量熔炼按钮
    Ares2.TapFormFeature(feature.背包.批量熔炼.图标)
    
    
	if Ares2.Find.MultiColor(feature.背包.批量熔炼.是否有装备) then
        -- 点击熔炼按钮
		Ares2.TapFormFeature(feature.背包.批量熔炼.熔炼)
	end
    
    
    -- 点击关闭按钮
    Ares2.TapFormFeature(feature.背包.批量熔炼.关闭熔炼)
    
    
	-- 关闭背包框
	Ares2.TapFormFeature(feature.system.back2);
end