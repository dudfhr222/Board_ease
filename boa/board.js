//Validation Check
function check_ok(){
	if(wt_frm.b_name.value.length == 0){
		alert("이름을 작성해주세요");
	}
	if(wt_frm.b_title.value.length == 0){
		alert("제목을 작성해주세요");
	}
	if(wt_frm.b_content.value.length == 0){
		alert("내용을 작성해주세요");
	}
	
	document.wt_frm.submit();
}
