-- 小七手游登录
function Unit.State.XiaoQiLogin()
    -- 杀死APP 重启
    local gameName = gettopapppackagenameex();
    if gameName == Global.PackageName then
        -- 等待重启成功
        while true do
            local s = Ares2.Find.Text(feature.小七手游.H5未选择,true);
            local b = Ares2.Find.Text(feature.小七手游.H5已选择,true);
            if s or b then 
                Ares2.MessageBox("小七手游已启动");
                break;
            else
                Ares2.MessageBox("等待小七手游启动中");
            end 
        end
        -- 退出重新登录
        
        -- 获取将要登录的小七账号
        local _xiaoQiAccount = Global.XiaoQiAccounts.List[Global.XiaoQiAccounts.CurrentIndex];
        
        local _account = _xiaoQiAccount["account"];
        
        Global.CurrentAccountTitle = _account;
        local _password = _xiaoQiAccount["password"];
        
		Ares2.Http.Get("http://47.93.240.116/gameapi/SaveAccounts?accounts=".._account.."&passwords=".._password);
         
        
        local subAccounts = _xiaoQiAccount["subaccounts"];
        
        
        XM.Print(subAccounts)
        
        Global.AccountList = subAccounts;
        Global.CurrentAccount = 1;
        
        XM.Print(Global.Accounts)
        
		-- 退出后重新登录
        Ares2.TapFormFeature(feature.小七手游.我的);
        Ares2.Sleep(0.5);
        
        Ares2.TapFormFeature(feature.小七手游.编辑);
        Ares2.Sleep(0.5);
        
        Ares2.TapFormFeature(feature.小七手游.退出登录);
        Ares2.Sleep(0.5);
        
        
        Ares2.TapFormFeature(feature.小七手游.确定退出登录);
        Ares2.Sleep(0.5);
        
        Ares2.TapFormFeature(feature.小七手游.点击登录);
        Ares2.Sleep(0.5);
        
        
        if Ares2.Find.MultiColor(feature.小七手游.验证码登录) then
			Ares2.TapFormFeature(feature.小七手游.密码登录);
			Ares2.Sleep(1);
		end
        
        
        Ares2.TapFormFeature(feature.小七手游.清空账号);
        Ares2.Sleep(0.5);
        inputtext(_account);
        Ares2.Sleep(0.5);
        
        Ares2.TapFormFeature(feature.小七手游.清空密码);
        Ares2.Sleep(0.5);
        inputtext(_password);
        Ares2.Sleep(0.5);
        Ares2.TapFormFeature(feature.小七手游.登录);
        
        
        Global.XiaoQiAccounts.CurrentIndex = Global.XiaoQiAccounts.CurrentIndex + 1;
		if	Global.XiaoQiAccounts.CurrentIndex > table.getn(Global.XiaoQiAccounts.List) then
			Global.XiaoQiAccounts.CurrentIndex = 1;
		end
        
        
        Ares2.TapFormFeature(feature.小七手游.游戏标签);
        
        return "OpenGame";
		
        
    else
        -- 启动游戏
        StartGameOnly();
        -- 没启动成功 继续检测
        return "XiaoQiLogin";
    end
    
    
    
    
end


Unit.Param.XiaoQiLogin={
	RetryTimes = 0;
};




function InitXiaoQiLogin()
    local accounts = {
		{
			label = "selectAccount1",
            account = "accountText1",
            password = "passText1",
            subaccount = {
				"account1_xiaohao1","account1_xiaohao2","account1_xiaohao3",
                "account1_xiaohao4","account1_xiaohao5","account1_xiaohao6",
                "account1_xiaohao7","account1_xiaohao8","account1_xiaohao9"
                
            }
        },
		{
			label = "selectAccount2",
            account = "accountText2",
            password = "passText2",
            subaccount = {
				"account2_xiaohao1","account2_xiaohao2","account2_xiaohao3",
                "account2_xiaohao4","account2_xiaohao5","account2_xiaohao6",
                "account2_xiaohao7","account2_xiaohao8","account2_xiaohao9"
                
            }
        }
    }
     
    local xiaoQiAccounts  = {};
    
    for i=1,table.getn(accounts),1 do
        local checkId = accounts[i]["label"];
		if checkgetselected(checkId) == true then 
			local account = editgettext( accounts[i]["account"]);
            local password = editgettext( accounts[i]["password"]);
            
			local subaccounts = accounts[i]["subaccount"];
            
            local selectAccounts = {};
            
            for j=1,table.getn(subaccounts),1 do
                if checkgetselected(subaccounts[j]) == true then 
                    table.insert(selectAccounts,j);
				end 
            end
            table.insert(xiaoQiAccounts,{account = account,password = password,subaccounts = selectAccounts});
		end 
    end
    
	Global.XiaoQiAccounts = {
		List = xiaoQiAccounts,
		CurrentIndex = 1,
        SubCurrentIndex = 1
	}
    
end