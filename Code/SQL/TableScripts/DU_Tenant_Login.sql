USE [CES_Practice]
GO

/****** Object:  Table [dbo].[DU_Tenant_Login]    Script Date: 04-09-2018 17:06:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DU_Tenant_Login](
	[TenantLoginID] [int] IDENTITY(100,1) NOT NULL,
	[LoginID] [int] NOT NULL,
	[TenantLoginSecurityAnswerID] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_DU_Tenant_Login] PRIMARY KEY CLUSTERED 
(
	[TenantLoginID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[DU_Tenant_Login]  WITH CHECK ADD  CONSTRAINT [FK_DU_Tenant_Login_DU_Login] FOREIGN KEY([LoginID])
REFERENCES [dbo].[DU_Login] ([LoginID])
GO

ALTER TABLE [dbo].[DU_Tenant_Login] CHECK CONSTRAINT [FK_DU_Tenant_Login_DU_Login]
GO

ALTER TABLE [dbo].[DU_Tenant_Login]  WITH CHECK ADD  CONSTRAINT [FK_DU_Tenant_Login_DU_Tenant_Login_Security_Answers] FOREIGN KEY([TenantLoginSecurityAnswerID])
REFERENCES [dbo].[DU_Tenant_Login_Security_Answers] ([TenantLoginSecurityAnswerID])
GO

ALTER TABLE [dbo].[DU_Tenant_Login] CHECK CONSTRAINT [FK_DU_Tenant_Login_DU_Tenant_Login_Security_Answers]
GO

