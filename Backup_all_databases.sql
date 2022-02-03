DECLARE @name VARCHAR(50) -- database name  
DECLARE @path VARCHAR(256) -- path for backup files  
DECLARE @fileName VARCHAR(256) -- filename for backup  
DECLARE @fileDate VARCHAR(20) -- used for file name 

/*  удаление предыдущего бэкапа */

--exec
--xp_cmdshell 'DEL | ERASE C:\Databases\Backups\all\*.* /q'

/*  путь */
SET @path = 'D:\practice\'  


SELECT @fileDate = CONVERT(VARCHAR(20),GETDATE(),112) 

DECLARE db_cursor CURSOR FOR  
SELECT name 
FROM master.dbo.sysdatabases
/* все бд, кроме системных, и которые в данный момент онлайн */
--WHERE name NOT IN ('master','model','msdb','tempdb')  
--AND DATABASEPROPERTYEX(name, 'status') = 'ONLINE'


OPEN db_cursor   
FETCH NEXT FROM db_cursor INTO @name   

WHILE @@FETCH_STATUS = 0   
BEGIN   
       SET @fileName = @path + @name + '_' + @fileDate + '.BAK'  
       BACKUP DATABASE @name TO DISK = @fileName   

       FETCH NEXT FROM db_cursor INTO @name   
END   

CLOSE db_cursor   
DEALLOCATE db_cursor 

/*копирование в папку по сетевому пути , если xp_cmdshell не включен изначально, надо включеть заранее*/
--exec
--xp_cmdshell 'xcopy c:\databases\backups\all /-y D:\backups\'