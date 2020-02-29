-- 强化装备
function ZhuangBeiQiangHua()
    -- 点开锻造
    Ares2.TapFormFeature(feature.锻造.图标);
    -- 点开强化tab页
    Ares2.TapFormFeature(feature.锻造.强化.图标);
    
	local retryTimes = 0;
    
	while true do
        
		if retryTimes > 20 then
            Ares2.MessageBox("强化次数超过上限，停止强化");
            break;
		end
        
        -- 验证有没有养成礼包
        if Ares2.Find.MultiColor(feature.yangchenglibao.icon,true) then
            Ares2.Sleep(2);
		end;
        
        -- 验证能不能强化
        -- 1.没有强化石了
        if Ares2.Find.SingleColor(feature.锻造.强化.无强化石) then
            Ares2.MessageBox("没有强化石了");
            break;
        end
        -- 2.等级不够了
        if Ares2.Find.MultiColor(feature.锻造.强化.等级不足) == false then
            Ares2.MessageBox("强化等级不足");
            break;
		end
        
		-- 进行强化
		Ares2.TapFormFeature(feature.锻造.强化.开始强化);
        
        -- 验证有没有进化按钮
        Ares2.Find.MultiColor(feature.锻造.强化.突破,true);
        
        retryTimes = retryTimes + 1;
    end 
    
    
	-- 关闭强化
	Ares2.TapFormFeature(feature.system.back2);
end