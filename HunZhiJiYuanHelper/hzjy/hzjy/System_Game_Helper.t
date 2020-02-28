-- 关闭所有弹窗 并回到首页
function CloseAllDialogAndBackToIndex()
    -- 检测是不是在神殿内
    if TaskBossCheckIsInShenDianIndex(true) == true then 
        Ares.Sleep(5);
	end
    
    -- 检测有没有聊天窗口
	if Ares.FindMultiColorWithTap(feature.聊天.聊天定位1) == true and Ares.FindMultiColorWithTap(feature.聊天.聊天定位2) == true then 
		Ares.TapFormFeature(feature.聊天.关闭聊天)
	end
    
    
    -- 检测是不是在挖矿界面
	Ares2.Find.MultiColor(feature.水晶遗迹.退出按钮,true);
    
    
    -- 检测是不是在工会界面
    
    
    
    -- 检测一些异常提示框
    Ares.FindMultiColorWithTap(feature.异常处理.提示1,true)
   
    Ares.Sleep();
end


-- 检测是不是在游戏首页
function CheckIsGameIndexPage()
	local a = Ares.FindMultiColorWithTap(feature.游戏首页.定位点1);
	local b = Ares.FindMultiColorWithTap(feature.游戏首页.定位点2);
    if a == true and b == true then
        return true;
    else
        return false;
    end
end




-- 初始化到首页
function InitGameIndex(success,fail)
	-- 关闭一些异常的窗口
	CloseAllDialogAndBackToIndex();
    
    
    
	-- 检测是不是首页
    if CheckIsGameIndexPage() == false then
        local x1 = -1 y1 = -1;
		x1,y1 = Ares.FindText(feature.index.back1);
		local x2 = -1 y2 = -1;
		x2,y2 = Ares.FindText(feature.index.back2);
		if x1>0 and y1>0 then
			Ares.Tap(x1,y1);
			return success;
		elseif x2>0 and y2>0 then
			Ares.Tap(x2,y2);
			return success;
		else
			Ares.Tap(696,1177);
			return fail;
		end
	else
        return success;
	end 
end

