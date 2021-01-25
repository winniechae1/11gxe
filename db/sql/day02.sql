create user scott1 identified by tiger account unlock;

alter user scott1 identified by tiger account unlock;

grant resource, connect to scott1;

/*
    sqlplus 에서 작업이 끝나고 일반 cmd  환경으로 돌아가려면 
    작업을 정상적으로 종료 해줘야 한다.
    이작업은 매우 중요하고 반드시 수행해 줘야 한다.
    
    sqlplus의 작업을 정상적으로 종료시키는 명령은
        
        exit
    명령이다.
    
-------------------------------------------------------------------------------
    
    emp 테이블 구조 : 사원 정보 테이블
        한 사원의 속성은 8개로 구성이 되어있다.
        
        empno       - 사원번호
        ename       - 사원이름
        job         - 사원직급
        mgr         - 상사의 사원번호(상사번호)
        hiredate    - 입사일
        sal         - 급여
        comm        - 커미션
        deptno      - 부서번호
        
    dept 테이블 구조 : 부서정보테이블
        부서의 정보를 기억하는 테이블
        3개의 속성(컬럼, 필드, attribute)으로 이루져있다.
        
        deptno      - 부서번호
        dname       - 부서이름
        loc         - 부서위치(location)
        
    salgrade 테이블 구조 : 급여 등급 테이블
        3개의 컬럼으로 구성되어있다.
        
        grade       - 급여등급
        losal       - 최소급여
        hisal       - 최대급여
        
--------------------------------------------------------------------------
    오라클이란??
        데이터베이스 메지니먼트 시스템의 한 종류로
        많은 양의 데이터를 보관하고 있다가
        누군가(프로그램, sqlplus, sqldeveloper, web, ....) 
        데이터가 필요하면 데이터를 알려주는 도구이다.
        
        따라서 스스로 뭔가를 하는 개념 보다는
        다른 누군가의 명령을 받아서 그 명령에 해당하는 작업을(데이터)
        처리하는 도구이다.
        
        구성 
            
            1. DBMS
                ==> 명령을 받아서 실행하는 프로그램의 일종
                    데이터베이스를 관리하는 프로그램의 일종...
                    
            2. Data Bank
                ==> 데이터를 보관하는 장소를 관리하는 도구
                
            참고 ]
                우리가 흔히 좋은 데이터베이스다 또는 
                그 데이터베이스의 성능이 좋다 나쁘다 라는 표현은
                DBMS의 기능에 따라서 구분되는 것이다.
                이 말은 곧 데이터베이스 관리 시스템 마다 dbms가 다르다라는 말이고
                결론적으로
                데이터베이스를 조작하는 명령이 데이터베이스에 따라 달라진다.
                
--------------------------------------------------------------------------
sql 기본연산 - CRUD
    : 데이터베이스를 공부하는 사람이라면 반드시 알아야 할 4가지 명령
    
    C   - create    - insert    : 데이터를 추가하는 명령
    R   - read      - select    : 데이터를 조회하는 명령
    U   - update    - update    : 데이터를 수정하는 명령
    D   - delete    - delete    : 데이터를 삭제하는 명령
    
                        DML 명령에 해당한다.
                        
----------------------------------------------------------------------
참고 ]
    오라클이 데이터를 보관하는 방법
        
        테이블(entity:개체) 단위로 보관한다.
        ==> 테이블이란??
            마치 엑셀처럼
                줄과 칸으로 구성되어서 데이터를 보관하는 방식
                
        결론적으로
        테이블이란 필드(컬럼, 엔티티)와 레코드(row, 행)로 구성된 데이터를 
        보관하는 가장 작은 단위이다.
        
        필드(컬럼, attibute) : 같은 개념의 데어터 모임
        레코드(행, row)        : 같은 목적을 가진 데이터 모임
        
        
        참고 ]
            필드에는 그 항목을 구분하기 위한 이름이 부여되어 있다.
            이것을 '필드이름' 이라 부른다.
            
            하지만 레코드(행, row)는 각 행을 구분하는 방법이 존재하지 않는다.
            따라서 속성 값으로 구분지어 주어야 한다. (기본키 제약조건 : null 아니고 반드시 다른 행의 속성값과 구분(UNIQUE)되어야 한다. )
            
*/ 

-- 1. scott 계정이 가지고있는 테이블이 무엇이 있는지 알아보자.

SELECT 
    tname   --tname : tab 이라는 테이블이 가지고있는 필드이름: 테이블이름을 기억
FROM 
    tab     -- 오라클이 관리하는 테이블로 우리가 테이블만들면 그 테이블의 정보가 자동 기억된다.
; -- 세미콜론은 하나의 명령이 끝났음을 알려주는 기호

/*
SELECT 
    tname 
FROM 
    tab

SELECT 
    tname 
FROM 
    tab
    ;
===> 오류의 원인은 전 질의명령이 끝났음을 알려주지 않아서 오류가 발생한다.
*/
/*
    조회 질의 명령(쿼리문) 구조
    
    1. 기본 구조
        
        SELECT
            조회할 필드이름들이 나열       -------> 여기까지를 select절
            
            -- 여러 필드를 조회할 때는 , 로 구분해서 나열하면 된다.
                예 ]
                    사원번호, 사원이름, 급여
                    ==>
                    empno, ename, sal
        FROM
            테이블이름                     -------> 여기까지를 from 절
        ;
*/

-- 사원정보 테이블에서 사원들의 이름만 조회하세요.
SELECT
    ename
FROM
    emp
;

-- 사원 정보 테이블에서 사원번호, 사원이름, 봉급을 조회하세요.
SELECT
    empno, ename, sal 
FROM
    emp
;   

/*
    참고
        특정 테이블의 간략한 정보를 조회하는 명령
        
        describe 테이블이름;
        또는
        desc 테이블이름;
        
*/

-- 부서정보테이블(dept)의 구조를 간략하게 조회해보자.
DESCRIBE dept;
DESC dept;