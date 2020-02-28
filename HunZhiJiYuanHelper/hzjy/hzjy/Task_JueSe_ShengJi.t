-- 人物升级
function RenWuShengJi()
    -- 点开经验池
    Ares.TapFormFeature(feature.task.jingyanchi.icon);
    
    while true do
		local a = MyFindMultiColor(feature.task.jingyanchi.shengji.juese1,true);
		local b = MyFindMultiColor(feature.task.jingyanchi.shengji.juese2,true);
		local c = MyFindMultiColor(feature.task.jingyanchi.shengji.juese3,true);
		local d = MyFindMultiColor(feature.task.jingyanchi.shengji.juese4,true);
		local e = MyFindMultiColor(feature.task.jingyanchi.shengji.juese5,true);
        
        if a == false and b == false and c == false and d == false and e == false then 
            Ares.MessageBox("人物升级完成")
            break;
		end 
    end
end