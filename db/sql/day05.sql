-- day05

/*
    문자 함수
    ==> 문자데이터를 처리하기 위한 기능들을 가지고 있는 함수들...
    
    종류 ]
        
        1. LOWER
        ==> 알파벳을 모두 소문자로 변환시켜 보여주는 함수
            
            예 ]
                SELECT LOWER('CLASS02-java 반') FROM dual;
        
        2. UPPER
        ==> 알파벳 문자를 모두 대문자로 변환시켜서 보여주는 함수
            
            예 ]
                SELECT UPPER(LOWER('CLASS02-java 반')) FROM dual;
                
        3. INITCAP
        ==> 알파벳 단어의 첫글자만 대문자로 변환시켜서 보여주는 함수
            예 ]
                
                SELECT INITCAP('CLASS02-java 반 class db 수업 다음은 자바class') FROM dual;
                ==> 결과 : Class02-Java 반 Class Db 수업 다음은 자바Class
                
        4. LENGTH / LENGTHB
            ==> 문자데이터의 길이를 반환해주는 함수
            
            예 ]
                SELECT LENGTH('class02 db 수업') FROM dual; ==> 13
                
                SELECT LENGTHB('class02 db 수업') FROM dual; ==> 17
                
                SELECT LENGTHB('class02 db ') FROM dual; ==> 11
                
                SELECT LENGTHB('수업') FROM dual; ==> 6
                
                SELECT LENGTHB('수') FROM dual; ==> 3
                
        참고 ]
            문자열 함수 중에는 이름이 B로 끝나는 함수가 있는데
            이 함수들은 처리를 byte(바이트) 단위로 하는 함수를 의미한다.
            따라서 B로 끝나지 않는 함수는 처리를 문자 단위로 한다.
        
        5. CONCAT
            ==> 두개의 문자데이터를 하나로 합치는 함수
                이와 같은 기능의 연산자는 || 이다.
                
            형식 ]
                CONCAT(데이터1, 데이터2)
                
            예 ]
                사원들의 (사원번호) 번 [사원이름] 사원 이라는 문제데이터를 조회하세요.
                1001 번 홍길동 사원
                
                SELECT
                    CONCAT(empno || ' 번 ', ename || ' 사원') 사원정보
                FROM
                    emp
                ;
                
                SELECT
                    CONCAT(CONCAT(empno, ' 번 '), CONCAT(ename, ' 사원')) 사원정보
                FROM
                    emp
                ;
                
        6. SUBSTR / SUBSTRB
            ==> 문자데이터 중에서 특정 위치의 문자데이터만 추출해서 반환해주는 함수
            
            형식 ]
                SUBSTR(데이터, 시작위치, 개수)
                
            *****
            참고 ]
                다른 프로그램 언어에서는 위치값의 시작이 0부터 시작하지만
                데이터베이스에서는 시작 위치값이 1부터 시작한다.
                
                        'HELLO WORLD'
                JAVA     01234567891011
                ORACLE   123456789101112
                
            예 ]
                SELECT SUBSTR('HELLO WORLD', 7, 5) FROM dual;
                
            참고 ]
                SUBSTR 함수의 인수는 3개를 입력해주는 것이 원칙이지만
                마지막의 꺼내올 갯수는 생략해줘도 되는데
                이 경우는 해당 문자데이터의 맨 끝 문자까지 모두 추출하게 된다.
                
                SELECT SUBSTR('HELLO WORLD', 7) FROM dual;
                
            문제 ]
                사원 이름중에서 3번째 글자가 'A'인 사원의 
                사원이름, 직급, 급여를 조회하세요.
                단, 이름 순으로 정렬해서 조회하세요.
                
                SELECT
                    ename 이름, job 직급, sal 급여
                FROM
                    emp
                WHERE
                    SUBSTR(ename, 3, 1) = 'A'
                ORDER BY
                    ename
                ;
                
                SELECT
                    ename 이름, job 직급, sal 급여
                FROM
                    emp
                WHERE
                    ename LIKE '__A%'
                ORDER BY
                    ename
                ;
                
                
            참고 ]
                시작위치 값은 음수를 사용할 수 있다.
                이경우 시작위치는 뒤에서부터 계산해서 사용하게 된다.
                
                SELECT SUBSTR('HELLO WORLD', -5) FROM dual;
        
        
        7. INSTR / INSTRB
            ==> 문자열 데이터 중에서 찾을 문자열의 위치를 반환해주는 함수
            
            예 ]
                'HELLO WORD' 라는 문자데이터에서 'WORLD'는 시작 위치값이 6 이다.
                이 숫자를 반환해주는 함수
                
            형식 ]
                
                INSTR(데이터, 찾을 문자열[, 찾을시작위치, 건너뛸 횟수])
                
                
            예 ]
                SELECT INSTR('HONG GIL DONG', 'O', 1, 2) FROM dual;
                
            참고 ]
                시작위치는 음수로 사용할 수 있으며
                음수로 지정하면 뒤에서 부터 시작위치를 지정하게 된다.
                ***
                이경우 찾는 방법이 뒤에서부터 앞으로 진행하면서 찾게 된다.
                
                SELECT SUBSTR('HONG GIL DONG', -4, 2) FROM dual;
                
                SELECT INSTR('HONG GIL DONG', 'O', -4) FROM DUAL;
                
            참고 ]
                만약 찾는 문자가 존재하지 않으면 0 을 반환해준다.
                
            예 ]
                사원중 이름에 'M'이 포함되지 않는 사원들의 사원이름, 직급 을 조회하세요.
                
                SELECT
                    ename, job
                FROM
                    emp
                WHERE
                    -- NOT INSTR(ename, 'M') != 0
                    -- NOT INSTR(ename, 'M') <> 0
                    INSTR(ename, 'M') = 0
                ;
                
        8. LPAD, RPAD
            ==> 문자데이터의 길이를 지정한 후
                남는 공간은 지정한 문자로 채워주는 함수
                
                두 함수의 차이점은 왼쪽의 남는 공간을 채울것인지 - LPAD
                                    오른쪽의 남는 공간을 채울것인지 - RPAD
                                    
                예 ]
                    아이디의 경우 특정 자리수만 보여주고 
                    다른 자리수의 문자는 * 로 표시한다.
                    
                    euns ==> *u**
                    
                형식 ]
                    LPAD(문자데이터, 표현할 전체길이, 채울문자)
                    
                예 ]
                    SELECT
                        LPAD('hong', 10, '#') LEFTPAD,
                        RPAD('hong', 10, '#') RIGHTPAD,
                        RPAD('hong gil dong', 10, '#') LEFTPAD1
                    FROM
                        dual
                    ;
                    
                참고 ]
                    만약 문자데이터가 지정한 길이보다 크면
                    지정한 길이까지만 표현한다.
        
*/

