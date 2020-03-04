function VipBoss()
    local index = 1;
    if	CheckTaskStatus(8) then
		Ares2.MessageBox("VIPBOSS挑战完毕")
		return false
	end
    while true do
        -- 点击BOSS 
        Ares2.TapFormFeature(feature.BOSS.图标);
        -- 点击VIP页签
        Ares2.TapFormFeature(feature.BOSS.VIP.图标);
        
        -- 上推 显示全部
        Ares2.Swipe(360,880,360,540,4,1);
        Ares2.Sleep(2);
		
        -- 打boss
        local isFindBoss = false;
        if index == 1 then
            isFindBoss = Ares2.Find.MultiColor(feature.BOSS.VIP.BOSS1,true);
        elseif index == 2 then
            isFindBoss = Ares2.Find.MultiColor(feature.BOSS.VIP.BOSS2,true);
        elseif index == 3 then
            isFindBoss = Ares2.Find.MultiColor(feature.BOSS.VIP.BOSS3,true);
        elseif index == 4 then
            isFindBoss = Ares2.Find.MultiColor(feature.BOSS.VIP.BOSS4,true);
        else
            -- 点返回按钮
            Ares2.TapFormFeature(feature.system.back2);
            break;
        end
        if isFindBoss == true then 
			Ares2.MessageBox("开始挑战VIP BOSS "..index);

			while CheckIsGameIndexPage() == false do
				Ares2.Sleep(1)
				Ares2.MessageBox("VIP BOSS "..index.."挑战中");
			end
        end 
        index = index + 1;
		
    end
    
	Ares2.MessageBox("VIP BOSS 挑战完毕");
    
	ChangeTaskStatus(8);
end
