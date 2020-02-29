-- 签到领奖
function QianDaoLingJiang()
    -- 打开福利
    Ares.TapFormFeature(feature.task.fuli.icon);
	local rows = 8;
    -- 拉到最下面
    swipe(feature.system.swipeUp[1],feature.system.swipeUp[2],feature.system.swipeUp[3],feature.system.swipeUp[4]);	 
    -- 一点一点的往下找 可领取三个字
    for i=1,rows,1 do
        Ares.Sleep(1);
		-- 找领取的小图标
		if Ares.FindMultiColorWithTap(feature.task.fuli.meiriqiandao.qiandaolingjiang,true) then
            break;
        else
            XM.Swipe(178,488,178,312,4,1000);
            Ares.Sleep(1)
        end
    end
    
    
	-- 摇钱树 
    Ares.TapFormFeature(feature.task.fuli.qifuxuyuan.icon);
 
    Ares.TapFormFeature(feature.task.fuli.qifuxuyuan.lingbiqifu);
    
    
    -- 点返回
    Ares.TapFormFeature(feature.system.back1);
    Ares.TapFormFeature(feature.system.back1);
    
    
end
