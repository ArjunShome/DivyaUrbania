/*
Author:- Arjun Shome
Description :- Stored procedure Script to reset the Login Password for Divya Urbania.
*/
ALTER PROCEDURE USP_DU_ResetPassword
@id NVARCHAR(100), @passwd NVARCHAR(100), @message NVARCHAR(100) OUTPUT
AS
BEGIN
SET NOCOUNT ON
	BEGIN TRANSACTION
		UPDATE LG 
		SET 
		LG.OldLoginPassword = LoginPassword,
		LG.LoginPassword = @passwd,
		LG.UpdateDate = GETDATE()
		FROM dbo.DU_Login LG
		WHERE LoginEmail = @id
			AND LG.LoginPassword <> @passwd
			AND ISNULL(LG.OldLoginPassword,'') <> @passwd
			AND LG.Active = 1
	
	IF @@ROWCOUNT = 1 AND @@ERROR = 0
	BEGIN
		COMMIT
		SET @message = 'Password has been successfully reset'
	END
	ELSE
	BEGIN
		ROLLBACK
		SET @message = 'Password Entered to reset cannot be same as the current or the last password'
	END	
END

DECLARE  @msg NVARCHAR(200)
EXECUTE USP_DU_ResetPassword 'arjunshome111@gmail.com','Arjunrama@829080',@msg output
SELECT ISNULL(@msg,'')