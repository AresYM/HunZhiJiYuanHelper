-- 角色加点
function JueSeJiaDian()
    -- 打开角色
    Ares.TapFormFeature(feature.角色.图标);
    Ares2.Sleep(2);
    
    Ares.TapFormFeature(feature.角色.图标);
    Ares2.Sleep(2);
    
	local x = 130 y = 212;
    
    
    for i=1,5,1 do
        x = 130 + (i - 1) * 122;
        lineprint("x:"..x.." y:"..y)
        -- 点击人物头像
        Ares2.Tap(x,212)
        Ares2.Sleep(1);
        
        -- 判断信息页签
        if Ares2.Find.MultiColor(feature.角色.信息.可操作,true) then
            -- 一键装备
            Ares2.TapFormFeature(feature.角色.信息.一键装备);
		end
        
        -- 判断加点页签
        if Ares2.Find.MultiColor(feature.角色.加点.可操作,true) then
            -- 点击推荐
			Ares2.TapFormFeature(feature.角色.加点.推荐);
			-- 点击保存
			Ares2.TapFormFeature(feature.角色.加点.保存);
		end
        
         
    end
 
    Ares2.TapFormFeature(feature.system.back2);
		
    Ares2.MessageBox("角色加点操作完毕",2);
    
end