package com.neowave.screening.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.druid.util.StringUtils;
import com.neowave.screening.model.Drug;
import com.neowave.screening.service.DrugService;

@Controller
public class DrugController {	
	@Autowired
	private DrugService drugService;
	
	@RequestMapping(value = "/drug/{code}", method = {RequestMethod.GET})
	@ResponseBody
	public Map<String, Object> drug(@PathVariable String code) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		Drug drug = drugService.selectDrug(code);
		if (drug != null){
			setIcon(drug);
			resultMap.put("resultCode", "OK");
			resultMap.put("drug", drug);
		}
		else{
			resultMap.put("resultCode", "ERR");
			resultMap.put("resultMsg", "药品不存在");
		}
		
		return resultMap;
	}
	
	@RequestMapping(value = "/manual/{code}", method = {RequestMethod.GET})
	public ModelAndView manual(@PathVariable String code){
		String manual = drugService.selectDrugManual(code);
		if (StringUtils.isEmpty(manual)){
			manual = "暂无说明书";
		}
		return new ModelAndView("drug", "manual", toHTMLString(manual));
	}
	
	private static void setIcon(Drug drug){
		String[] s = {
				"jiaolang:胶囊:粒",
				"pianji:片剂,咀嚼片,糖衣片:片", 
				"wanji:丸剂,大蜜丸,水蜜丸,丸:丸", 
				"hunxuan:混悬剂,糖浆剂,合剂:none", 
				"keli:颗粒剂:none"
		};
		
		for (String ss : s){
			String[] s2 = ss.split(":");
			String[] s3 = s2[1].split(",");
			
			for (String sss: s3){
				if (drug.getForm() != null && drug.getForm().contains(sss)){
					drug.setIcon(s2[0]);
					
					if ("none".equalsIgnoreCase(s2[2])){
						setDosage(drug);
					}
					else{
						drug.setDosage(s2[2]);
					}
					return;
				}
			}
		}
		
		drug.setIcon("other");
		setDosage(drug);
	}
	
	private static void setDosage(Drug drug){
		String[] s = {
				"片:每片,糖衣片",
				"粒:每粒",
				"滴:每滴",
				"贴:每贴,贴",
				"揿:每揿",
				"丸:丸",
				"杯:每杯",
				"袋:每袋",
				"支:每支",
				"包:每包",
				"瓶:每瓶",
				"毫升:ml,毫升",
				"克:克,g",
				"微克:微克",
				"毫克:mg,毫克",
		};
		
		for (String ss : s){
			String[] s2 = ss.split(":");
			String[] s3 = s2[1].split(",");
			for (String sss: s3){
				if (drug.getSpec() != null && drug.getSpec().contains(sss)){
					drug.setDosage(s2[0]);
					return;
				}
			}
		}
		
		drug.setDosage("粒");
	}
	
	public static String toHTMLString(String in) {
		in = in.replace("&nbsp;", "");
        StringBuffer out = new StringBuffer();
        for (int i = 0; in != null && i < in.length(); i++) {
            char c = in.charAt(i);
            if (c == '\\')
                out.append("&#039;");
            else if (c == '/')
                out.append("&#034;");
            else if (c == '<')
                out.append("&lt;");
            else if (c == '>')
                out.append("&gt;");
            else if (c == '&')
                out.append("&amp;");
            else if (c == ' ')
                out.append("&nbsp;");
            else if (c == '\n')
                out.append("<br/>");
            else
                out.append(c);
        }
        return out.toString();
    }
	
//	public static void main(String[] args){
//		Drug drug = new Drug();
//		drug.setForm("丸剂");
//		DrugController.setIcon(drug);
//		System.out.println(drug.getIcon());
//	}
}
