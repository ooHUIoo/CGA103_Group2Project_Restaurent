var signUpBtn = document.querySelector('.signUp');
var logInBtn = document.querySelector('.logIn');
// var msg = document.getElementById('message');


//註冊
function signUpcheck() {

  // model
  var emailStr = document.querySelector('.email').value;
  var passwordStr = document.querySelector('.password').value;
  var account = {}; //輸入的資料，填入空物件
  account.email = emailStr; //填入的 email
  account.password = passwordStr; //填入的密碼

  var xhr = new XMLHttpRequest();
  xhr.open('post', 'https://hexschool-tutorial.herokuapp.com/api/signup', true);
  xhr.setRequestHeader('Content-type', 'application/json');
  var data = JSON.stringify(account); //因為格式是 JSON，所以要轉字串
  xhr.send(data);
  xhr.onload = function () {
    var callbackData = JSON.parse(xhr.responseText); //因為輸入資料目前是字串，要轉成物件才能使用
    var str = callbackData.message;
    if (str == "帳號註冊成功") {
      alert('帳號註冊成功');
    } else {
      alert('帳號已被使用');
    }
  }
}

//登入
function logIncheck() {

  // model
  var emailStr = document.querySelector('.email').value;
  var passwordStr = document.querySelector('.password').value;
  var account = {}; //輸入的資料，填入空物件
  account.email = emailStr; //填入的 email
  account.password = passwordStr; //填入的密碼

  var xhr = new XMLHttpRequest();
  xhr.open('post', 'https://hexschool-tutorial.herokuapp.com/api/signIn', true);
  xhr.setRequestHeader('Content-type', 'application/json');
  var data = JSON.stringify(account); //因為格式是 JSON，所以要轉字串
  xhr.send(data);
  xhr.onload = function () {
    var callbackData = JSON.parse(xhr.responseText); //因為輸入資料目前是字串，要轉成物件才能使用
    var str = callbackData.message;
    if (str == "登入成功") {
      alert('登入成功');
    } else {
      alert('此帳號不存在或帳號密碼錯誤');
    }
  }

}

// event
signUpBtn.addEventListener('click', signUpcheck, false);
logInBtn.addEventListener('click', logIncheck, false);