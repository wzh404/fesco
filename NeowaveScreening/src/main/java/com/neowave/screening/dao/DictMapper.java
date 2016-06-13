package com.neowave.screening.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.neowave.screening.model.FescoDict;
import com.neowave.screening.model.FescoDict1;
import com.neowave.screening.model.FescoDict3;
import com.neowave.screening.model.FescoDictRisk;

public interface DictMapper {
	public FescoDict selectDict(String code);
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
	
	public int updateDict1(FescoDict1 dict1);
	
	public int insertDict1(FescoDict1 dict1);
	
	public int updateDict3(FescoDict3 dict3);
	
	public int updateRisk(FescoDictRisk risk);
	
	public List<FescoDict3> selectDict3Level1();
	
	public List<FescoDict3> selectDict3Level2(@Param("pid") Integer pid);
}