-- 문제 ] 사원의 이름이 4, 5 글자인 사원들의 사원이름, 직급, 급여를 조회하세요.(LENGTH() 사용해서 처리하세요.)
-- 정렬은 이름 길이순으로 출력되게 하고, 길이가 같은 경우는 급여가 낮은 사람부터 조회되게 하세요.
SELECT
    ename 사원이름, job 사원직급, sal 사원급여
FROM
    emp
WHERE
    LENGTH(ename) IN (4, 5)
ORDER BY
    LENGTH(ename), sal
;


/*  
        문제 1] 사원의 이름 5글자 이하인 사원의 정보를 조회하세요.
*/
SELECT
    ename, job, hiredate
FROM
    emp
WHERE
--    LENGTH(ename) <= 5
    LENGTH(ename) IN (1, 2, 3, 4, 5)
;
/*
        문제 2] 사원이름 앞에 'Mr.' 를 붙여서 사원의 이름, 직급을 조회하세요.(문자처리함수로 처리할 것.)
*/
SELECT
    CONCAT('Mr.', ename) 사원이름, job 직급
FROM
    emp
;
/*
        문제 3] 사원 이름의 마지막 글자가 'N'인 사원의 사원이름, 입사일 을 조회하세요.
*/
SELECT
    ename, hiredate
FROM
    emp
WHERE
    SUBSTR(ename, -1) = 'N'
;
/*
        문제 4 ] 사원이름중 'A'가 포함되지 않는 사원의 정보를 조회하세요.
*/
SELECT
    ename, hiredate, sal
FROM
    emp
WHERE
    INSTR(ename, 'A') = 0
;
/* 
        문제 5] 사원이름중 뒤부분 2글자만 남기고
                    앞의 글자는 '*'로 바꿔서 출력하세요.
                
                출력 예 ]
                    SMITH ==> ***TH
*/

