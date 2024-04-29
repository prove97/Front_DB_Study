/*
    <VIEW ��>
    
    SELECT ��(������)�� �����ص� �� �ִ� ��ü
    (���� ����ϴ� SELECT���� �����صθ� �� SELECT���� �Ź� �ٽ� ����� �ʿ䰡 ����.)
    �ӽ����̺� ���� ����(���� �����Ͱ� ����ִ� �� �ƴϴ� => �������� ���̺�)
*/

--�ѱ����� �ٹ��ϴ� ������� ���, �̸�, �μ���, �޿�, �ٹ������� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING (NATIONAL_CODE)
WHERE NATIONAL_NAME = '�ѱ�';

--���þƿ��� �ٹ��ϴ� ������� ���, �̸�, �μ���, �޿�, �ٹ������� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING (NATIONAL_CODE)
WHERE NATIONAL_NAME = '���þ�';

--------------------------------------------------------------------------------

/*
    1. VIEW �������
    
    [ǥ����]
    CREATE VIEW ���
    AS ��������
*/
--TB_ -> ���̺� �̸� ���� ����
--VW_ -> �� �̸� ���� ����

GRANT CREATE VIEW TO KH; --VIEW ���� ���� ����(������(SYS AS SYSDBA) �������� ����)

CREATE VIEW VW_EMPLOYEE
AS(SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
   FROM EMPLOYEE
   JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
   JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
   JOIN NATIONAL USING (NATIONAL_CODE));

SELECT * FROM VW_EMPLOYEE;
--���� ����Ǵ� ���� �Ʒ��� ���� ���������� ����ȴٰ� �� �� �ִ�.
SELECT * FROM (SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
               FROM EMPLOYEE
               JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
               JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
               JOIN NATIONAL USING (NATIONAL_CODE));

--�ѱ����� �ٹ��ϴ� ������� ���, �̸�, �μ���, �޿�, �ٹ������� ��ȸ
SELECT * FROM VW_EMPLOYEE
WHERE NATIONAL_NAME = '�ѱ�';
--���þƿ��� �ٹ��ϴ� ������� ���, �̸�, �μ���, �޿�, �ٹ������� ��ȸ
SELECT * FROM VW_EMPLOYEE
WHERE NATIONAL_NAME = '���þ�';
--�Ϻ����� �ٹ��ϴ� ������� ���, �̸�, �μ���, �޿�, �ٹ������� ��ȸ
SELECT * FROM VW_EMPLOYEE
WHERE NATIONAL_NAME = '�Ϻ�';

CREATE OR REPLACE VIEW VW_EMPLOYEE --CREATE OR REPLACE VIEW ��� : �����
AS(SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
   FROM EMPLOYEE
   JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
   JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
   JOIN NATIONAL USING (NATIONAL_CODE));
   
--------------------------------------------------------------------------------

/*
    *�� �÷��� ��Ī�ο�
    ���������� SELECT���� �Լ����̳� ���������� ����Ǿ� ���� ��� �ݵ�� ��Ī�� �����ؾ��Ѵ�.
*/

CREATE OR REPLACE VIEW VW_EMP_JOB
AS SELECT EMP_ID, EMP_NAME, JOB_NAME,
          DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '2', '��') AS "����",
          EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) AS "�ٹ����"
   FROM EMPLOYEE
   JOIN JOB USING(JOB_CODE);
   
SELECT * FROM VW_EMP_JOB;

CREATE OR REPLACE VIEW VW_EMP_JOB(���, �̸�, ���޸�, ����, �ٹ����)
AS SELECT EMP_ID, EMP_NAME, JOB_NAME,
          DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '2', '��'),
          EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)
   FROM EMPLOYEE
   JOIN JOB USING(JOB_CODE);

SELECT * 
FROM VW_EMP_JOB
WHERE �ٹ���� >= 20;

--�並 �����ϰ� ���� ��
DROP VIEW VW_EMP_JOB;

--------------------------------------------------------------------------------

-- ������ �並 ���ؼ� DML(INSERT, UPDATE, DELETE) ��� ����
-- �並 ���ؼ� �����ϰ� �Ǹ� ���� �����Ͱ� ����ִ� ���̺��� �ݿ��� �ȴ�.

CREATE OR REPLACE VIEW VW_JOB
AS SELECT JOB_CODE, JOB_NAME
   FROM JOB;
   
