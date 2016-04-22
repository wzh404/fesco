package com.neowave.screening.dao;

import java.util.List;

import com.neowave.screening.model.FescoDict1;
import com.neowave.screening.model.FescoDict3;
import com.neowave.screening.model.FescoDictRisk;

public interface DictMapper {
	/**
	 * 根据字典code查询一级字典数据
	 * 
	 * @param dcode 字典code
	 * @return
	 */
	public List<FescoDict1> selectDict1(String dcode);
	
	public List<FescoDict3> selectDict3();
	
	public List<FescoDictRisk> selectDictRisk();
	
	public List<FescoDict1> selectDict1All();
}