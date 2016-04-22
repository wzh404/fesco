package com.neowave.screening.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.neowave.screening.dao.DictMapper;
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
}
