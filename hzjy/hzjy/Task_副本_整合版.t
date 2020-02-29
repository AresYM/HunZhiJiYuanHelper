function FuBenZhengHeBan()
    
	Ares2.TapFormFeature(feature.副本.图标);
    while true do
        local isFinish = true;
        
        -- 1、装备副本
		if checkgetselected("task_zhuangbeifuben") == true then
            -- 点击副本按钮-- 寻路进入装备副本
			while IsFuBenIndex() == false do
				Ares2.TapFormFeature(feature.副本.图标);
				Ares2.MessageBox("副本寻路中");
			end
			 -- 检测装备副本能不能打
			Ares2.TapFormFeature(feature.副本.装备副本.图标);
            Ares2.Sleep(2);
			
			if Ares2.Find.MultiColor(feature.副本.装备副本.可以挑战) then
				isFinish = false;
				-- 切换最简单的副本
				Ares.TapFormFeature(feature.副本.装备副本.副本类别);
				-- 切换到噩梦副本
				Ares.TapFormFeature(feature.副本.装备副本.难度);
				-- 开打
				Ares.TapFormFeature(feature.副本.装备副本.开始挑战);
				local retryTimes = 0;
				-- 检测装备副本是否完成
				while IsFuBenIndex() == false do
                    Ares2.Sleep(1);
                    if retryTimes >= 120 then
						Ares2.MessageBox("副本挑战超时")
                        
                        break;
					end
                    retryTimes = retryTimes + 1;
					Ares2.MessageBox("装备副本挑战中")
				end
			end
		end	        
        
		
        
		-- 2、魂卡副本
        if checkgetselected("task_hunkafuben") == true then
			-- 点击副本按钮-- 寻路进入装备副本
			while IsFuBenIndex() == false do
				Ares2.TapFormFeature(feature.副本.图标);
				Ares2.MessageBox("副本寻路中");
			end
			Ares2.TapFormFeature(feature.副本.魂卡副本.图标);
			Ares2.Sleep(2);
			
			if Ares2.Find.MultiColor(feature.副本.魂卡副本.可以挑战) then
				isFinish = false;
				-- 切换最简单的副本
				Ares.TapFormFeature(feature.副本.魂卡副本.副本类别);
				-- 切换到噩梦副本
				Ares.TapFormFeature(feature.副本.魂卡副本.难度);
				-- 开打
				Ares.TapFormFeature(feature.副本.魂卡副本.开始挑战);
				local retryTimes = 0;
				-- 检测装备副本是否完成
				while IsFuBenIndex() == false do
                    Ares2.Sleep(1);
                    if retryTimes >= 120 then
						Ares2.MessageBox("副本挑战超时")
                        
                        break;
					end
                    retryTimes = retryTimes + 1;
					Ares2.MessageBox("魂卡副本挑战中")
				end
			end
        end
        
        
			
		-- 3、经验副本
		if checkgetselected("task_jingyanfuben") == true then
			-- 点击副本按钮-- 寻路进入装备副本
			while IsFuBenIndex() == false do
				Ares2.TapFormFeature(feature.副本.图标);
				Ares2.MessageBox("副本寻路中");
			end
			Ares2.TapFormFeature(feature.副本.经验副本.图标);
			Ares2.Sleep(2);
			if Ares2.Find.MultiColor(feature.副本.经验副本.可以挑战) then
				isFinish = false;
				-- 检测是不是CD中
				if Ares2.Find.MultiColor(feature.副本.经验副本.CD中) == true then
					Ares2.MessageBox("经验副本CD中")
				else 
					-- 开打
					Ares.TapFormFeature(feature.副本.经验副本.开始挑战);
					Ares.TapFormFeature(feature.副本.经验副本.开始挑战确定);
					 
					
					-- 检测是不是在挑战中
					while Ares2.Find.MultiColor(feature.副本.经验副本.挑战中定位点1) == true do
						Ares2.MessageBox("经验副本挑战中")
					end
					Ares.TapFormFeature(feature.副本.经验副本.离开确定);
				end
			end
        end
        
		-- 4、雷霆岛
		if checkgetselected("task_jingyanfuben") == true then
            -- 点击副本按钮-- 寻路进入装备副本
			while IsFuBenIndex() == false do
				Ares2.TapFormFeature(feature.副本.图标);
				Ares2.MessageBox("副本寻路中");
			end
			Ares2.TapFormFeature(feature.副本.雷霆岛.图标);
			Ares2.Sleep(2);
			if Ares2.Find.MultiColor(feature.副本.雷霆岛.可以挑战) then
				isFinish = false;
				-- 开打
				Ares.TapFormFeature(feature.副本.雷霆岛.开始挑战);
				Ares.TapFormFeature(feature.副本.雷霆岛.开始挑战确定);
				
				-- 检测是不是在挑战中
				local retryTimes = 0;
				-- 检测装备副本是否完成
				while IsFuBenIndex() == false do
                    Ares2.Sleep(1);
                    if retryTimes >= 120 then
						Ares2.MessageBox("副本挑战超时")
                        
                        break;
					end
                    retryTimes = retryTimes + 1;
					Ares2.MessageBox("雷霆岛副本挑战中")
				end
			end
        end
        
        if isFinish == true then
			Ares2.MessageBox("副本全部挑战完毕")
			Ares.TapFormFeature(feature.副本.关闭);
            break;
		end
        
    end
end


function IsFuBenIndex()
    local pos1 = Ares2.Find.MultiColor(feature.副本.定位点1);
    local pos2 = Ares2.Find.MultiColor(feature.副本.定位点2);
    if	pos1 and pos2 then
		return true;
	else
		return false;
	end
end