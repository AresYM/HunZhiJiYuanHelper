function ChangeAccount()
	KillGame();
	sleep(3000);
	if checkgetselected("multiAccount") then
        if Global.ChangeXiaoQiAccount == true then
            return "XiaoQiLogin";
        else
			return "OpenGame";
		end  
	else
		return "OpenGame"
	end
end