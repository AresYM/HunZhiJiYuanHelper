-- 批量熔炼
function PiLiangRongLian()
    -- 点击背包按钮
    Ares.TapFormFeature(feature.task.beibao.icon);
    -- 点击批量熔炼按钮
    Ares.TapFormFeature(feature.task.beibao.ronglian.piliangronglian)
    -- 点击熔炼按钮
    Ares.TapFormFeature(feature.task.beibao.ronglian.ronglian_guanbi)
    -- 点击关闭按钮
    Ares.TapFormFeature(feature.task.beibao.ronglian.ronglian_guanbi)
end