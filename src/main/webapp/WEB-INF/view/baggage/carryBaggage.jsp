<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>

<main>
	<div>
		<div>
			<h1>휴대 수하물</h1>
		</div>

		<div>
			<p>편안한 여행과 안전운항을 위해 기내로 가져갈 수 있는 휴대 수하물의 종류와 규격 및 개수를 안내해드립니다.</p>
		</div>

		<div>
			<h3>휴대 수하물 허용 기준</h3>

			<div>
				허용 규격
				<ul>
					<li>무게 : 10kg(22lbs)</li>
					<li>크기 : 삼변의 합 115cm 이내 (손잡이와 바퀴 포함)</li>
					<li>* 각 변의 최대치 A(Height) 55 cm, B(Depth) 20 cm, C(Width) 40 cm</li>
				</ul>
			</div>
		</div>

		<div>
			<h3>휴대 수하물 규격 및 개수</h3>

			<div>기내로 가져갈 수 있는 휴대 수하물의 규격 및 개수를 다음과 같이 제한하고 있습니다.</div>

			<div class="table_wrap">
				<table class="table_list table_bag">
					<caption>
						<strong>휴대수하물 규격 및 개수 표</strong>
						<p>비즈니스 클래스,이코노미 클래스로 구성된 표입니다.</p>
					</caption>
					<colgroup>
						<col style="width: 50%;" span="2">
					</colgroup>
					<thead>
						<tr>
							<th scope="col" class="NamoSE_border_show">비즈니스 클래스</th>
							<th scope="col" class="NamoSE_border_show">이코노미 클래스</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>
								<div>
									<span>10kg(22lbs)</span> <span>10kg(22lbs)</span>
									<p>
										무게 : <span>10kg</span>(22lbs) 이내<br> 허용 개수 : <span>2개</span>
									</p>
								</div>
							</td>
							<td>
								<div>
									<span>10kg(22lbs)</span>
									<p>
										무게 : <span>10kg</span>(22lbs) 이내<br> 허용 개수 : <span>1개</span>
									</p>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
				<ul>
					<li>수하물은 반드시 머리 위 선반이나 앞 좌석 밑에 안전하게 수납할 수 있어야 합니다.</li>
					<li>비즈니스 스위트 탑승 시 비즈니스 클래스 규정 적용</li>
				</ul>
			</div>
		</div>

	</div>

</main>

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>