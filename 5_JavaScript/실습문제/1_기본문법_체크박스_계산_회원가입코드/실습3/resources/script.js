function joinMember(){
    const id = document.getElementById("inputID");
    const checkID = document.getElementById("checkID");
    const inputPWD = document.getElementById("inputPWD");
    const reInputPWD = document.getElementById("reInputPWD");
    const checkPWD = document.getElementById("checkPWD");
    const inputName = document.getElementById("inputName");

    const spanList = document.querySelectorAll("span");
    const inputList = document.getElementsByTagName("input");    

    let isEmpty = true;
    for(let i = 0; i<inputList.length; i++){
        if(inputList[i].value === ""){
            alert(`"${spanList[i].innerText}"를 입력해주세요.`);
            inputList[i].focus();
            break;                    
        }
        if(i === inputList.length-1){
            isEmpty = false;
        }
    }
    
    if(!isEmpty){
        if(id.value !== "user01"){
            checkID.innerHTML = "사용 가능한 아이디입니다.";
            checkID.style.color = "green";
        } else{
            checkID.innerHTML = "이미 존재하는 아이디입니다.";
            checkID.style.color = "red";
        }

        if(inputPWD.value === reInputPWD.value){
            checkPWD.innerHTML = "비밀번호가 일치합니다."
            checkPWD.style.color = "green";
        } else{
            checkPWD.innerHTML = "비밀번호가 일치하지 않습니다."
            checkPWD.style.color = "red";
        }

        if(checkID.style.color === "green" && checkPWD.style.color === "green"){
            alert(`${inputName.value}님, 회원가입이 성공적으로 완료되었습니다^^`);

            for(let i = 0; i<inputList.length; i++){
                inputList[i].value = "";
            }
            checkID.innerHTML = "";
            checkPWD.innerHTML = "";

        }
    }
    
    
    



    


}