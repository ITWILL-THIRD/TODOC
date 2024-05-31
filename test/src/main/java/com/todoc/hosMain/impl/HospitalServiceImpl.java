package com.todoc.hosMain.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.todoc.hosMain.HospitalService;
import com.todoc.hosMain.HospitalVO;
import com.todoc.hosMain.dao.HospitalDAO;

@Service("hospitalService")
public class HospitalServiceImpl implements HospitalService {
	@Autowired
	private HospitalDAO hospitalDAO;
	
	public HospitalServiceImpl(HospitalDAO joinHospitalDAO) {
		System.out.println(">> HospitalServiceImpl(joinHospitalDAO) 객체 생성");
	}
	
	//병원 상세 조회
	@Override
	public HospitalVO selectOne(int hosIdx) {
		return hospitalDAO.selectOne(hosIdx);
	}

	//병원 전체 조회
	@Override
	public List<HospitalVO> selectList() {
		return hospitalDAO.selectList();
	}

	@Override
	public List<HospitalVO> getHosSearch(HospitalVO vo) {
		return hospitalDAO.getHosSearch(vo);
	}

}