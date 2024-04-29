/*
    *��������( SUBQUERY)
    -�ϳ��� SQL�� �ȿ� ���Ե� �� �ٸ� SELECT��
    -���� SQL���� ���� ���� ������ �ϴ� ����
*/

--������ �������� ����1.
--���ö ����� ���� �μ��� ���� ����� ��ȸ

--1) ���ö ����� �μ��ڵ�
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '���ö';

--2) �μ��ڵ尡 D9�� ����� ��ȸ
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

--���� �� �ܰ踦 �ϳ��� ����������!
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE 
                   FROM EMPLOYEE
                   WHERE EMP_NAME = '���ö');
                   
--������ �������� ����2
--�� ������ ��ձ޿����� �� ���� �޿��� �޴� ������� ���, �̸�, �����ڵ�, �޿� ��ȸ
--1) �������� ��ձ޿�
SELECT ROUND(AVG(SALARY))
FROM EMPLOYEE;

--2) 3047663���� �� ���� �޿��� �޴� ������� ���, �̸�, �����ڵ�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3047663;

--�� �ܰ踦 �ϳ��� ���غ���
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= (SELECT ROUND(AVG(SALARY))
                 FROM EMPLOYEE);
                 
/*
    *���������� ����
    ���������� ������ ������� ���� ��� �����Ŀ� ���� �з�
    
    -������ �������� : ���������� ��ȸ ������� ������ ������ 1���� ��
    -������ �������� : ���������� ��ȸ ������� �������� ��(������ �ѿ�)
    -���߿� �������� : ���������� ��ȸ ������� �� �������� �÷��� �������� ��
    -������ ���߿� �������� : ���������� ��ȸ ������� ������ �����÷��� ��
    
    >> ���������� ������ ������ ���� �������� �տ� �ٴ� ������ �޶���    
*/

/*
    1. ������ ��������
    ���������� ��ȸ ������� ������ ������ 1���� ��(���� �ѿ�)
    �Ϲ� �񱳿����� ��� ����
    =, !=, >, <=, ...
*/
--1) �� ������ ��� �޿����� �޿��� �� ���Թ޴� ������� �����, �����ڵ�, �޿� ��ȸ
SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY < (SELECT AVG(SALARY) FROM EMPLOYEE);

--2) �����޿��� �޴� ����� ���, �̸�, �޿�, �Ի��� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY) FROM EMPLOYEE);

--3) ���ö ����� �޿����� ���� �޴� ������� ���, �̸�, �μ��ڵ�, �޿���ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME = '���ö');

--4) ���ö ����� �޿����� ���� �޴� ������� ���, �̸�, �μ���, �޿���ȸ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
WHERE SALARY > (SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME = '���ö');

--5) �μ��� �޿� ���� ���� ū �μ��� �μ��ڵ�, �޿� ��
--1. �μ��� �޿����߿��� ���� ū �� �ϳ��� ��ȸ
SELECT MAX(SUM(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE;

--2. �μ� �޿����� 17700000�� �μ��� �μ��ڵ�, �޿��� ��ȸ
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE 
HAVING SUM(SALARY) = 17700000; 

--3. �� �������� ��
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE 
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))
                      FROM EMPLOYEE
                      GROUP BY DEPT_CODE); 


--6) '������'����� ���� �μ��� ������� ���, �����, ��ȭ��ȣ, �Ի���, �μ����� ��ȸ
-- ��, ����������� ����
SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE EMP_NAME != '������' AND DEPT_CODE = (SELECT DEPT_CODE 
                                           FROM EMPLOYEE 
                                           WHERE EMP_NAME = '������');

--------------------------------------------------------------------
/*
    2. ������ ��������
    ���������� ������ ������� �������� ��(�÷��� �Ѱ�)
    
    IN (��������) : �������� ����� �߿��� �Ѱ��� ��ġ�ϴ� ���� �ִٸ� ��ȸ
    > ANY (��������) : �������� ����� �߿��� �Ѱ��� Ŭ ��� ��ȸ
    < ANY (��������) : �������� ����� �߿��� �Ѱ��� ���� ��� ��ȸ
        �񱳴�� > ANY (���������� ����� => ��1, ��2, ��3, ...)
        �񱳴�� > ��1 OR �񱳴�� > ��2 OR �񱳴�� > ��3 OR ...
        
    > ALL (��������) : �������� ��� ������� ���� Ŭ ��� ��ȸ
    < ALL (��������) : �������� ��� ������� ���� ���� ���
      �񱳴�� > ALL (���������� ����� => ��1, ��2, ��3, ...)
      �񱳴�� > ��1 AND �񱳴�� > ��2 AND �񱳴�� > ��3 ...
*/
--1) ����� �Ǵ� ������ ����� ���� ������ ������� ���, �����, �����ڵ�, �޿� ��ȸ
--1. ����� �Ǵ� ������ ����� �����ڵ�
SELECT JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME IN('������', '�����');

