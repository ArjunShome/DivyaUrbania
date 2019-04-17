USE [DivyaUrbania]
GO

/****** Object:  Table [dbo].[DU_Tenant]    Script Date: 04-09-2018 17:06:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DU_Tenant](
	[TenantID] [int] IDENTITY(100,1) NOT NULL,
	[TenantProfileID] [int] NOT NULL,
	[TenantLoginID] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_DU_Tenant] PRIMARY KEY CLUSTERED 
(
	[TenantID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[DU_Tenant]  WITH CHECK ADD  CONSTRAINT [FK_DU_Tenant_DU_Tenant_Login] FOREIGN KEY([TenantLoginID])
REFERENCES [dbo].[DU_Tenant_Login] ([TenantLoginID])
GO

ALTER TABLE [dbo].[DU_Tenant] CHECK CONSTRAINT [FK_DU_Tenant_DU_Tenant_Login]
GO

ALTER TABLE [dbo].[DU_Tenant]  WITH CHECK ADD  CONSTRAINT [FK_DU_Tenant_DU_Tenant_Profile] FOREIGN KEY([TenantProfileID])
REFERENCES [dbo].[DU_Tenant_Profile] ([TenantProfileID])
GO

ALTER TABLE [dbo].[DU_Tenant] CHECK CONSTRAINT [FK_DU_Tenant_DU_Tenant_Profile]
GO


