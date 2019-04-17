USE DivyaUrbania

INSERT INTO dbo.DU_Tenant_Profile(EmailID,FirstName,LastName,Birthdate,CreateDate,Active,Gender,Organisation,PhoneNumber)
VALUES
(
'killer.arjun143@gmail.com',
'Arjun',
'Shome',
'1992-11-16',
GETDATE(),
1,
'M',
'CES ltd',
'9007172411'
)

INSERT INTO dbo.DU_Login(LoginEmail,LoginPassword,LastLoginTime,CreateDate,Active)
VALUES
(
'arjunshome111@gmail.com',
'Arjunrama@829080',
GETDATE(),
GETDATE(),
1
)

INSERT INTO dbo.DU_Tenant_Login_Security_Questions(SecurityQuestions,CreateDate,Active)
VALUES
(
'Where is your birth place',
GETDATE(),
1
)


INSERT INTO dbo.DU_Tenant_Login_Security_Answers(TenantLoginSecurityQuestionID,TenantLoginID,Answer,CreateDate,Active)
VALUES
(
100,
100,
'Kolkata',
GETDATE(),
1
)


INSERT INTO DU_Tenant_Login(LoginID,CreateDate,Active)
VALUES
(
100,
GETDATE(),
1
)

INSERT INTO dbo.DU_Tenant(TenantProfileID,TenantLoginID,CreateDate,Active)
VALUES
(
100,
100,
GETDATE(),
1
)



SELECT * FROM DU_Tenant_Profile
SELECT * FROM dbo.DU_Login
SELECT * FROM dbo.DU_Tenant
SELECT * FROM DU_Tenant_Login
SELECT * FROM dbo.DU_Tenant_Login_Security_Questions
SELECT * FROM dbo.DU_Tenant_Login_Security_Answers

