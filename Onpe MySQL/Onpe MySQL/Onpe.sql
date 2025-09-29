-- www.web.onpe.gob.pe/modElecciones/elecciones/elecciones2016/PRP2V2016/

drop database if exists Onpe;
create database Onpe;
use Onpe;

create table Departamento (
  idDepartamento int primary key auto_increment,
  Detalle char(30) unique );

create table Provincia (
  idProvincia int primary key auto_increment,
  idDepartamento int references Departamento,
  Detalle char(30) unique );
  
create table Distrito (
  idDistrito int primary key auto_increment,
  idProvincia int references Provincia,
  Detalle char(50) not null );
  
create table Partido (
  idPartido int primary key auto_increment,
  RazonSocial char(30) not null,
  CandidatoPresidencial char(30) not null );

create Table LocalVotacion (
  idLocalVotacion int primary key auto_increment,
  idDistrito int references Distrito,
  RazonSocial char(100) not null,
  Direccion char(200) not null );

create table GrupoVotacion (
  idLocalVotacion int references LocalVotacion,
  idGrupoVotacion char(6) primary key,
  nCopia char(3) not null,
  idEstadoActa int not null,	-- 1. 'ACTA ELECTORAL NORMAL', 2. 'ACTA ELECTORAL RESUELTA'
  ElectoresHabiles int,
  TotalVotantes int,
  P1 int,
  P2 int,
  VotosBlancos int,
  VotosNulos int,
  VotosImpugnados int );


-- ---------- Vistas ----------
create view vDepartamentos as select * from Departamento;

create view vListaVotantes
  as select DE.idDepartamento, DE.Detalle 'Departamento', PR.Detalle 'Provincia', DI.idDistrito, DI.Detalle 'Distrito',
			SUM( GV.TotalVotantes) 'TV', 
            ( SUM(GV.ElectoresHabiles) - SUM( GV.TotalVotantes) ) 'TA', 
            SUM(GV.ElectoresHabiles) 'EH'
		from  Departamento DE, Provincia PR, Distrito DI, LocalVotacion LV, GrupoVotacion GV
		where DE.idDepartamento = PR.idDepartamento and 
			  PR.idProvincia = DI.idProvincia and
			  DI.idDistrito = LV.idDistrito and 
              LV.idLocalVotacion = GV.idLocalVotacion
		group by DE.idDepartamento, DE.Detalle, PR.Detalle, DI.idDistrito, DI.Detalle;


create view vTotalVotos
  as select	SUM(TotalVotantes) 'Total Asistentes', 
			CONCAT ( CAST( ( SUM(TotalVotantes) * 100.0 / SUM(ElectoresHabiles) ) as decimal(8,3) ), ' %' ) '% Total Asistentes',
			( SUM(ElectoresHabiles) - SUM(TotalVotantes) ) 'Total Ausentes',
			CONCAT ( FORMAT( ( SUM(ElectoresHabiles) - SUM(TotalVotantes) ) * 100.0 / SUM(ElectoresHabiles), 3 ), ' %' ) '% Total Ausentes',
			SUM(ElectoresHabiles) 'Electores Hábiles' 
			from GrupoVotacion;


-- ---------- Procedimientos ----------
create procedure sp_isDepartamento(in _Detalle char(30))
	select count(*) from Departamento where Detalle = _Detalle;

create procedure sp_isProvincia(in _Detalle char(30))
	select count(*) from Provincia where Detalle = _Detalle;

create procedure sp_getDepartamentos(in _inicio int, in _fin int)
   select * from Departamento where idDepartamento between _inicio and _fin;

create procedure sp_getProvincias(in _idDepartamento int)
  select idProvincia, Detalle from Provincia where idDepartamento = _idDepartamento;

create procedure sp_getProvinciasbyDepartamento(in _Departamento char(30))
  select idProvincia, Detalle from Provincia where idDepartamento = ( select idDepartamento from Departamento where Detalle = _Departamento);

create procedure sp_getDistritos(in _idProvincia int)
  select idDistrito, Detalle from Distrito where idProvincia = _idProvincia;

