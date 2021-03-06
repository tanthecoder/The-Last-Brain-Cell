USE [master]
GO
/****** Object:  Database [LastBraincell]    Script Date: 2018-10-31 9:29:31 PM ******/
CREATE DATABASE [LastBraincell]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'LastBraincell', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\LastBraincell.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'LastBraincell_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\LastBraincell_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [LastBraincell] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [LastBraincell].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [LastBraincell] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [LastBraincell] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [LastBraincell] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [LastBraincell] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [LastBraincell] SET ARITHABORT OFF 
GO
ALTER DATABASE [LastBraincell] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [LastBraincell] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [LastBraincell] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [LastBraincell] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [LastBraincell] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [LastBraincell] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [LastBraincell] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [LastBraincell] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [LastBraincell] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [LastBraincell] SET  ENABLE_BROKER 
GO
ALTER DATABASE [LastBraincell] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [LastBraincell] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [LastBraincell] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [LastBraincell] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [LastBraincell] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [LastBraincell] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [LastBraincell] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [LastBraincell] SET RECOVERY FULL 
GO
ALTER DATABASE [LastBraincell] SET  MULTI_USER 
GO
ALTER DATABASE [LastBraincell] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [LastBraincell] SET DB_CHAINING OFF 
GO
ALTER DATABASE [LastBraincell] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [LastBraincell] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [LastBraincell] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'LastBraincell', N'ON'
GO
ALTER DATABASE [LastBraincell] SET QUERY_STORE = OFF
GO
USE [LastBraincell]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [LastBraincell]
GO
/****** Object:  Table [dbo].[AdminLogin]    Script Date: 2018-10-31 9:29:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdminLogin](
	[ID_Adm] [int] IDENTITY(1,1) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](15) NOT NULL,
 CONSTRAINT [PK_ID_Adm] PRIMARY KEY CLUSTERED 
(
	[ID_Adm] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cart]    Script Date: 2018-10-31 9:29:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cart](
	[ID_Cart] [int] IDENTITY(1,1) NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[OrderDate] [datetime] NULL,
	[OrderStatus] [bit] NOT NULL,
	[ID_Cust] [int] NULL,
 CONSTRAINT [PK_CART] PRIMARY KEY CLUSTERED 
(
	[ID_Cart] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CartItems]    Script Date: 2018-10-31 9:29:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CartItems](
	[ID_CartItem] [int] IDENTITY(1,1) NOT NULL,
	[ID_Cart] [int] NOT NULL,
	[ID_Prod] [char](4) NULL,
	[Qty] [int] NOT NULL,
	[HistoricalPrice] [decimal](18, 2) NOT NULL,
	[StatusID] [char](1) NOT NULL,
	[Remove] [bit] NULL,
 CONSTRAINT [PK_CARTITEMS] PRIMARY KEY CLUSTERED 
(
	[ID_CartItem] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 2018-10-31 9:29:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[ID_Cat] [char](4) NOT NULL,
	[cat_name] [char](15) NOT NULL,
	[description] [char](200) NULL,
 CONSTRAINT [PK_CATEGORY] PRIMARY KEY CLUSTERED 
(
	[ID_Cat] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 2018-10-31 9:29:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[ID_Cust] [int] IDENTITY(1,1) NOT NULL,
	[FName] [varchar](50) NOT NULL,
	[MName] [varchar](20) NULL,
	[LName] [varchar](50) NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](15) NOT NULL,
	[DOB] [datetime] NOT NULL,
	[Phone] [varchar](10) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Archived] [bit] NULL,
	[Street] [nvarchar](50) NOT NULL,
	[City] [varchar](50) NOT NULL,
	[State] [varchar](50) NOT NULL,
	[ZIP] [nvarchar](15) NOT NULL,
	[Country] [varchar](20) NOT NULL,
	[Validate] [char](8) NULL,
 CONSTRAINT [PK_ACCOUNT] PRIMARY KEY CLUSTERED 
(
	[ID_Cust] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderHistory]    Script Date: 2018-10-31 9:29:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderHistory](
	[ID_Order] [int] IDENTITY(1,1) NOT NULL,
	[ID_Cart] [int] NOT NULL,
	[ShippingAddress] [nvarchar](300) NOT NULL,
	[Status] [int] NULL,
	[PaymentType] [nvarchar](20) NOT NULL,
	[OrderDate] [datetime] NULL,
 CONSTRAINT [PK_ORDER] PRIMARY KEY CLUSTERED 
(
	[ID_Order] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderItems]    Script Date: 2018-10-31 9:29:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderItems](
	[OI_Id] [int] IDENTITY(1,1) NOT NULL,
	[ID_Order] [int] NOT NULL,
	[ID_Cart] [int] NOT NULL,
	[ID_Prod] [char](4) NOT NULL,
	[Qty] [int] NOT NULL,
	[HistoricalPrice] [decimal](18, 2) NOT NULL,
	[StatusId] [int] NOT NULL,
 CONSTRAINT [PK_OrderItems] PRIMARY KEY CLUSTERED 
(
	[OI_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderStatus]    Script Date: 2018-10-31 9:29:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderStatus](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [varchar](30) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 2018-10-31 9:29:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[ID_Pr] [char](4) NOT NULL,
	[pro_name] [char](30) NOT NULL,
	[descriptionBrief] [char](200) NOT NULL,
	[descriptionFull] [ntext] NOT NULL,
	[price] [float] NOT NULL,
	[isFeatured] [bit] NULL,
	[ID_Cat] [char](4) NOT NULL,
	[status] [char](1) NOT NULL,
	[pic] [varchar](25) NOT NULL,
	[ID_Img] [int] NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[ID_Pr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SiteImages]    Script Date: 2018-10-31 9:29:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SiteImages](
	[ID_Img] [int] IDENTITY(1,1) NOT NULL,
	[fileName] [nvarchar](50) NOT NULL,
	[altText] [nvarchar](50) NOT NULL,
	[locus] [nvarchar](150) NOT NULL,
	[uploadDateTime] [datetime] NOT NULL,
	[verified] [bit] NOT NULL,
	[active] [bit] NOT NULL,
	[ID_Adm] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_Img] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StatusStatic]    Script Date: 2018-10-31 9:29:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StatusStatic](
	[status] [char](1) NOT NULL,
	[description] [varchar](30) NOT NULL,
 CONSTRAINT [PKstatus] PRIMARY KEY CLUSTERED 
(
	[status] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[AdminLogin] ON 

INSERT [dbo].[AdminLogin] ([ID_Adm], [Email], [Password]) VALUES (1, N'tyson@gmail.com', N'password')
INSERT [dbo].[AdminLogin] ([ID_Adm], [Email], [Password]) VALUES (2, N'tyson.nado@gmail.com', N'password')
INSERT [dbo].[AdminLogin] ([ID_Adm], [Email], [Password]) VALUES (3, N'hanford@gmail.com', N'password')
INSERT [dbo].[AdminLogin] ([ID_Adm], [Email], [Password]) VALUES (4, N'g.flett276@outlook.com', N'password')
SET IDENTITY_INSERT [dbo].[AdminLogin] OFF
INSERT [dbo].[Categories] ([ID_Cat], [cat_name], [description]) VALUES (N'0001', N'Productive     ', N'Hit a creative block? We''ll get you right back on track with our creative ideas!                                                                                                                        ')
INSERT [dbo].[Categories] ([ID_Cat], [cat_name], [description]) VALUES (N'0002', N'Scientific     ', N'These ideas are about physics, mathematics, chemistry and such                                                                                                                                          ')
INSERT [dbo].[Categories] ([ID_Cat], [cat_name], [description]) VALUES (N'0003', N'Comedy         ', N'Do you want to be the next Chrysippus? Your jokes go here                                                                                                                                               ')
INSERT [dbo].[Categories] ([ID_Cat], [cat_name], [description]) VALUES (N'0004', N'Weaponizeable  ', N'This basiacally can be from any category which can be used to erase humanity                                                                                                                            ')
INSERT [dbo].[Categories] ([ID_Cat], [cat_name], [description]) VALUES (N'0005', N'Health         ', N'How to not be a McDonald''s victim                                                                                                                                                                       ')
INSERT [dbo].[Categories] ([ID_Cat], [cat_name], [description]) VALUES (N'0006', N'Test           ', N'Testy test test                                                                                                                                                                                         ')
SET IDENTITY_INSERT [dbo].[Customer] ON 

INSERT [dbo].[Customer] ([ID_Cust], [FName], [MName], [LName], [UserName], [Password], [DOB], [Phone], [Email], [Archived], [Street], [City], [State], [ZIP], [Country], [Validate]) VALUES (2, N'Turd', N'F', N'Ferguson', N'Turd', N'password', CAST(N'1985-01-01T00:00:00.000' AS DateTime), N'4444444444', N'turd@gmail.com', 0, N'Loaf 363', N'Loaf', N'Loafs', N'E1A 3E6', N'United States', NULL)
INSERT [dbo].[Customer] ([ID_Cust], [FName], [MName], [LName], [UserName], [Password], [DOB], [Phone], [Email], [Archived], [Street], [City], [State], [ZIP], [Country], [Validate]) VALUES (7, N'Hamy', N'N', N'Hamster', N'Hammy', N'password', CAST(N'1985-01-01T00:00:00.000' AS DateTime), N'4444444444', N'hammy@gmail.com', 0, N'Loafe 93', N'Donk', N'NY', N'E1A 3E6', N'United States', NULL)
INSERT [dbo].[Customer] ([ID_Cust], [FName], [MName], [LName], [UserName], [Password], [DOB], [Phone], [Email], [Archived], [Street], [City], [State], [ZIP], [Country], [Validate]) VALUES (8, N'Harriot', N'L', N'Lamar', N'Jilly', N'password', CAST(N'1980-01-01T00:00:00.000' AS DateTime), N'1234656789', N'jill@gmail.com', 0, N'Slumville', N'Springfield', N'New York', N'E1A 3E6', N'United States', NULL)
INSERT [dbo].[Customer] ([ID_Cust], [FName], [MName], [LName], [UserName], [Password], [DOB], [Phone], [Email], [Archived], [Street], [City], [State], [ZIP], [Country], [Validate]) VALUES (9, N'hoang', N'', N'Nguyen', N'asd', N'123', CAST(N'1990-10-24T00:00:00.000' AS DateTime), N'5062296555', N'hn102498@gmail.com', 0, N'302 Lonsdale Dr', N'Moncton', N'nb', N'E1G0A8', N'United States', NULL)
SET IDENTITY_INSERT [dbo].[Customer] OFF
SET IDENTITY_INSERT [dbo].[OrderHistory] ON 

INSERT [dbo].[OrderHistory] ([ID_Order], [ID_Cart], [ShippingAddress], [Status], [PaymentType], [OrderDate]) VALUES (4, 32, N'Canada,Loaf,Loaf 363,E1A 3E6,Loafs', 1, N'MasterCard', CAST(N'2018-10-31T21:16:43.633' AS DateTime))
INSERT [dbo].[OrderHistory] ([ID_Order], [ID_Cart], [ShippingAddress], [Status], [PaymentType], [OrderDate]) VALUES (5, 33, N'Canada,Loaf,Loaf 363,E1A 3E6,Loafs', 1, N'Visa', CAST(N'2018-10-31T21:20:25.380' AS DateTime))
SET IDENTITY_INSERT [dbo].[OrderHistory] OFF
SET IDENTITY_INSERT [dbo].[OrderItems] ON 

INSERT [dbo].[OrderItems] ([OI_Id], [ID_Order], [ID_Cart], [ID_Prod], [Qty], [HistoricalPrice], [StatusId]) VALUES (1, 4, 32, N'0001', 5, CAST(21.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[OrderItems] ([OI_Id], [ID_Order], [ID_Cart], [ID_Prod], [Qty], [HistoricalPrice], [StatusId]) VALUES (2, 5, 33, N'0004', 4, CAST(9.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[OrderItems] ([OI_Id], [ID_Order], [ID_Cart], [ID_Prod], [Qty], [HistoricalPrice], [StatusId]) VALUES (3, 5, 33, N'0005', 1, CAST(50.00 AS Decimal(18, 2)), 1)
SET IDENTITY_INSERT [dbo].[OrderItems] OFF
SET IDENTITY_INSERT [dbo].[OrderStatus] ON 

INSERT [dbo].[OrderStatus] ([id], [title]) VALUES (1, N'awaiting fulfillment')
INSERT [dbo].[OrderStatus] ([id], [title]) VALUES (2, N'fulfilled')
INSERT [dbo].[OrderStatus] ([id], [title]) VALUES (3, N'shipped')
INSERT [dbo].[OrderStatus] ([id], [title]) VALUES (4, N'canceled')
INSERT [dbo].[OrderStatus] ([id], [title]) VALUES (5, N'backordered')
SET IDENTITY_INSERT [dbo].[OrderStatus] OFF
INSERT [dbo].[Products] ([ID_Pr], [pro_name], [descriptionBrief], [descriptionFull], [price], [isFeatured], [ID_Cat], [status], [pic], [ID_Img]) VALUES (N'0001', N'Videogame Concept             ', N'The royalty free concept of a new and exciting videogame.                                                                                                                                               ', N'This is the idea for a new and exciting videogame. Whether you are an amateur looking to make their mark or a professional in desperate need of an idea to keep their job we’ve got just the thing for you! Best of all: it’s royalty free like all our ideas so you don’’t have to worry any of us taking the credit for your work!', 20.73, 1, N'0001', N'1', N'videogame.png', NULL)
INSERT [dbo].[Products] ([ID_Pr], [pro_name], [descriptionBrief], [descriptionFull], [price], [isFeatured], [ID_Cat], [status], [pic], [ID_Img]) VALUES (N'0002', N'The Wise Decision             ', N'This help you stop being obese                                                                                                                                                                          ', N'By start cooking your meals, take an hour to calculate your calories intake and calories from daily food,
 and stop going to McDonald''s every meal actually help you lose some weight', 5, 1, N'0001', N'1', N'thewisedecision.jpg', NULL)
INSERT [dbo].[Products] ([ID_Pr], [pro_name], [descriptionBrief], [descriptionFull], [price], [isFeatured], [ID_Cat], [status], [pic], [ID_Img]) VALUES (N'0003', N'The Look Right Here Beam      ', N'This beam changes your mind                                                                                                                                                                             ', N'The beam enters through the eyes, it triggers the retina to send nerve signals to your nervous system which can shortly change your mind, or make you forget what you were doing', 500, 1, N'0004', N'2', N'lookrighthere.jpg', NULL)
INSERT [dbo].[Products] ([ID_Pr], [pro_name], [descriptionBrief], [descriptionFull], [price], [isFeatured], [ID_Cat], [status], [pic], [ID_Img]) VALUES (N'0004', N'Surprise Idea                 ', N'It is a mystery!                                                                                                                                                                                        ', N'A surprise idea just for you!', 9, 1, N'0003', N'1', N'notavailable.png', NULL)
INSERT [dbo].[Products] ([ID_Pr], [pro_name], [descriptionBrief], [descriptionFull], [price], [isFeatured], [ID_Cat], [status], [pic], [ID_Img]) VALUES (N'0005', N'Baking Soda Volcano           ', N'Fun, safe science!                                                                                                                                                                                      ', N'You cannot go wrong with a baking soda volcano!', 50, 0, N'0002', N'1', N'notavailable.png', NULL)
INSERT [dbo].[Products] ([ID_Pr], [pro_name], [descriptionBrief], [descriptionFull], [price], [isFeatured], [ID_Cat], [status], [pic], [ID_Img]) VALUES (N'0006', N'What if I''m a Cow?            ', N'This is called boanthropy                                                                                                                                                                               ', N'This will suggest that the target is a cow. You''ll know it works when you see them on all fours and eating grass.', 50, 0, N'0004', N'1', N'cow.png', NULL)
INSERT [dbo].[Products] ([ID_Pr], [pro_name], [descriptionBrief], [descriptionFull], [price], [isFeatured], [ID_Cat], [status], [pic], [ID_Img]) VALUES (N'0007', N'Test Product                  ', N'Testy                                                                                                                                                                                                   ', N'Test Test', 5, 0, N'0006', N'1', N'notavailable.png', NULL)
SET IDENTITY_INSERT [dbo].[SiteImages] ON 

INSERT [dbo].[SiteImages] ([ID_Img], [fileName], [altText], [locus], [uploadDateTime], [verified], [active], [ID_Adm]) VALUES (33, N'LUGDM6IVNJEORL3', N'asdas', N'~/images/LUGDM6IVNJEORL3.jpg', CAST(N'2018-10-31T18:51:37.823' AS DateTime), 1, 1, 1)
INSERT [dbo].[SiteImages] ([ID_Img], [fileName], [altText], [locus], [uploadDateTime], [verified], [active], [ID_Adm]) VALUES (34, N'sevenfinger', N'a game', N'~/images/sevenfinger.PNG', CAST(N'2018-10-31T21:23:34.203' AS DateTime), 1, 1, 1)
SET IDENTITY_INSERT [dbo].[SiteImages] OFF
INSERT [dbo].[StatusStatic] ([status], [description]) VALUES (N'1', N'available')
INSERT [dbo].[StatusStatic] ([status], [description]) VALUES (N'2', N'out of stock')
INSERT [dbo].[StatusStatic] ([status], [description]) VALUES (N'3', N'back ordered')
INSERT [dbo].[StatusStatic] ([status], [description]) VALUES (N'4', N'temporarily available')
INSERT [dbo].[StatusStatic] ([status], [description]) VALUES (N'5', N'discontinued')
ALTER TABLE [dbo].[CartItems] ADD  DEFAULT ((0)) FOR [Remove]
GO
ALTER TABLE [dbo].[Customer] ADD  DEFAULT ((0)) FOR [Archived]
GO
ALTER TABLE [dbo].[OrderHistory] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[OrderHistory] ADD  DEFAULT (getdate()) FOR [OrderDate]
GO
ALTER TABLE [dbo].[OrderItems] ADD  DEFAULT ((1)) FOR [StatusId]
GO
ALTER TABLE [dbo].[Products] ADD  DEFAULT ((0)) FOR [isFeatured]
GO
ALTER TABLE [dbo].[Products] ADD  DEFAULT ('1') FOR [status]
GO
ALTER TABLE [dbo].[Products] ADD  DEFAULT ('notavailable.png') FOR [pic]
GO
ALTER TABLE [dbo].[Products] ADD  DEFAULT ('notavailable.png') FOR [ID_Img]
GO
ALTER TABLE [dbo].[SiteImages] ADD  DEFAULT ('notavailable.png') FOR [fileName]
GO
ALTER TABLE [dbo].[SiteImages] ADD  DEFAULT (getdate()) FOR [uploadDateTime]
GO
ALTER TABLE [dbo].[SiteImages] ADD  DEFAULT ((0)) FOR [verified]
GO
ALTER TABLE [dbo].[SiteImages] ADD  DEFAULT ((1)) FOR [active]
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD  CONSTRAINT [FK_ID_Cust] FOREIGN KEY([ID_Cust])
REFERENCES [dbo].[Customer] ([ID_Cust])
GO
ALTER TABLE [dbo].[Cart] CHECK CONSTRAINT [FK_ID_Cust]
GO
ALTER TABLE [dbo].[CartItems]  WITH CHECK ADD  CONSTRAINT [FK_ID_Prod] FOREIGN KEY([ID_Prod])
REFERENCES [dbo].[Products] ([ID_Pr])
GO
ALTER TABLE [dbo].[CartItems] CHECK CONSTRAINT [FK_ID_Prod]
GO
ALTER TABLE [dbo].[CartItems]  WITH CHECK ADD  CONSTRAINT [FK_IDCart] FOREIGN KEY([ID_Cart])
REFERENCES [dbo].[Cart] ([ID_Cart])
GO
ALTER TABLE [dbo].[CartItems] CHECK CONSTRAINT [FK_IDCart]
GO
ALTER TABLE [dbo].[OrderItems]  WITH CHECK ADD  CONSTRAINT [FK_ID_ProdOI] FOREIGN KEY([ID_Prod])
REFERENCES [dbo].[Products] ([ID_Pr])
GO
ALTER TABLE [dbo].[OrderItems] CHECK CONSTRAINT [FK_ID_ProdOI]
GO
ALTER TABLE [dbo].[OrderItems]  WITH CHECK ADD  CONSTRAINT [FK_OH] FOREIGN KEY([ID_Order])
REFERENCES [dbo].[OrderHistory] ([ID_Order])
GO
ALTER TABLE [dbo].[OrderItems] CHECK CONSTRAINT [FK_OH]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Category] FOREIGN KEY([ID_Cat])
REFERENCES [dbo].[Categories] ([ID_Cat])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Category]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_ProductImage] FOREIGN KEY([ID_Img])
REFERENCES [dbo].[SiteImages] ([ID_Img])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_ProductImage]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_StatusStatic] FOREIGN KEY([status])
REFERENCES [dbo].[StatusStatic] ([status])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_StatusStatic]
GO
ALTER TABLE [dbo].[SiteImages]  WITH CHECK ADD  CONSTRAINT [FK_Adder] FOREIGN KEY([ID_Adm])
REFERENCES [dbo].[AdminLogin] ([ID_Adm])
GO
ALTER TABLE [dbo].[SiteImages] CHECK CONSTRAINT [FK_Adder]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [Status_Range] CHECK  (([status] like '[1-5]'))
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [Status_Range]
GO
/****** Object:  StoredProcedure [dbo].[Address_By_IDCust]    Script Date: 2018-10-31 9:29:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Address_By_IDCust]
@ID_Cust int
as
begin
select street, city, state, zip,country from customer 
where ID_Cust=@ID_Cust
end
GO
/****** Object:  StoredProcedure [dbo].[Admin_Login]    Script Date: 2018-10-31 9:29:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Gets Login Information for admin
create   PROC [dbo].[Admin_Login]
@Email nvarchar(50),
@Password nvarchar(15)
AS
BEGIN

IF (NOT EXISTS(SELECT * FROM AdminLogin where Email = @Email AND [Password] = @Password))
THROW 50001, 'Password and/or email invalid!',1;

SELECT * FROM AdminLogin where Email = @Email AND [Password] = @Password;

END

GO
/****** Object:  StoredProcedure [dbo].[ArchiveAccount]    Script Date: 2018-10-31 9:29:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create  procedure [dbo].[ArchiveAccount]
@ID_Cust int
AS
BEGIN
UPDATE Customer
set Archived=1
WHERE ID_Cust = @ID_Cust
END
GO
/****** Object:  StoredProcedure [dbo].[AuthenticateCust]    Script Date: 2018-10-31 9:29:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[AuthenticateCust]
@UserName NVarChar(50),
@Password NVarChar(15)
AS
BEGIN
If EXISTS (SELECT ID_Cust, Password FROM Customer WHERE UserName = @UserName AND Password = @Password)
Select  'true'
else
Select 'False'
END
GO
/****** Object:  StoredProcedure [dbo].[Categ_Add]    Script Date: 2018-10-31 9:29:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[Categ_Add]
	@ID_Cat Character(4) OUTPUT,
	@cat_name Character(15) ,
	@description Character(200) NULL
AS
BEGIN

if (Exists(select * from Categories where cat_name = @cat_name))
THROW 50001, 'A category by that name already exists!',1;

DECLARE @newID Character(4);
DECLARE @intID int;

IF ((SELECT COUNT(*)FROM Categories) = 0)
BEGIN
set @newID = '0001';
END
ELSE 
	BEGIN
	
	set @intID = CAST((SELECT TOP 1 ID_Cat + 1 FROM Categories ORDER BY ID_Cat desc) AS INT);

	

	IF (@intID < 10)
	set @newID = '000' + cast(@intID as CHARACTER);
	ELSE IF (@intID < 100)
	set @newID = '00' + cast(@intID as CHARACTER);
	ELSE if (@intID < 1000)
	set @newID = '0' + cast(@intID as CHARACTER);
	


	END

	INSERT INTO Categories (ID_Cat,cat_name,[description])
	VALUES
	(
		@newID,@cat_name,@description
	)
	
	set @newID = SCOPE_IDENTITY();

END

GO
/****** Object:  StoredProcedure [dbo].[Categ_Delete]    Script Date: 2018-10-31 9:29:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[Categ_Delete]
 @ID_Cat Character(4)
AS
BEGIN
Delete from Categories where ID_Cat= @ID_Cat
END

GO
/****** Object:  StoredProcedure [dbo].[Categ_Get_All]    Script Date: 2018-10-31 9:29:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Categ_Get_All]

AS
BEGIN
SELECT * FROM Categories
ORDER BY cat_name asc
END

GO
/****** Object:  StoredProcedure [dbo].[Categ_Get_One]    Script Date: 2018-10-31 9:29:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Categ_Get_One]

@ID_Cat Character(4)

AS
BEGIN
SELECT * FROM Categories
WHERE ID_Cat = @ID_Cat



END
GO
/****** Object:  StoredProcedure [dbo].[Categ_Update]    Script Date: 2018-10-31 9:29:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[Categ_Update]
 @ID_Cat Character(4), @cat_name varchar(30), @description varchar(200)
AS
BEGIN
update Categories
set cat_name=@cat_name , description=@description where ID_Cat= @ID_Cat
END

GO
/****** Object:  StoredProcedure [dbo].[CreateCustomer]    Script Date: 2018-10-31 9:29:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CreateCustomer] 
@ID_Cust int output,
@FName VarChar(20),
@MName VarChar(20) NULL,
@LName VarChar(20),
@UserName NVarChar(20),
@Password NVarChar(50),
@DOB Date,
@Street NVarChar(20),
@City Varchar(20),
@State VarChar(20),
@ZIP NVARCHAR(10),
@Country VARCHAR(20),
@Phone VarChar(10),
@Email NVarChar(50),
@Validate Char(8)
AS
BEGIN

IF (EXISTS(SELECT * from Customer where UserName = @UserName))
THROW 50001, 'User name has already been taken', 1;

INSERT INTO Customer(FName,MName ,LName,UserName ,Password ,DOB, Phone ,Email ,Street,City,State ,ZIP ,Country,Validate)
Values(@FName,@MName,@LName,@UserName,@Password,@DOB,@Phone ,@Email ,@Street,@City ,@State ,@ZIP ,@Country,@Validate)
SET @ID_Cust=SCOPE_IDENTITY()
END
GO
/****** Object:  StoredProcedure [dbo].[Customers_by_Keywords]    Script Date: 2018-10-31 9:29:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[Customers_by_Keywords]
@SearchString varchar(50) = null
AS
BEGIN

	if (@SearchString = '' OR @SearchString is NULL)
	BEGIN
		Select * From Customer
	END
	else
	BEGIN
		Select * From Customer Where
		(ID_Cust LIKE '%' + @SearchString + '%' OR UserName LIKE '%' + @SearchString + '%' OR Phone LIKE '%' + @SearchString + '%' OR Email LIKE '%' + @SearchString + '%')
	END
END
GO
/****** Object:  StoredProcedure [dbo].[Customers_Get_All]    Script Date: 2018-10-31 9:29:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create  proc [dbo].[Customers_Get_All]
AS 
begin
SELECT * FROM Customer
end
GO
/****** Object:  StoredProcedure [dbo].[Delete_Image]    Script Date: 2018-10-31 9:29:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   PROC [dbo].[Delete_Image]
@ID_Img int
AS
BEGIN
IF Exists(Select * from products where id_img = @ID_Img)
throw 50001,'This image is being used in a product, cannot be deleted',1
DELETE FROM SiteImages 
WHERE ID_Img = @ID_Img

END
GO
/****** Object:  StoredProcedure [dbo].[Get_Customer]    Script Date: 2018-10-31 9:29:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Get_Customer]
@ID_Cust int
AS
BEGIN
 if (NOT EXISTS (SELECT * from Customer WHERE ID_Cust = @ID_Cust))
THROW 50001, 'Customer not found!', 1


SELECT * from Customer WHERE ID_Cust = @ID_Cust
END
GO
/****** Object:  StoredProcedure [dbo].[Get_OrderHistory_Details]    Script Date: 2018-10-31 9:29:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Get_OrderHistory_Details]
@ID_Cart int
AS
BEGIN
SELECT * From OrderHistory WHERE ID_Cart = @ID_Cart
END
GO
/****** Object:  StoredProcedure [dbo].[Get_User_For_Session]    Script Date: 2018-10-31 9:29:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Get_User_For_Session]
@UserName NVarChar(20),
@Password NVarChar(15)
AS
BEGIN

--If this does not return a 
if (NOT EXISTS (SELECT * FROM Customer where UserName = @UserName AND [Password] = @Password AND Archived = 0))
THROW 50001, 'Invalid username and/or password.' ,1

DECLARE @Id int = (SELECT ID_Cust FROM Customer where UserName = @UserName AND [Password] = @Password);

Declare @ID_Cart int = null;

if (Exists (SELECT * FROM Cart WHERE ID_Cust = @Id AND ID_Cart NOT IN (SELECT ID_Cart FROM OrderHistory)))
BEGIN
Set @ID_Cart = (SELECT TOP 1 ID_Cart FROM Cart WHERE ID_Cust = @Id AND ID_Cart NOT IN (SELECT ID_Cart FROM OrderHistory));
END

Declare @Validated bit = 0

if ((SELECT Validate From Customer where @Id = ID_Cust) is null)
Set @Validated = 1;


SELECT @UserName AS UserName,@Id AS ID_Cust,(SELECT Email From Customer WHERE ID_Cust = @Id) as Email,@ID_Cart AS ID_Cart, @Validated as Validated

--SELECT UserName, Customer.ID_Cust,Cart.ID_Cart 
--From Customer LEFT JOIN Cart ON Customer.ID_Cust = Cart.ID_Cust 
--where UserName = @UserName AND [Password] = @Password;

END
GO
/****** Object:  StoredProcedure [dbo].[Load_Image]    Script Date: 2018-10-31 9:29:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

---For a single image
create   PROC [dbo].[Load_Image]
@ID_Img int 
AS
BEGIN
SELECT * FROM siteImages where ID_Img = @ID_Img

END

GO
/****** Object:  StoredProcedure [dbo].[Load_Unverified]    Script Date: 2018-10-31 9:29:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[Load_Unverified]
@ID_Adm int
AS
BEGIN
SELECT * FROM SiteImages Where ID_Adm <> @ID_Adm and verified = 0
END
GO
/****** Object:  StoredProcedure [dbo].[Load_Verified]    Script Date: 2018-10-31 9:29:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create   PROC [dbo].[Load_Verified]
AS
BEGIN
select * from siteimages 
where verified = 1

END

GO
/****** Object:  StoredProcedure [dbo].[LookupUsers]    Script Date: 2018-10-31 9:29:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[LookupUsers]
@SearchString varchar(50)
AS
BEGIN
Select * From Customer Where
ID_Cust LIKE '%' + @SearchString + '%' OR Email LIKE '%' + @SearchString + '%' OR UserName LIKE '%' + @SearchString + '%' Or Phone LIKE '%' + @SearchString + '%'
END
GO
/****** Object:  StoredProcedure [dbo].[Own_Cart]    Script Date: 2018-10-31 9:29:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Own_Cart]
--This is used on login to give ownership of a cart to the user
@ID_Cart int,
@ID_Cust int
AS
BEGIN

	UPDATE Cart
	SET ID_Cust = @ID_Cust
	WHERE ID_Cart = @ID_Cart
	
END
GO
/****** Object:  StoredProcedure [dbo].[PlaceOrder]    Script Date: 2018-10-31 9:29:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PlaceOrder]
@ID_Cart int,
@ShippingAddress nvarchar(300),
@PaymentType nvarchar(20)
AS
BEGIN
INSERT INTO OrderHistory(ID_Cart,ShippingAddress,PaymentType)
Values
(@ID_Cart,@ShippingAddress,@PaymentType)

END
GO
/****** Object:  StoredProcedure [dbo].[PlaceOrderOutput]    Script Date: 2018-10-31 9:29:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PlaceOrderOutput]

@ID_Order int OUTPUT,
@ID_Cart int,
@ShippingAddress nvarchar(300),
@PaymentType nvarchar(20)
AS
BEGIN
INSERT INTO OrderHistory(ID_Cart,ShippingAddress,PaymentType)
Values
(@ID_Cart,@ShippingAddress,@PaymentType)

UPDATE Cart Set OrderDate = GETDATE() WHERE ID_Cart = @ID_Cart --- Set the Order Date

SET @ID_Order = SCOPE_IDENTITY();

--Time to move order items into order items

--if object_ID('dbo.siteimages','u') is not null
--drop table #tempTransfer;

Select (ID_Cart + 0) AS ID_Cart,ID_Prod,Qty,HistoricalPrice,StatusID
INTO #tempTransfer
FROM CartItems
WHERE ID_Cart = @ID_Cart

--Give them a number
ALTER table #tempTransfer
ADD rowCounter int IDENTITY(0,1);

DECLARE @counter int = 0;

WHILE (@counter < (SELECT COUNT(*) FROM #tempTransfer))
BEGIN
	INSERT INTO OrderItems (ID_Order,ID_Cart,ID_Prod,Qty,HistoricalPrice,StatusId)
	VALUES
	(
		@ID_Order,
		(SELECT ID_Cart FROM #tempTransfer WHERE rowCounter = @counter),
		(SELECT ID_Prod FROM #tempTransfer WHERE rowCounter = @counter),
		(SELECT Qty FROM #tempTransfer WHERE rowCounter = @counter),
		(SELECT HistoricalPrice FROM #tempTransfer WHERE rowCounter = @counter),
		CONVERT(int,(SELECT StatusID FROM #tempTransfer WHERE rowCounter = @counter))
	)

	set @counter = @counter + 1;
END

--Delete the cart and cart items

DELETE CartItems where ID_Cart = @ID_Cart;
DELETE Cart where ID_Cart = @ID_Cart;
DELETE #tempTransfer;
--DROP TABLE #tempTransfer;

RETURN;

---Should the customer id be added to the Order items?

END


GO
/****** Object:  StoredProcedure [dbo].[Prod_Add]    Script Date: 2018-10-31 9:29:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[Prod_Add]
	@newID Character(4) OUTPUT,
	@pro_name Character(30),
	@descriptionBrief Character(200),
	@descriptionFull nText,
	@price Float,
	@ID_Cat Character (4),
	@isFeatured bit = 0,
	@status Character (1) = '1',
	@pic varchar(25) = 'notavailable.png'
AS
BEGIN

if (Exists(select * from Products where pro_name = @pro_name))
THROW 50001, 'A product by that name already exists!',1;

DECLARE @intID int;

IF ((SELECT COUNT(*)FROM Products) = 0)
BEGIN
set @newID = '0001';
END
ELSE 
	BEGIN
	
	set @intID = CAST((SELECT TOP 1 ID_Pr + 1 FROM Products ORDER BY ID_Pr desc) AS INT);

	

	IF (@intID < 10)
	set @newID = '000' + cast(@intID as CHARACTER);
	ELSE IF (@intID < 100)
	set @newID = '00' + cast(@intID as CHARACTER);
	ELSE if (@intID < 1000)
	set @newID = '0' + cast(@intID as CHARACTER);
	


	END

	INSERT INTO Products (ID_Pr,pro_name,descriptionBrief,descriptionFull,price,ID_Cat,isFeatured,[status], pic)
	VALUES
	(
		@newID,
		@pro_name,
		@descriptionBrief,
		@descriptionFull,
		@price,
		@ID_Cat,
		@isFeatured,
		@status,
		@pic
	)

	set @newID = SCOPE_IDENTITY();

END

GO
/****** Object:  StoredProcedure [dbo].[Prods_Add]    Script Date: 2018-10-31 9:29:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[Prods_Add]
	@newID Character(4) OUTPUT,
	@pro_name Character(30),
	@descriptionBrief Character(200),
	@descriptionFull nText,
	@price Float,
	@ID_Cat Character (4),
	@isFeatured bit = 0,
	@status Character (1) = '1',
	@pic varchar(25) = 'notavailable.png'
AS
BEGIN

if (Exists(select * from Products where pro_name = @pro_name))
THROW 50001, 'A product by that name already exists!',1;

DECLARE @intID int;

IF ((SELECT COUNT(*)FROM Products) = 0)
BEGIN
set @newID = '0001';
END
ELSE 
	BEGIN
	
	set @intID = CAST((SELECT TOP 1 ID_Pr + 1 FROM Products ORDER BY ID_Pr desc) AS INT);

	

	IF (@intID < 10)
	set @newID = '000' + cast(@intID as CHARACTER);
	ELSE IF (@intID < 100)
	set @newID = '00' + cast(@intID as CHARACTER);
	ELSE if (@intID < 1000)
	set @newID = '0' + cast(@intID as CHARACTER);
	


	END

	INSERT INTO Products (ID_Pr,pro_name,descriptionBrief,descriptionFull,price,ID_Cat,isFeatured,[status], pic)
	VALUES
	(
		@newID,
		@pro_name,
		@descriptionBrief,
		@descriptionFull,
		@price,
		@ID_Cat,
		@isFeatured,
		@status,
		@pic
	)

	set @newID = SCOPE_IDENTITY();


END
GO
/****** Object:  StoredProcedure [dbo].[Prods_by_Keyword]    Script Date: 2018-10-31 9:29:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Prods_by_Keyword]
@daWord1 varchar(50),
@allowDiscontinued bit = 0


AS
BEGIN

	Select Products.*,Categories.cat_name,StatusStatic.[description] AS str_stat from Products 
	INNER JOIN Categories on Products.ID_Cat = Categories.ID_Cat
	INNER JOIN StatusStatic on StatusStatic.[status] = Products.[status]
	where 
	(descriptionBrief LIKE '%'+@daWord1+'%' OR descriptionFull LIKE '%'+@daWord1+'%' OR  descriptionBrief LIKE '%'+@daWord1+'%' OR cat_name LIKE '%'+@daWord1+'%')   
	
END

GO
/****** Object:  StoredProcedure [dbo].[Prods_by_Keywords]    Script Date: 2018-10-31 9:29:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Prods_by_Keywords]
@mustALL char(1),
@daWord1 varchar(50) = NULL,
@daWord2 varchar(50) = NULL,
@daWord3 varchar(50) = NULL,
@daWord4 varchar(50) = NULL,
@daWord5 varchar(50) = NULL



AS
BEGIN

if (@mustAll = '0')
BEGIN
	Select Products.*,Categories.cat_name,StatusStatic.[description] AS str_stat,StatusStatic.[status]
	from Products 
	INNER JOIN Categories on Products.ID_Cat = Categories.ID_Cat
	INNER JOIN StatusStatic on StatusStatic.[status] = Products.[status]
	where 
	(Products.[status] <> 5)AND
	(
	(descriptionBrief LIKE '%'+@daWord1+'%' OR descriptionFull LIKE '%'+@daWord1+'%' OR  descriptionBrief LIKE '%'+@daWord1+'%' OR cat_name LIKE '%'+@daWord1+'%')OR
	(descriptionBrief LIKE '%'+@daWord2+'%' OR descriptionFull LIKE '%'+@daWord2+'%' OR  descriptionBrief LIKE '%'+@daWord2+'%' OR cat_name LIKE '%'+@daWord2+'%')OR
	(descriptionBrief LIKE '%'+@daWord3+'%' OR descriptionFull LIKE '%'+@daWord3+'%' OR  descriptionBrief LIKE '%'+@daWord3+'%' OR cat_name LIKE '%'+@daWord3+'%')OR
	(descriptionBrief LIKE '%'+@daWord4+'%' OR descriptionFull LIKE '%'+@daWord4+'%' OR  descriptionBrief LIKE '%'+@daWord4+'%' OR cat_name LIKE '%'+@daWord4+'%')OR 
	(descriptionBrief LIKE '%'+@daWord5+'%' OR descriptionFull LIKE '%'+@daWord5+'%' OR  descriptionBrief LIKE '%'+@daWord5+'%' OR cat_name LIKE '%'+@daWord5+'%'))
END	
ELSE if (@daWord5 IS NOT NULL)
BEGIN
	Select Products.*,Categories.cat_name,StatusStatic.[description] AS str_stat from Products 
	INNER JOIN Categories on Products.ID_Cat = Categories.ID_Cat
	INNER JOIN StatusStatic on StatusStatic.[status] = Products.[status]
	where 
	(Products.[status] <> 5)AND
	(
	((descriptionBrief LIKE '%'+@daWord1+'%' OR descriptionFull LIKE '%'+@daWord1+'%' OR  descriptionBrief LIKE '%'+@daWord1+'%' OR cat_name LIKE '%'+@daWord1+'%'))AND
	((descriptionBrief LIKE '%'+@daWord2+'%' OR descriptionFull LIKE '%'+@daWord2+'%' OR  descriptionBrief LIKE '%'+@daWord2+'%' OR cat_name LIKE '%'+@daWord2+'%'))AND
	((descriptionBrief LIKE '%'+@daWord3+'%' OR descriptionFull LIKE '%'+@daWord3+'%' OR  descriptionBrief LIKE '%'+@daWord3+'%' OR cat_name LIKE '%'+@daWord3+'%'))AND
	((descriptionBrief LIKE '%'+@daWord4+'%' OR descriptionFull LIKE '%'+@daWord4+'%' OR  descriptionBrief LIKE '%'+@daWord4+'%' OR cat_name LIKE '%'+@daWord4+'%'))AND 
	((descriptionBrief LIKE '%'+@daWord5+'%' OR descriptionFull LIKE '%'+@daWord5+'%' OR  descriptionBrief LIKE '%'+@daWord5+'%' OR cat_name LIKE '%'+@daWord5+'%'))
	)
END	
ELSE if (@daWord4 IS NOT NULL)
BEGIN
	Select Products.*,Categories.cat_name,StatusStatic.[description] AS str_stat from Products 
	INNER JOIN Categories on Products.ID_Cat = Categories.ID_Cat
	INNER JOIN StatusStatic on StatusStatic.[status] = Products.[status]
	where 
	(Products.[status] <> 5)AND
	(
	((descriptionBrief LIKE '%'+@daWord1+'%' OR descriptionFull LIKE '%'+@daWord1+'%' OR  descriptionBrief LIKE '%'+@daWord1+'%' OR cat_name LIKE '%'+@daWord1+'%'))AND
	((descriptionBrief LIKE '%'+@daWord2+'%' OR descriptionFull LIKE '%'+@daWord2+'%' OR  descriptionBrief LIKE '%'+@daWord2+'%' OR cat_name LIKE '%'+@daWord2+'%'))AND
	((descriptionBrief LIKE '%'+@daWord3+'%' OR descriptionFull LIKE '%'+@daWord3+'%' OR  descriptionBrief LIKE '%'+@daWord3+'%' OR cat_name LIKE '%'+@daWord3+'%'))AND
	((descriptionBrief LIKE '%'+@daWord4+'%' OR descriptionFull LIKE '%'+@daWord4+'%' OR  descriptionBrief LIKE '%'+@daWord4+'%' OR cat_name LIKE '%'+@daWord4+'%'))
	)
END	
ELSE if (@daWord3 IS NOT NULL)
BEGIN
	Select Products.*,Categories.cat_name,StatusStatic.[description] AS str_stat from Products 
	INNER JOIN Categories on Products.ID_Cat = Categories.ID_Cat
	INNER JOIN StatusStatic on StatusStatic.[status] = Products.[status]
	where 
	(Products.[status] <> 5)AND
	(
	((descriptionBrief LIKE '%'+@daWord1+'%' OR descriptionFull LIKE '%'+@daWord1+'%' OR  descriptionBrief LIKE '%'+@daWord1+'%' OR cat_name LIKE '%'+@daWord1+'%'))AND
	((descriptionBrief LIKE '%'+@daWord2+'%' OR descriptionFull LIKE '%'+@daWord2+'%' OR  descriptionBrief LIKE '%'+@daWord2+'%' OR cat_name LIKE '%'+@daWord2+'%'))AND
	((descriptionBrief LIKE '%'+@daWord3+'%' OR descriptionFull LIKE '%'+@daWord3+'%' OR  descriptionBrief LIKE '%'+@daWord3+'%' OR cat_name LIKE '%'+@daWord3+'%'))
	)
END	
ELSE if (@daWord2 IS NOT NULL)
BEGIN
	Select Products.*,Categories.cat_name,StatusStatic.[description] AS str_stat from Products 
	INNER JOIN Categories on Products.ID_Cat = Categories.ID_Cat
	INNER JOIN StatusStatic on StatusStatic.[status] = Products.[status]
	where
	 (Products.[status] <> 5)AND
	(
	((descriptionBrief LIKE '%'+@daWord1+'%' OR descriptionFull LIKE '%'+@daWord1+'%' OR  descriptionBrief LIKE '%'+@daWord1+'%' OR cat_name LIKE '%'+@daWord1+'%'))AND
	((descriptionBrief LIKE '%'+@daWord2+'%' OR descriptionFull LIKE '%'+@daWord2+'%' OR  descriptionBrief LIKE '%'+@daWord2+'%' OR cat_name LIKE '%'+@daWord2+'%'))
	)
END	
ELSE 
BEGIN
	Select Products.*,Categories.cat_name,StatusStatic.[description] AS str_stat from Products 
	INNER JOIN Categories on Products.ID_Cat = Categories.ID_Cat
	INNER JOIN StatusStatic on StatusStatic.[status] = Products.[status]
	where 
	(Products.[status] <> 5)AND
	(
	((descriptionBrief LIKE '%'+@daWord1+'%' OR descriptionFull LIKE '%'+@daWord1+'%' OR  descriptionBrief LIKE '%'+@daWord1+'%' OR cat_name LIKE '%'+@daWord1+'%'))
	)
END	
END

GO
/****** Object:  StoredProcedure [dbo].[Prods_byCategory]    Script Date: 2018-10-31 9:29:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Prods_byCategory]
@ID_Cat int,
@allowDiscontinued bit = 0


AS
BEGIN

if (@allowDiscontinued = 1)
Select * from Products where ID_Cat = @ID_Cat;


else
Select * from Products where ID_Cat = @ID_Cat AND status <> 5;


END

GO
/****** Object:  StoredProcedure [dbo].[Prods_Delete]    Script Date: 2018-10-31 9:29:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Prods_Delete]
@id_pr Character(4)
AS
BEGIN
	DELETE Products WHERE ID_Pr = @id_pr;
END

GO
/****** Object:  StoredProcedure [dbo].[Prods_Get_Featured]    Script Date: 2018-10-31 9:29:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Prods_Get_Featured]
--Gets all products
AS
BEGIN
	Select Products.*,cat_name,StatusStatic.[description] AS str_stat from Products 
	INNER JOIN Categories on Products.ID_Cat = Categories.ID_Cat
	INNER JOIN StatusStatic on StatusStatic.[status] = Products.[status]
	WHERE isFeatured = '1';
END

GO
/****** Object:  StoredProcedure [dbo].[Prods_Get_One]    Script Date: 2018-10-31 9:29:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Prods_Get_One]
@ID_Pr Character(4)
AS
If (NOT EXISTS(SELECT * From Products WHERE ID_Pr = @ID_Pr))
THROW 50001, 'That product does not exist!',1;


BEGIN
	Select Products.*,Categories.cat_name,StatusStatic.[description] AS str_stat, StatusStatic.[status] AS statID from Products 
	INNER JOIN Categories on Products.ID_Cat = Categories.ID_Cat
	INNER JOIN StatusStatic on StatusStatic.[status] = Products.[status]
	WHERE ID_Pr = @ID_Pr;
END
GO
/****** Object:  StoredProcedure [dbo].[Prods_Update]    Script Date: 2018-10-31 9:29:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[Prods_Update]
@id_pr Character(4),
@pro_name Character(30),
@descriptionBrief Character(200),
@descriptionFull nText,
@price Float,
@ID_Cat Character (4),
@isFeatured bit = 0,
@status Character (1) = '1',
@pic varchar(25) = 'notavailable.png'
AS
BEGIN
update Products
set pro_name=@pro_name,descriptionBrief=@descriptionBrief,descriptionFull=@descriptionFull,price=@price,isFeatured=@isFeatured,ID_Cat=@ID_Cat,status=@status,pic=@pic
where ID_Pr=@ID_Pr
END
GO
/****** Object:  StoredProcedure [dbo].[RejectImage]    Script Date: 2018-10-31 9:29:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   proc [dbo].[RejectImage]
@ID_Img int,
@ID_Adm int 
AS
BEGIN
if((select ID_adm from siteImages where ID_Img = @ID_Img) = @ID_Adm)
throw 5000001, 'Uploader and Verifier cannot be the same admin', 1
delete from SiteImages
where ID_Img = @ID_Img
END

GO
/****** Object:  StoredProcedure [dbo].[RetrieveAccountByID]    Script Date: 2018-10-31 9:29:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RetrieveAccountByID]
@ID_Cust int
AS
BEGIN
SELECT * FROM Customer
WHERE ID_Cust=@ID_Cust
END
GO
/****** Object:  StoredProcedure [dbo].[Save_Image]    Script Date: 2018-10-31 9:29:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   PROC [dbo].[Save_Image]
@fileName nvarchar(50),
@altText nvarchar(50),
@locus nvarchar(150),
@ID_Adm int
AS
BEGIN
INSERT INTO SiteImages (fileName, altText, locus, ID_Adm)
Values (@fileName, @altText, @locus, @ID_Adm)
END

GO
/****** Object:  StoredProcedure [dbo].[spAddProductToCart]    Script Date: 2018-10-31 9:29:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spAddProductToCart]
@ID_Cart int,
@ID_Prod char(4),
@HistoricalPrice decimal(18,0),
@Qty int=1
as
begin
if not exists (select @ID_Prod from cartItems where ID_Prod=@ID_Prod AND ID_Cart = @ID_Cart)
	begin
	declare @StatusID char(1)
	set @StatusID = (Select status from products where ID_Pr=@ID_Prod)
	INSERT INTO CartItems (ID_Cart,ID_Prod,Qty,HistoricalPrice,StatusID)
	Values(@ID_Cart,@ID_Prod,@Qty,@HistoricalPrice,@StatusID)
END
else 
begin
	update CartItems
	Set Qty=Qty+@Qty
	where ID_Cart = @ID_Cart
end
end
GO
/****** Object:  StoredProcedure [dbo].[spCreateNewCart]    Script Date: 2018-10-31 9:29:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[spCreateNewCart]
@ID_Cart int OUTPUT
AS
BEGIN
SET NOCOUNT ON;
if not exists(select @ID_Cart from cart where ID_Cart=@ID_Cart)
begin
INSERT INTO Cart (DateCreated,OrderStatus)
Values(GETDATE(),0)
set @ID_Cart = SCOPE_IDENTITY()
END
END

GO
/****** Object:  StoredProcedure [dbo].[spLoadCartItems]    Script Date: 2018-10-31 9:29:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spLoadCartItems]
@ID_Cart int
AS
BEGIN
SELECT ID_Prod as [Product ID], pro_name as [Product Name], qty, HistoricalPrice, HistoricalPrice*Qty as [SubTotal],description as [Item Status],cartitems.Remove 
from cartitems inner join StatusStatic on StatusID=status inner join products on Convert(int,CartItems.ID_Prod) = Convert(int,Products.ID_Pr)
WHERE ID_Cart= @ID_Cart AND ID_Cart NOT IN (SELECT ID_Cart FROM OrderHistory)
END
GO
/****** Object:  StoredProcedure [dbo].[spLoadOrderedItems]    Script Date: 2018-10-31 9:29:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spLoadOrderedItems]
@ID_Cart int
AS
BEGIN
SELECT ID_Prod as [Product ID], pro_name as [Product Name], qty, HistoricalPrice, HistoricalPrice*Qty as [SubTotal],description as [Item Status]
from OrderItems inner join StatusStatic on Orderitems.StatusId=StatusStatic.status inner join products on Convert(int,OrderItems.ID_Prod) = Convert(int,Products.ID_Pr)
WHERE ID_Cart= @ID_Cart 
END
GO
/****** Object:  StoredProcedure [dbo].[spUpdateCartItems]    Script Date: 2018-10-31 9:29:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[spUpdateCartItems]
@ID_Cart int,
@ID_Pr char(4),
@qty int = 1,
@remove bit = 0
AS
BEGIN 

if (@remove = 1 OR @qty = 0)--Just Delete the item
	BEGIN
		DELETE CartItems
		WHERE ID_Prod = @ID_Pr AND @ID_Cart = ID_Cart
	END
	ELSE

	BEGIN 
		UPDATE CartItems
		SET Qty = @qty 
		WHERE ID_Prod = @ID_Pr AND @ID_Cart = ID_Cart
	END
END
GO
/****** Object:  StoredProcedure [dbo].[Status_Get_All]    Script Date: 2018-10-31 9:29:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Status_Get_All]
AS
BEGIN
	Select * from StatusStatic;
END

GO
/****** Object:  StoredProcedure [dbo].[Update_Image]    Script Date: 2018-10-31 9:29:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create   PROC [dbo].[Update_Image]
@ID_Img int,
@fileName nvarchar(50),
@altText nvarchar(50),
@locus nvarchar(150),
@active bit
AS
BEGIN
update siteimages 
set fileName = @fileName , altText=@altText , locus = @locus, active = @active
where ID_Img = @ID_Img
END

GO
/****** Object:  StoredProcedure [dbo].[Update_Quantity]    Script Date: 2018-10-31 9:29:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[Update_Quantity]
@ID_Cart int,
@Qty int,
@ID_Prod int
AS
BEGIN
UPDATE CartItems SET Qty = @Qty
WHERE ID_Cart = @ID_Cart AND ID_Prod = @ID_Prod;

if (@Qty <= 0)
DELETE CartItems WHERE ID_Cart = @ID_Cart AND ID_Prod = @ID_Prod;

END
GO
/****** Object:  StoredProcedure [dbo].[UpdateAccount]    Script Date: 2018-10-31 9:29:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[UpdateAccount]
@ID_Cust int,
@FName VarChar(20),
@MName VarChar(20) NULL,
@LName VarChar(20),
@UserName NVarChar(20),
@Password NVarChar(50),
@DOB Date,
@Street NVarChar(20),
@City Varchar(20),
@State VarChar(20),
@ZIP NVARCHAR(10),
@Country VARCHAR(20),
@Phone VarChar(10),
@Email NVarChar(50)
AS
BEGIN
UPDATE Customer 
SET 
fname=@FName,
mname=@MName,
lname=@LName,
username=@UserName,
password=@Password,
dob=@DOB,
street=@Street,
city=@City ,
state=@State,
zip=@ZIP,
country=@Country,
phone=@Phone,
email=@Email
WHERE ID_Cust=@ID_Cust
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateAccountUser]    Script Date: 2018-10-31 9:29:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[UpdateAccountUser]
@ID_Cust int,
@FName VarChar(20),
@MName VarChar(20) NULL,
@LName VarChar(20),
@UserName NVarChar(20),
@Password NVarChar(50),
@DOB Date,
@Street NVarChar(20),
@City Varchar(20),
@State VarChar(20),
@ZIP NVARCHAR(10),
@Country VARCHAR(20),
@Phone VarChar(10),
@Email NVarChar(50)
AS
BEGIN

if (Not EXISTS(SELECT * From Customer WHERE @UserName = UserName AND @Password = Password))
	Throw 50001,'Password is incorrect',1

UPDATE Customer 
SET 
fname=@FName,
mname=@MName,
lname=@LName,
username=@UserName,
password=@Password,
dob=@DOB,
street=@Street,
city=@City ,
state=@State,
zip=@ZIP,
country=@Country,
phone=@Phone,
email=@Email
WHERE ID_Cust=@ID_Cust
END
GO
/****** Object:  StoredProcedure [dbo].[ValidateCustomer]    Script Date: 2018-10-31 9:29:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ValidateCustomer]
@Validate char(8)
AS
BEGIN

if (NOT EXISTS (SELECT * FROM Customer WHERE Validate = @Validate))
THROW 50001, 'No customer validated!', 1

SELECT * FROM Customer WHERE Validate = @Validate

UPDATE Customer
SET Validate = null
WHERE Validate = @Validate;

END
GO
/****** Object:  StoredProcedure [dbo].[VerifyImage]    Script Date: 2018-10-31 9:29:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-----REMEMBER: THE UPLOADER OF AN IMAGE CANNOT VERIFY THEIR OWN IMAGES.
CREATE   PROC [dbo].[VerifyImage]
@ID_Img int,
@newLocus nvarchar(150),
@ID_Adm int 
AS
BEGIN
if((select ID_adm from siteImages where ID_Img = @ID_Img) = @ID_Adm)
throw 5000001, 'Uploader and Verifier cannot be the same admin', 1
UPDATE SiteImages
SET Verified = 1, locus = @newLocus
where ID_Img = @ID_Img
END

GO
USE [master]
GO
ALTER DATABASE [LastBraincell] SET  READ_WRITE 
GO
