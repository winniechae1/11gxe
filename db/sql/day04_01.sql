/*
    
*/

-- 사원의 이름, 직책, 입사일을 조회하세요.
-- 입사일 기준으로 가장 먼저 입사한 사람부터 조회하세요.
SELECT
    ename 이름, job 직책, hiredate 입사일
FROM
    emp
ORDER BY
    hiredate
;

-- 사원의 이름, 직책, 입사일을 조회하세요.
-- 단, 직책이 알파벳 순서대로 오름차순, 같은 직책이면 이름 순서대로 오름차순 정렬하세요.
SELECT
    ename 이름, job 직책, hiredate 입사일
FROM
    emp
ORDER BY
    job, ename
;

-- 사원들의 사원번호, 사원이름, 직책, 급여를 조회하는데
-- 이름 글자수가 작은 사람부터 조회되게 하고(LENGTH() 사용)
-- 이름 글자수가 같으면 급여가 많은 사람부터 조회되게 하세요...
SELECT
    empno, ename, job, sal
FROM
    emp
ORDER BY
    LENGTH(ename), sal DESC
;

/*
    참고 ]
        조건절(WHERE절)과 같이 사용하는 경우
        조건절이 반드시 먼저 와야 한다.
*/

-- 사원번호, 사원이름, 급여, 부서번호를 조회하는데
-- 부서번호가 작은 사원부터 조회하고 
-- 같은 부서면 사원번호가 작은 사원부터 조회되게 질의명령을 작성하세요.

SELECT
    empno eno, ename name, sal, deptno dno 
FROM
    emp
--[WHERE ]
ORDER BY
    dno, eno -- ORDER BY 절에서는 별칭으로 정렬해도 된다.
;

---------------------------------------------------------------------
/*
    집합 연산자
        정의 ]
            두개 이상의 SELECT 질의 명령을 이용해서
            그 결과의 집합을 얻어내는 방법
            
        형식 ]
            
            SELECT ... FROM... [WHERE ... ORDER BY]
            집합연사자
            SELECT ... FROM... [WHERE ... ORDER BY]

        종류 ]
            UNION       - 합집합
            UNION ALL   - 합집합(동일한 데이터를 중복해서 보여준다.)
            INTERSECT   - 교집합
            MINUS
            
        공통적인 특징 ]
            1. 두질의 명령의 결과는 같은 필드의 갯수를 가져야 한다.
            2. 두 질의 명령의 결과는 같은 형태의 필드여야 한다.(타입이 같아야 한다.)
                크기는 따지지 않는다.쿵
*/

-- 부서번호가 10, 20 번인 사원의 사원이름, 직급, 부서번호를 조회하세요.

SELECT
    ename, job, deptno
FROM
    emp
WHERE
    deptno = 10
union
SELECT
    ename, job, deptno
FROM
    emp
WHERE
    deptno = 20
;


SELECT
    ename, job, deptno
FROM
    emp
WHERE
    deptno = 10
union
SELECT
    ename, TO_CHAR(sal), empno
FROM
    emp
WHERE
    deptno = 20
;


---------------------------------------------------------------------------------------------------------------------