create procedure sp_getDistritosByProvincia(in _Provincia char(30))
  select idDistrito, Detalle from Distrito where idProvincia = ( select idProvincia from Provincia where Detalle = _Provincia);
  
create procedure sp_getLocalesVotacion(in _idDistrito int)
  select idLocalVotacion, RazonSocial from LocalVotacion where idDistrito = _idDistrito;

create procedure sp_getLocalesVotacionByDistrito( in _Provincia char(30) , in _Distrito char(50))
  select idLocalVotacion, RazonSocial from LocalVotacion lv, Distrito di, Provincia pv
	  where	lv.idDistrito = di.idDistrito and 
			di.idProvincia = pv.idProvincia and
			pv.Detalle = _Provincia and di.Detalle = _Distrito;

create procedure sp_getGruposVotacion(in _idLocalVotacion int)
  select idGrupoVotacion from GrupoVotacion where idLocalVotacion = _idLocalVotacion;

create procedure sp_getGruposVotacionByProvinciaDistritoLocal(in _Provincia char(30), in _Distrito char(50), in _LocalVotacion char(100) )
    select idGrupoVotacion from GrupoVotacion gv, LocalVotacion lv, Distrito di, Provincia pv
       where gv.idLocalVotacion = lv.idLocalVotacion and
			 lv.idDistrito = di.idDistrito and
			 di.idProvincia = pv.idProvincia and
			 pv.Detalle = _Provincia and di.Detalle = _Distrito and lv.RazonSocial = _LocalVotacion;

create procedure sp_getGrupoVotacion(in _idGrupoVotacion char(6))
  select DE.Detalle 'Departamento', PR.Detalle 'Provincia', DI.Detalle 'Distrito', LV.RazonSocial, LV.Direccion, GV.*
		from GrupoVotacion GV, LocalVotacion LV, Departamento DE, Provincia PR, Distrito DI
		where  LV.idDistrito = DI.idDistrito and PR.idProvincia = DI.idProvincia and DE.idDepartamento = PR.idDepartamento and
			   GV.idLocalVotacion = LV.idLocalVotacion and GV.idGrupoVotacion = _idGrupoVotacion;

create procedure sp_getGrupoVotacionByProvinciaDistritoLocalGrupo(in _Departamento char(30), in _Provincia char(30), in _Distrito char(50), in _LocalVotacion char(100), in _GrupoVotacion char(6) )
	select de.Detalle 'Departamento', pv.Detalle 'Provincia', di.Detalle 'Distrito', lv.RazonSocial, lv.Direccion, gv.*
	   from GrupoVotacion gv, LocalVotacion lv, Distrito di, Provincia pv, Departamento de
       where de.Detalle = _Departamento and  pv.Detalle = _Provincia and di.Detalle = _Distrito and 
             lv.RazonSocial = _LocalVotacion and gv.idGrupoVotacion = _GrupoVotacion;

create procedure sp_getVotos(in _inicio int, in _fin int)
 select TRIM(Departamento) 'DPD',
		FORMAT( SUM(TV), 0 ) 'TV', 
        CONCAT ( FORMAT ( SUM(TV) * 100.0 / SUM(EH), 3 ), ' %' ) 'PTV',
		FORMAT( SUM(TA), 0 ) 'TA',
        CONCAT ( FORMAT ( SUM(TA) * 100.0 / SUM(EH), 3 ), ' %' ) 'PTA',
        FORMAT( SUM(EH), 0 ) 'EH'
		from vListaVotantes 
		where idDepartamento between _inicio and _fin
		group by idDepartamento, Departamento
		order by Departamento;

create procedure sp_getVotosDepartamento(in _Departamento char(30))
 select TRIM(Provincia) 'DPD',
		FORMAT( SUM(TV), 0 ) 'TV',
        CONCAT ( FORMAT ( SUM(TV) * 100.0 / SUM(EH), 3 ), ' %' ) 'PTV',
		FORMAT( SUM(TA), 0 ) 'TA',
        CONCAT ( FORMAT ( SUM(TA) * 100.0 / SUM(EH), 3 ), ' %' ) 'PTA',
		FORMAT( SUM(EH), 0 ) 'EH' 
        from vListaVotantes 
        where Departamento = _Departamento 
        group by Provincia;

