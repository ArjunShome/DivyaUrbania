USE [CES_Practice]
GO

/****** Object:  Table [dbo].[DU_Tenant_Login_Security_Questions]    Script Date: 04-09-2018 17:06:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DU_Tenant_Login_Security_Questions](
	[TenantLoginSecurityQuestionsID] [int] IDENTITY(100,1) NOT NULL,
	[SecurityQuestions] [nvarchar](200) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_DU_Tenant_Login_Security_Questions] PRIMARY KEY CLUSTERED 
(
	[TenantLoginSecurityQuestionsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


