### DATATIME에서 DATE로 형 변환

🔒 [문제 보기](https://school.programmers.co.kr/learn/courses/30/lessons/59040)

```SQL
SELECT ANIMAL_ID, NAME, DATE_FORMAT(DATETIME, '%Y-%m-%d')
FROM ANIMAL_INS
ORDER BY ANIMAL_ID;

------
