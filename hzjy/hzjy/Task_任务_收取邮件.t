-- 收取邮件
function ShouQuYouJian()
    
    -- 打开好友
    Ares2.TapFormFeature(feature.好友.图标);
    Ares2.Sleep(2);
    
    -- 打开邮件
    Ares2.TapFormFeature(feature.好友.邮件.图标);
    Ares2.Sleep(2);
    -- 一键领取
    
    Ares2.Find.MultiColor(feature.好友.邮件.一键领取,true)
     
    Ares2.TapFormFeature(feature.好友.邮件.领取确认);
     
    sleep(2000);
    -- 删除已读
    Ares2.TapFormFeature(feature.好友.邮件.删除已读);
    
    -- 查未读邮件
    
    while Ares2.Find.MultiColor(feature.好友.邮件.未读邮件,true) do
		-- 点删除 
		Ares2.TapFormFeature(feature.好友.邮件.删除未读);
    end
    
    Ares2.TapFormFeature(feature.好友.邮件.退出);
    
    Ares2.MessageBox("邮件处理完毕")
    
    ChangeTaskStatus(2);
end

