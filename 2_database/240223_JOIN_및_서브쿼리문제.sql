--1. 70년대 생(1970~1979) 중 여자이면서 전씨인 사원의 이름과 주민번호, 부서 명, 직급 조회
SELECT EMP_NAME, EMP_NO, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN JOB USING(JOB_CODE)
WHERE TO_NUMBER(SUBSTR(EMP_NO, 1, 2)) BETWEEN 70 AND 79
AND SUBSTR(EMP_NO, 8, 1) IN('2', '4')
AND EMP_NAME LIKE '전%';

--2. 나이 상 가장 막내의 사원 코드, 사원 명, 나이, 부서 명, 직급 명 조회
--SELECT EMP_ID, EMP_NAME, TRUNC(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 6), 'RRMMDD')) / 12) AS "나이", DEPT_TITLE, JOB_NAME
SELECT EMP_ID, EMP_NAME, TRUNC(MONTHS_BETWEEN(TRUNC(SYSDATE), TO_DATE(SUBSTR(EMP_NO, 1, 6))) / 12) AS "나이", DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN JOB USING(JOB_CODE)
WHERE TRUNC(MONTHS_BETWEEN(TRUNC(SYSDATE), TO_DATE(SUBSTR(EMP_NO, 1, 6))) / 12) = (SELECT MIN(TRUNC(MONTHS_BETWEEN(TRUNC(SYSDATE), TO_DATE(SUBSTR(EMP_NO, 1, 6))) / 12)) FROM EMPLOYEE);
--EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO, 1, 6))) -> 나이 구하는
-- TRUNC(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 6))) / 12)
SELECT TRUNC(SYSDATE)
FROM EMPLOYEE;

--3. 이름에 ‘형’이 들어가는 사원의 사원 코드, 사원 명, 직급 조회
SELECT EMP_ID, EMP_NAME, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE EMP_NAME LIKE '%형%';

--4. 부서코드가 D5이거나 D6인 사원의 사원 명, 직급 명, 부서 코드, 부서 명 조회
SELECT EMP_NAME, JOB_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN JOB USING(JOB_CODE)
WHERE DEPT_CODE IN('D5', 'D6');

--5. 보너스를 받는 사원의 사원 명, 부서 명, 지역 명 조회
SELECT EMP_NAME, BONUS, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
WHERE BONUS IS NOT NULL;

--6. 사원 명, 직급 명, 부서 명, 지역 명 조회
SELECT EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE);

--7. 한국이나 일본에서 근무 중인 사원의 사원 명, 부서 명, 지역 명, 국가 명 조회
SELECT EMP_NAME, DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING(NATIONAL_CODE)
WHERE NATIONAL_NAME IN('한국', '일본');
 
--8. 한 사원과 같은 부서에서 일하는 사원의 이름 조회
SELECT E1.DEPT_CODE, E1.EMP_NAME, E2.DEPT_CODE, E2.EMP_NAME
FROM EMPLOYEE E1 
JOIN EMPLOYEE E2 ON (E1.DEPT_CODE = E2.DEPT_CODE) --LEFT 를 붙혔을때와 아닐때의 차이 모름
WHERE E1.EMP_NAME != E2.EMP_NAME
ORDER BY E1.EMP_NAME;

--9. 보너스가 없고 직급 코드가 J4이거나 J7인 사원의 이름, 직급 명, 급여 조회(NVL 이용)
SELECT EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE NVL(BONUS,0) = 0
      AND JOB_CODE IN ('J4', 'J7'); 

--10. 보너스 포함한 연봉이 높은 5명의 사번, 이름, 부서 명, 직급, 입사일, 순위 조회
--ROWNUM 사용
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, HIRE_DATE, ROWNUM
FROM (SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, HIRE_DATE 
      FROM EMPLOYEE
      JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
      JOIN JOB USING(JOB_CODE)
      ORDER BY 12*SALARY*(1+NVL(BONUS, 0)) DESC)
WHERE ROWNUM <= 5;

--RANK OVER사용
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, HIRE_DATE, 순위
FROM (SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, HIRE_DATE, 
           RANK() OVER(ORDER BY 12*SALARY*(1+NVL(BONUS, 0)) DESC) AS 순위 
      FROM EMPLOYEE
      JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
      JOIN JOB USING(JOB_CODE))
WHERE 순위 <= 5;


--11. 부서 별 급여 합계가 전체 급여 총 합의 20%보다 많은 부서의 부서 명, 부서 별 급여 합계 조회
--11-1. JOIN과 HAVING 사용
SELECT DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
GROUP BY DEPT_TITLE HAVING SUM(SALARY) > 0.2*(SELECT SUM(SALARY) FROM EMPLOYEE);

--11-2. 인라인 뷰 사용
SELECT DEPT_TITLE, "부서 별 급여"
FROM (SELECT DEPT_TITLE, SUM(SALARY) AS "부서 별 급여"
      FROM EMPLOYEE
      LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
      GROUP BY DEPT_TITLE)
WHERE "부서 별 급여" > 0.2*(SELECT SUM(SALARY) FROM EMPLOYEE);

--11-3. WITH 사용
WITH SALARY_TABLE AS (
    SELECT DEPT_TITLE, SUM(SALARY) AS "부서별급여"
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    GROUP BY DEPT_TITLE HAVING SUM(SALARY) > 0.2*(SELECT SUM(SALARY) FROM EMPLOYEE)
)
SELECT DEPT_TITLE, "부서별급여" 
FROM SALARY_TABLE;


--12. 부서 명과 부서 별 급여 합계 조회
SELECT DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
GROUP BY DEPT_TITLE;

--13. WITH를 이용하여 급여 합과 급여 평균 조회
WITH SALARY_SUM AS(
        SELECT TO_CHAR(SUM(SALARY), 'L99,999,999') AS 급여합 FROM EMPLOYEE),
     SALARY_AVG AS(
        SELECT TO_CHAR(TRUNC(AVG(SALARY)), 'L99,999,999') AS 급여평균 FROM EMPLOYEE)
SELECT 급여합, 급여평균
FROM SALARY_SUM, SALARY_AVG;

