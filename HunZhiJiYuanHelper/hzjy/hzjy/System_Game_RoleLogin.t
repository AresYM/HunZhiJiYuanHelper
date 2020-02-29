-- 根据配置文件登录小号
function RoleLogin()
    -- 上滑显示全部列表
	Ares2.Swipe(360,840,360,240,4,1);
    Ares2.Sleep(1);
	Ares2.Swipe(360,840,360,240,4,1);
    
    local _currentAccount = Global.AccountList[tonumber(Global.CurrentAccount)]
	Ares2.MessageBox("当前准备登录账号".._currentAccount);
    
    local fontParam = feature.角色账号[_currentAccount];
    
	if Ares2.Find.Text(fontParam,true,"account_font_library") then	
        Global.CurrentAccount = tonumber(Global.CurrentAccount) + 1;
        Global.ChangeXiaoQiAccount = false;
		if Global.CurrentAccount > table.getn(Global.AccountList) then
			Global.CurrentAccount = Global.AccountList[1];
            Global.ChangeXiaoQiAccount = true;
		end 
        
        return true;
	else
        return false;
	end
end


function InitAccounts()
    local accountList = {};
    
    
	local labels = {
		"account1","account2","account3",
		"account4","account5","account6",
		"account7","account8","account9"
    
    };
    
    for i=1,table.getn(labels),1 do
        if checkgetselected(labels[i]) == true then
			table.insert(accountList,i);
		end
    end
    
    Global.AccountList = accountList;
    
    
     -- 默认账号
    local start_account = getselectscheckitemindex("zhanghao_start");
    start_account = start_account + 1;
    
    lineprint("默认"..start_account);
    for i=1,table.getn(Global.AccountList),1 do
        lineprint("当前"..Global.AccountList[i].."index"..i);
        if tonumber( Global.AccountList[i]) == tonumber(start_account) then
            Global.CurrentAccount = i;
            break;
		end
    end
    
    
end
