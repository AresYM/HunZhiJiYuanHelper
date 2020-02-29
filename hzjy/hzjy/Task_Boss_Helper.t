-- 检测是不是在黑暗神殿tab页签下
function TaskBossCheckIsInShenDianTab()
    --local a = Ares.FindMultiColorWithTap(feature.task.boss.shendian.pitch1);
    --local b = Ares.FindMultiColorWithTap(feature.task.boss.shendian.pitch2);

    local a = Ares.FindMultiColorWithTap(feature.task.boss.神殿.神殿入口定位1);
    local b = Ares.FindMultiColorWithTap(feature.task.boss.神殿.神殿入口定位2);
    
    if	a == true and b == true then
		return true;
	else
		return false;
	end
end


-- 检测是不是在黑暗神殿内
function TaskBossCheckIsInShenDianIndex(isBack)
    local x1 = -1 y1 = -1;
    local x2 = -1 y2 = -1;
    XM.KeepScreen(0)
    x1,y1 = Ares.FindMultiColor(feature.task.boss.shendian.inner_pitch1);
    x2,y2 = Ares.FindMultiColor(feature.task.boss.shendian.inner_pitch2);
    if	x1>0 and y1>0 and x2>0 and y2>0 then
		if isBack == true then
            
			Ares.TapFormFeature(feature.task.boss.shendian.tuichu);
			Ares.TapFormFeature(feature.task.boss.shendian.tuichuqueren);
		end
		return true;
	else
		return false;
	end
end


-- 检测是不是在黑暗神殿内
function TaskBossCheckIsFighting()
    local x1 = -1 y1 = -1;
    local x2 = -1 y2 = -1;
    x1,y1 = Ares.FindMultiColor(feature.task.boss.shendian.fighting_pitch1);
    x2,y2 = Ares.FindMultiColor(feature.task.boss.shendian.fighting_pitch2);
    if	(x1>0 and y1>0) and (x2>0 and y2>0) then
		return true;
	else
		return false;
	end
end