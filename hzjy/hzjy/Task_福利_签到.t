-- 签到领奖
function QianDaoLingJiang()
    -- 打开福利
    Ares2.TapFormFeature(feature.福利.图标);
    
    -- 切换签到页
    Ares2.TapFormFeature(feature.福利.签到.图标);
    
    
    
    if Ares2.Find.MultiColor(feature.福利.签到.有奖励) == false then
		Ares2.MessageBox("无奖励");
        return;
    end
    
	local rows = 8;
    -- 拉到最下面
    swipe(feature.system.swipeUp[1],feature.system.swipeUp[2],feature.system.swipeUp[3],feature.system.swipeUp[4]);	 
    
    
    -- 一点一点的往下找 可领取三个字
    for i=1,rows,1 do
        Ares2.Sleep(1);
		-- 找领取的小图标
		if Ares2.Find.MultiColor(feature.福利.签到.可领取,true) then
            break;
        else
            Ares2.Swipe(178,488,178,312,4,1);
            Ares2.Sleep(1)
        end
    end
    
    
	-- 摇钱树 
    Ares2.TapFormFeature(feature.福利.祈福.图标);
 
    Ares2.TapFormFeature(feature.福利.祈福.灵币祈福);
    
    
    -- 点返回
    Ares2.TapFormFeature(feature.system.back1);
    Ares2.TapFormFeature(feature.system.back1);
    
    
end
