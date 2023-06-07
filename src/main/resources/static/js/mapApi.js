window.initMap = function() {
	let map = new google.maps.Map(document.getElementById("map"), {
		center: { lat: 35.17322, lng: 128.9464591 },
		zoom: 13,
	});

	// 조회하기 버튼을 누른 위도 경도 가져와서 마커 생성
	let onClickSearch = () => {
		let latitude = parseFloat(document.getElementById("latitude").value);
		let longitude = parseFloat(document.getElementById("longitude").value);

		// 경계 객체 생성 -> 줌 조정하기
		let bounds = new google.maps.LatLngBounds();
		// 마커 클릭시 정보창
		let infowindow = new google.maps.InfoWindow();

		airport.forEach(({ label, lat, lng }) => {
			let marker = new google.maps.Marker({
				position: { lat, lng },
				label,
				map,
			});

			// 각 마커의 위치 정보 전달
			bounds.extend(marker.position);

			marker.addListener("click", () => {
				// 클릭 했을 때 지도 중심이 이동
				map.panTo(marker.position);

				infowindow.setContent(`위도: ${latitude}, 경도: ${longitude}`);
				infowindow.open({
					anchor: marker,
					map,
				});
			});
		});

		// 지도 경계 객체 전달
		map.fitBounds(bounds);
	};
};

// select 박스에 변화가 생겼을 때
$(document).ready(function() {
	$("#id--selectContinent").change(function() {
		let selectedContinent = $(this).val();

		$.ajax({
			url: "/continent",
			type: "GET",
			data: {
				region: selectedContinent
			},
		}).done(function(res) {
			// option 초기화
			let target = document.getElementById("id--selectAirport");
			target.options.length = 0;

			// option 생성
			for (let i = 0; i < res.length; i++) {
				let opt = document.createElement("option");
				opt.value = res[i].name;
				opt.innerHTML = res[i].name;
				target.appendChild(opt);
			}
		}).fail(function(error) {
			console.error(error);
		});
	});
});

// 조회하기 버튼 눌렀을 때
$(document).ready(function() {
	$(".btn--search").on("click", function() {
		// 공항이 선택됬는지 확인
		let selectedAirport = $("#id--selectAirport").val();
		console.log(selectedAirport);
		if (selectedAirport == "" || selectedAirport == null) {
			alert("공항을 선택해주세요.");
			return;
		}

		// 공항 이름을 쿼리 파라미터로 담아서 controller로 보내기
		$.ajax({
			url: "/airportPosition",
			type: "GET",
			data: {
				searchName: selectedAirport
			}
		}).done(function(res) {
			let latitude = res.latitude;
			let longitude = res.longitude;

			// 구글 맵 API를 이용하여 해당 좌표로 이동
			let map = new google.maps.Map(document.getElementById("map"), {
				center: {
					lat: latitude,
					lng: longitude
				},
				zoom: 13
			});

			// 특정 위치 표시
			let marker = new google.maps.Marker({
				position: {
					lat: latitude,
					lng: longitude
				},
				map: map
			});
		}).fail(function(xhr, status, error) {
			console.error(error);
		});
	});
});