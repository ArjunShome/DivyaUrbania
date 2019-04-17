USE DivyaUrbania
GO

/****** Object:  Table [dbo].[DU_Tenant_Login_Security_Answers]    Script Date: 05-09-2018 20:05:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DU_Tenant_Login_Security_Answers](
	[TenantLoginSecurityAnswerID] [int] IDENTITY(100,1) NOT NULL,
	[TenantLoginID] [int] NOT NULL,
	[TenantLoginSecurityQuestionID] [int] NOT NULL,
	[Answer] [nvarchar](200) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpodateDate] [datetime] NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_DU_Tenant_Login_Security_Answers] PRIMARY KEY CLUSTERED 
(
	[TenantLoginSecurityAnswerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[DU_Tenant_Login_Security_Answers]  WITH CHECK ADD  CONSTRAINT [FK_DU_Tenant_Login_Security_Answers_DU_Tenant_Login] FOREIGN KEY([TenantLoginID])
REFERENCES [dbo].[DU_Tenant_Login] ([TenantLoginID])
GO

ALTER TABLE [dbo].[DU_Tenant_Login_Security_Answers] CHECK CONSTRAINT [FK_DU_Tenant_Login_Security_Answers_DU_Tenant_Login]
GO

ALTER TABLE [dbo].[DU_Tenant_Login_Security_Answers]  WITH CHECK ADD  CONSTRAINT [FK_DU_TenantSecurityQuestion_DU_TenantSecurityAnswer] FOREIGN KEY([TenantLoginSecurityQuestionID])
REFERENCES [dbo].[DU_Tenant_Login_Security_Questions] ([TenantLoginSecurityQuestionsID])
GO

ALTER TABLE [dbo].[DU_Tenant_Login_Security_Answers] CHECK CONSTRAINT [FK_DU_TenantSecurityQuestion_DU_TenantSecurityAnswer]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key contraint between DU_Tenant_Security_Question and DU_Tenant_Security_Answer tables on columns TenantLoginSecurityQuestionID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DU_Tenant_Login_Security_Answers', @level2type=N'CONSTRAINT',@level2name=N'FK_DU_TenantSecurityQuestion_DU_TenantSecurityAnswer'
GO


