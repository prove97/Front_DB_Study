--�ǽ����� --
--�������� ���α׷��� ����� ���� ���̺�� �����--
--�̶�, �������ǿ� �̸��� �ο��� ��
--   �� �÷��� �ּ��ޱ�

/*
    1. ���ǻ�鿡 ���� �����͸� ������� ���ǻ� ���̺�(TB_PUBLISHER)
    �÷� : PUB_NO(���ǻ� ��ȣ) - �⺻Ű(PUBLISHER_PK)
          PUB_NAME(���ǻ��) -- NOT NULL(PUBLISHER_NN)
          PHONE(���ǻ���ȭ��ȣ) -- �������Ǿ���
*/
--���� 3������ ����
CREATE TABLE TB_PUBLISHER(
    PUB_NO NUMBER CONSTRAINT PUBLISHER_PK PRIMARY KEY,
    PUB_NAME VARCHAR2(20) CONSTRAINT PUBLISHER_NN NOT NULL,
    PHONE CHAR(20)
);

COMMENT ON COLUMN TB_PUBLISHER.PUB_NO IS '���ǻ� ��ȣ';
COMMENT ON COLUMN TB_PUBLISHER.PUB_NAME IS '���ǻ��';
COMMENT ON COLUMN TB_PUBLISHER.PHONE IS '���ǻ���ȭ��ȣ';

INSERT INTO TB_PUBLISHER VALUES (1, '���ǻ�1', '010-1111-2222');
INSERT INTO TB_PUBLISHER VALUES (2, '���ǻ�2', '010-1111-3333');
INSERT INTO TB_PUBLISHER VALUES (3, '���ǻ�3', '010-4444-2222');

/*
    2. �����鿡 ���� �����͸� ������� ���� ���̺�(TB_BOOK)
    �÷� : BK_NO(������ȣ)--�⺻Ű(BOOK_PK)
          BK_TITLE(������)--NOT NULL(BOOK__NN_TITLE)
          BK_AUTHOR(���ڸ�)--NOT NULL(BOOK__NN_AUTHOR)
          BK_PRICE(����)-- �������Ǿ���
          BK_PUB_NO(���ǻ� ��ȣ)--�ܷ�Ű(BOOK_FK)(TB_PUBLISHER���̺��� ����)
                                �̶� �����ϰ� �ִ� �θ����� ������ �ڽĵ����͵� ���� �ǵ��� �ɼ�����
                                
*/
CREATE TABLE TB_BOOK(
    BK_NO NUMBER CONSTRAINT BOOK_PK PRIMARY KEY,
    PK_TITLE VARCHAR2(30) CONSTRAINT BOOK_NN_TITLE NOT NULL,
    BK_AUTHOR VARCHAR2(30) CONSTRAINT BOOK_NN_AUTHOR NOT NULL,
    BK_PRICE NUMBER,
    BK_PUB_NO NUMBER CONSTRAINT BOOK_FK REFERENCES TB_PUBLISHER ON DELETE CASCADE     
);

COMMENT ON COLUMN TB_BOOK.BK_NO IS '������ȣ';
COMMENT ON COLUMN TB_BOOK.PK_TITLE IS '������';
COMMENT ON COLUMN TB_BOOK.BK_AUTHOR IS '���ڸ�';
COMMENT ON COLUMN TB_BOOK.BK_PRICE IS '����';
COMMENT ON COLUMN TB_BOOK.BK_PUB_NO IS '���ǻ��ȣ';

--5�� ������ ���� ������ �߰��ϱ�
INSERT INTO TB_BOOK VALUES (1, '����1', 'ȫ�浿', 10000, 1);
INSERT INTO TB_BOOK VALUES (2, '����2', '��浿', 44000, 2);
INSERT INTO TB_BOOK VALUES (3, '����3', '�̱浿', 20000, 3);
INSERT INTO TB_BOOK VALUES (4, '����4', '�ֱ浿', 12000, 3);
INSERT INTO TB_BOOK VALUES (5, '����5', '�ڱ浿', 13000, 2);

