USE [DivyaUrbania]
GO
/****** Object:  StoredProcedure [dbo].[USP_DU_SignInUser]    Script Date: 06-09-2018 16:15:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_DU_SignInUser]
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

	DECLARE @TenantProfileID TABLE (TenantProfileID INT);
	DECLARE @LoginID TABLE (LoginID INT);
	DECLARE @TenantLoginID TABLE (TenantLoginID INT)

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
	OUTPUT inserted.TenantProfileID INTO @TenantProfileID
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

	BEGIN TRANSACTION
	--INSERT INTO DU_LOGIN TABLE
	INSERT INTO DU_Login(LoginEmail,LoginPassword,LastLoginTime,CreateDate,Active)
	OUTPUT inserted.LoginID INTO @LoginID
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

	BEGIN TRANSACTION
	-- INSERT INTO DU_TENANT_LOGIN
	INSERT INTO DU_Tenant_Login(LoginID,CreateDate,Active)
	OUTPUT inserted.TenantLoginID INTO @TenantLoginID
	SELECT LoginID,GETDATE(),1
	FROM @LoginID
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
	-- INSERT INTO DU_TENANT
	INSERT INTO DU_Tenant(TenantLoginID,TenantProfileID,CreateDate,Active)
	SELECT (SELECT TenantLoginID FROM @TenantLoginID),(SELECT TenantProfileID FROM @TenantProfileID),GETDATE(),1
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
	SELECT securityQuestionID,(SELECT TenantLoginID FROM @TenantLoginID),securityAnswer,GETDATE(),1
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
