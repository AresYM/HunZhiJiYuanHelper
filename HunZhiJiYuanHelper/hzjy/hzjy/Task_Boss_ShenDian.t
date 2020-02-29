-- 神殿BOSS
function ShenDianBoss()
    
    while true do
        -- 在游戏首页 点boss按钮
		if CheckIsGameIndexPage() == true then 
			Ares.TapFormFeature(feature.task.boss.icon);
            Ares2.Sleep(2);
             -- 切换神殿页签
			Ares.TapFormFeature(feature.task.boss.神殿.Tab图标);
        end 
        
        
        if Ares2.Find.Text(feature.task.boss.神殿.进入场景) or Ares2.Find.Text(feature.task.boss.神殿.进入场景2) then
			Ares.MessageBox("神殿挑战完成");
            Ares.TapFormFeature(feature.system.back2);
			break;
		end
            
            
        Ares.Sleep(5);
        
        local bossAmount = 9;
        local isError = false;
        local seedX = 104 seedY = 688 totalCols = 3 totalRows = 3;
		
		for i=bossAmount,1,-1 do
            local rows = math.ceil(i/totalRows);
            local cols = i % totalCols;
            if cols == 0 then 
                cols = totalCols;
			end
            lineprint(i..":第"..rows.."行"..cols.."列")
            local bossX = seedX + (cols-1) * 242;
            local bossY = seedY + (rows-1) * 114;
            Ares.TapFormFeature({bossX,bossY,1});
            -- 检测能不能检测
            local tiaozhanParam = {"BOSS"..i.."可挑战",bossX,bossY,bossX + 130,bossY + 30,"4DCA34",1,0};
            if Ares.FindColorWithTap(tiaozhanParam,true) == true then
				Ares.MessageBox("准备挑战BOSS"..i);
				-- 点击挑战按钮 等CD
				Ares.TapFormFeature(feature.task.boss.神殿.开始挑战);
				
				-- 检测是不是到了挑战界面
				local retryTimes = 1;
				while true do
					if TaskBossCheckIsFighting() == false then
						Ares.MessageBox("BOSS寻路中");
						lineprint("错误次数"..retryTimes)
						if	retryTimes>= 20 then
							isError = true;
							Ares.MessageBox("BOSS寻路异常");
							break;
						end
						retryTimes = retryTimes + 1;
					else
						Ares.MessageBox("BOSS挑战中");
						break;
					end 
				end
				
				while true do
					Ares.Sleep(1);
					if TaskBossCheckIsInShenDianIndex(true) == true then 
						Ares.MessageBox("BOSS挑战完成");
						Ares.Sleep(5)
						break;
					else 
						
						Ares.MessageBox("BOSS挑战中");
					end 
				end
				break
                
			else
                 Ares.MessageBox("BOSS"..i.."不可以挑战");
			end
              
                
			if isError == true then
				Ares.MessageBox("BOSS寻路异常");
				-- 退出神殿
				Ares.TapFormFeature(feature.task.boss.shendian.tuichu);
				Ares.TapFormFeature(feature.task.boss.shendian.tuichuqueren);
				Ares.Sleep(5);
				break;
			end                
            
        end
        
        if isError == true then
			-- 退出神殿重新来
            Ares.TapFormFeature(feature.task.boss.shendian.tuichu);
			Ares.TapFormFeature(feature.task.boss.shendian.tuichuqueren);
            Ares.Sleep(5);
        end
    end
end