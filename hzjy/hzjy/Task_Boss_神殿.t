-- 神殿BOSS
function ShenDianBoss()
    
    while true do
        
        Ares.Sleep(10);
        -- 在游戏首页 点boss按钮
		if CheckIsGameIndexPage() == true then 
			Ares2.TapFormFeature(feature.BOSS.图标);
            Ares2.Sleep(2);
             -- 切换神殿页签
			Ares2.TapFormFeature(feature.BOSS.神殿.图标);
            Ares2.Sleep(2);
        end 
        
            
		if Ares2.Find.MultiColor(feature.BOSS.神殿.可挑战) == false then
			Ares2.TapFormFeature(feature.system.back2);
            Ares2.Sleep(1);
			Ares2.MessageBox("神殿挑战完成");
			break;
		end
            
        Ares.Sleep(5);
        
        local bossAmount = 9;
        local isError = false;
        local seedX = 104 seedY = 688 totalCols = 3 totalRows = 3;
        local isFinish = false;
        
        for _floor=2,1,-1 do
            if _floor == 2 then
				Ares2.TapFormFeature(feature.BOSS.神殿.第二层);
                Ares2.MessageBox("第二层BOSS");
			end
            if _floor == 1 then
				Ares2.TapFormFeature(feature.BOSS.神殿.第一层);
                Ares2.MessageBox("第一层BOSS");
			end
            for i=bossAmount,1,-1 do
				local rows = math.ceil(i/totalRows);
				local cols = i % totalCols;
				if cols == 0 then 
					cols = totalCols;
				end
				
				local bossX = seedX + (cols-1) * 242;
				local bossY = seedY + (rows-1) * 114;
				Ares2.TapFormFeature({bossX,bossY,1});
				-- 检测能不能检测
				local tiaozhanParam = {"BOSS"..i.."可挑战",bossX,bossY,bossX + 65,bossY + 30,"4DCA34",1,0};
				if Ares2.Find.SingleColor(tiaozhanParam,true) == true then
					Ares.MessageBox("准备挑战BOSS"..i);
					-- 点击挑战按钮
					Ares2.TapFormFeature(feature.BOSS.神殿.开始挑战);
                    local retryTimes = 1;
                    -- 检测是不是在寻路中
                    while Ares2.Find.MultiColor(feature.BOSS.神殿.黑暗神殿) == true do
						if retryTimes > 20 then
                            Ares2.MessageBox("寻路异常");
                            isError = true;
                            break;
						end 
                        
                        if Ares2.Find.MultiColor(feature.BOSS.神殿.采集,true) then
							-- 等待采集
                            Ares2.Sleep(10 * 6);
                            isError = true;
                            break;
						end
                        Ares2.Sleep(1);
                        retryTimes = retryTimes + 1;
                    end
                    
                    -- 检测是不是挑战中
                    
                    while Ares2.Find.MultiColor(feature.BOSS.神殿.黑暗神殿) == false do
                        Ares2.MessageBox("BOSS挑战中");
                        Ares2.Sleep(1);
                    end
                    
                    if	isError then
						break;
                    end
                    
                    Ares2.Sleep(10);
                    Ares2.TapFormFeature(feature.BOSS.神殿.退出);
					Ares2.TapFormFeature(feature.BOSS.神殿.退出确认);
                    isFinish = true;
                    break;
				else
					Ares2.MessageBox("BOSS"..i.."不可以挑战");
				end
			end  
			if isError then
                Ares2.TapFormFeature(feature.BOSS.神殿.退出);
				Ares2.TapFormFeature(feature.BOSS.神殿.退出确认);
                Ares2.Sleep(5);
				break;
			end 
            if isFinish  then
                break;
            end
        end
    end
end