/*
    3. ȸ���� ���� �����͸� ������� ȸ�� ���̺�(TB_MEMBER)
    �÷��� : MEMBER_NO(ȸ����ȣ) -- �⺻Ű(MEMBER_PK)
            MEMBER_ID(���̵�) -- �ߺ�����(MEMBER_UQ_ID)
            MEMBER_PWD(��й�ȣ) -- NOT NULL(MEMBER_NN_PWD)
            MEMBER_NAME(ȸ����) -- NOT NULL(MEMBER_NN_NAME)
            GENDER(����) -- M�Ǵ� F�� �Էµǵ��� ����(MEMBER_CK_GEN)
            ADDRESS(�ּ�) -- �������Ǿ���
            PHONE(����ó)-- �������Ǿ���
            STATUS(Ż�𿩺�) -- �⺻���� N���� ����, �׸��� N�Ǵ� Y�� �Էµǵ��� �������� ����(MEMBER_CK_STA)
            ENROLL_DATE(������) -- �⺻������ SYSDATE, NOT NULL ��������(MEMBER_NN_EN)
*/
CREATE TABLE TB_MEMBER(
    MEMBER_NO NUMBER CONSTRAINT MEMBER_PK PRIMARY KEY,
    MEMBER_ID VARCHAR2(30) CONSTRAINT MEMBER_UQ_ID UNIQUE,
    MEMBER_PWD VARCHAR2(30) CONSTRAINT MEMBER_NN_PWD NOT NULL,
    MEMBER_NAME VARCHAR2(20) CONSTRAINT MEMBER_NN_NAME NOT NULL,
    GENDER CHAR(1) CONSTRAINT MEMBER_CK_GEN CHECK(GENDER IN('M','F')),     
    ADDRESS VARCHAR2(100),
    PHONE VARCHAR2(13),
    STATUS CHAR(1) DEFAULT 'N' CONSTRAINT MEMBER_CK_STA CHECK (STATUS IN ('N', 'Y')) ,
    ENROLL_DATE DATE DEFAULT SYSDATE CONSTRAINT MEMBER_NN_EN NOT NULL 
);

COMMENT ON COLUMN TB_MEMBER.MEMBER_NO IS 'ȸ����ȣ';
COMMENT ON COLUMN TB_MEMBER.MEMBER_ID IS '���̵�';
COMMENT ON COLUMN TB_MEMBER.MEMBER_PWD IS '��й�ȣ';
COMMENT ON COLUMN TB_MEMBER.MEMBER_NAME IS 'ȸ����';
COMMENT ON COLUMN TB_MEMBER.GENDER IS '����';
COMMENT ON COLUMN TB_MEMBER.ADDRESS IS '�ּ�';
COMMENT ON COLUMN TB_MEMBER.PHONE IS '����ó';
COMMENT ON COLUMN TB_MEMBER.STATUS IS 'Ż�𿩺�';
COMMENT ON COLUMN TB_MEMBER.ENROLL_DATE IS '������';


--5�� ������ ���� ������ �߰��ϱ�
INSERT INTO TB_MEMBER VALUES (1, 'aaa', 'pwd1', 'ȫ�浿', 'M', '010-1111-2222', '���� ���Ǳ�', 'N', '19/02/21');
INSERT INTO TB_MEMBER VALUES (2, 'bbb', 'pwd2', 'ȫ���', 'w', '010-1121-2222', '���� ������', 'N', '19/02/24'); 
INSERT INTO TB_MEMBER VALUES (3, 'ccc', 'pwd3', '�ڱ浿', 'M', '010-1333-2222', '��� ����', 'N', '20/06/01'); 
INSERT INTO TB_MEMBER VALUES (4, 'ddd', 'pwd4', '��浿', 'M', '010-1111-6643', '���� ��걸', 'N', '23/02/21'); 
INSERT INTO TB_MEMBER VALUES (5, 'eee', 'pwd5', '�ֱ浿', 'M', '010-1113-2577', '���� �߱�', 'Y', '17/08/23'); 

/*
    4.� ȸ���� � ������ �뿩�ߴ����� ���� �뿩��� ���̺�(TB_RENT)
    �÷��� : RENT_NO(�뿩��ȣ)-- �⺻Ű(RENT_PK)
            RENT_MEM_NO(�뿩ȸ����ȣ)-- �ܷ�Ű(RENT_FK_MEM) TB_MEMBER�� �����ϵ���
                                        �̶� �θ� ������ ������ �ڽĵ����� ���� NULL�� �ǵ��� ����
            RENT_BOOK_NO(�뿩������ȣ)-- �ܷ�Ű(RENT_FK_BOOK) TB_BOOK�� �����ϵ���
                                        �̶� �θ� ������ ������ �ڽĵ����� ���� NULL�� �ǵ��� ����
            RENT_DATE(�뿩��) -- �⺻�� SYSDATE
*/
CREATE TABLE TB_RENT(
    RENT_NO NUMBER CONSTRAINT RENT_PK PRIMARY KEY,
    RENT_MEM_NO NUMBER CONSTRAINT RENT_FK_MEM REFERENCES TB_MEMBER ON DELETE SET NULL,
    RENT_BOOK_NO NUMBER CONSTRAINT RENT_FK_BOOK REFERENCES TB_BOOK ON DELETE SET NULL,
    RENT_DATE DATE DEFAULT SYSDATE
);

COMMENT ON COLUMN TB_RENT.RENT_NO IS '�뿩��ȣ'; 
COMMENT ON COLUMN TB_RENT.RENT_MEM_NO IS '�뿩ȸ����ȣ'; 
COMMENT ON COLUMN TB_RENT.RENT_BOOK_NO IS '�뿩������ȣ'; 
COMMENT ON COLUMN TB_RENT.RENT_DATE IS '�뿩��'; 

--3�� ������ ���� ������ �߰��ϱ�
INSERT INTO TB_RENT VALUES (1, 1, 1, '20/01/01');
INSERT INTO TB_RENT VALUES (2, 2, 1, '20/02/01');
INSERT INTO TB_RENT VALUES (3, 2, 3, '20/04/01');