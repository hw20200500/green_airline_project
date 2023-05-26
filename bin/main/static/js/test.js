$('.content')
	.on("dragover", dragOver)
	.on("dragleave", dragOver)
	.on("drop", uploadFiles);

function dragOver(e) {
	e.stopPropagation();
	e.preventDefault();
	if (e.type == "dragover") {
		$(e.target).css({
			"background-color": "black",
			"outline-offset": "-20px"
		});
	} else {
		$(e.target).css({
			"background-color": "gray",
			"outline-offset": "-10px"
		});
	}
}

function uploadFiles(e) {
	e.stopPropagation();
	e.preventDefault();
	dragOver(e);

	e.dataTransfer = e.originalEvent.dataTransfer;
	var files = e.target.files || e.dataTransfer.files;
	if (files.length > 1) {
		alert('하나만 올려라.');
		return;
	}
	if (files[0].type.match(/image.*/)) {
		$(e.target).css({
			"background-image": "url(" + window.URL.createObjectURL(files[0]) + ")",
			"outline": "none",
			"background-size": "100% 100%"
		});
	} else {
		alert('이미지가 아닙니다.');
		return;
	}
}


