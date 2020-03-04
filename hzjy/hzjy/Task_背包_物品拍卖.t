-- 物品拍卖
function WuPinPaiMai()
	-- 打开背包
	Ares2.TapFormFeature(feature.背包.图标);
    

    Ares2.TapFormFeature(feature.背包.背包页);
    
    local continueSec = 0;
   
	-- 验证第4个物品是不是拍品
    
    if Ares2.Find.MultiColor(feature.背包.拍卖.物品4可用,true) or Ares2.Find.MultiColor(feature.背包.拍卖.物品4过期,true) then
        
        Ares2.TapFormFeature(feature.背包.拍卖.使用);
        while true do
            continueSec = continueSec + 1;
            if continueSec > 120 then
                break;
            end
			if Ares2.Find.MultiColor(feature.背包.拍卖.批量未完成) then
                Ares2.TapFormFeature(feature.背包.拍卖.批量拿去拍卖);
			elseif Ares2.Find.MultiColor(feature.背包.拍卖.批量过期) then
                Ares2.TapFormFeature(feature.背包.拍卖.批量自己使用);
            else
                Ares2.MessageBox("拍卖处理完成");
                -- 关闭拍卖框
                Ares2.TapFormFeature(feature.背包.拍卖.关闭批量拍卖);
                -- 关闭背包框
                Ares2.TapFormFeature(feature.system.back2);
                break;
            end
       end
        
	else
        while true do
            continueSec = continueSec + 1;
            if continueSec > 120 then
                break;
            end
            local isBreak = true;
            if Ares2.Find.MultiColor(feature.背包.拍卖.物品1可用,true) then
				Ares2.TapFormFeature(feature.背包.拍卖.使用);
                Ares2.TapFormFeature(feature.背包.拍卖.单个拍卖);
                isBreak = false;
			end
            
            if Ares2.Find.MultiColor(feature.背包.拍卖.物品1过期,true) then 
				Ares2.TapFormFeature(feature.背包.拍卖.使用);
                Ares2.TapFormFeature(feature.背包.拍卖.单个自己使用);
                isBreak = false;
			end  
            
            if	isBreak then
				break;
            end
        end
		Ares2.MessageBox("拍卖处理完成");
		-- 关闭背包框
		Ares2.TapFormFeature(feature.system.back2);
	end
end