/*
Author:- Arjun
Description:- Procedure to Sign In a User to the Application
*/
CREATE PROCEDURE USP_DU_SignInUser
@id NVARCHAR(100),
@loginEmail NVARCHAR(100),
@passwd NVARCHAR(100),
@firstName NVARCHAR(100),
@middleName NVARCHAR(100),
@lastName NVARCHAR(100),
@organisation NVARCHAR(100),
@dateOfBirth DATE,
@phoneNumber NVARCHAR(10),
@securityQuestionID INT,
@securityAnswer NVARCHAR(100),
@img VARBINARY,
@gender NVARCHAR(1)
AS
BEGIN
SET NOCOUNT ON
	BEGIN

	IF OBJECT_ID('tempdb..#Records') IS NOT NULL
    DROP TABLE #Records

	DECLARE @TenantProfileID INT,
		    @LoginID INT,
			@TenantLoginID INT

	-- TABLE FOR INPUT RECORDS
	CREATE TABLE #Records(
	id NVARCHAR(100),
	loginEmail NVARCHAR(100),
	passwd NVARCHAR(100),
	firstName NVARCHAR(100),
	middleName NVARCHAR(100),
	lastName NVARCHAR(100),
	organisation NVARCHAR(100),
	dateOfBirth DATE,
	phoneNumber NVARCHAR(10),
	securityQuestionID INT,
	securityAnswer NVARCHAR(100),
	img VARBINARY,
	gender NVARCHAR(1))

	--INSERT INPUT RECORDS
	INSERT INTO #Records
	SELECT @id,	@loginEmail, @passwd, @firstName, @middleName, @lastName, @organisation, @dateOfBirth, @phoneNumber, @securityQuestionID, @securityAnswer, @img, @gender

	BEGIN TRANSACTION
	-- INSERT RECORDS INTO TABLE DU_TENANT_PROFILE
	INSERT INTO DU_Tenant_Profile(EmailID,FirstName,MiddleName,LastName,Birthdate,Gender,Image,Organisation,PhoneNumber,Active,CreateDate)
	SELECT REC.id,REC.firstName,REC.middleName,REC.lastName,REC.dateOfBirth,REC.gender,REC.img,REC.organisation,REC.phoneNumber,1,GETDATE()
	FROM #Records REC 
	LEFT JOIN DU_Tenant_Profile TP
		ON REC.id = TP.EmailID
		AND REC.firstName = TP.FirstName
		AND REC.phoneNumber = TP.PhoneNumber
		AND TP.Active = 1
	WHERE TP.TenantProfileID IS NULL

	SELECT @TenantProfileID = TenantProfileID 
	FROM #Records Rec
	INNER JOIN DU_Tenant_Profile TP 
		ON TP.EmailID = REC.id
		AND TP.Active = 1

	--INSERT INTO DU_LOGIN TABLE
	INSERT INTO DU_Login(LoginEmail,LoginPassword,CreateDate,Active)
	SELECT REC.loginEmail,REC.passwd,GETDATE(),1
	FROM #Records REC 
	LEFT JOIN DU_Login LG
		ON REC.loginEmail = LG.LoginEmail
		AND REC.passwd = LG.LoginPassword
	WHERE LG.LoginID IS NULL

	SELECT @LoginID = LG.LoginID
	FROM DU_Login LG 
	INNER JOIN #Records REC
		ON LG.LoginEmail = REC.loginEmail
		AND Active = 1

	-- INSERT INTO DU_TENANT_LOGIN
	INSERT INTO DU_Tenant_Login(LoginID,CreateDate,Active)
	SELECT @LoginID,GETDATE(),1

	SELECT @TenantLoginID = LoginID
	FROM DU_Tenant_Login WHERE LoginID = @LoginID

	-- INSERT INTO DU_TENANT
	INSERT INTO DU_Tenant(TenantLoginID,TenantProfileID,CreateDate,Active)
	SELECT @TenantLoginID,@TenantProfileID,GETDATE(),1

	-- INSERT INTO DU_Tenant_Login_Security_Answers
	INSERT INTO DU_Tenant_Login_Security_Answers(TenantLoginSecurityQuestionID,TenantLoginID,Answer,CreateDate,Active)
	SELECT securityQuestionID,@TenantLoginID,securityAnswer,GETDATE(),1
	FROM #Records

	IF @@ROWCOUNT = 5 AND @@ERROR = 0
	BEGIN
		COMMIT
	END
	ELSE
	BEGIN
		ROLLBACK
	END

	IF OBJECT_ID('tempdb..#Records') IS NOT NULL
    DROP TABLE #Records

	END
END