package com.neowave.screening.dao;

import com.neowave.screening.model.Drug;

public interface DrugMapper {
	public Drug selectDrug(String code);
	
	public String selectDrugManual(String code);
}
