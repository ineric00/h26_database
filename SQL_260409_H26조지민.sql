04.09(목) 문제 23.[사원 데이터베이스] 

어느 기업의 사원 데이터베이스가 있다. 다음 질문에 대해 SQL문을 작성하시오. 
Dept는 부서 (Department) 테이블로 depno(부서번호),dname(부서이름), loc(위치,location)으로 구성되어 
있다.
Emp는 사원(Employee)테이블로 empno(사원번호), ename(사원이름), job(업무), mgr
(팀장번호, manager), hiredate(고용날짜), sal(월급여, salary), comm(커미션금액, 
commission), deptno(부서번호)로 구성되어 있다. 
밑줄친 속성은 기본키이고 Emp의 deptno는 Dept의 deptno를 참조하는 외래키이며, 
Emp의 mgr은 자신의 상사에 대한 empno를 참조하는 외래키이다.
[실습준비] 시스템 계정으로 demo_scott_system.sql을 실행해 scott계정을 생성한 후 
(사용자 이름: C##scott, 비밀번호 : tiger. 이외 madang과 동일). 생성한 계정으로 
접속하여 demo_scott.sql을 실행하면 예제테이블과 데이터가 설치된다.
Dept(depno NUMBER(2), dname VARCHAR(14), loc VARCHAR(13))
Emp(empno NUMBER(4), ename VARCHAR(10), job VARCHAR(9),
      mgr NUMBER(4), hiredate DATE, sal NUMBER(7,2), 
      comm NUMBER(7,2), deptno NUMBER(2))

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

(1)교재 질의 

⓵사원의 이름과 업무를 출력하시오. 단 사원의 이름은 ‘사원이름’, ‘업무는 ’사원업무‘, 머리글
이 나오도록 출력하시오.

- SELECT ename AS "사원이름", job AS "사원업무" FROM emp;

⓶30번 부서에 근무하는 모든 사원의 이름과 급여를 출력하시오

- SELECT ename, sal FROM emp WHERE deptno = 30;

⓷사원번호와 이름, 현재급여, 증가된 급여분(열 이름은  증가액), 10% 인상된 급여(열 이름은  
’인상된 급여‘)를 사원 번호 순으로 출력하시오.

- SELECT empno, ename, sal, sal*0.1 AS "증가액", sal*1.1 AS "인상된 급여" FROM emp ORDER BY empno;

⓸’S’로 시작하는 모든 사원과 부서번호를 출력하시오.

- SELECT * FROM emp WHERE ename LIKE 'S%';

⑤모든 사원의 최대 및 최소 급여, 합계 및 평균 급여를 출력하시오. 열이름은 각각 MAX, MIN, SUM, AVG로 한다. 단 소수점 이하는 반올림하여 정수로 출력한다.

- 
- SELECT ROUND(MAX(sal)) AS MAX, ROUND(MIN(sal)) AS MIN, ROUND(SUM(sal)) AS SUM, ROUND(AVG(sal)) AS AVG FROM emp;

⓺업무(job)별로 동일한 업무를 하는 사원의 수를 출력하시오. 열이름은 각각 ‘업무’ 와 ‘업무별 사원수’로 한다.

- Select Round(Max(job Varchar)) AS Max, Round(Max(empno))
-

⓻사원의 최대 급여와 최소 급여의 차액을 출력하시오.

- Select Max(sal) - Min(sal) From emp;

⓼30번 부서의 사원 수와 사원들 급여의 합계와 평균을 출력하시오.

- Select Count(*), sum(sal), avg(sal) from emp where deptno = 30;
- SELECT COUNT(*), SUM(sal), AVG(sal) FROM emp WHERE deptno = 30;

⓽평균 급여가 가장 높은 부서의 번호를 출력하시오.

- 
-SELECT deptno FROM emp GROUP BY deptno HAVING AVG(sal) = (SELECT MAX(AVG(sal)) FROM emp GROUP BY deptno);

⓾세일즈맨(SALESMAN)을 제외하고, 각 업무별 사원의 총급여가 3,000이상인 가가 업무에 대해서, 업무명과 각 업무별 평균 급여를 출력하시오.

-  
- SELECT job, AVG(sal) FROM emp WHERE job != 'SALESMAN' GROUP BY job HAVING SUM(sal) >= 3000;

⑪전체 사원 가운데 직속상관이 있는 사원의 수를 출력하시오.

- 
- SELECT COUNT(mgr) FROM emp;

⑫EMP 테이블에서 이름, 급여, 커미션 금액(comm), 총액(sal*12+comm)을 구하여 총액이 많은 순서대로 출력하시오.

-
-SELECT ename, sal, comm, (sal*12 + NVL(comm, 0)) AS "총액" FROM emp ORDER BY "총액" DESC;

⑬부서별로 같은 업무를 하는 사람의 인원수를 구하여 부서번호, 업무 이름, 인원수를 출력하시오.

- SELECT deptno, job, COUNT(*) FROM emp GROUP BY deptno, job;

⑭사원이 한 명도 없는 부서의 이름을 출력하시오.

- SELECT dname FROM dept WHERE deptno NOT IN (SELECT DISTINCT deptno FROM emp);

⑮같은 업무를 하는 사람의 수가 4명 이상인 업무와 인원수를 출력하시오.

- SELECT job, COUNT(*) FROM emp GROUP BY job HAVING COUNT(*) >= 4;

⑯사원번호가 7400 이상 7600 이하인 사원의 이름을 출력하시오.

- SELECT ename FROM emp WHERE empno BETWEEN 7400 AND 7600;

⑰사원의 이름과 사원의 부서이름을 출력하시오.

- SELECT e.ename, d.dname FROM emp e JOIN dept d ON e.deptno = d.deptno;

⑱사원의 이름과 팀장(mgr)의 이름을 출력하시오.

- SELECT e.ename AS "사원", m.ename AS "팀장" FROM emp e JOIN emp m ON e.mgr = m.empno;

⑲사원 SCOTT보다 급여를  많이 받는 사람의 이름을 출력하시오.

- SELECT ename FROM emp WHERE sal > (SELECT sal FROM emp WHERE ename = 'SCOTT');

⑳사원 SCOTT이 일하는 부서번호 혹은 DALLAS 에 있는 부서번호를 출력하시오

- SELECT deptno FROM emp WHERE ename = 'SCOTT' UNION SELECT deptno FROM dept WHERE loc = 'DALLAS';

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

(2)단순질의

⓵comm(커미션)이 NULL이 아닌 사원의 이름과 커미션을 출력하시오.

-
- SELECT ename, comm FROM emp WHERE comm IS NOT NULL;
(커미션 존재)

⓶급여가 1500이상 3000 이하인 사원의 이름과 급여를 급여 오름차순으로 출력하시오.

-
- SELECT ename, sal FROM emp WHERE sal BETWEEN 1500 AND 3000 ORDER BY sal;
(급여 범위)

⓷1981년에 입사한 사원의 이름과 입사일을 출력하시오.

-
- SELECT ename, hiredate FROM emp WHERE hiredate LIKE '81%';
	(또는 EXTRACT)
(1981 입사)

⓸이름의 세 번째 글자가  ‘A’인 사원을 출력하시오.

-
- SELECT * FROM emp WHERE ename LIKE '__A%';
(이름 패턴) 

⑤사원의 이름을 소문자로 출력하시오.

-
- SELECT LOWER(ename) FROM emp;
(소문자 변환)

⓺사원 이름, 입사일, 오늘까지의 근무 개월 수를 출력하시오.

- 
- SELECT ename, hiredate, MONTHS_BETWEEN(SYSDATE, hiredate) FROM emp;
(근무 개월 수)

⓻사원 이름과 이름의 글자 수를 글자 수 내림차순으로 출력하시오.

- 
- SELECT ename, LENGTH(ename) FROM emp ORDER BY LENGTH(ename) DESC;
(글자 수 정렬)

⓼comm이 NULL이면 0으로 대체하여 총소득(sal+comm)을 출력하시
오.

- 
- SELECT sal + NVL(comm, 0) FROM emp;
(NVL 활용)

⓽ANALYST 또는 PRESIDENT인 사원의 이름, 업무, 급여를 출력하시오.

-
- SELECT ename, job, sal FROM emp WHERE job IN ('ANALYST', 'PRESIDENT');
(IN 연산자)

⓾이름 길이가 긴 순, 같으면 알파벳 순으로 사원 이름을 출력하시오.

- 
- SELECT ename FROM emp ORDER BY LENGTH(ename) DESC, ename ASC;  
(복합 정렬)

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

(3)부속질의

⓵JONES와 같은 부서에 근무하는 사원의 이름을 출력하시오(JONES본인 제외)

-
- SELECT ename FROM emp WHERE deptno = (SELECT deptno FROM emp WHERE ename = 'JONES') AND ename != 'JONES';
(JONES 부서)

⓶각 부서에서 가장 높은 급여를 받는 사원의 이름, 급여, 부서번호를 출력하시오.

-
- SELECT ename, sal, deptno FROM emp WHERE (deptno, sal) IN (SELECT deptno, MAX(sal) FROM emp GROUP BY deptno);
(부서별 최고 급여)

⓷30번 부서 평균 급여보다 급여가 높은 사원의 이름과 급여를 출력하시오.

-
- SELECT ename, sal FROM emp WHERE sal > (SELECT AVG(sal) FROM emp WHERE deptno = 30);

⓸MANAGER 직급 평균 급여보다 적은 CLERK 사원의 이름과 급여를 출력하시오.

-
- SELECT ename, sal FROM emp WHERE job = 'CLERK' AND sal < (SELECT AVG(sal) FROM emp WHERE job = 'MANAGER');

⑤업무별 최고 급여를 받는 사원의 이름, 업무, 급여를 출력하시오.

-
- SELECT ename, job, sal FROM emp WHERE (job, sal) IN (SELECT job, MAX(sal) FROM emp GROUP BY job);


⓺KING에게 직접 보고하는 사원의 이름과 업무를 출력하시오.

-
- SELECT ename, job FROM emp WHERE mgr = (SELECT empno FROM emp WHERE ename = 'KING');

⓻입사일이 가장 최근인 사원과 가장 오래된 사원을 함께 출력하시오.

-
- SELECT ename, hiredate FROM emp WHERE hiredate = (SELECT MAX(hiredate) FROM emp) OR hiredate = (SELECT MIN(hiredate) FROM emp);

⓼전체 평균 급여보다 급여가 높고 직위가 MANAGER인 사원을 출력하시오.

-
- SELECT ename, job, sal FROM emp WHERE sal > (SELECT AVG(sal) FROM emp) AND job = 'MANAGER';

⓽급여가 전체 사원 급여 합계의 10%를 초과하는 사원이 이름과 급여를 출력하시오.

-
- SELECT ename, sal FROM emp WHERE sal > (SELECT SUM(sal) * 0.1 FROM emp);

⓾BLAKE와 같은 직위(job)를 가진 사원의 이름과 급여를 출력하시오(BLAKE 본인 제외)

-
- SELECT ename, sal FROM emp WHERE job = (SELECT job FROM emp WHERE ename = 'BLAKE') AND ename != 'BLAKE';

⑪30번 부서에 속한 사원과 같은 직위(job)를 가진 모든 사원을 출력하시오. 

-
- SELECT ename, job FROM emp WHERE job IN (SELECT job FROM emp WHERE deptno = 30);

⑫급여가 모든 CLERK보다 많은 사원의 이름과 급여를 출력하시오(ALL)

-
- SELECT ename, sal FROM emp WHERE sal > ALL (SELECT sal FROM emp WHERE job = 'CLERK'); 
(ALL은 서브쿼리의 모든 결과보다 커야 함을 의미합니다)

⑬SALESMAN 중 누구보다도 급여가 많은 사원의 이름과 급여를 출력하시오.(ANY)

-
- SELECT ename, sal FROM emp WHERE sal > ANY (SELECT sal FROM emp WHERE job = 'SALESMAN'); 
(ANY는 서브쿼리 결과 중 하나라도 크면 됨을 의미합니다)

⑭부하 직원이 존재하는 (관리자인) 사원의 이름과 직위를 출력하시오(EXITS)

-
- SELECT ename, job FROM emp e WHERE EXISTS (SELECT 1 FROM emp m WHERE m.mgr = e.empno);
(EXISTS 활용)

⑮급여 상위 3위 안에 드는 사원의 이름과 급여를 출력하시오.

-
- SELECT ename, sal FROM (SELECT ename, sal FROM emp ORDER BY sal DESC) WHERE ROWNUM <= 3;
(ROWNUM (TOP-N))

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

(4)조인질의

⓵사원의 이름과 소속 부서 이름을 출력하시오.

-
- SELECT e.ename, d.dname FROM emp e JOIN dept d ON e.deptno = d.deptno;

⓶사원의 이름과 팀장의 이름을 출력하시오.(셀프 조인)

-
- SELECT e.ename AS "사원", m.ename AS "팀장" FROM emp e JOIN emp m ON e.mgr = m.empno; 
(셀프 조인)

⓷사원이 한 명도 없는 부서의 이름을 출력하시오.

-
- SELECT d.dname FROM dept d LEFT JOIN emp e ON d.deptno = e.deptno WHERE e.empno IS NULL;

⓸NEW YORK에 근무하는 사원의 이름과 업무를 출력하시오.

-
- SELECT e.ename, e.job FROM emp e JOIN dept d ON e.deptno = d.deptno WHERE d.loc = 'NEW YORK';

⑤사원이름, 급여, 급여 등급을 출력하시오.(SALGRADE 활용)

-
- SELECT e.ename, e.sal, s.grade FROM emp e JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal; 
(비등가 조인: = 대신 BETWEEN 사용)


⓺사원이름, 급여, 급여 등급, 부서 이름을 한 번에 출력하시오.

-
- SELECT e.ename, e.sal, s.grade, d.dname FROM emp e JOIN dept d ON e.deptno = d.deptno JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal; 
(3개 테이블 조인)


⓻자신의 상관보다 급여가 높은 사원의 이름과 두 사람의 급여를 출력하시오.

-
- SELECT e.ename, e.sal, m.sal FROM emp e JOIN emp m ON e.mgr = m.empno WHERE e.sal > m.sal;


⓼사원 이름, 부서이름, 근무 도시를 출력하시오.

-
- SELECT e.ename, d.dname, d.loc FROM emp e JOIN dept d ON e.deptno = d.deptno;


⓽CHOICAGO에 근무하는 사원 수를 출력하시오.

-
- SELECT COUNT(*) FROM emp e JOIN dept d ON e.deptno = d.deptno WHERE d.loc = 'CHICAGO'; 
(오타 수정: CHOICAGO -> CHICAGO)


⓾부서별 인원 수가 많은 순으로 부서번호, 부서이름, 인원수를 출력하시오.

-
- SELECT d.deptno, d.dname, COUNT(e.empno) FROM dept d LEFT JOIN emp e ON d.deptno = e.deptno GROUP BY d.deptno, d.dname ORDER BY COUNT(e.empno) DESC;


⑪부서별 평균 급여를 부서이름과 함께 출력하시오.

-
- SELECT d.dname, ROUND(AVG(e.sal)) FROM emp e JOIN dept d ON e.deptno = d.deptno GROUP BY d.dname;

⑫급여 등급이 3등급인 사원의 이름, 급여, 부서이름을 출력하시오.

-
- SELECT e.ename, e.sal, d.dname FROM emp e JOIN dept d ON e.deptno = d.deptno JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal WHERE s.grade = 3;

⑬사원의 이름, 입사일, 입사 요일을 부서이름과 함께 출력하시오.

-
- SELECT e.ename, e.hiredate, TO_CHAR(e.hiredate, 'DAY') AS "요일", d.dname FROM emp e JOIN dept d ON e.deptno = d.deptno; (TO_CHAR 함수로 요일 추출)


⑭같은 부서에서 근무하는 사원끼리 이름을 나란히 출력하시오.(셀프 조인, 중복제거)

-
- SELECT a.ename, b.ename FROM emp a JOIN emp b ON a.deptno = b.deptno AND a.empno < b.empno;
 (중복 제거를 위해 < 조건 사용)


⑮사원이름, 상관이름, 상관의 부서이름을 출력하시오(셀프+DEPTt조인)

-
- SELECT e.ename AS "사원이름", m.ename AS "상관이름", d.dname AS "상관부서" FROM emp e JOIN emp m ON e.mgr = m.empno JOIN dept d ON m.deptno = d.deptno;


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

(5)집계질의

⓵업무별 최고, 최소, 평균 급여와 사원 수를 출력하시오.

- Select 
- SELECT job, MAX(sal), MIN(sal), ROUND(AVG(sal)), COUNT(*) FROM emp GROUP BY job;

⓶부서별, 업무별 인원수를 출력하시오.

-
- SELECT deptno, job, COUNT(*) FROM emp GROUP BY deptno, job;

⓷직원별 총 급여(sal*12+comm)를 내림차순으로 출력하시오.

-
- SELECT ename, (sal * 12 + NVL(comm, 0)) AS "총급여" FROM emp ORDER BY "총급여" DESC;

⓸평균 급여보다 높은 급여를 받는 부서(번호)와 해당 부서의 평균 급여를 출력하시오

-
- SELECT deptno, ROUND(AVG(sal)) FROM emp GROUP BY deptno HAVING AVG(sal) > (SELECT AVG(sal) FROM emp);

⑤입사년도별 사원 수를 출력하시오.

-
- SELECT TO_CHAR(hiredate, 'YYYY'), COUNT(*) FROM emp GROUP BY TO_CHAR(hiredate, 'YYYY');

⓺급여 등급별 사원 수와 평균 급여를 출력하시오

-
- SELECT s.grade, COUNT(*), ROUND(AVG(e.sal)) FROM emp e JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal GROUP BY s.grade;

⓻총급여가 5000 이상인 부서의 번호와 합계를 출력하시오.

-
- SELECT deptno, SUM(sal) FROM emp GROUP BY deptno HAVING SUM(sal) >= 5000;

⓼각 사원의 급여가 전체 급여 합계에서 차지하는 비율(%)을 출력하시오.

-
- SELECT ename, sal, ROUND(sal / (SELECT SUM(sal) FROM emp) * 100, 2) || '%' AS "비율" FROM emp;

⓽근속 연수 10년 이상인 사원의 이름, 입사일, 근속 연수를 출력하시오.

-
- SELECT ename, hiredate, TRUNC(MONTHS_BETWEEN(SYSDATE, hiredate)/12) AS "근속연수" FROM emp WHERE MONTHS_BETWEEN(SYSDATE, hiredate)/12 >= 10;

⓾급여 상위 5명의 사원 이름과 급여를 출력하시오

-
- SELECT ename, sal FROM (SELECT ename, sal FROM emp ORDER BY sal DESC) WHERE ROWNUM <= 5; (인라인 뷰를 활용한 상위 N개 추출)


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------




demo_scott.sql의 내용

SET TERMOUT ON
PROMPT Building demonstration tables. Please wait.
SET TERMOUT OFF
DROP TABLE EMP;
DROP TABLE DEPT;
DROP TABLE BONUS;
DROP TABLE SALGRADE;
DROP TABLE DUMMY;
CREATE TABLE EMP (
EMPNO NUMBER(4) NOT NULL,
ENAME VARCHAR2(10),
JOB VARCHAR2(9),
MGR NUMBER(4),
HIREDATE DATE,
SAL NUMBER(7, 2),
COMM NUMBER(7, 2),
DEPTNO NUMBER(2)
);
INSERT INTO EMP VALUES (7369, 'SMITH', 'CLERK', 7902,TO_DATE('1980-12-17', 
'YYYY-MM-DD'), 800, NULL, 20);
INSERT INTO EMP VALUES (7499, 'ALLEN', 'SALESMAN', 7698,TO_DATE('1981-02-20', 
'YYYY-MM-DD'), 1600, 300, 30);
INSERT INTO EMP VALUES (7521, 'WARD', 'SALESMAN', 7698,TO_DATE('1981-02-22', 
'YYYY-MM-DD'), 1250, 500, 30);
INSERT INTO EMP VALUES (7566, 'JONES', 'MANAGER', 7839,TO_DATE('1981-04-02', 
'YYYY-MM-DD'), 2975, NULL, 20);
INSERT INTO EMP VALUES (7654, 'MARTIN', 'SALESMAN', 7698,TO_DATE('1981-09-28', 
'YYYY-MM-DD'), 1250, 1400, 30);
INSERT INTO EMP VALUES (7698, 'BLAKE', 'MANAGER', 7839,TO_DATE('1981-05-01', 
'YYYY-MM-DD'), 2850, NULL, 30);
INSERT INTO EMP VALUES (7782, 'CLARK', 'MANAGER', 7839,TO_DATE('1981-06-09', 
'YYYY-MM-DD'), 2450, NULL, 10);
INSERT INTO EMP VALUES (7788, 'SCOTT', 'ANALYST', 7566,TO_DATE('1982-12-09', 
'YYYY-MM-DD'), 3000, NULL, 20);
INSERT INTO EMP VALUES (7839, 'KING', 'PRESIDENT', NULL,TO_DATE('1981-11-17', 
'YYYY-MM-DD'), 5000, NULL, 10);
INSERT INTO EMP VALUES (7844, 'TURNER', 'SALESMAN', 7698,TO_DATE('1981-09-08', 
'YYYY-MM-DD'), 1500, 0, 30);
INSERT INTO EMP VALUES (7876, 'ADAMS', 'CLERK', 7788,TO_DATE('1983-01-12', 
'YYYY-MM-DD'), 1100, NULL, 20);
INSERT INTO EMP VALUES (7900, 'JAMES', 'CLERK', 7698,TO_DATE('1981-12-03', 
'YYYY-MM-DD'), 950, NULL, 30);
INSERT INTO EMP VALUES (7902, 'FORD', 'ANALYST', 7566,TO_DATE('1981-12-03', 
'YYYY-MM-DD'), 3000, NULL, 20);
INSERT INTO EMP VALUES (7934, 'MILLER', 'CLERK', 7782,TO_DATE('1982-01-23', 
'YYYY-MM-DD'), 1300, NULL, 10);
CREATE TABLE DEPT(
DEPTNO NUMBER(2),
DNAME VARCHAR2(14),
LOC VARCHAR2(13) 
);
INSERT INTO DEPT VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO DEPT VALUES (20, 'RESEARCH', 'DALLAS');
INSERT INTO DEPT VALUES (30, 'SALES', 'CHICAGO');
INSERT INTO DEPT VALUES (40, 'OPERATIONS', 'BOSTON');
CREATE TABLE BONUS(
ENAME VARCHAR2(10),
JOB VARCHAR2(9),
SAL NUMBER,
COMM NUMBER
);
CREATE TABLE SALGRADE(
GRADE NUMBER,
LOSAL NUMBER,
HISAL NUMBER
);
INSERT INTO SALGRADE VALUES (1, 700, 1200);
INSERT INTO SALGRADE VALUES (2, 1201, 1400);
INSERT INTO SALGRADE VALUES (3, 1401, 2000);
INSERT INTO SALGRADE VALUES (4, 2001, 3000);
INSERT INTO SALGRADE VALUES (5, 3001, 9999);
CREATE TABLE DUMMY (DUMMY NUMBER);
INSERT INTO DUMMY VALUES (0);
COMMIT;
SET TERMOUT ON
PROMPT Demonstration table build is complete.
