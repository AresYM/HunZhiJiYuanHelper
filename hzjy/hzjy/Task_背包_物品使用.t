function WuPinShiYong()
    -- 打开背包
	Ares2.TapFormFeature(feature.背包.图标);
	Ares2.TapFormFeature(feature.背包.背包页);
   
	while true do
        Ares2.Sleep(1);

		if Ares2.Find.MultiColor(feature.背包.拍卖.物品1可用,true) then
            Ares2.TapFormFeature(feature.背包.拍卖.使用);
			Ares2.TapFormFeature(feature.背包.拍卖.单个拍卖);
		else
            -- 点第一个物品
			Ares2.TapFormFeature(feature.背包.使用.物品1);
			
			-- 验证有没有使用按钮
			if Ares2.Find.MultiColor(feature.背包.使用.使用按钮,true) then 
				if Ares2.Find.MultiColor(feature.背包.使用.使用成功) == true then 
					Ares2.TapFormFeature(feature.背包.使用.关闭提示);
				end
			else
				Ares2.MessageBox("物品使用完毕")
				Ares2.TapFormFeature(feature.system.back2);
				break;
			end
		end 
        
        
        
    end
   
end