/**
 * Scope
 * 
 */

var number1 = 20;

function test1(){
    console.log(number1);
}

// test1();

function test2(){
    var number1 = 40;
    console.log(number1);
}

// test2();

var number1 = 20;

function test3(){
    var number1 = 40;
    test4();
    console.log("number1 : " + number1);
}

function test4(){
    var number2 = 11;
    console.log("number2 : " + number2);
    console.log("number1 : " + number1);
}

test3();
console.log(number1);

/**
 * JS => Lexical Scope
 * 선언된 위치가 상위 스코프를 정한다.
 * 
 * Dynamic Scope
 * 실행한 위치가 상위 소코프를 정한다.
*/

// var i = 1000;
// for(var i=0; i<10; i++){ //for문에서는 scope를 안만듦
//     console.log(i);
// }
// console.log("i = " + i);

let i = 1000;
for(let i=0; i<10; i++){ 
    console.log(i);
}
console.log("i = " + i);

//클로저(closure)