create procedure sp_getVotosProvincia(in _Provincia char(30))
 select TRIM(Distrito) 'DPD',
		FORMAT( SUM(TV), 0 ) 'TV',
        CONCAT ( FORMAT ( SUM(TV) * 100.0 / SUM(EH), 3 ), ' %' ) 'PTV',
		FORMAT( SUM(TA), 0 ) 'TA',
        CONCAT ( FORMAT ( SUM(TA) * 100.0 / SUM(EH), 3 ), ' %' ) 'PTA',
		FORMAT( SUM(EH), 0 ) 'EH' 
        from vListaVotantes 
        where Provincia = _Provincia
        group by Distrito;

create procedure sp_getDistritosDepartamento(in _Departamento char(30))
 select Di.idDistrito, Di.Detalle 'Distrito', P.Detalle 'Provincia' 
		from Distrito Di, Provincia P, Departamento De
		where De.idDepartamento = P.idDepartamento and 
			  P.idProvincia = Di.idProvincia and 
              De.Detalle = _Departamento;

create procedure sp_getLocalesVotacionDepartamento(in _Departamento char(30))
 select LV.idLocalVotacion, LV.RazonSocial, Di.Detalle 'Distrito', P.Detalle 'Provincia'
		from LocalVotacion LV, Distrito Di, Provincia P, Departamento De
		where De.idDepartamento = P.idDepartamento and
			  P.idProvincia = Di.idProvincia and
              De.Detalle = Departamento and
              Di.idDistrito = LV.idDistrito;


-- call sp_isDepartamento('AMAZONAS')
-- call sp_isProvincia('BAGUA')
-- call sp_getDepartamentos(1,25)
-- call sp_getProvincias(1)
-- call sp_getProvinciasByDepartamento('AMAZONAS')
-- call sp_getDistritos(1)
-- call sp_getDistritosByProvincia('BAGUA')
-- call sp_getLocalesVotacion(170)
-- call sp_getLocalesVotacionByDistrito('BAGUA', 'ARAMANGO')
-- call sp_getGruposVotacion(1)
-- call sp_getGruposVotacionByProvinciaDistritoLocal('BAGUA', 'ARAMANGO', 'IE MIGUEL MONTEZA TAFUR')
-- call sp_getGrupoVotacion('000001')
-- call sp_getGrupoVotacionByProvinciaDistritoLocalGrupo('AMAZONAS', 'BAGUA', 'ARAMANGO', 'IE 16201', '000169')

-- call sp_getGrupoVotacionByProvinciaDistritoLocalGrupo('AMAZONAS', 'RODRIGUEZ DE MENDOZA', 'SAN NICOLAS', 'IE 18207 SAN NICOLAS', '000490')
-- call sp_getVotos(1,25)
-- call sp_getVotosDepartamento('AMAZONAS')
-- call sp_getVotosProvincia('BAGUA')

-- select * from vTotalVotos

