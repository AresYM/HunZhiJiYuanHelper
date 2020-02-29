-- 竞技
function JingJi()    
    -- 点竞技按钮
	Ares.TapFormFeature(feature.task.jingji.icon);
    
    -- 等待进入竞技界面
    while MyFindMultiColor(feature.task.jingji.success_current) == false do
        Ares.MessageBox("竞技寻路中。。。")
        sleep(1000)
    end
    
    -- 先领取奖励
	Ares.TapFormFeature(feature.task.jingji.tab_jiangli);
	-- 领取
	Ares.TapFormFeature(feature.task.jingji.tab_jiangli_lingqu);
	-- 领取
	Ares.TapFormFeature(feature.task.jingji.tab_jiangli_lingqu);
	-- 跳回匹配对手
	Ares.TapFormFeature(feature.task.jingji.tab_pipei);
    
    -- 开始循环匹配
    while true do

        
        -- 点击匹配按钮
        Ares.TapFormFeature(feature.task.jingji.pipeiduishou);
        
		-- 检测是否已经完成了
		if MyFindMultiColor(feature.task.jingji.complete_all) == true then
            Ares.MessageBox("竞技已经完成")
            break;
		end 
        
        -- 检测是不是在正在挑战界面
        while CheckHasGoOutButton() == true do
            Ares.MessageBox("竞技挑战中。。。")
            sleep(1000)
        end
        
        -- 检测是不是完成了本次竞技
        while  MyFindMultiColor(feature.task.jingji.success_current) == false do
            sleep(1000);
        end
        
    end
end
