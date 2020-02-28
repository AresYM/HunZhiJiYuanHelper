function VipBoss()
    local index = 1;
    while true do
        -- 点击BOSS 
        Ares.TapFormFeature(feature.task.boss.icon);
        -- 点击VIP页签
        Ares.TapFormFeature(feature.task.boss.vip.icon);
        
        -- 上推 显示全部
        XM.Swipe(360,880,360,540,4,1000);
        sleep(2000);
        
        -- 打boss
        local isFindBoss = false;
        XM.KeepScreen(0);
        if index == 1 then
            isFindBoss = Ares.FindMultiColorWithTap(feature.task.boss.vip.boss1,true);
        elseif index == 2 then
            isFindBoss = Ares.FindMultiColorWithTap(feature.task.boss.vip.boss2,true);
        elseif index == 3 then
            isFindBoss = Ares.FindMultiColorWithTap(feature.task.boss.vip.boss3,true);
        elseif index == 4 then
            isFindBoss = Ares.FindMultiColorWithTap(feature.task.boss.vip.boss4,true);
        else
            -- 点返回按钮
            Ares.TapFormFeature(feature.system.return_back_click);
            break;
        end
        if isFindBoss == true then 
			Ares.MessageBox("开始挑战VIP BOSS "..index);

			while CheckIsGameIndexPage() == false do
				Ares.Sleep(1)
				Ares.MessageBox("VIP BOSS "..index.."挑战中");
			end
        end 
        index = index + 1;
		
    end
    
end