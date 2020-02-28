function WuPinPaiMai()
   -- 打开背包
   Ares.TapFormFeature(feature.task.beibao.icon);
   
   -- 验证第五个物品是不是拍品   
   local wupin4 = Ares.FindMultiColorWithTap(feature.task.beibao.paimai.wupin4);
   local wupin4_outtime = Ares.FindMultiColorWithTap(feature.task.beibao.paimai.wupin4_outtime)
   local wupin1 = Ares.FindMultiColorWithTap(feature.task.beibao.paimai.wupin1);
   
   -- 如果是拍卖物品
   if wupin4 == true or wupin4_outtime == true then
       -- 点开 并上架
       Ares.TapFormFeature(feature.task.beibao.paimai.wupin4_click);
       
       Ares.TapFormFeature(feature.task.beibao.paimai.wupin_shiyong);
       
       while true do
			if Ares.FindMultiColorWithTap(feature.task.beibao.paimai.piliang_weiwancheng) == true then
                Ares.TapFormFeature(feature.task.beibao.paimai.piliang_naqupaimai);
			elseif Ares.FindMultiColorWithTap(feature.task.beibao.paimai.piliang_guoqi) == true then
                Ares.TapFormFeature(feature.task.beibao.paimai.piliang_zijishiyong);
            else
                Ares.MessageBox("拍卖处理完成");
                -- 关闭拍卖框
                Ares.TapFormFeature(feature.task.beibao.paimai.paimai_guanbi);
                -- 关闭背包框
                Ares.TapFormFeature(feature.system.back2);
                break;
            end
       end
   else
		while Ares.FindMultiColorWithTap(feature.task.beibao.paimai.wupin1) == true do
            Ares.TapFormFeature(feature.task.beibao.paimai.wupin1_click);
			Ares.TapFormFeature(feature.task.beibao.paimai.wupin_shiyong);
			Ares.TapFormFeature(feature.task.beibao.paimai.dange_naqupaimai);
        end
		Ares.MessageBox("拍卖处理完成");
		-- 关闭背包框
		Ares.TapFormFeature(feature.system.back2);
   end
end