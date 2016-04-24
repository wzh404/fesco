package com.neowave.screening.vo;

import java.util.ArrayList;
import java.util.List;

import com.neowave.screening.model.FescoDict1;
import com.neowave.screening.model.FescoDictRisk;

public class DictVo {
	private List<FescoDict1> dict1List;
	private List<FescoDictRisk> dictRisk;
	
	public List<FescoDictRisk> getDictRisk() {
		return dictRisk;
	}

	public void setDictRisk(List<FescoDictRisk> dictRisk) {
		this.dictRisk = dictRisk;
	}

	public List<FescoDict1> getDict1List() {
		return dict1List;
	}

	public void setDict1List(List<FescoDict1> dict1List) {
		this.dict1List = dict1List;
	}

	public List<FescoDict1> get(String dcode){
		List<FescoDict1> dict1s = new ArrayList<FescoDict1>();
		
		for (FescoDict1 dict1 : dict1List){
			if (dcode.equalsIgnoreCase(dict1.getDcode())){
				dict1s.add(dict1);
			}
		}
		
		return dict1s;
	}
}
