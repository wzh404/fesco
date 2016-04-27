package com.neowave.screening.controller;

import java.util.ArrayList;
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
import org.springframework.web.servlet.ModelAndView;

import com.neowave.screening.model.FescoDict;
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
	
	@RequestMapping(value = "/home", method = {RequestMethod.GET})
	public ModelAndView home(){		
		return new ModelAndView("redirect:/dict1/list/01");
	}
	
	/**
	 * 一级字典列表
	 * 
	 * @param code
	 * @return
	 */
	@RequestMapping(value = "/dict1/list/{code}", method = {RequestMethod.GET})
	public ModelAndView listDict1(@PathVariable String code){
		FescoDict dict = dictService.selectDict(code);
		List<FescoDict1> dictList = dictService.selectDict1(code);
		
		ModelAndView map = new ModelAndView("list_dict1", "dict1List", dictList);
		map.addObject("dictCode", code);
		map.addObject("dictName", dict.getName());
		return map;
	}
	
	/**
	 * 修改一级字典
	 * 
	 * @param dictCode 字典代码
	 * @param dictId  一级字典ID
	 * @param dictName 一级字典名称
	 * @param dictVal 风险系数
	 * @return
	 */
	@RequestMapping(value = "/dict1/update", method = {RequestMethod.POST})
	public ModelAndView updateDict1(
			@RequestParam(value = "dict_code", required = true) String dictCode,
			@RequestParam(value = "dict_1_id", required = true) Integer dictId,
			@RequestParam(value = "dict_1_name", required = true) String dictName,
			@RequestParam(value = "dict_1_val", required = true) Integer dictVal){
		FescoDict1 dict1 = new FescoDict1();
		dict1.setId(dictId);
		dict1.setDcode(dictCode);
		dict1.setVal(dictVal);
		dict1.setName(dictName);
		
		if (dictId > 0){
			dictService.updateDict1(dict1);
		}
		else{
			dict1.setId(null);
			dict1.setCode("0000");
			dictService.insertDict1(dict1);
		}
		
		return new ModelAndView("redirect:/dict1/list/" + dictCode);
	}
	
	/**
	 * 修改三级字典(岗位分类)
	 * 
	 * @param dictId
	 * @param dictPid
	 * @param dictName
	 * @param dictVal
	 * @return
	 */
	@RequestMapping(value = "/dict3/update", method = {RequestMethod.POST})
	public ModelAndView updateDict3(
			@RequestParam(value = "dict_3_id", required = true) Integer dictId,
			@RequestParam(value = "dict_3_pid", required = true) Integer dictPid,
			@RequestParam(value = "dict_3_name", required = true) String dictName,
			@RequestParam(value = "dict_3_val", required = true) Integer dictVal){
		FescoDict3 dict3 = new FescoDict3();
		dict3.setId(dictId);
		dict3.setName(dictName);
		dict3.setVal(dictVal);
		dictService.updateDict3(dict3);
		
		ModelAndView mav = null;
		if (dictPid == 0){
			mav = new ModelAndView("redirect:/dict3/list/");
		}
		else{
			mav = new ModelAndView("redirect:/dict3/list2/" + dictPid);
		}
		return mav;
	}
	
	
	@RequestMapping(value = "/dict3/list", method = {RequestMethod.GET})
	public ModelAndView listDict3(){
		List<FescoDict3> dictList = dictService.selectDict3Level1();
		
		ModelAndView map = new ModelAndView("list_dict3", "dict3List", dictList);
		return map;
	}
	
	@RequestMapping(value = "/dict3/list2/{pid}", method = {RequestMethod.GET})
	public ModelAndView listDict3Level2(@PathVariable Integer pid){
		List<FescoDict3> dictList = dictService.selectDict3Level2(pid);		
		Map<Integer, List<FescoDict3>> listMap = new HashMap<Integer, List<FescoDict3>>();
		
		for (FescoDict3 dict3 : dictList){
			
			if (dict3.getPpid().intValue() != 0){
				List<FescoDict3> list = listMap.get(dict3.getPpid());
				if (list == null){
					list = new ArrayList<FescoDict3>();
					listMap.put(dict3.getPpid(), list);
				}
				
				list.add(dict3);
			}
		}
		
		for (Map.Entry<Integer, List<FescoDict3>> entry: listMap.entrySet()){
			System.out.println(entry.getKey() + " = " + entry.getValue().size());
		}
		
		ModelAndView mav = new ModelAndView("list_dict3_level2");
		mav.addObject("dict3List", dictList);
		mav.addObject("listMap", listMap);
		return mav;
	}
	
	@RequestMapping(value = "/risk/list", method = {RequestMethod.GET})
	public ModelAndView listRisk(){
		List<FescoDict1> riskList = dictService.selectDict1("02");
		List<FescoDict1> contractList = dictService.selectDict1("03");
		List<FescoDictRisk> dictRisk = dictService.selectDictRisk();
		
		ModelAndView mav = new ModelAndView("list_dict_risk");
		mav.addObject("riskList", riskList);
		mav.addObject("contractList", contractList);
		mav.addObject("dictRisk", dictRisk);
		
		return mav;
	}
}
