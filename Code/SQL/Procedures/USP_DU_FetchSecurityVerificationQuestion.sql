/*
Author:- Arjun Shome
Description :- Fetch Security Question Stored procedure Script for Divya Urbania
*/
CREATE PROCEDURE USP_DU_FetchSecurityVerificationQuestionAnswer
@id NVARCHAR(50), @question NVARCHAR(100) OUT, @deactivated NVARCHAR(10) OUT, @Error NVARCHAR(200) OUT
AS
BEGIN	
	IF EXISTS(SELECT * FROM dbo.DU_Login WHERE LoginEmail = @id AND Active = 1)
	BEGIN
		SELECT @question = que.SecurityQuestions+','+LSG.Answer 
		FROM dbo.DU_Login LG WITH (NOLOCK)
		INNER JOIN dbo.DU_Tenant_Login TLG WITH (NOLOCK)
			ON LG.LoginID = TLG.LoginID
			AND LG.Active = 1
			AND TLG.Active = 1
		INNER JOIN dbo.DU_Tenant_Login_Security_Answers LSG WITH (NOLOCK)
			ON LSG.TenantLoginID = TLG.TenantLoginID
			AND LSG.Active = 1 
		INNER JOIN dbo.DU_Tenant_Login_Security_Questions que WITH (NOLOCK)
			ON que.TenantLoginSecurityQuestionsID = LSG.TenantLoginSecurityQuestionID
			AND que.Active = 1
		INNER JOIN dbo.DU_Tenant TN WITH (NOLOCK)
			ON TN.TenantLoginID = TLG.TenantLoginID
			AND TN.Active = 1
		INNER JOIN dbo.DU_Tenant_Profile Pro WITH (NOLOCK)
			ON Pro.TenantProfileID = TN.TenantProfileID
			AND Pro.Active = 1
		WHERE LG.LoginEmail = @id
	END
	ELSE
	BEGIN
		SET @Error = 'EMAIL ID DOES NOT EXIST, Please Enter Your Registered EMAILID'
	END
	IF @question IS NULL AND @Error IS NULL
	BEGIN
		SET @deactivated = 'YES'
	END
	IF @question IS NOT NULL AND @Error IS NULL
		SET @deactivated = 'NO'
END