--2. ������ J3, J7�� ���ʵ� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN('J3', 'J7');

--3. �� ������ ��
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN(SELECT JOB_CODE
                  FROM EMPLOYEE
                  WHERE EMP_NAME IN('������', '�����'));
                  
                  
--2) �븮 �����ӿ��� ���� ���� �޿��� �� �ּ� �޿����� ���� �޴� ����� ��ȸ                  
--(���, �̸�, ����, �޿�)
SELECT MIN(SALARY)
FROM EMPLOYEE
WHERE JOB_CODE = 'J6';

SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '�븮' AND SALARY > ANY(SELECT SALARY
                                     FROM EMPLOYEE
                                     JOIN JOB USING(JOB_CODE)
                                     WHERE JOB_NAME = '����');
                                     
-----------------------------------------------------
/*
    3. ���߿� ��������
    ������� �� �������� ������ �÷� ���� �������� ���
*/

--1) ������ ����� ���� �μ��ڵ�, ���� ���� �ڵ忡 �ش��ϴ� ����� ��ȸ
--(�����, �μ��ڵ�, �����ڵ�, �Ի���)
--> ������ ��������
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                   FROM EMPLOYEE
                   WHERE EMP_NAME = '������')
AND JOB_CODE = (SELECT JOB_CODE
                   FROM EMPLOYEE
                   WHERE EMP_NAME = '������');
                   
--> ���߿� ���������� �ۼ�
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) = (SELECT DEPT_CODE, JOB_CODE
                               FROM EMPLOYEE
                               WHERE EMP_NAME = '������');

--2) �ڳ��� ����� ���� �����ڵ�, ���� ����� ������ �ִ� ������� ���, �����, �����ڵ�, ����ڵ带 ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, MANAGER_ID
FROM EMPLOYEE
WHERE (JOB_CODE, MANAGER_ID) = (SELECT JOB_CODE, MANAGER_ID 
                                FROM EMPLOYEE 
                                WHERE EMP_NAME = '�ڳ���')
AND EMP_NAME != '�ڳ���';

----------------------------------------------------------------
/*
    4. ������ ���߿� ��������
    ���������� ��ȸ ������� ������ �������� ���
*/

--1) �� ���޺� �ּұ޿��� �޴� �����ȸ(���, �����, �����ڵ�, �޿�)
--> �� ���޺� �ּұ޿�
SELECT JOB_CODE, MIN(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE;

-->�� ���޺� �ּұ޿��� �޴� ��� ��ȸ(���, �����, �����ڵ�, �޿�)
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE

WHERE JOB_CODE = 'J2' AND SALARY = 3700000
OR JOB_CODE = 'J7' AND SALARY = 13800000
OR JOB_CODE = 'J3' AND SALARY = 3400000
OR JOB_CODE = 'J6' AND SALARY = 2000000
OR JOB_CODE = 'J5' AND SALARY = 2200000
OR JOB_CODE = 'J1' AND SALARY = 8000000
OR JOB_CODE = 'J4' AND SALARY = 1550000;

-->�������� ����
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) IN (SELECT JOB_CODE, MIN(SALARY)
                             FROM EMPLOYEE
                             GROUP BY JOB_CODE);
                                
--�� �μ��� �ְ�޿��� �޴� ������� ���, �����, �μ��ڵ�, �޿�            
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE (DEPT_CODE, SALARY) IN (SELECT DEPT_CODE, MAX(SALARY)
                              FROM EMPLOYEE
                              GROUP BY DEPT_CODE);
                              

-----------------------------------------------------------------
/*
    5. �ζ��� ��
    FROM���� ���������� �ۼ��� ��
    ���������� ������ ����� ��ġ ���̺�ó�� ���
*/

