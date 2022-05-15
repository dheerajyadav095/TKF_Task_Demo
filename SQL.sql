
ALTER TABLE [dbo].[tblSkillsEmpData] DROP CONSTRAINT [FK__tblSkills__Skill__534D60F1]
GO

ALTER TABLE [dbo].[tblSkillsEmpData] DROP CONSTRAINT [FK__tblSkills__EmpID__52593CB8]
GO

/****** Object:  Table [dbo].[tblSkillsEmpData]    Script Date: 5/15/2022 11:06:52 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblSkillsEmpData]') AND type in (N'U'))
DROP TABLE [dbo].[tblSkillsEmpData]
GO

/****** Object:  Table [dbo].[tblSkills]    Script Date: 5/15/2022 11:06:52 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblSkills]') AND type in (N'U'))
DROP TABLE [dbo].[tblSkills]
GO

/****** Object:  Table [dbo].[tblEmployeeDetails]    Script Date: 5/15/2022 11:06:52 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblEmployeeDetails]') AND type in (N'U'))
DROP TABLE [dbo].[tblEmployeeDetails]
GO

/****** Object:  Table [dbo].[tblEmployeeDetails]    Script Date: 5/15/2022 11:06:52 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblEmployeeDetails](
	[EmpID] [int] IDENTITY(1,1) NOT NULL,
	[EmpName] [varchar](50) NULL,
	[EmpDOB] [datetime] NULL,
	[EmpDesignation] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[EmpID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[tblSkills]    Script Date: 5/15/2022 11:06:52 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblSkills](
	[SkillID] [int] IDENTITY(1,1) NOT NULL,
	[SkillName] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[SkillID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[tblSkillsEmpData]    Script Date: 5/15/2022 11:06:52 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblSkillsEmpData](
	[Skill_LogID] [int] IDENTITY(1,1) NOT NULL,
	[SkillID] [int] NULL,
	[EmpID] [int] NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[tblSkillsEmpData]  WITH CHECK ADD FOREIGN KEY([EmpID])
REFERENCES [dbo].[tblEmployeeDetails] ([EmpID])
GO

ALTER TABLE [dbo].[tblSkillsEmpData]  WITH CHECK ADD FOREIGN KEY([SkillID])
REFERENCES [dbo].[tblSkills] ([SkillID])
GO


INSERT INTO tblSkills
(SkillName)(
SELECT 'C#' AS SkillName UNION
SELECT 'VB.NET' AS SkillName UNION
SELECT 'CSS' AS SkillName UNION
SELECT 'Python' AS SkillName UNION
SELECT 'Ruby on Rails' AS SkillName UNION
SELECT 'React JS' AS SkillName 
)

/****** Object:  StoredProcedure [dbo].[PropsUpdateEmployeeDetails]    Script Date: 5/15/2022 11:09:56 AM ******/
DROP PROCEDURE [dbo].[PropsUpdateEmployeeDetails]
GO

/****** Object:  StoredProcedure [dbo].[PropsSaveSkills]    Script Date: 5/15/2022 11:09:56 AM ******/
DROP PROCEDURE [dbo].[PropsSaveSkills]
GO

/****** Object:  StoredProcedure [dbo].[PropsSaveEmployeeDetails]    Script Date: 5/15/2022 11:09:56 AM ******/
DROP PROCEDURE [dbo].[PropsSaveEmployeeDetails]
GO

/****** Object:  StoredProcedure [dbo].[PropsDeleteEmpolyeeDetails]    Script Date: 5/15/2022 11:09:56 AM ******/
DROP PROCEDURE [dbo].[PropsDeleteEmpolyeeDetails]
GO

/****** Object:  StoredProcedure [dbo].[PropGetUserEdit]    Script Date: 5/15/2022 11:09:56 AM ******/
DROP PROCEDURE [dbo].[PropGetUserEdit]
GO

/****** Object:  StoredProcedure [dbo].[PropGetSkills]    Script Date: 5/15/2022 11:09:56 AM ******/
DROP PROCEDURE [dbo].[PropGetSkills]
GO

/****** Object:  StoredProcedure [dbo].[PropGetEmployeeDetails]    Script Date: 5/15/2022 11:09:56 AM ******/
DROP PROCEDURE [dbo].[PropGetEmployeeDetails]
GO

