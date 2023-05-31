package com.green.airline.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.green.airline.repository.interfaces.MemoRepository;
import com.green.airline.repository.model.Memo;

/**
 * @author 서영
 *
 */
@Service
public class MemoService {

	@Autowired
	private MemoRepository memoRepository;
	
	/**
	 * 메모 갱신
	 * 만약 메모가 존재하지 않는다면 생성
	 */
	public void updateMemo(Memo memo) {
		
		// 존재하는지 확인
		Memo entity = readByManagerId(memo.getManagerId());
		
		if (entity == null) {
			memoRepository.insert(memo);
		} else {
			// content에 변화가 없다면 갱신하지 않음
			if (memo.getContent().equals(entity.getContent())) {
				return;
			}
			memoRepository.update(memo);
			System.out.println("dddd");
		}
		
	}
	
	/**
	 * 해당 관리자의 메모 조회
	 */
	public Memo readByManagerId(String managerId) {
		return memoRepository.selectByManagerId(managerId);
	}
	
}