--������� ���, �̸�, ���ʽ����Կ���, �μ��ڵ� ��ȸ
--��, ���ʽ����� ������ NULL�� �Ǹ� �ȵȴ�.
--��, ���ʽ����� ������ 3000���� �̻��� ����鸸 ��ȸ
SELECT EMP_ID, EMP_NAME, 12*SALARY*(NVL(BONUS, 0)+1) as "���ʽ����Կ���", DEPT_CODE
FROM (SELECT * 
      FROM EMPLOYEE 
      WHERE 12*SALARY*(NVL(BONUS, 0)+1) >= 30000000); 
      
--> �ζ��κ並 �ַ� ����ϴ� �� >> TOP-N�м� : ���� ��� ��ȸ
-- �� ������ �޿��� ���� ���� 5�� ��ȸ
-- ROWNUM : ����Ŭ���� �������ִ� �÷�, ��ȸ�� ������� 1���� ������ �ο����ִ� �÷�(������ 1���� ����)
SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE ROWNUM <= 5
ORDER BY SALARY DESC;

--> ORDER BY ���� ����� ����� ������ ROWNUM�ο� -> ���� 5�� ��ȸ
SELECT ROWNUM, EMP_NAME, SALARY
FROM(SELECT EMP_NAME, SALARY
     FROM EMPLOYEE
     ORDER BY SALARY DESC)
WHERE ROWNUM <=5;

--���� �ֱٿ� �Ի��� ��� 5�� ��ȸ(�����, �޿�, �Ի���)

SELECT ROWNUM, EMP_NAME, SALARY, HIRE_DATE
FROM (SELECT EMP_NAME, SALARY, HIRE_DATE -- 
      FROM EMPLOYEE
      ORDER BY HIRE_DATE DESC)
WHERE ROWNUM <= 5;

--�� �μ��� ��ձ޿��� ���� 3���� �μ� ��ȸ
SELECT ROWNUM, DEPT_TITLE, DEPT_CODE, ��ձ޿�
FROM (SELECT DEPT_CODE, AVG(SALARY) AS ��ձ޿�
      FROM EMPLOYEE
      GROUP BY DEPT_CODE
      ORDER BY AVG(SALARY) DESC)
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
WHERE ROWNUM <=3;

--�μ��� ��ձ޿��� 270������ �ʰ��ϴ� �μ��鿡 ���ؼ�
--(�μ��ڵ�, �μ��� �� �޿���, �μ��� ��ձ޿�, �μ��� �����) ��ȸ
SELECT DEPT_CODE, SUM(SALARY) AS "����", AVG(SALARY) AS "���", COUNT(*) AS "�ο���"
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) > 2700000
ORDER BY DEPT_CODE ASC;

SELECT *
FROM (SELECT DEPT_CODE, SUM(SALARY) AS "����", AVG(SALARY) AS "���", COUNT(*) AS "�ο���"
      FROM EMPLOYEE
      GROUP BY DEPT_CODE
      ORDER BY DEPT_CODE ASC)
WHERE ��� >= 2700000;

--------------------------------------------------------------
/*
    *������ �ű�� �Լ�(WINDOW FUNCTION)
    RANK() OVER(���ı���) | DENSE_RANK() OVER(���ı���)
    RANK() OVER(���ı���) : ������ ���� ������ ����� ������ �ο��� ��ŭ �ǳʶٰ� �������
    DENSE_RANK() OVER(���ı���) : ������ ������ �ִٰ� �ص� �� ���� ����� ������ 1�� ������Ŵ
    
    ������ SELECT�������� ��밡��
*/

--�޿��� ���� ������� ������ �Űܼ� ��ȸ
SELECT EMP_NAME, SALARY, RANK() OVER(ORDER BY SALARY DESC) AS "����"
FROM EMPLOYEE;
--���� 19�� 2�� �� ���� ����� 21������ �ϳ� �ǳ� �� �� �� �� �ִ�.
SELECT *
FROM(SELECT EMP_NAME, SALARY, DENSE_RANK() OVER(ORDER BY SALARY DESC) AS "����"
FROM EMPLOYEE)
WHERE ���� <=5;
--> 19���� ���������� �� �ڿ� 20���� �ٷ� ������ ���� �� �� �ִ�.

