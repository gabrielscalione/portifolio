

-- Backup
BACKUP DATABASE PlataformaCursos TO DISK = 'C:\Backup\PlataformaCursos.bak';

-- Restore
RESTORE DATABASE PlataformaCursos FROM DISK = 'C:\Backup\PlataformaCursos.bak';
