-- 角色加点
function JueSeJiaDian()
    -- 打开角色
    Ares.TapFormFeature(feature.task.juese.icon);
    Ares2.Sleep(2);
	-- 切换角色页
	Ares.TapFormFeature(feature.task.juese.jiadian.icon);
    Ares2.Sleep(2);
	local x = 130 y = 212;
    
    
    for i=1,5,1 do
        x = 130 + (i - 1) * 122;
        Ares2.Tap(x,y);
        Ares2.Sleep(1);
        -- 点击加点
		Ares.TapFormFeature(feature.task.juese.jiadian.jiadian);
		-- 点击推荐
		Ares.TapFormFeature(feature.task.juese.jiadian.tuijian);
		-- 点击保存
		Ares.TapFormFeature(feature.task.juese.jiadian.baocun);
        
        -- 点击信息
		Ares.TapFormFeature(feature.task.juese.xinxi.icon);
        
        -- 点击一键装备
		Ares.TapFormFeature(feature.task.juese.xinxi.yijianzhuangbei);
    end
 
    Ares.TapFormFeature(feature.system.back2);
		
    Ares.MessageBox("角色加点操作完毕",2);
    
end