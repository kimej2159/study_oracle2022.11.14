--2��. ������ ��ȸ ����

/*
DML : SELECT, INSERT, UPDATE, DELETE
DDL : CREATE, ALTER, DROP
DCL : GRANT, REVOKE, TRUNCATE
*/

SELECT �÷�1, �÷�2
FROM    ���̺��;

SELECT employee_id, first_name, department_id
FROM employees;

SELECT *
FROM eployees;

--2.2 SLECT ���� + ������(+���͸�) : Ư�� ���ǿ� �´� �����͸� ��ȸ

SELECT employee_id, first_name, department_id       
FROM employees
WHERE department_id = 100;

--�ڵ����� ���� : ���ϴ� ������ �� ���� �� CTRL + F7(=�ڵ� ���� )
--TAB ���� ���!

--2.3.3 �� ������
-- ���� ��
-- ���� ��(p.7)

[���� 2-11] tjddl king�� ����� ������ ��ȸ�Ͻÿ�
--����� ���� : ���, �̸�, ��, ��ȭ��ȣ, �̸���, �Ŵ���, �μ�, ���ʽ�...
--      last_name �� king ���� ��!! (=����, ũ��, �۴�)

SELECT employee_id ���, last_name ��, department_id �μ�
FROM employees
WHERE last_name = 'King'; 
     

-- ���ڿ� ���� : Ư�� ������ ���ڸ� ã�� ����
-- ex> ��ȭ��ȣ, �̸��� ==> 010-1234-1234 vs email@naver.com
-- sql�� ��, �ҹ��ڸ� �������� ������, ���� �����ʹ� ������
--          (��ɾ�)               (���ڰ�)

[���� 2-12] �Ի����� 2004�� 1�� 1�� ������ ����� ����(=���, �Ի���,�̸�...)
--2004�� 1�� 1�� ����, ó������ ~ 2003�� 12�� 31�� ����
SELECT *
FROM employees
WHERE hire_date < '01-JAN-04'; --��/��/�� 

--' ' : ���� ����ǥ�� 1) ���ڿ� ������ / 2)�ð�,��¥ �����͸� ǥ���� �� ���
--" " : ū ����ǥ�� �÷��� ��Ī(=Alisa)�� ������ ��, ������ �ִ� �ܾ� 

/* ������� �����ߴµ�, �� ������ ������?
ORA-01858: ���ڰ� �־�� �ϴ� ��ġ���� ���ڰ� �ƴ� ���ڰ� �߰ߵǾ����ϴ�.
01858. 00000 -  "a non-numeric character was found where a numeric was expected"
*Cause:    The input data to be converted using a date format model was
           incorrect.  The input data did not contain a number where a number was
           required by the format model.
*Action:   Fix the input data or the date format model to make sure the
           elements match in number and type.  Then retry the operation.
*/

--���� ��¥ ����ϱ�
SELECT SYSDATE
FROM dual;
          
          
SELECT employee_id ���, last_name ��, department_id �μ�, hire_date �Ի���
FROM employees
WHERE hire_date < '04/01/01'; --��/��/��  