-- 人物升级
function RenWuShengJi()
    -- 点开经验池
    Ares2.TapFormFeature(feature.task.jingyanchi.icon);
    
    local retryTimes = 0;
    
    while true do
        if retryTimes > 20 then
            Ares2.MessageBox("人物升级次数过多，停止升级");
			Ares2.TapFormFeature(feature.system.back2);
            break;
		end
		local a = Ares2.Find.MultiColor(feature.task.jingyanchi.shengji.juese1,true);
		local b = Ares2.Find.MultiColor(feature.task.jingyanchi.shengji.juese2,true);
		local c = Ares2.Find.MultiColor(feature.task.jingyanchi.shengji.juese3,true);
		local d = Ares2.Find.MultiColor(feature.task.jingyanchi.shengji.juese4,true);
		local e = Ares2.Find.MultiColor(feature.task.jingyanchi.shengji.juese5,true);
        retryTimes = retryTimes + 1;
        if a == false and b == false and c == false and d == false and e == false then 
            Ares2.MessageBox("人物升级完成");
            -- 返回
			Ares2.TapFormFeature(feature.system.back2);
            
            break;
		end 
    end
end