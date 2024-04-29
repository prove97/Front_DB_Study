function calculator(){
    const num1 = Number(document.getElementById("num1").value);
    const num2 = Number(document.getElementById("num2").value);                                    
    
    let oper = document.getElementById("operator");
    
    let area = document.getElementById("result");
    area.value = "";
    area.style.background = "none";
    area.style.color = "black";
    let operator = oper.options[oper.selectedIndex].value;
    console.log(operator);

    if(num2 === 0 && (operator === "/" || operator === "%")){
        area.value = "연산불가";
        area.style.color = "white";
        area.style.background = "red";
    } else{
        // if(operator === "+"){
        //     area.value = num1 + num2;
        // } 
        // if(operator === "-"){
        //     area.value = num1 - num2;
        // }
        // if(operator === "*"){
        //     area.value = num1 * num2;
        // }
        // if(operator === "/"){
        //     area.value = num1 / num2;
        // }
        // if(operator === "%"){
        //     area.value = num1 % num2;
        // }

        switch(operator){            
            case '+':
                area.value = num1 + num2;
                break;
            case '-':
                area.value = num1 - num2;
                break;
            case '*':
                area.value = num1 * num2;
                break;
            case '/':
                area.value = num1 / num2;
                break;
            case '%':
                area.value = num1 % num2;
                break;
        }
        // console.log(area.value);
    }

    
    // if(oper.options[oper.selectedIndex].text == "+"){
    //     area.value = Number(num1.value) + Number(num2.value);
        
    // } if(oper.options[oper.selectedIndex].text == "-"){
    //     area.value = Number(num1.value) - Number(num2.value);
        
    // } if(oper.options[oper.selectedIndex].text == "*"){
    //     area.value = Number(num1.value) * Number(num2.value);
        
    // } if(oper.options[oper.selectedIndex].text == "/"){
    //     if(Number(num2.value) == 0){
    //         area.value = "연산불가";
    //         area.style.color = "white";
    //         area.style.background = "red";
    //     } else{
    //         area.value = Number(num1.value) / Number(num2.value);
    //     }
        
    // } if(oper.options[oper.selectedIndex].text == "%"){
    //     if(Number(num2.value) == 0){
    //         area.value = "연산불가";
    //         area.style.color = "white";
    //         area.style.background = "red";
    //     } else{
    //         area.value = Number(num1.value) % Number(num2.value);
    //     }
    
    // }
}