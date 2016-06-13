package com.neowave.screening.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.neowave.screening.dao.DrugMapper;
import com.neowave.screening.model.Drug;
import com.neowave.screening.service.DrugService;

@Service("drugService")
public class DrugServiceImpl implements DrugService{
	@Autowired
	private DrugMapper drugMapper;
	
	@Override
	public Drug selectDrug(String code) {		
		return drugMapper.selectDrug(code);
	}

	@Override
	public String selectDrugManual(String code) {
		return drugMapper.selectDrugManual(code);
	}	
}
