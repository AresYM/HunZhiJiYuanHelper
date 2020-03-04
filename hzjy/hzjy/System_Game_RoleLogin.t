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
        
		local taskRecordName = Ares2.RootPath..Global.CurrentAccountTitle.._currentAccount..".txt";
		Global.CurrentAccountTaskStatusFile = taskRecordName;
		local isExists = fileexist(taskRecordName);
			
		lineprint(taskRecordName.."是否存在："..isExists);
		local dayStr = os.date("%Y%m%d");
		
		-- 不存在  创建并初始化内容
		if isExists == 0 then
			local f = fileopen(taskRecordName,"a+");
			filewrite(f,dayStr);
			fileclose(f);
			Global.TaskStatus={};
			Global.TaskStatus[1] = dayStr;
		-- 存在 读出内容
		else
			local content =filereadex(taskRecordName)
			local taskStatus = Ares2.Ext.Split(content,"|");
			
			if	taskStatus[1] == dayStr then
				Global.TaskStatus = taskStatus;
			else
				Global.TaskStatus={};
				Global.TaskStatus[1] = dayStr;
			end
		end
        
        return true;
	else
        return false;
	end
end


function ChangeTaskStatus(taskId)
	local finded = false;
	for i=1,#Global.TaskStatus,1 do
        if tostring(Global.TaskStatus[i]) == tostring(taskId) then
            finded = true;
            break;
		end
    end
    if finded then
        return ;
	end 
    
	table.insert(Global.TaskStatus,taskId)
    local str = "";
    for i=1,#Global.TaskStatus,1 do
        if i == 1 then
            str = Global.TaskStatus[1].."|";
        elseif i == #Global.TaskStatus then
            str = str..Global.TaskStatus[i];
        else
			str = str..Global.TaskStatus[i].."|";
		end
    end
    AresFileWrite(Global.CurrentAccountTaskStatusFile,str);
end

function CheckTaskStatus(taskId)
    local content =filereadex(Global.CurrentAccountTaskStatusFile)
    lineprint("内容"..content)
	local taskStatus = Ares2.Ext.Split(content,"|");
    local finded = false;
    for i=1,#Global.TaskStatus,1 do
        if tostring(Global.TaskStatus[i]) == tostring(taskId) then
            finded = true;
            break;
		end
    end
    
    lineprint("taskid"..tostring(finded))
    return finded;
end

function AresFileWrite(path,content)
    
    lineprint("写入文件"..path.."内容"..content)
    local f = fileopen(path,"w+");
     
	filewrite(f,content);
	fileclose(f);
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
