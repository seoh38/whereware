
//아이디
let idCheck = RegExp(/^[a-zA-Z][a-zA-Z\d]{4,11}$/);
$('#userId').keyup(function() {
  if (!idCheck.test($('#userId').val())) {
    $('.error_id').css('color', 'red').text("알맞지 않은 아이디 입니다.");
  } else {
    $('.error_id').css('color', 'green').text("알맞은 아이디 입니다.");
  }
});


// 비밀번호
let passwordCheck = RegExp(/^(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^~*+=-])(?=.*[0-9]).{8,16}$/);
$('#userPwd').keyup(function() {
  if (!passwordCheck.test($('#userPwd').val())) {
    $('.error_pwd').css('color', 'red').text("영문 대문자, 소문자, 특수문자를 포함해주제요.");
  } else {
    $('.error_pwd').css('color', 'green').text("사용가능한 비밀번호 입니다.");
  }
});


// 비밀번호 확인체크
$('#userPwdCheck').keyup(function(){
  let passwd = $('#userPwd').val();
  let passwdcheck = $('#userPwdCheck').val();

  if(passwd == passwdcheck){
    passCheck = true;
    $('.error_pwdCk').text('동일한 비밀번호 입니다.');
    $('.error_pwdCk').css('color', '#08a600');
  }else{
    passCheck = false;
    $('.error_pwdCk').text('동일하지 않은 비밀번호 입니다.');
    $('.error_pwdCk').css('color', 'red');
  }
});

// 이름
let nameCheck = RegExp(/^[a-zA-Z가-힣]{2,}$/);
$('#userName').keyup(function() {
  if (!nameCheck.test($('#userName').val())) {
    $('.error_name').css('color', 'red').text("형식에 맞지 않음");
  } else {
    $('.error_name').css('color', 'green').text("형식에 맞음");
  }
});


// 전화번호
let phoneCheck = /^((01[1|6|7|8|9])[1-9]+[0-9]{6,7})|(010[1-9][0-9]{7})$/;
$('#userPhone').keyup(function() {
    if(!phoneCheck.test($('#userPhone').val())) {
        $('.error_phone').css('color', 'red').text("형식에 맞지 않음");
    } else {
        $('.error_phone').css('color', 'green').text("형식에 맞음");
    }
});

// 이메일
let emailCheck = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
$('#userEmail').keyup(function() {
    if(!emailCheck.test($('#userEmail').val())) {
        $('.error_email').css('color', 'red').text("형식에 맞지 않음");
    } else {
        $('.error_email').css('color', 'green').text("형식에 맞음");
    }
});





