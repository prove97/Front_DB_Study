let members = [
    '최지원',
    '김지원',
    '이지원',
    '박지원',
    '은지원'
]

//push
console.log(members.push('누군데'));
console.log(members);

//splice()
console.log(members.splice(0,3));

//concat
console.log(members.concat('머였'));
console.log(members);


members = [
    '최지원',
    '김지원',
    '이지원',
    '박지원',
    '은지원'
]

let members2 = [
    ...members
]

console.log(members2);

let memberInfo = {
    name: "지원",
    age: 28,
    gender: 'M'
}

let memberInfo2 = {
    ...memberInfo,
    age: 12
}

console.log(memberInfo2);

console.log("----------------------------")

//join : String형식으로 변환, 소괄호 안에 넣은 문자에 따라 해당 문자로 구분해줌
console.log(members2.join());
console.log(members2.join(', '));
console.log(members2.join('/'));
console.log(members2.join(' '));

//sort()
members2.sort();

console.log(members2);
console.log(members2.reverse());

let numbers = [1, 9, 7, 5, 3];

console.log(numbers);

// a, b를 비교한다.
// 1) a를 b보다 나중에 정렬하고 싶다면 (뒤에두려면) 0보다 큰수를 반환
// 2) a를 b보다 먼저 정렬하려한다면 (앞에 두려면) 0보다 작은수를 반환
// 3) 원래순서를 유지하고 싶다면 0을 반환

numbers.sort((a,b) => {
    console.log(a + " : " + b);
    return a < b ? 1 : -1; //내림차순 정렬
});

numbers.sort((a,b) => a < b ? 1 : -1);

console.log(numbers);

//map
//기존배열의 요소를 전부 반복하면서
//return된 값으로 새로운 배열을 만들어주는 함수
// console.log(members2.map((m) => {
//     if(m.length > 3){
//         return m + "[vip]";
//     } else {
//         return m + "[gold]";
//     }
// }));

// // => 
// let tmpMembers = [];
// for(let m of members2){
//     tmpMembers.push(m+1);
// }
// console.log(tmpMembers);

let classList = [{
    className: "자바 1장",
    time: "12:00",
    classNo: 2
},{
    className: "자바 2장",
    time: "14:00",
    classNo: 1
},{
    className: "자바 3장",
    time: "16:00",
    classNo: 1
}]

let studentList = [{
    name: "홍길동",
    classNo: 1
},{
    name: "이길동",
    classNo: 2
},{
    name: "구길동",
    classNo: 2
},{
    name: "고길동",
    classNo: 1
}]

console.log(studentList.map( s => {   //매개변수 한개일땐 소괄호 생략가능(두개 이상 일땐 불가능)
    for(let c of classList){
        if(s.classNo === c.classNo){
            return {
                ...c,
                ...s
            }
        }
    }

    //filter로 변경해보기

    return s;
}))

//filter()
let numbers2 = [1,8,6,4,3];
let tmp2 =[];
for(let n of numbers2){
    if(n%2 === 0){
        tmp2.push(n);
    }
}

tmp2 = numbers2.filter(n => n % 2 === 0);
console.log(tmp2);

//find() : 최초로 찾은 값 하나만 리턴
console.log(tmp2.find(n => n % 2 === 1)); //값이 없으면 undefined 리턴

//findIndex()
console.log(numbers2)
console.log(numbers2.findIndex(n => n % 2 === 0));

// reduce
// reduce((누적변수 ,배열의 요소) => {}, 초기값)
// 배열을 통해서 특정 변수 하나를 만들 때
console.log(numbers2.reduce((p, n) => p + n, 0)) //(p, n) => p + n  === function(p,n){ ... return p+n}
console.log(numbers2.reduce((sum,n) => {
    if(n % 2 === 1){
        sum.push(n);
    }
    return sum;
}, []))





