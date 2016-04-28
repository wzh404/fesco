package com.neowave.screening.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.neowave.screening.dao.DictMapper;
import com.neowave.screening.model.FescoDict;
import com.neowave.screening.model.FescoDict1;
import com.neowave.screening.model.FescoDict3;
import com.neowave.screening.model.FescoDictRisk;
import com.neowave.screening.service.DictService;

@Service("dictService")
public class DictServiceImpl implements DictService {
	@Autowired
	private DictMapper dictMapper;

	public List<FescoDict1> selectDict1(String dcode) {
		return dictMapper.selectDict1(dcode);
	}

	@Override
	public List<FescoDict3> selectDict3() {
		return dictMapper.selectDict3();
	}

	@Override
	public List<FescoDictRisk> selectDictRisk() {
		return dictMapper.selectDictRisk();
	}

	@Override
	public List<FescoDict1> selectDict1All() {
		return dictMapper.selectDict1All();
	}

	@Override
	public int updateDict1(FescoDict1 dict1) {
		return dictMapper.updateDict1(dict1);
	}

	@Override
	public int insertDict1(FescoDict1 dict1) {
		return dictMapper.insertDict1(dict1);
	}

	@Override
	public FescoDict selectDict(String code) {
		return dictMapper.selectDict(code);
	}

	@Override
	public List<FescoDict3> selectDict3Level1() {
		return dictMapper.selectDict3Level1();
	}

	@Override
	public List<FescoDict3> selectDict3Level2(int pid) {
		return dictMapper.selectDict3Level2(pid);
	}

	@Override
	public int updateDict3(FescoDict3 dict3) {
		return dictMapper.updateDict3(dict3);
	}

	@Override
	public int updateRisk(FescoDictRisk risk) {
		return dictMapper.updateRisk(risk);
	}
}
