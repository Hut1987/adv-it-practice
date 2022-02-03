USE DWH;
GO

DECLARE @ServerName nvarchar(256) = @@servername;
if (@ServerName = N'LEUMMRSUATV01')
begin
/*Prototype_live (OLE DB)*/
DELETE FROM	dwh.meta.SSISPackageConfiguration
where	ConfigurationFilter = 'Prototype_live (OLE DB)'
		and PackagePath = '\Package.Connections[Prototype_live (OLE DB)].Properties[ConnectionString]';
INSERT INTO dwh.meta.SSISPackageConfiguration (ConfigurationFilter,ConfiguredValue, PackagePath, ConfiguredValueType)
values ('Prototype_live (OLE DB)',
		'Data Source=LEUMPSQLUATV1;Initial Catalog=Prot;Provider=SQLNCLI11.1;Integrated Security=SSPI;Auto Translate=False;Application Name="SSIS-Prototype_live (OLE DB)";',
		'\Package.Connections[Prototype_live (OLE DB)].Properties[ConnectionString]',
		'String');
end;
else 
BEGIN;
			THROW 51000, N'ALARM!!!!! It''s not UAT environment!!!!!!!!!!', 1;
END;
