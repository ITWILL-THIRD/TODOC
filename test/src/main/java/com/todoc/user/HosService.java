package com.todoc.user;

public interface HosService {
	HospitalVO getHos(HospitalVO ho);
	void insertHos(HospitalVO vo);
	int hosId(HospitalVO ho) throws Exception;
}