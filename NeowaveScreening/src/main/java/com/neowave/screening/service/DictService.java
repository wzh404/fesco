package com.neowave.screening.service;

import java.util.List;

import com.neowave.screening.model.FescoDict1;
import com.neowave.screening.model.FescoDict3;
import com.neowave.screening.model.FescoDictRisk;

public interface DictService {
	/**
	 * 
	 * @param dcode
	 * @return
	 */
	public List<FescoDict1> selectDict1(String dcode);
	
	/**
	 * 
	 * @return
	 */
	public List<FescoDict1> selectDict1All();
	
	/**
	 * 
	 * @return
	 */
	public List<FescoDict3> selectDict3();
	
	/**
	 * 
	 * @return
	 */
	public List<FescoDictRisk> selectDictRisk();
}
