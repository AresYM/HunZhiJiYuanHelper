
-- 强化装备
function ZhuangBeiQiangHua()
    lineprint("强化")
    -- 点开锻造
    Ares.TapFormFeature(feature.task.duanzao.icon);
    -- 点开强化tab页
    Ares.TapFormFeature(feature.task.duanzao.qianghua.icon);
	while true do
        -- 验证有没有养成礼包
        MyFindMultiColor(feature.yangchenglibao.icon,true);
        
        -- 验证能不能强化
        -- 1.没有强化石了
        if MyFindColor(feature.task.duanzao.qianghua.wuqianghuashi) == true then
            Ares.MessageBox("没有强化石了");
            break;
        end
        -- 2.等级不够了
        if MyFindMultiColor(feature.task.duanzao.qianghua.dengjibuzu) == false then
            Ares.MessageBox("强化等级不足");
            break;
		end
        
		-- 进行强化
		Ares.TapFormFeature(feature.task.duanzao.qianghua.kaishiqianghua);
        
        -- 验证有没有进化按钮
        MyFindMultiColor(feature.task.duanzao.qianghua.qianghuajinhua,true);
    end 
end