SELECT
    SUBSTR(ename, -2) "마지막 두글자",
    LPAD(SUBSTR(ename, -2), LENGTH(ename), '*') 이름
FROM
    emp
;

/*                
        문제 6] 사원이름을 조회하는데
                이름의 세번째 문자는 보여주고 나머지 문자는 '*'로 출력되게 조회하세요.
                SMITH ==> **I**
*/

SELECT
    RPAD(LPAD(SUBSTR(ename, 3, 1), 3, '*'), LENGTH(ename), '*') 이름
FROM
    emp
;


/*                
        weekend bonus ]
                'increpas@increpas.com' 이라는 문자데이터를
                *n******@********.com 으로 출력되게 문자 처리함수를 사용해서 질의명령을 작성하세요.
                
                *** 반드시 문자 처리함수로만 처리하세요...
*/

SELECT
    'increpas@increpas.com',
    SUBSTR('increpas@increpas.com', INSTR('increpas@increpas.com', '@') + 1)
FROM
    dual
;

/*
    9. REPLACE
        ==> 문자데이터의 특정 부분을 다른 문자데이터로 대치하는 함수
        
        형식 ]
            REPLACE(데이터, 찾을문자, 바꿀문자)
            
        예 ]
            SELECT 
                REPLACE('hong gil dong', 'g', '###') 이름
            FROM
                dual
            ;
            
            SELECT 
                REPLACE('hong gil dong', 'on', '###') 이름
            FROM
                dual
            ;
    
    10. TRIM
        ==> 문자데이터 중에서 앞 혹은 뒤에 있는 지정한 문자를 삭제하는 함수
        
        참고 ]
            중간에 있는 문자는 삭제하지 않는다.
            
        형식 ]
            TRIM('삭제할 문자' FROM '데이터')
            
        예 ]
            SELECT
                TRIM('#' FROM '#####HONG#GIL#DONG#####') "잘라낸 이름",
                REPLACE(TRIM('#' FROM '#####HONG#GIL#DONG#####'), '#', ' ') 이름
            FROM
                dual
            ;
            
        10-1. LTRIM
        10-2. RTRIM
            형식 ]
                LTRIM(데이터, 잘라낼문자)
        
            SELECT
                '#####HONG#GIL#DONG#####' 원이름,
                LTRIM('#####HONG#GIL#DONG#####', '#') "왼쪽 잘라낸 이름",
                RTRIM('#####HONG#GIL#DONG#####', '#') "오른쪽 잘라낸 이름"
            FROM
                dual
            ;
            
        참고 ]
            가끔 데이터 앞 뒤에 공백 문자가 들어간 경우가 있다.
            이런경우를 대비해서 앞뒤에 들어간 공백 문자를 제거할 목적으로 많이 사용한다.
            
            SELECT
                TRIM(' ' FROM '     HONG GIL DONG                       ') 이름
            FROM
                dual
            ;
            
            
        11. ASCII
            ==> 문자데이터에 해당하는 ASCII 코드값을 알려주는 함수
            
            예 ]
                
                SELECT ASCII(' a') 공백코드값 FROM dual;
                
            참고 ]
                인수 데이터가 두글자 이상이면 첫글자의 코드값만 반환해준다.
                
        12. CHR
            ==> ASCII 코드를 입력하면 그 코드값에 해당하는 문자를 반환해주는 함수
            
            형식 ]
                CHR(코드값)
                
            예 ]
                
                SELECT CHR(77) FROM dual;
                
        13. TRANSLATE
            ==> REPLACE와 마찬가지로 문자열 중 지정한 부분을 다른 문자열로 바꾸는 함수
                
                차이점
                    
                    REPLACE는 바꿀 문자를 전체를 바꿔준다.
                    TRANSLATE는 문자 단위로 바꾼다.
            형식 ]
                TRANSLATE(데이터, 레퍼런스, 참조데이터)
            예 ]
                
                SELECT
                    TRANSLATE('ACDBEFGCBA', 'ABCD', '1234')
                FROM
                    dual
                ;
                
-----------------------------------------------------------------------------------------------------------------------------
    단일행 함수
        숫자함수, 문자함수, 날짜함수 

    날짜함수
        ==> 날짜데이터를 처리하는 기능을 가진 함수
        
        참고 ]
            SYSDATE
            ==> 오라클에서 사용하는 예약어로 현재 시스템의 날짜/시간을 알려주는 것.
            
            예 ]
                SELECT TO_CHAR(SYSDATE, 'YY/MM/DD HH:MI:SS DAY') FROM dual;
                
                SELECT TO_DATE('2021-01-22 13:00:00', 'YYYY-MM-DD HH24:MI:SS') FROM DUAL;
                
            참고 ]
                형식 문자
                    
                    YY      - 년도(2자리)
                    YYYY    - 년도(4자리)
                    MM      - 월
                    DD      - 일
                    DAY     - 요일
                    HH      - 시(12진법)
                    HH24    - 시(24진법)
                    MI      - 분
                    SS      - 초
        참고 ]
            날짜 데이터는 날짜연번을 만들어서 기억을 한다.
            이때 데이터의 단위는 밀리초 단위로 데이터를 기억한다.
            
            따라서
            날짜데이터 끼리의 빼기 연산은 허락한다.
            
            날짜 - 날짜     - o : 결과값은 일수가 반환된다.(NUMBER)
            이때 연산은 연번끼리 - 연산을 한다.
            
            SELECT (SYSDATE - TO_DATE('2020/12/25', 'YYYY/MM/DD')) FROM dual;

        예 ]
            사원들의 근무일수를 조회하세요.
            단, 소수 이하는 버리고 출력하세요.
            
            SELECT
                ename, FLOOR(SYSDATE - hiredate) 근무일수
            FROM
                emp
            ;
            
            
        참고 ]
            데이터베이스에서 날짜를 기억하는 방법
            1970년 1월 1일 0시 0분 0.000초를 기준으로
            지정한 날짜까지의 날짜 연번을 이용해서 기억한다.
            
            날짜연번은
                일수.시간 의 형태로 숫자로 표현된다.
                
        참고 ]
            날짜데이터의 -(빼기) 연산은 가능하지만
            +(더하기), /(나누기), *(곱하기) 연산은 하지 못한다.
            
        참고 ]
            날짜 +(또는 마이너스) 숫자 는 가능하다.
            ==> 날짜 연번에서 숫자만큼 연산된 날짜를 표시한다.
            
        예 ]
            
            현재시간부터 17일후 날짜는???
            SELECT SYSDATE + 17 FROM dual;
            SELECT SYSDATE - 17 FROM dual;
            
            
    1. ADD_MONTHS
        ==> 지정정한 날짜에서 지정한 달수를 뺀 날짜를 알려준다.
        
        형식 ]
            ADD_MONTHS(날짜, 더할개월수)
            
        참고 ]
            더할 개월수가 음수이면 뺀 날짜를 알려준다.
            
        예 ]
            오늘부터 6개월 후는 몇일인가요???
            
            SELECT ADD_MONTHS(SYSDATE, 6) FROM dual;
            
        2. MONTHS_BETWEEN
            ==> 두 잘짜 사이의 간격 개월수를 알려주는 함수
            
            형식 ]
                MONTHS_BETWEEN(날짜1, 날짜2)    ==> 날짜1에서 날짜2를 뺀 개월수를 반환해준다.
                
                
        3. LAST_DAY
            ==> 지정한 날짜가 있는 월의 마지막 날짜를 알려준다.
            
            형식 ]
                LAST_DAY(날짜)
                
            
        4. NEXT_DAY
            ==> 지정한 날 이후 처음 만나는 지정한 요일이 몇일인지를 알려주는 함수
            
            형식 ]
                NEXT_DAY(날짜, 요일)
                
            예 ]
                다음주 목요일은 몇일인지 조회하세요.
                
                SELECT NEXT_DAY(SYSDATE, '목') "다음주 목요일" FROM dual;
                
            참고 ]
                요일을 지정하는 방법
                
                1. 우리는 한글 세팅이 된 오라클이므로
                    '월', '화', ...
                    '월요일', '화요일', ...
                    
                2. 영어권에서는
                    'MON', 'TUES', ....
                    'MONDAY', ....
        5. ROUND
            ==> 날짜를 지정한 부분에서 반올림하는 함수
                지정한 부분이란 년, 월, 일,....
                
            형식 ]
                ROUND(날짜, '지정부분')
                
                참고 ]
                    지정부분
                        YEAR    - 년도
                        MONTH   - 월
                        DATE    - 일
                        
            예 ]
                SELECT ROUND(SYSDATE, 'DAY') FROM dual;
                
                SELECT ROUND(TO_DATE(SYSDATE, 'YYYY/MM/DD'), 'YEAR') FROM dual; ==> 2021/01/01(2021/01/22일 기준)
                SELECT ROUND(TO_DATE('2021/07/01', 'YYYY/MM/DD'), 'YEAR') FROM dual; ==> 2022/01/01
                
----------------------------------------------------------------------------------------------------------------------------
변환함수
    ==> 함수는 데이터 형태에 따라서 사용하는 함수가 달라진다.
        그런데 만약 사용하려는 함수에 필요한 데이터가 아니라면
        이럴때 사용하는 것이 변환함수
        ==> 데이터의 형태를 바꿔서 특정 함수에 사용 가능하도록 만들어주는 함수
        
        숫자데이터   <---------------->    문자데이터     <---------------->    날짜데이터
        
        
    1. TO_CHAR
        ==> 날짜나 숫자를 문자 데이터로 변환시켜주는 함수
        
        형식 1 ]
            TO_CHAR(날짜 혹은 숫자데이터)
            
        형식 2 ]
            TO_CHAR(날짜 혹은 숫자데이터, '변환형태')
            ==> 바꿀때 원하는 형태의 문자로 변환시키는 방법
            
            참고 ]
                숫자 데이터를 문자데이터로 변환할 때 문자의 형식을 지정해 줄 수 있는데
                
                9는 무효숫자를 무시하고
                0은 무효숫자를 표시한다.
                
                이때 0 또는 9는 데이터의 자릿수보다 많게 기술해야 한다.
                적으면 변환시 에러가 발생한다.
                
-------------------------------------------------------------------------------------------------------------------------------
    2. TO_DATE
        ==> 문자 데이터만 날짜 데이터로 변환시켜주는 함수
        
        형식 1 ]
            TO_DATE('날짜형태 문자열')
            
        형식 2 ]
            TO_DATE('문자데이터', '문자데이터의 날짜형식')
            
    3. TO_NUMBER
        ==> 문자 데이터를 숫자데이터로 변환시키는 함수
            
            문자 데이터는 + 나 - 연산이 안된다.
            
        형식 1 ]
            TO_NUMBER(숫자형태 문자 데이터)
            
        형식 2 ]
            TO_NUMBER(문자데이터, '문자 데이터의 숫자 형태')
        
*/

