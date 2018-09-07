/*
Author:- Arjun
Description:- Fetch All The Security Questions and QuestionID
*/
CREATE PROCEDURE USP_DU_Fetch_Questions
AS
BEGIN
SELECT SecurityQuestions,TenantLoginSecurityQuestionsID
FROM DU_Tenant_Login_Security_Questions
WHERE Active = 1
END

EXEC USP_DU_Fetch_Questions