
-- �Ϲ� ����� ������ �����ϴ� ����(���� ������ ���������� �����ϴ�)
-- [ǥ����] CREATE USER ������ IDENTIFIED BY ��й�ȣ;
--ID�� ��ҹ��� �������� ������ ,PW�� ������
CREATE USER JDBC IDENTIFIED BY JDBC;

-- ������ ������ �Ϲ� ����ڰ����� �ּ����� ����(����, �����Ͱ���) �ο�
-- [ǥ����] CREANT ����1, ����2... TO ������;
GRANT RESOURCE, CONNECT TO JDBC;
