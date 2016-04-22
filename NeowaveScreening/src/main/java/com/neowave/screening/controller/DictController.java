package com.neowave.screening.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.neowave.screening.model.FescoDict1;
import com.neowave.screening.model.FescoDict3;
import com.neowave.screening.model.FescoDictRisk;
import com.neowave.screening.service.DictService;

@Controller
public class DictController {
	@Autowired
	private DictService dictService;
	
	@RequestMapping(value = "/dict1/{code}", method = {RequestMethod.GET})
	@ResponseBody
	public Map<String, Object> dict1(@PathVariable String code) {
		List<FescoDict1> dictList = dictService.selectDict1(code);
		Map<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("resultCode", "OK");
		resultMap.put("list", dictList);
		return resultMap;
	}
	
	@RequestMapping(value = "/dict3", method = {RequestMethod.GET})
	@ResponseBody
	public Map<String, Object> dict3() {
		List<FescoDict3> dictList = dictService.selectDict3();
		Map<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("resultCode", "OK");
		resultMap.put("list", dictList);
		return resultMap;
	}
	
	@RequestMapping(value = "/dict/risk", method = {RequestMethod.GET})
	@ResponseBody
	public Map<String, Object> dictRisk() {
		List<FescoDictRisk> dictList = dictService.selectDictRisk();
		Map<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("resultCode", "OK");
		resultMap.put("list", dictList);
		return resultMap;
	}
}
