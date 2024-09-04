$(document).ready(function() {
	
	// 월별 매출액 그래프 
	
	let labelList = new Array();
	let valueList = new Array();
	
	for (let i = 0; i < salesData.length; i++) {
		let target = salesData[i];
		labelList.push(target.period);
		valueList.push(target.sales);
	}
	
	let data = {
			labels: labelList,
			datasets: [{
				// label: 범례 이름
				data: valueList,
				fill: false, // 아래 색 채우기 false
				borderColor: '#8abbe1',
				backgroundColor: '#8abbe1',
				tension: 0 // 꺾은선 그래프 각지게
			}]
	};
	
	let salesContext = document.getElementById('salesChart').getContext('2d');
	new Chart(salesContext, {
		type: 'line', 
		data: data,
		options: {
			responsive: false, // canvas에 너비/높이 주면 차트를 원하는 크기로 조정 가능
			tooltips: {
				callbacks: { // 콤마 처리
					label: function(tooltipItem, data) {
						var value = " " + data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index].toLocaleString();
					    return value;
					}
				},
				mode: "index",
				intersect: false // 가까이 가면 툴팁 보이게
			},
			scales: {
				yAxes: [{
					ticks: { // 콤마 처리
					 	beginAtZero: true,
						callback: function(value, index, values) {
							return (parseInt(value) / 1000000) + "M";
						}                            
					},
					gridLines: {
						color: "#bbb", 
						display: false // 그리드 선 제거
					}
				}],
				xAxes: [{
					gridLines: {
						color: "#bbb",
						display: false // 그리드 선 제거
					}
				}]
			},
			title: { // 차트 대제목 숨김
				display: false
			},
			legend: { // 범례 숨김
				display: false
			},
			layout: {
				padding: {
					left: 10,
					right: 10,
					top: 10,
					bottom: 10
				}
			},
			elements: {
				point: { 
					hoverRadius: 7, // hover 시 포인트 크기
					radius: 4 // 평소 포인트 크기
				}
			}
		}
	});
	
	
	// 고객의 말씀 비율 차트
	
	let labelList2 = new Array();
	let valueList2 = new Array();
	
	for (let i = 0; i < vocData.length; i++) {
		let target = vocData[i];
		labelList2.push(target.type);
		valueList2.push(target.count);
	}
	
	let data2 = {
			labels: labelList2,
			datasets: [{
				// label: 범례 이름
				data: valueList2,
				backgroundColor: ['#afcedc', '#ceddd9', '#E1E9ED', '#d1d1e0']
			}]
	};
	
	let vocContext = document.getElementById('vocChart').getContext('2d');
	new Chart(vocContext, {
		type: 'doughnut', 
		data: data2,
		options: {
			responsive: false, // canvas에 너비/높이 주면 차트를 원하는 크기로 조정 가능
			tooltips: {
				mode: "index",
				intersect: true
			},
			scales: {
				yAxes: [{
	            	display: false, // y축 없애기
					gridLines: {
						display: false // 그리드 선 제거
					}
				}],
				xAxes: [{
	            	display: false, // x축 없애기
					gridLines: {
						display: false // 그리드 선 제거
					}
				}]
			},
			title: { // 차트 대제목 숨김
				display: false
			},
			legend: {
				position: "right"
			}
		}
	});
	
	// 도착지별 이용객 수 순위
	
	let labelList3 = new Array();
	let valueList3 = new Array();
	
	for (let i = 0; i < routeData.length; i++) {
		let target = routeData[i];
		labelList3.push(target.destination);
		valueList3.push(target.count);
	}
	
	let data3 = {
			labels: labelList3,
			datasets: [{
				data: valueList3,
				backgroundColor: '#afcedc'
			}]
	};

	let routeContext = document.getElementById('routeChart').getContext('2d');
	new Chart(routeContext, {
		type: 'horizontalBar', // 가로형 막대 그래프 
		data: data3,
		options: {
			responsive: false, // canvas에 너비/높이 주면 차트를 원하는 크기로 조정 가능
			tooltips: {
				mode: "index",
				intersect: true 
			},
			scales: {
				yAxes: [{
					ticks: {
						fontSize: 12
					},
					gridLines: {
						display: false // 그리드 선 제거
					}
				}],
				xAxes: [{
	            	display: false, // x축 없애기
					gridLines: {
						display: false // 그리드 선 제거
					}
				}]
			},
			title: { // 차트 대제목 숨김
				display: false
			},
			legend: {
				display: false
			}
		}
	});
	
	// 마일리지샵 구매량 상위 5개 브랜드
	
	let labelList4 = new Array();
	let valueList4 = new Array();
	
	for (let i = 0; i < brandData.length; i++) {
		let target = brandData[i];
		labelList4.push(target.brand);
		valueList4.push(target.orderAmount);
	}
	
	let data4 = {
			labels: labelList4,
			datasets: [{
				data: valueList4,
				backgroundColor: ['#E1E7EA', '#DFEAF1', '#C8E2ED', '#A8CEDF', '#8BBAD0']
			}]
	};
	
	let brandContext = document.getElementById('brandChart').getContext('2d');
	new Chart(brandContext, {
		type: 'bar', // 가로형 막대 그래프 
		data: data4,
		options: {
			responsive: false, // canvas에 너비/높이 주면 차트를 원하는 크기로 조정 가능
			tooltips: {
				enabled: false
			},
			scales: {
				yAxes: [{
	            	display: false, // y축 없애기
					gridLines: {
						display: false // 그리드 선 제거
					}
				}],
				xAxes: [{
					ticks: {
						fontSize: 10
					},
					gridLines: {
						display: false // 그리드 선 제거
					}
				}]
			},
			title: { // 차트 대제목 숨김
				display: false
			},
			legend: {
				display: false
			}
		}
	});
	
	// 메모 갱신
	
	$("#memoArea").on("blur", function() {
		let data = {
			content: $(this).val()
		};
		
		$.ajax({
			type: 'POST',
			url: '/manager/updateMemo',
			contentType: 'application/json; charset=UTF-8',
			data: JSON.stringify(data),
			dataType: 'json'
		})
		.done((res) => {
			console.log("통신 성공");
		})
		.fail((error) => {
			console.log(error);
		});
	});
	
	// 고객의 말씀 상세 페이지로 이동
	
	$(".list--table tbody tr").on("click", function() {
		let id = $(this).attr("id").split("tr")[1];
		
		location.href="/voc/detail/" + id;
		
	});
	
});