SELECT * FROM VW_JOB; --�������̺�(���� �����Ͱ� ������� ����)
SELECT * FROM JOB;

--�並 ���ؼ� INSERT
INSERT INTO VW_JOB VALUES('J8', '����');

--�並 ���ؼ� UPDATE
UPDATE VW_JOB
SET JOB_NAME = '�˹�'
WHERE JOB_CODE = 'J8';

--------------------------------------------------------------------------------

/*
    *DML ���ɾ�� ������ �Ұ����� ��찡 ����.
    
    1) �信 ���ǵǾ����� ���� �÷��� �����Ϸ��� �ϴ� ���
    2) �信 ���ǵǾ����� ���� �÷� �� ���̽����̺� �� NOT NULL ���������� �����Ǿ��ִ� ���
    3) �������� �Ǵ� �Լ������� ���ǰ� �Ǿ��ִ� ���
    4) �׷��Լ��� GROUP BY���� ���Ե� ���
    5) DISTINCT������ ���Ե� ���
    6) JOIN�� �̿��ؼ� ���� ���̺��� ������ѳ��� ���
    
    ��κ� ��� ��ȸ�� �������� ����
    -> �並 ���� DML�� �ǵ��� �Ⱦ��°� ����!
*/
/*
    VIEW �ɼ�
    
    [��ǥ����]
    CREATE [OR REPLACE] [FORCE | NOFORCE] VIEW ���
    AS ��������
    [WITH CHECK OPTION]
    [WITH READ ONLY];
    
    1) OR REPLACE : ������ ������ �䰡 ���� ��� �����ϰ�, �׷��� �ʴٸ� ���� ����
    2) FORCE | NOFORCE
        > FORCE : ���������� ����� ���̺��� �������� �ʾƵ� �䰡 �����ǵ��� �ض�
        > NOFORCE : ���������� ����� ���̺��� �����ϴ� ���̺��̾�߸� �䰡 �����ǰ� �ϴ� �ɼ�(�⺻��)
    3) WITH CHECK OPTION : DML�� ���������� ����� ���ǿ� ������ �����θ� DML�� �����ϵ��� ��
    4) WITH READ ONLY : VIEW�� ���ؼ� ��ȸ�� �����ϵ��� ����
*/

--2) FORCE | NOFORCE
DROP TABLE TT;
DROP VIEW VW_EMP;

CREATE OR REPLACE NOFORCE VIEW VW_EMP
AS SELECT TCODE, TNAME, TCONTENT
   FROM TT;

--���������� ����� ���̺��� �������� �ʾƵ� �䰡 �켱�� ����� �ȴ�.   
CREATE OR REPLACE FORCE VIEW VW_EMP
AS SELECT TCODE, TNAME, TCONTENT
   FROM TT;
   
SELECT * FROM VW_EMP; --���� �߻�
   
CREATE TABLE TT(
    TCODE NUMBER,
    TNAME VARCHAR2(20),
    TCONTENT VARCHAR2(30)
);
   
--3) WITH CHECK OPTION : ���������� ����� ���ǿ� �������� �ʴ� ������ ���� �� ���� �߻�
CREATE OR REPLACE VIEW VW_EMP
AS SELECT *
   FROM EMPLOYEE
   WHERE SALARY >= 3000000;

SELECT * FROM VW_EMP;

--200�� ��� �޿��� 200�������κ���(SALARY >= 3000000 ���ǿ� ���� �ʴ� ����)
UPDATE VW_EMP
SET SALARY = 2000000
WHERE EMP_ID = 200;

ROLLBACK;

CREATE OR REPLACE VIEW VW_EMP
AS SELECT *
   FROM EMPLOYEE
   WHERE SALARY >= 3000000
WITH CHECK OPTION;

--200�� ��� �޿��� 200�������κ���(SALARY >= 3000000 ���ǿ� ���� �ʴ� ����)�� ���� ����
UPDATE VW_EMP
SET SALARY = 2000000
WHERE EMP_ID = 200;

--4) WITH READ ONLY : �信 ���� ��ȸ�� �����ϵ���
CREATE OR REPLACE VIEW VW_EMP
AS SELECT EMP_ID, EMP_NAME, BONUS
   FROM EMPLOYEE
   WHERE BONUS IS NOT NULL
   WITH READ ONLY;
   
SELECT * FROM VW_EMP;

DELETE
FROM VW_EMP
WHERE EMP_ID = 200;