/****** Object:  StoredProcedure [dbo].[PropGetEmployeeDetails]    Script Date: 5/15/2022 11:09:56 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[PropGetEmployeeDetails]
	
AS
BEGIN
	SET NOCOUNT ON;

    SELECT 
    E.EmpID,E.EmpName,CONVERT(VARCHAR,E.EmpDOB,101) AS EmpDOB ,E.EmpDesignation,
    (
        SELECT STUFF((SELECT ', ' + CAST(X.SkillName AS VARCHAR(MAX)) FROM  
        (   
        SELECT S.SkillName FROM tblSkillsEmpData SE 
        INNER JOIN tblSkills S ON SE.SkillID = S.SkillID
        WHERE SE.EmpID = E.EmpID      
        )X  
        FOR XML PATH('')) ,1,2,'')  
    ) AS SkillName
    FROM tblEmployeeDetails E 
        
END
GO

/****** Object:  StoredProcedure [dbo].[PropGetSkills]    Script Date: 5/15/2022 11:09:56 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[PropGetSkills]
	
AS
BEGIN
	SET NOCOUNT ON;

    SELECT * FROM tblSkills S 
        
END
GO

/****** Object:  StoredProcedure [dbo].[PropGetUserEdit]    Script Date: 5/15/2022 11:09:56 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[PropGetUserEdit]
    @EMPID int
AS
BEGIN
	SET NOCOUNT ON;
    
    
    SELECT E.EmpName,Convert(VARCHAR,E.EmpDOB,101)AS EmpDOB,E.EmpDesignation,
	(
        SELECT STUFF((SELECT ', ' + CAST(X.SkillName AS VARCHAR(MAX)) FROM  
        (   
        SELECT S.SkillName FROM tblSkillsEmpData SE 
        INNER JOIN tblSkills S ON SE.SkillID = S.SkillID
        WHERE SE.EmpID = E.EmpID AND SE.EmpID = @EMPID     
        )X  
        FOR XML PATH('')) ,1,2,'')  
    ) AS SkillName
	FROM tblEmployeeDetails E 
    WHERE E.EmpID = @EMPID

END
GO

/****** Object:  StoredProcedure [dbo].[PropsDeleteEmpolyeeDetails]    Script Date: 5/15/2022 11:09:56 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[PropsDeleteEmpolyeeDetails]
 @EmpID INT
AS
BEGIN
	SET NOCOUNT ON;

    IF EXISTS(SELECT TOP 1 * FROM tblEmployeeDetails WHERE EmpID = @EmpID)
    BEGIN

        DELETE FROM tblSkillsEmpData WHERE EmpID = @EmpID
        DELETE FROM tblEmployeeDetails WHERE EmpID = @EmpID

    END

END
GO

/****** Object:  StoredProcedure [dbo].[PropsSaveEmployeeDetails]    Script Date: 5/15/2022 11:09:56 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[PropsSaveEmployeeDetails]

@EmpName VARCHAR(50),
@EmpDOB DATETIME,
@EmpDesignation VARCHAR(200)

AS
BEGIN
	SET NOCOUNT ON;

    INSERT INTO tblEmployeeDetails
    (
    EmpName,
    EmpDOB,
    EmpDesignation
    )
    VALUES
    (
    @EmpName,
    @EmpDOB,
    @EmpDesignation
    )
   
  SELECT @@IDENTITY    

END
GO

/****** Object:  StoredProcedure [dbo].[PropsSaveSkills]    Script Date: 5/15/2022 11:09:56 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[PropsSaveSkills]

@EmpID INT,
@SkillID INT

AS
BEGIN
	SET NOCOUNT ON;

    IF EXISTS(SELECT TOP 1 * FROM tblSkillsEmpData S WHERE S.EmpID = @EmpID AND S.SkillID = @SkillID)
    BEGIN 
         DELETE FROM tblSkillsEmpData WHERE EmpID = @EmpID
    END
    
    INSERT INTO tblSkillsEmpData
    (
        SkillID,
        EmpID
    )
    VALUES
    (
        @SkillID,
        @EmpID
    )
   
END
GO

/****** Object:  StoredProcedure [dbo].[PropsUpdateEmployeeDetails]    Script Date: 5/15/2022 11:09:56 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[PropsUpdateEmployeeDetails]

@EmpID INT,
@EmpName VARCHAR(50),
@EmpDOB DATETIME,
@EmpDesignation VARCHAR(200)

AS
BEGIN
	SET NOCOUNT ON;

    Update tblEmployeeDetails
    SET
        EmpName =@EmpName,
        EmpDOB =@EmpDOB,
        EmpDesignation =@EmpDesignation
   WHERE EmpID=@EmpID
    

END
GO


