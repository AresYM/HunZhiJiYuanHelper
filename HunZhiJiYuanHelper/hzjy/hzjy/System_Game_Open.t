local LoginGameErrorTimes = 0;

-- 开启游戏
function Unit.State.OpenGame()
    
    local gameName = gettopapppackagenameex();
    
    if gameName == Global.PackageName then
        
		LoginGameErrorTimes = LoginGameErrorTimes + 1;
        
        Ares2.MessageBox("尝试第"..LoginGameErrorTimes.."次登录")
        
		if Ares2.Find.MultiColor(feature.小七手游.小号列表) == false then
            Ares2.TapFormFeature(feature.小七手游.游戏标签);
		end 
        
		local sh5 = Ares2.Find.Text(feature.小七手游.H5未选择,true);
        
		local bh5 = Ares2.Find.Text(feature.小七手游.H5已选择,true);
        
		if LoginGameErrorTimes > 10 then
            LoginGameErrorTimes = 0;
            KillGame()
            return "OpenGame";
		end
        
        -- 启动成功了 继续下一步
        if sh5 or bh5 then
			-- 向下滑动 找出游戏图标
			Ares2.Swipe(360,540,360,1080,3,1);
            -- 点击魂之纪元的游戏图标
            if Ares2.Find.MultiColor(feature.小七手游.魂之纪元,true) then
				Ares2.Sleep(1);
                local loginResult = RoleLogin();
                if loginResult == true then
                    LoginGameErrorTimes = 0;
                    return "SystemGameJoin"
                else
                    return "OpenGame";
                end
            else
                return "OpenGame";
            end
        else
            -- 检测是不是进入了账号列表界面
            if Ares2.Find.MultiColor(feature.小七手游.小号列表) then
				Ares2.Sleep(1);
                local loginResult = RoleLogin();
                if loginResult == true then
                    LoginGameErrorTimes = 0;
                    return "SystemGameJoin"
                else
                    return "OpenGame";
                end
            else
                -- 检测是不是已经在游戏内了
                if CheckIsGameIndexPage() == true then 
                    return "HandleTasks";
                else
					-- 检测是不是进入了开始游戏界面
                    if Ares2.Find.MultiColor(feature.游戏进入页.老账号_开始冒险) then
						LoginGameErrorTimes = 0;
						return "SystemGameJoin";
					else					
						return "OpenGame";
                    end
                end
            end
        end
    else
        -- 启动游戏
        StartGameOnly();
        -- 没启动成功 继续检测
        return "OpenGame";
    end
end

Unit.Param.OpenGame={

};