--������ ��ȸ(p.4)
--SQL�� ��, �ҹ��ڸ� �������� ���� vs Java�� ��, �ҹ��� ������ ������!
--���̺��� ������ ���캸�� ��� :desc, describe


desc countries;
describe countries; -- ���̺��� �� �÷�
DESC countries;


SELECT * FROM countries;

SELECT *       -- select ��(=clause)
FROM countries;  -- from ��

SELECT country_id, country_name,region_id
FROM countries;

[���� 2-1] employees ���̺��� ������ ��ȸ�Ͻÿ�
DESC empoloyees;

[���� 2-2] employees ���̺��� �����͸� ��� ��ȸ�Ͻÿ� VS ���, �̸� �� ���޿�
SELECT *
FROM employees;

SELECT employee_id, first_name, last_name, salary
FROM employees;







2.2 ������
��ü �����Ϳ��� Ư�� �� �����͸� �����Ͽ� ��ȸ�ϱ� ���ؼ� �������� ����մϴ�.
/*
SELECT �÷�1, �÷�2,...          (3)���ϴ� �÷��� ��ȸ
FROM ���̺� �̸�                 (1) ����
WHERE ������ ����;               (2) ����( = ���͸� ��ȸ)
*/
[����2-3] 80�� �μ����� ��� ������ ��ȸ�Ͻÿ�
--Space Bar�� ���� ��ɰ� �÷�, ���ǵ��� ���� �����Ͽ� �������� ����
SELECT *
FROM employees
WHERE department_id = 80; --���� ������ : = (eaual)

-- Ű������ Tab Ű�� ���� ������ ������ �����ϸ鼭 ���������� �������� ����
SELECT  *
FROM    employees
WHERE   department_id = 80;

-- �� ����� CTRL+F7 : �ڵ����� SQL ���� ������ ����
SELECT
FROM
WHERE

--��ü �μ��� ����?
DESC departments;

SELECT  *
FROM departments;  --27 rows
