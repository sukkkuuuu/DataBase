### 이름에 el들어가는 동물 찾기

🔒 [문제 보기](https://school.programmers.co.kr/learn/courses/30/lessons/59047)

```SQL
SELECT ANIMAL_ID, NAME
FROM ANIMAL_INS
WHERE UPPER(NAME) LIKE "%EL%" AND ANIMAL_TYPE = "Dog"
ORDER BY NAME;

------
