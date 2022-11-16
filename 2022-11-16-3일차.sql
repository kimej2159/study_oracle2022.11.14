/*-----------------------------------   
    �������� �����ϴ� �׸����� �з�
    1) �÷�, ����, ����
    2) ���������: +, -, *, / �� ������ : =, >=, <=, >, <, !=, <>, (����) ���� ������:
    3) AND, OR, NOT : �� ������
    4) LIKE, IN, BETWEEN, EXISTS, NOT
    5) IS NULL, IS NOT NULL
    6) ANY, SOME, ALL
    7)  �Լ�(��۾��� �����ϴ� ��ɾ��� ����)    (VS ���ν���)
    
2.3������
2.3.1 ��� ������ : +, -, *, /
-- SELECT ��, WHERE ������
*/
SELECT 2+2, 2-1, 2*3, 4/2
FROM dual; --dual : ��¥ ���̺� (+���� �������� �ʴ� ������ ���̺��� dual�� ���� ó��)

[���� 2-4] 80�� �μ� ����� �� �� ���� ���� �޿�(=����)�� ��ȸ�Ͻÿ�
-- ������� ������ EPLOYEES ��� ���̺� ����Ǿ� ����.
-- ����� �ٹ��ϴ� �μ��� ������ DEPARTMENTS ��� ���̺� ����Ǿ� ����.
SELECT employee_id emp_id, last_name, salary *12 "Annual Salary"  -- ��Ī(=alias, ����)
FROM employees
WHERE department_id = 80; --34 rows

SELECT department_id, department_name, manager_id
FROM departments
WHERE department_id = 80; --34 rows

[����2-5] ��ü ����� �� �� �� ���� ���� �޿��� 12000�� ����� ��ȸ�Ͻÿ�
-- ��ü��� ��ȸ
-- * : aesterisk, ���� ���� / ��� ���ڿ��� ��ü (= ��� �÷��� ����. ��� ~ �μ� �ڵ����)
SELECT *
FROM employees
WHERE salary*12 = 120000;  --


2.3.2 ���� ������ :||
-- �̸��� ���� �����Ͽ� �̸�/���� �̶�� Į������ ��ȸ�� ��
SELECT employee_id, first_name || last_name full_name
FROM employees;

[���� 2-6] ����� 101�� ����� ������ ��ȸ�Ͻÿ�
-- ���⼭ ������ �̸�+���� ����, ���� FULLNAME �̶�� ��.
SELECT employee_id ���, first_name || '  ' || last_name ����, department_id �μ��̸�
FROM employees
WHERE employee_id = 101;

--��Ī(Alias)�� �÷��� ��Ī ==> ���� ����
    1)������ �ΰ� ����Ѵ�.
    2)Ű����δ� As �Ǵ� as�� ����Ѵ�. 
    3��Ī�� ������ ������ ū ����ǥ�� ��� ����Ѵ�.
    
[���� 2-8] ����� 101�� ����� ������ ���, ����, ����, �μ��� ��ȸ�Ͻÿ�
SELECT 'hanul' company, employee_id, first_name ||' '||last_name, salary * 12 as "Annual Salary", department_id �μ��̸�
FROM employees
WHERE  employee_id = 101;

[���� 2-9] �޿��� 3000 ������ ����� ������ ��ȸ�Ѵ�
SELECT employee_id, first_name ||' '||last_name, department_id, salary
FROM employees
WHERE Salary <= 3000;

--30�� �μ�, 50�� �μ��� � �μ����� �μ���, �μ���(manager_id)�� �˾ƺ�����!

SELECT *
FROM departments
WHERE department_id = 30; --Purchasing

SELECT *
FROM departments
WHERE department_id = 50;--shipping

SELECT *
FROM departments
WHERE department_id = :num; --���ε� ���� pl/sql ��Ʈ����

[����2-10]�μ��ڵ尡 80���� �ʰ��ϴ� ����� ������ ��ȸ�Ͻÿ�
SELECT *
FROM employees
WHERE department_id > 80;