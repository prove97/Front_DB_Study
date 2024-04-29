function test(){
    console.log("test함수 실행");

}

test();

const test2 = function(str, int){
    console.log(arguments);
    console.log("test2함수 실행");
}

test2("test", 8);

/**
 * Arrow 함수
 */

const arrow1 = () => {
    console.log(this);

}