-- 사원들의 입사일에서 3개월 후는 몇일인지 조회하세요.

SELECT ADD_MONTHS(hiredate, 3) "입사일 3개월 후" FROM emp;

-- 사원들의 근무 개월수를 조회하세요.
SELECT ename 이름, FLOOR(MONTHS_BETWEEN(SYSDATE, hiredate)) "근무 개월 수" FROM emp;

-- 다음달의 마지막 날짜를 조회하세요.
SELECT 
    LAST_DAY(TO_DATE('2021/02/14', 'YYYY/MM/DD')) "다음달 마지막 날"
FROM
    dual
;

-- 문제 ] 사원들의 첫 월급일을 조회하세요. 급여는 매월 말일에 지급합니다.
SELECT 
    ename, LAST_DAY(hiredate) "첫 급여일"
FROM
    emp
;

-- 문제 ] 5월 입사한 사원의 사원이름, 입사일 을 조회하세요.
-- 형식 1번
SELECT
    ename, hiredate
FROM
    emp
WHERE
    TO_CHAR(hiredate) LIKE '_____05%'
;

SELECT
    ename, hiredate
FROM
    emp
WHERE
    TO_CHAR(hiredate, 'MM') = '05'
;

-- 급여가 100 ~ 999 사이인 사원의 사원이름, 급여를 조회하세요.
SELECT
    ename, sal
FROM
    emp
WHERE
    sal BETWEEN 100 AND 999
;

-- 형변환 함수로 처리
SELECT
    ename, sal
FROM
    emp
WHERE
    LENGTH(TO_CHAR(sal)) = 3
;


SELECT
    TO_CHAR(sal, '$9,999,999,999') 급여1,
    TO_CHAR(sal, '$0,000,000,000') 급여2
FROM
    emp
;

SELECT
    TO_CHAR(3.140, '000.000000') 숫자1,
    TO_CHAR(3.140, '999.999999') 숫자2
FROM
    dual
;  

SELECT
    TO_NUMBER('123,456', '999,999') 숫자
    -- 형식의 길이는 데이터의 길이보다 커야한다.
FROM
    dual
;


