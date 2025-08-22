CREATE or replace VIEW `b1`.`viewProfileUser` AS 
select `b1`.`Usuario`.`id` AS `id`,
`b1`.`Usuario`.`rut` AS `rut`,
`b1`.`Usuario`.`rut_provisorio` AS `rut_provisorio`,
`b1`.`Nacionalidad`.`Nacionalidad` AS `Nacionalidad`,
`b1`.`Usuario`.`nombres` AS `nombres`,
`b1`.`Usuario`.`apellido_paterno` AS `apellido_paterno`,
`b1`.`Usuario`.`apellido_materno` AS `apellido_materno`,
`b1`.`Usuario`.`fecha_nacimiento` AS `fecha_nacimiento`,
`b1`.`Usuario`.`sexo_id` AS `sexo_id`,
`b1`.`Usuario`.`estado_civil_id` AS `estado_civil_id`,
`b1`.`EstadoCivil`.`descripcion` AS `descripcion_estado_civil`,
`b1`.`Usuario`.`nacionalidad_id` AS `nacionalidad_id`,
`b1`.`Usuario`.`username` AS `username`,
`b1`.`Usuario`.`activo` AS `activo`,
`b1`.`Contacto`.`email` AS `email`,
`b1`.`Contacto`.`fijo` AS `fijo`,
`b1`.`Contacto`.`movil` AS `movil`,

`b1`.`Ubicacion`.`region_id` AS `region_id`,
`b1`.`Ubicacion`.`comuna_id` AS `comuna_id`,
`b1`.`Ubicacion`.`direccion` AS `direccion`,
`b1`.`Regiones`.`nombre` AS `nomregion`,
`b1`.`Regiones`.`orden` AS `orden`,
`b1`.`Comunas`.`nombre` AS `nomcomuna`,

`b1`.`UsuariosDepartamentos`.`sociedad_id` AS `sociedad_id`,
`b1`.`UsuariosDepartamentos`.`sede_id` AS `sede_id`,
`b1`.`UsuariosDepartamentos`.`departamento_id` AS `departamento_id`,
`b1`.`Departamentos`.`nombre` AS `nomdepartamento`,
`b1`.`UsuariosGruposEmpleado`.`grupo_empleados_id` AS `grupo_empleados_id`,
`b1`.`GruposEmpleado`.`nombre` AS `nombre_grupo`,
`b1`.`Sede`.`nombre` AS `nombre_sede`,

ifnull(`b1`.`DatosLaborales`.`salario_base`,'No Asignado') AS `salario_base`,
ifnull(`b1`.`DatosLaborales`.`periodo_salario`,'No Asignado') AS `periodo_salario`,
if(`b1`.`DatosLaborales`.`periodo_salario` = 1,'Quincenal',if(`b1`.`DatosLaborales`.`periodo_salario` = 2,'Mensual','A Termino')) AS `periodo_salario_caracter`,
ifnull(`b1`.`DatosLaborales`.`unidad_sueldo`,'1') AS `unidad_sueldo`,
if(`b1`.`DatosLaborales`.`unidad_sueldo` = 2,'UF','$') AS `unidad_sueldo_caracter`,
ifnull(`b1`.`DatosLaborales`.`dias_descanso`,'6,7') AS `dias_descanso`,
ifnull(`b1`.`DatosLaborales`.`tipo_contrato`,'1') AS `tipo_contrato_id`,
ifnull(`b1`.`DatosLaborales`.`termino_contrato`,'1') AS `termino_contrato`,
ifnull(`b1`.`TerminoContrato`.`descripcion`,'No Asignado') AS `termino_contrato_nombre`,
ifnull(`b1`.`DatosLaborales`.`fecha_inicio`,'No Asignado') AS `fecha_inicio`,
ifnull(if(`b1`.`DatosLaborales`.`fecha_fin` <> '1990-01-01',`b1`.`DatosLaborales`.`fecha_fin`,'No Asignado'),'No Asignado') AS `fecha_fin`,
ifnull(`b1`.`DatosLaborales`.`hora_ingreso`,'08:00') AS `hora_ingreso`,
ifnull(`b1`.`DatosLaborales`.`hora_egreso`,'18:00') AS `hora_egreso`,
ifnull(`b1`.`DatosLaborales`.`modalidad`,'No Asignado') AS `modalidad`,
ifnull(`b1`.`DatosLaborales`.`nivel_estudio_id`,'6') AS `nivel_estudio_id`,
ifnull(`b1`.`NivelEstudio`.`descripcion`,'No Asignado') AS `nivel_estudio`,
ifnull(`b1`.`TiposContrato`.`descripcion`,'No Asignado') AS `tipo_contrato`,
ifnull(`b1`.`DatosLaborales`.`jefatura`,0) AS `jefatura`,
ifnull(`b1`.`DatosLaborales`.`cargo_id`,'No Asignado') AS `cargo_id`,
ifnull(`b1`.`Cargos`.`nombre`,'No Asignado') AS `cargo`,

