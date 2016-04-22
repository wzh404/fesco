package com.neowave.screening.controller;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.neowave.screening.service.DictService;
import com.neowave.screening.vo.DictVo;

@Controller
public class ScreenController {
	private final Logger logger = Logger.getLogger(ScreenController.class);
	
	@Autowired
	private DictService dictService;
	
	@RequestMapping(value = "/screen", method = {RequestMethod.GET})
	public ModelAndView screening(){
		DictVo dictVo = new DictVo();		
		dictVo.setDict1List(dictService.selectDict1All());
		logger.info("size is " + dictVo.get("01").size());
		
		return new ModelAndView("showUser", "dict", dictVo);
	}
}
