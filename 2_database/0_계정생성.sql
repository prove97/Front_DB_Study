-- �� �� �ּ�
/*
    ���� �� �ּ�
*/

SELECT * FROM DBA_USERS; --���� ��� �����鿡 ���ؼ� ��ȸ�ϴ� ��ɹ�
-- ��ɹ� �ѱ��� ����(������ �����ư Ŭ�� | Ctrl + Enter)

-- �Ϲ� ����� ������ �����ϴ� ����(���� ������ ���������� �����ϴ�)
-- [ǥ����] CREATE USER ������ IDENTIFIED BY ��й�ȣ;
CREATE USER SPRING IDENTIFIED BY SPRING;
-- ������ ��й�ȣ�� ��ҹ��ڸ� �����Ѵ�.

-- ������ ������ �Ϲ� ����ڰ����� �ּ����� ����(����, �����Ͱ���) �ο�
-- [ǥ����] CREANT ����1, ����2... TO ������;
GRANT RESOURCE , CONNECT TO SPRING;

--DROP USER SEMIPROJECT CASCADE;