ifnull(`b1`.`BancariosUser`.`banco_id`,'No Asignado') AS `banco_id`,
ifnull(`b1`.`BancariosUser`.`numero_cuenta`,'No Asignado') AS `numero_cuenta`,
ifnull(`b1`.`BancariosUser`.`en_uso`,'No Asignado') AS `en_uso`,
ifnull(`b1`.`BancariosUser`.`terceros`,'No Asignado') AS `terceros`,
ifnull(`b1`.`BancariosUser`.`rut_tercero`,'No Asignado') AS `rut_tercero`,
ifnull(`b1`.`BancariosUser`.`nombre_tercero`,'No Asignado') AS `nombre_tercero`,
ifnull(`b1`.`BancariosUser`.`email_tercero`,'No Asignado') AS `email_tercero`,
'0' AS `vacaciones_acumuladas`,`b1`.`Sexo`.`descripcion` AS `sexo`,
ifnull(`b1`.`Bancos`.`nombre`,'No Asignado') AS `nombre_banco`,
ifnull(`b1`.`DatosPago`.`medio`,'No Asignado') AS `medio_pago`,
ifnull(`b1`.`MedioPagos`.`tipo`,'No Asigado') AS `medio_pago_nombre`,
ifnull(`b1`.`DatosPago`.`tipo_cuenta`,'No Asignado') AS `tipo_cuenta`,
ifnull(`b1`.`TiposCuentasBancos`.`tipo`,'No Asignado') AS `tipo_cuenta_nombre`,

ifnull(`b1`.`UsuariosAFP`.`jubilado_afp`,'No asignado') AS `jubilado_afp`,
ifnull(`b1`.`UsuariosAFP`.`afp_id`,'No Asignado') AS `afp_id`,
ifnull(`b1`.`UsuariosAFP`.`ahorro_afp2`,0) AS `ahorro_afp2`,

ifnull(`b1`.`APVUsuarios`.`apv_institucion_id`,'No asignado') AS `apv_institucion_id`,
ifnull(`b1`.`APVUsuarios`.`colectivo`,'No asignado') AS `colectivo`,
ifnull(`b1`.`APVUsuarios`.`pago_directo`,'No asignado') AS `pago_directo`,
ifnull(`b1`.`APVUsuarios`.`monto_pacto`,'No asignado') AS `monto_pacto`,
ifnull(`b1`.`APVUsuarios`.`unidad_pacto_id`,'No asignado') AS `unidad_pacto_id`,
ifnull(`b1`.`APVUsuarios`.`activo`,'No asignado') AS `apv_activo`,
ifnull(`b1`.`APVUsuarios`.`nconvenio`,'No asignado') AS `nconvenio`,
ifnull(`b1`.`APVUsuarios`.`regimen`,'No asignado') AS `regimen`,

ifnull(`b1`.`UsuariosPrevisionSalud`.`prevision_salud_id`,'No asignado') AS `prevision_salud_id`,
ifnull(`b1`.`PrevisionSalud`.`nombre`,'No asignado') AS `nombre_prevision_salud`,
ifnull(`b1`.`UsuariosPrevisionSalud`.`pactado`,'No asignado') AS `pactado`,
ifnull(`b1`.`UsuariosPrevisionSalud`.`gratificacion`,'No asignado') AS `gratificacion`,
ifnull(`b1`.`UsuariosPrevisionSalud`.`afiliado_afc`,'No asignado') AS `afiliado_afc`,
ifnull(`b1`.`UsuariosPrevisionSalud`.`antiguedad_afc`,'No asignado') AS `antiguedad_afc`,
ifnull(`b1`.`UsuariosPrevisionSalud`.`vejez`,'No asignado') AS `vejez`,
ifnull(`b1`.`UsuariosPrevisionSalud`.`invalidez`,'No asignado') AS `invalidez`,
ifnull(`b1`.`UsuariosPrevisionSalud`.`exinp`,'No asignado') AS `exinp`,

ifnull(`b1`.`FotosUsuarios`.`url`,'') AS `foto` 