/*
select 
	SUM(P1) AS Total_P1,
	CONCAT(ROUND((SUM(P1)*100.0)/(SUM(P1)+SUM(P2)),2),'%') AS Porcentaje_P1,
	SUM(P2) AS Total_P2,
	CONCAT(ROUND((SUM(P2)*100.0)/(SUM(P1)+SUM(P2)),2),'%') AS Porcentaje_P2,
    COUNT(*) AS Total_Actas,
	CONCAT(ROUND((COUNT(*)*100.0)/(SELECT COUNT(*) FROM GrupoVotacion),2),'%') AS Porcentaje_Actas,
    SUM(ElectoresHabiles) AS TotalElectoresHabiles,
	SUM(TotalVotantes) AS TotalCiudadanosVotaron,
	ROUND(AVG(TotalVotantes*1.0 / ElectoresHabiles * 100), 2) AS PorcentajeParticipacion,
    100 - ROUND(AVG(TotalVotantes * 100.0 / ElectoresHabiles), 2) AS PorcentajeAusentismo
	FROM GrupoVotacion

SELECT FORMAT(SUM(P1), 'N2') 'TotalVotosPPK', FORMAT(SUM(P2), 'N2') ' TotalVotosKeiko', CONCAT(CAST((SUM(TotalVotantes)-SUM(P1)) * 100.0 / SUM(TotalVotantes) AS decimal(10, 3)), ' %') '% VOTOS VÁLIDOSppk',
CONCAT(CAST((SUM(P2)) * 100.0 / SUM(TotalVotantes)  AS decimal(8, 3)), ' %' ) '% VOTOS VÁLIDOSkeyko',
format(COUNT(idEstadoActa),'N2') 'totalActas', format(COUNT(*),'N2')'totalActasProcesadas',format(COUNT(*),'N2') 'totalActasContabilizadas', FORMAT(SUM(ElectoresHabiles), 'N2')  'Electores Hábiles', FORMAT(SUM(TotalVotantes), 'N2') 'Ciudadanos que votaron ',
CONCAT ( CAST ( ( SUM(TotalVotantes) * 100.0 / SUM(TotalVotantes) ) as decimal (8,3) ), ' %' ) '% de participacion',
CONCAT ( CAST ( ( ( SUM(ElectoresHabiles) - SUM(TotalVotantes) ) * 100.0 / SUM(ElectoresHabiles) ) as decimal (8,3) ), ' %' ) '% de ausentismo'
FROM GrupoVotacion


select 
SUM(P1) 'NumeroP1', 
			CONCAT ( CAST ( ( SUM(P1) * 100.0 / SUM(P1+P2) ) as decimal (8,3) ), ' %' ) 'TotalP1',
			( SUM(P2) ) 'NumeroP2',
			CONCAT ( CAST ( ( SUM(P2) * 100.0 / SUM(P1+P2) ) as decimal (8,3) ), ' %' ) 'TotalP2',
			SUM(TotalVotantes) 'NumeroAsistentes', 
			CONCAT ( CAST ( ( SUM(TotalVotantes) * 100.0 / SUM(ElectoresHabiles) ) as decimal (8,3) ), ' %' ) 'TotalAsistentes',
			( SUM(ElectoresHabiles) - SUM(TotalVotantes) ) 'NumeroAusentes',
			CONCAT ( CAST ( ( ( SUM(ElectoresHabiles) - SUM(TotalVotantes) ) * 100.0 / SUM(ElectoresHabiles) ) as decimal (8,3) ), ' %' ) 'TotalAusentes',
			SUM(ElectoresHabiles) 'ElectoresHabiles'
			from GrupoVotacion


select	sum(p1) as 'Kambio', CONCAT ( CAST ( ( SUM(p1) * 100.0 / SUM(TotalVotantes) ) as decimal (8,3) ), ' %' ) 'Votok',sum(p2) as 'FP', CONCAT ( CAST ( ( SUM(p2) * 100.0 / SUM(TotalVotantes) ) as decimal (8,3) ), ' %' ) 'Votop',SUM(TotalVotantes) 'total', 
			CONCAT ( CAST ( ( SUM(TotalVotantes) * 100.0 / SUM(ElectoresHabiles) ) as decimal (8,3) ), ' %' ) 'Participacion',
			( SUM(ElectoresHabiles) - SUM(TotalVotantes) ) 'Ausentes',
			CONCAT ( CAST ( ( ( SUM(ElectoresHabiles) - SUM(TotalVotantes) ) * 100.0 / SUM(ElectoresHabiles) ) as decimal (8,3) ), ' %' ) 'TotalAusencia',
			SUM(ElectoresHabiles) 'ElectoresHabiles' ,count(*) as 'TotalActas', count(votosImpugnados) as 'Procesadas',count(votosImpugnados) as 'Contabilizadas'
			from GrupoVotacion