### NULL 처리하기

🔒 [문제 보기](https://school.programmers.co.kr/learn/courses/30/lessons/59410)

```SQL
SELECT ANIMAL_TYPE, COALESCE(NAME, "No name"), SEX_UPON_INTAKE
FROM ANIMAL_INS;


------
