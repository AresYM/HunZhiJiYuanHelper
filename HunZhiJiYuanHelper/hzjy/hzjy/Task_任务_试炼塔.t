function ShiLianTa()
    
	-- 点击试炼塔图标
	Ares2.TapFormFeature(feature.试炼塔.图标);
    Ares2.MessageBox("寻路中");
    Ares2.Sleep(5);
    
    
	Ares2.TapFormFeature(feature.试炼塔.挑战);
    
    local finish = false;
    
    while true do
		Ares2.MessageBox("挑战中");
        if  CheckIsGameIndexPage() then
            break;
		end 
        
        if Ares2.Find.MultiColor(feature.试炼塔.通关提醒) then
			Ares2.TapFormFeature(feature.试炼塔.关闭通关提醒);
			break;
		end
    end
    
end