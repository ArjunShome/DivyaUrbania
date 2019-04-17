USE [DivyaUrbania]
GO

/****** Object:  Table [dbo].[DU_Tenant_Profile]    Script Date: 04-09-2018 17:06:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DU_Tenant_Profile](
	[TenantProfileID] [int] IDENTITY(100,1) NOT NULL,
	[FirstName] [nvarchar](100) NOT NULL,
	[MiddleName] [nvarchar](100) NULL,
	[LastName] [nvarchar](100) NOT NULL,
	[EmailID] [nvarchar](50) NOT NULL,
	[Image] [varbinary](max) NULL,
	[Gender] [nvarchar](1) NOT NULL,
	[PhoneNumber] [nvarchar](10) NOT NULL,
	[Organisation] [nvarchar](50) NOT NULL,
	[Birthdate] [date] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_DU_Tenant_Profile] PRIMARY KEY CLUSTERED 
(
	[TenantProfileID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


