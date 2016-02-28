SELECT * FROM org_list;
SELECT * FROM org_detail;
SELECT * FROM internship_list;
SELECT * FROM internship_detail;
SELECT * FROM student_list;
SELECT * FROM student_detail;
SELECT * FROM user_list;
SELECT * FROM user_detail;
SELECT * FROM change_list;
SELECT * FROM change_detail;

CALL student_detail_single(321237227);
CALL internship_detail_single(3);
CALL org_detail_single(7);
CALL internship_list_by_org(23);
CALL user_detail_single(48);
CALL change_detail_single(1064);