/*
    함수
    ==> 기능의 최소단위
        데이터를 가공하기 위해 오라클이 제시한 명령들...
        
    참고 
        DBMS는 데이터베이스마다 다르다.
        특히 함수 부분은 데이터베이스마다 매우 다르다.
        
        따라서 다른데이터베이스를 사용하려면
        먼저 데이터 타입을 살펴보고
        그리고 함수들이 기존 사용하던 데이터베이스와 다른점을 찾아서
        익혀야 한다.
        
    종류 ]
        
        1. 단일행 함수
            ==> 한줄 한줄마다 매번 명령이 실행되는 함수
                따라서 단일행 함수의 결과는 출력되는 데이터의 갯수와 동일하다.
                
        2. 그룹함수
            ==> 여러줄을 모아서 한번만 실행되는 함수
            
            MAX()   - 최대값
            MIN()   - 최소값
            SUM()   - 합계
            AVG()   - 평균
            COUNT() - 카운트
            ...
            
            ***
            주의 사항 ]
                단일행 함수와 그룹함수는 절대로 같이 사용할 수 없다.
                
    참고 ]
        DUAL 테이블
            - 단일행 함수는 데이터의 갯수만큼 실행하므로
                데이터가 많이 존재하는 테이블에서 테스트를 하려면 매우 불편하다.
                이런 불편함을 줄이기 위해서 임시테이블 하나를 제고하고 있다.(의사 테이블)
                이 테이블은 한행으로만 구성된 테이블이다.
                따라서 함수를 테스트 하면 결과도 한행만 나오게 된다.
                
                
    1. 단일행 함수
        
        
        참고 ]
            
            데이터의 타입 변환
            
                
                숫자     <----------->    문자      <----------------->   날짜
                    ^                                                       ^
                    |                                                       |
                    ------------------------  X -----------------------------
        
        1-1. 숫자함수
            ==> 데이터가 숫자인 경우에만 사용할 수 있는 함수
                
                1) ABS()
                    ==> 절대값을 구하는 함수
                        (음수 ===> 양수 또는 양수 ====> 양수)
                        
                        형식 ]
                            ABS(데이터 혹은 필드이름)
                            
                        예 ]
                            SELECT ABS(-999) FROM dual;
                            
                2) FLOOR()
                    ==> 소수점 이하를 버리는 함수(정수를 만들어주는 함수)
                    
                    형식 ]
                        FLOOR( 데이터 )
                        
                    예 ]
                        사원들의 사원이름, 급여를 조회하는데
                        급여는 15% 인상된 급여로 조회하세요.
                        
                        SELECT
                            ename 이름, sal * 1.15 급여, FLOOR(sal * 1.15) 버림급여
                        FROM
                            emp
                        ;
                
                3) ROUND()
                    ==> 지정한 자리수에서 반올림하는 함수
                    
                    형식 ]
                        ROUND(데이터[ , 자리수 ])
                        
                    예 ]
                        사원들의 사원이름, 급여를 조회하는데
                        급여는 15% 인상된 급여로 조회하세요.
                        
                        SELECT
                            ename 이름, sal * 1.15 급여, FLOOR(sal * 1.15) 버림급여,  ROUND(sal * 1.15, 1) 반올림급여
                        FROM
                            emp
                        ;
                        
                        참고 ]
                            자리수는 양수로 하용하면 소수 이하 자리수에서 반올림한다.
                            음수를 사용하면 소수 이상 자리수에서 반올림한다.
                            
                        
                        사원들의 사원이름, 급여를 조회하는데
                        급여는 15% 인상된 급여로 조회하세요.
                        십의 자리에서 반올림해서 조회하세요
                        
                        SELECT
                            ename 이름, sal * 1.15 급여, FLOOR(sal * 1.15) 버림급여,  ROUND(sal * 1.15, -2) 반올림급여
                        FROM
                            emp
                        ;
                        
                4) TRUNC()
                    ==> FLOOR()와 마찬가지로 버림 함수인데
                        차이점은 자리수를 지정할 수 있다.
                        
                    형식 ]
                        TRUNC(데이터[, 자리수])
                        
                    예 ]
                        사원의 급여를 15% 인상한 금액을 조회하세요.
                        단, 100$ 미만은 버리세요.
                        
                        SELECT
                            ename, TRUNC(sal * 1.15, -2) 버림급여
                        FROM
                            emp
                        ;
                
                5) MOD()
                    ==> 나머지를 반환해주는 함수
                    
                    형식 ]
                        MOD(데이터1, 데이터2)
                        ==> 데이터1을 데이터2로 나눈 나머지를 반환해준다.
                        
                참고 ]
                    모든 함수는 조회(SELECT절)에서도 사용할 수 있고
                    조건식에서도 사용할 수 있다.
                    
                    예 ]
                        급여가 짝수인 사원의 사원이름, 급여를 조회하세요.
                        
                        SELECT
                            ename, sal
                        FROM
                            emp
                        WHERE
                            MOD(sal, 2) = 0 
                        ;
                                    
        1-2. 문자함수
        
        1-3. 날짜함수
        
        
*/


SELECT
    LENGTH('ABCD') "ABCD 길이"
FROM
    emp
; -- EMP 테이블에서 'ABCD'의 길이를 구해주세요. 사원중에서....

SELECT
    'abcd'
FROM
    emp
WHERE
    ename = 'KING'
;


SELECT
    ename
FROM
    emp
;

SELECT
    '데이터베이스 무지 재미있다.' title
FROM
    dual
;

SELECT
    to_char(sysdate, 'yyyy/MM/dd HH24:MI:ss') 현재시간
FROM
    dual
;







