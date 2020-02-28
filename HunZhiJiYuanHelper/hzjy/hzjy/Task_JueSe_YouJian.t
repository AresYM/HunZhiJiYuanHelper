-- 收取邮件
function ShouQuYouJian()
    
    -- 打开好友
    Ares.TapFormFeature(feature.task.haoyou.icon);
    Ares2.Sleep(2);
    -- 打开邮件
    Ares.TapFormFeature(feature.task.haoyou.youjian.icon);
    Ares.TapFormFeature(feature.task.haoyou.youjian.icon);
    Ares2.Sleep(2);
    -- 一键领取
    Ares.TapFormFeature(feature.task.haoyou.youjian.yijianlingqu);
    -- 关闭提示界面
    Ares.TapFormFeature(feature.task.haoyou.youjian.yijianlingqu);
    sleep(2000);
    -- 删除已读
    Ares.TapFormFeature(feature.task.haoyou.youjian.shanchuyidu);
end

