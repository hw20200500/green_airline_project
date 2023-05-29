$(document).ready(function() {
	
	$("#contentArea").on("keyup change keydown", function() {
		checkMaxByte($(this));
		let text = $(this).val();
		let totalByte = 0;
		
		if (text.length != 0) {
			for (let i = 0; i < text.length; i++) {
				// 한글은 1글자당 2byte
				totalByte += (text.charCodeAt(i) > 128) ? 2 : 1;
			}
		}
		$("#currentLen").text(totalByte);
	});
	
	function checkMaxByte(obj) {
		let text = obj.val();
		
		let rbyte = 0;
		let rlen = 0;
		let char1 = "";
		let resultStr = "";
		
		for (let i = 0; i < text.length; i++) {
			char1 = text.charAt(i);
			if (escape(char1).length > 4) {
				rbyte += 2;
			} else {
				rbyte ++;
			}
			
			if (rbyte <= maxByte) {
				rlen = i + 1;
			}
		}
		if (rbyte > maxByte) {
			resultStr = text.substr(0, rlen);
			obj.val(resultStr);
			checkMaxByte(obj);
		}
	}
});