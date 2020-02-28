function KuaFuHanHua()
    local txt = editgettext("task_kuafuhanhua_neirong");
    
    if txt ~= nil and txt ~= "" then
        -- 打开聊天
        Ares.TapFormFeature(feature.聊天.打开聊天);
        
        
        Ares.Sleep(2);
        
        -- 选择跨服
        Ares.TapFormFeature(feature.聊天.跨服聊天);
        
        -- 点击聊天文本框
        Ares.TapFormFeature(feature.聊天.聊天输入);
		local offset = math.random(0,20);
        
		local newTxt = txt;-- string.gsub(txt,"","-");
        lineprint(newTxt)
        newTxt = offset..newTxt.." 辅-助-裙66364270";
        
        -- 输入文字
        inputtext(newTxt);
        Ares.Sleep(2);
        
        -- 发送
        Ares.TapFormFeature(feature.聊天.发送);
        
        
        -- 关闭
        Ares.TapFormFeature(feature.聊天.关闭聊天);
        
	end 
end