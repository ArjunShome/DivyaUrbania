/*
Author:- Arjun Shome
Description :- Login Stored procedure Script for Divya Urbania
*/
GO
ALTER PROCEDURE USP_DU_Tenant_Login
@id nvarchar(50), @PASSWD nvarchar(50), 
@message NVARCHAR(100) OUT
AS
BEGIN
	IF EXISTS(SELECT * FROM dbo.DU_Login WHERE LoginEmail = @id AND LoginPassword = @PASSWD AND Active = 1)
	BEGIN
		BEGIN TRANSACTION

		UPDATE LG  SET LG.LastLoginTime = GETDATE()
		FROM dbo.DU_Login LG 
		WHERE LG.LoginEmail = @id
			AND LG.LoginPassword = @PASSWD

		IF @@ROWCOUNT = 1 AND @@ERROR = 0
		BEGIN 
			COMMIT
			SELECT @message = 'Successfully Logged IN'
		END
		ELSE
		ROLLBACK
	END
	ELSE
	BEGIN
		IF EXISTS(SELECT * FROM dbo.DU_Login WHERE LoginEmail = @id AND LoginPassword <> @PASSWD AND Active = 1)
		BEGIN
			SET @message = 'Invalid Password'		
		END
		ELSE
		BEGIN
			SET @message = 'Invalid UserID or EmailID, Please Enter your registered EmailID'
		END
	END
END
GO

DECLARE @message NVARCHAR(100)
EXECUTE USP_DU_Tenant_Login 'arjunshome111@gmail.com','Arjunrama@829080',@message output
PRINT @message