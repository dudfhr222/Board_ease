//Validation Check
function check_ok(){
	if(wt_frm.b_name.value.length == 0){
		alert("이름을 작성해주세요");
		wt_frm.b_name.focus();
		return;
	}
	if(wt_frm.b_title.value.length == 0){
		alert("제목을 작성해주세요");
		wt_frm.b_title.focus();
		return;
	}
	if(wt_frm.b_content.value.length == 0){
		alert("내용을 작성해주세요");
		wt_frm.b_content.focus();
		return;
	}
	if(wt_frm.b_pwd.value.length == 0){
		alert("비밀번호를 작성해주세요");
		wt_frm.b_pwd.focus();
		return;
	}
	
	document.wt_frm.submit();
}