from ((((((((((((((((((((((((((((`b1`.`Usuario` 
left join `b1`.`Contacto` on(`b1`.`Usuario`.`id` = `b1`.`Contacto`.`user_id`)) 
left join `b1`.`Ubicacion` 
	on(`b1`.`Usuario`.`id` = `b1`.`Ubicacion`.`user_id`)) 
left join `b1`.`Regiones` 
	on(`b1`.`Ubicacion`.`region_id` = `b1`.`Regiones`.`id`)) 
left join `b1`.`Comunas` 
	on(`b1`.`Ubicacion`.`comuna_id` = `b1`.`Comunas`.`id` and `b1`.`Ubicacion`.`region_id` = `b1`.`Comunas`.`region_id`)) 
left join `b1`.`UsuariosDepartamentos` 
	on(`b1`.`UsuariosDepartamentos`.`user_id` = `b1`.`Usuario`.`id`)) 
left join `b1`.`DatosLaborales` 
	on(`b1`.`Usuario`.`id` = `b1`.`DatosLaborales`.`user_id`)) 
join `b1`.`Departamentos` 
	on(`b1`.`UsuariosDepartamentos`.`departamento_id` = `b1`.`Departamentos`.`id`)) 
join `b1`.`UsuariosGruposEmpleado` 
	on(`b1`.`UsuariosGruposEmpleado`.`user_id` = `b1`.`Usuario`.`id`)) 
join `b1`.`GruposEmpleado` 
	on(`b1`.`GruposEmpleado`.`id` = `b1`.`UsuariosGruposEmpleado`.`grupo_empleados_id`)) 
join `b1`.`Sede` 
	on(`b1`.`Sede`.`id` = `b1`.`UsuariosDepartamentos`.`sede_id`)) 
left join `b1`.`Cargos` 
	on(`b1`.`DatosLaborales`.`cargo_id` = `b1`.`Cargos`.`id`)) 
left join `b1`.`CargosUsuario` 
	on(`b1`.`CargosUsuario`.`cargo_id` = `b1`.`Cargos`.`id` and `b1`.`CargosUsuario`.`user_id` = `b1`.`Usuario`.`id`)) join `b1`.`Nacionalidad` on(`b1`.`Usuario`.`nacionalidad_id` = `b1`.`Nacionalidad`.`id`)) 
left join `b1`.`BancariosUser` 	
	on(`b1`.`BancariosUser`.`user_id` = `b1`.`Usuario`.`id`)) 
join `b1`.`Sexo` 
	on(`b1`.`Sexo`.`id` = `b1`.`Usuario`.`sexo_id`)) 
left join `b1`.`DatosPago` 
	on(`b1`.`DatosPago`.`user_id` = `b1`.`Usuario`.`id`)) 
left join `b1`.`Bancos` 
	on(`b1`.`Bancos`.`id` = `b1`.`BancariosUser`.`banco_id`)) 
left join `b1`.`NivelEstudio` 
	on(`b1`.`NivelEstudio`.`id` = `b1`.`DatosLaborales`.`nivel_estudio_id`)) 
left join `b1`.`TerminoContrato` 
	on(`b1`.`DatosLaborales`.`termino_contrato` = `b1`.`TerminoContrato`.`id`)) 
left join `b1`.`TiposContrato` 
	on(`b1`.`DatosLaborales`.`tipo_contrato` = `b1`.`TiposContrato`.`id`)) 
left join `b1`.`FotosUsuarios` 
	on(`b1`.`FotosUsuarios`.`user_id` = `b1`.`Usuario`.`id`)) 
left join `b1`.`EstadoCivil` 
	on(`b1`.`EstadoCivil`.`id` = `b1`.`Usuario`.`estado_civil_id`)) 
left join `b1`.`UsuariosAFP` 
	on(`b1`.`UsuariosAFP`.`user_id` = `b1`.`Usuario`.`id`)) 
left join `b1`.`APVUsuarios` 
	on(`b1`.`APVUsuarios`.`user_id` = `b1`.`Usuario`.`id`)) 
left join `b1`.`UsuariosPrevisionSalud` 
	on(`b1`.`UsuariosPrevisionSalud`.`user_id` = `b1`.`Usuario`.`id`)) 
left join `b1`.`PrevisionSalud` 
	on(`b1`.`PrevisionSalud`.`id` = `b1`.`UsuariosPrevisionSalud`.`prevision_salud_id`)) 
left join `b1`.`TiposCuentasBancos` 
	on(`b1`.`TiposCuentasBancos`.`id` = `b1`.`DatosPago`.`tipo_cuenta`)) 
left join `b1`.`MedioPagos` 
	on(`b1`.`MedioPagos`.`id` = `b1`.`DatosPago`.`medio`)) 

group by `b1`.`Usuario`.`id`;
