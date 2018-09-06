/*
Author:- Arjun
Description:- Procedure to Sign In a User to the Application
*/
ALTER PROCEDURE USP_DU_SignInUser
@id NVARCHAR(100),
@loginEmail NVARCHAR(100),
@passwd NVARCHAR(100),
@firstName NVARCHAR(100),
@middleName NVARCHAR(100),
@lastName NVARCHAR(100) ,
@organisation NVARCHAR(100),
@dateOfBirth DATE,
@phoneNumber NVARCHAR(10),
@securityQuestionID INT,
@securityAnswer NVARCHAR(100),
@img VARBINARY,
@gender NVARCHAR(1),
@message NVARCHAR(200) OUTPUT
AS
BEGIN
SET NOCOUNT ON
BEGIN TRY
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
	IF @@TRANCOUNT = 1 AND @@ERROR = 0
	BEGIN
		SET @message = 'Success'
		COMMIT
	END
	ELSE 
	BEGIN
		ROLLBACK
		SET @message = 'Error'
	END

	SELECT @TenantProfileID = TenantProfileID 
	FROM #Records Rec
	INNER JOIN DU_Tenant_Profile TP 
		ON TP.EmailID = REC.id
		AND TP.Active = 1

	BEGIN TRANSACTION
	--INSERT INTO DU_LOGIN TABLE
	INSERT INTO DU_Login(LoginEmail,LoginPassword,LastLoginTime,CreateDate,Active)
	SELECT REC.loginEmail,REC.passwd,'',GETDATE(),1
	FROM #Records REC 
	LEFT JOIN DU_Login LG
		ON REC.loginEmail = LG.LoginEmail
		AND REC.passwd = LG.LoginPassword
	WHERE LG.LoginID IS NULL
	IF @@TRANCOUNT = 1 AND @@ERROR = 0
	BEGIN
		SET @message = 'Success'
		COMMIT
	END
	ELSE 
	BEGIN
		ROLLBACK
		SET @message = 'Error'
	END

	SELECT @LoginID = LG.LoginID
	FROM DU_Login LG 
	INNER JOIN #Records REC
		ON LG.LoginEmail = REC.loginEmail
		AND Active = 1

	BEGIN TRANSACTION
	-- INSERT INTO DU_TENANT_LOGIN
	INSERT INTO DU_Tenant_Login(LoginID,CreateDate,Active)
	SELECT @LoginID,GETDATE(),1
	IF @@TRANCOUNT = 1 AND @@ERROR = 0
	BEGIN
		SET @message = 'Success'
		COMMIT
	END
	ELSE 
	BEGIN
		ROLLBACK
		SET @message = 'Error'
	END

	SELECT @TenantLoginID = LoginID
	FROM DU_Tenant_Login WHERE LoginID = @LoginID

	BEGIN TRANSACTION
	-- INSERT INTO DU_TENANT
	INSERT INTO DU_Tenant(TenantLoginID,TenantProfileID,CreateDate,Active)
	SELECT @TenantLoginID,@TenantProfileID,GETDATE(),1
	IF @@TRANCOUNT = 1 AND @@ERROR = 0
	BEGIN
		SET @message = 'Success'
		COMMIT
	END
	ELSE 
	BEGIN
		ROLLBACK
		SET @message = 'Error'
	END

	BEGIN TRANSACTION
	-- INSERT INTO DU_Tenant_Login_Security_Answers
	INSERT INTO DU_Tenant_Login_Security_Answers(TenantLoginSecurityQuestionID,TenantLoginID,Answer,CreateDate,Active)
	SELECT securityQuestionID,@TenantLoginID,securityAnswer,GETDATE(),1
	FROM #Records
	IF @@TRANCOUNT = 1 AND @@ERROR = 0
	BEGIN
		SET @message = 'Success'
		COMMIT
	END
	ELSE 
	BEGIN
		ROLLBACK
		SET @message = 'Error'
	END

	IF @message = 'Success'
	BEGIN
		SET @message = 'THANKS '+@firstName+' FOR SIGNING UP.. :)'
	END
	ELSE
	BEGIN
		SET @message = 'THERE WAS SOME PROBLEM SIGNING YOU IN '+@firstName+' PLEASE CONTACT THE SUPPORT FOR HELP'
	END

	IF OBJECT_ID('tempdb..#Records') IS NOT NULL
    DROP TABLE #Records
END TRY 
BEGIN CATCH
	ROLLBACK
	SET @message = 'THERE WAS SOME PROBLEM SIGNING YOU IN, '+@firstName+'. PLEASE CONTACT THE SUPPORT FOR HELP'
END CATCH
END

DECLARE @msg NVARCHAR(100)
EXECUTE USP_DU_SignInUser 'laltushome111@gmail.com','laltushome111@gmail.com','12345678','Laltu','','Shome','CES ltd','1992-11-16','9831153673',100,'Barrackpore',0x,'M',@msg OUTPUT
SELECT @msg