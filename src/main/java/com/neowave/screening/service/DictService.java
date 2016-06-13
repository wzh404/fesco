package com.neowave.screening.service;

import java.util.List;

import com.neowave.screening.model.FescoDict;
import com.neowave.screening.model.FescoDict1;
import com.neowave.screening.model.FescoDict3;
import com.neowave.screening.model.FescoDictRisk;

public interface DictService {
	public FescoDict selectDict(String code);
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
	
	/**
	 * 
	 * @param dict1
	 * @return
	 */
	public int updateDict1(FescoDict1 dict1);
	
	/**
	 * 
	 * @param dict1
	 * @return
	 */
	public int insertDict1(FescoDict1 dict1);
	
	
	public List<FescoDict3> selectDict3Level1();
	
	public List<FescoDict3> selectDict3Level2(int pid);
	
	public int updateDict3(FescoDict3 dict3);
	
	public int updateRisk(FescoDictRisk risk);
}
