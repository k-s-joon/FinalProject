package kr.or.ddit.good.service;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.employee.vo.EmployeeVO;
import kr.or.ddit.good.vo.GoodVO;
import kr.or.ddit.mapper.EmployeeMapper;
import kr.or.ddit.mapper.GoodMapper;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class GoodServiceImpl implements IGoodService {
	
	@Inject
	private GoodMapper goodMapper;
	
	@Inject
	private EmployeeMapper empMapper;

	@Override
	public List<GoodVO> getGoodList(String youLikeNo) {

		return goodMapper.getGoodList(youLikeNo);
	}

	@Override
	public List<EmployeeVO> getEmpByGoodList(List<GoodVO> goodList) {
		
		List<EmployeeVO> empList = new ArrayList<EmployeeVO>();
		
		for (int i = 0; i < goodList.size(); i++) {
			EmployeeVO empVO = new EmployeeVO();
			
			String empNo = goodList.get(i).getEmpNo();
			empVO.setEmpNo(empNo);
			
			empVO = empMapper.getEmp(empVO);
			empList.add(empVO);
			
		}
		return empList;
	}

	//좋아요 insert 공지게시판
	@Override
	public void insertGood(GoodVO goodVO) {
		
		goodMapper.insertGood(goodVO);
	}

	//좋아요 insert 자유게시판
	@Override
	public void insertFree(GoodVO goodVO) {
		
		goodMapper.insertFree(goodVO);
	}

	//나의 좋아요 List
	@Override
	public List<GoodVO> getLikesByUsername(String myLikeNo) {

		return goodMapper.getLikesByUsername(myLikeNo);
	}

	@Override
	public void deleteGood(GoodVO goodVO) {
		// TODO Auto-generated method stub
		goodMapper.deleteGood(goodVO);
		
	}


}
