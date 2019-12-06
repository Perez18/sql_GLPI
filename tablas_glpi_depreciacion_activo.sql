CREATE TABLE `glpi_plugin_depreciacion_activos` (
  `id` int(11) NOT NULL,
  `tipo` varchar(20) DEFAULT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `no_factura` varchar(100) DEFAULT NULL,
  `fecha_compra` varchar(20) DEFAULT NULL,
  `valor` decimal(12,2) DEFAULT NULL,
  `vida_util` varchar(50) DEFAULT NULL,
  `ubicacion` varchar(100) DEFAULT NULL,
  `no_cia` varchar(50) DEFAULT NULL,
  `no_centro` varchar(50) DEFAULT NULL,
  `usuario` varchar(20) DEFAULT NULL,
  `fecha_registro` varchar(20) DEFAULT NULL,
  `comentario` varchar(50) DEFAULT NULL,
  `depreciacion_acumulada` decimal(20,2) DEFAULT NULL,
  `valor_real` decimal(20,2) DEFAULT NULL,
  `tiempo_uso` varchar(100) DEFAULT NULL,
  `dep_mensual` decimal(20,2) DEFAULT NULL,
  `ano` int(12) DEFAULT NULL,
  `mes` int(12) DEFAULT NULL,
  `dias_transcurrido` int(12) DEFAULT NULL,
  `cuenta_depreciacion` varchar(15) DEFAULT NULL,
  `cuenta_gasto` varchar(15) DEFAULT NULL,
  `cia_master` varchar(15) DEFAULT NULL,
  `familia` int(11) DEFAULT NULL,
  `estado` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `glpi_plugin_depreciacion_activos_ano_idx` (`ano`,`mes`,`tipo`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `glpi_plugin_depreciacion_bitacora` (
  `id_activo` varchar(50) NOT NULL,
  `activos` varchar(255) DEFAULT NULL,
  `id_localizacion` varchar(50) DEFAULT NULL,
  `nombre_ubicacion` varchar(100) DEFAULT NULL,
  `id_centro_costo` varchar(100) DEFAULT NULL,
  `no_cia` varchar(50) DEFAULT NULL,
  `no_centro_costo` varchar(50) DEFAULT NULL,
  `cia_master` varchar(50) DEFAULT NULL,
  `fecha_creacion` varchar(50) DEFAULT NULL,
  `comentario` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_activo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `glpi_plugin_depreciacion_control` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `proceso` varchar(20) DEFAULT NULL,
  `ano` varchar(20) DEFAULT NULL,
  `mes` varchar(10) DEFAULT NULL,
  `dia` varchar(10) DEFAULT NULL,
  `estado` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `glpi_plugin_depreciacion_control_un` (`ano`,`mes`)
) ENGINE=InnoDB AUTO_INCREMENT=297 DEFAULT CHARSET=latin1;


CREATE TABLE `glpi_plugin_depreciacion_historica` (
  `id` int(11) NOT NULL,
  `ano` int(11) NOT NULL,
  `mes` int(11) NOT NULL,
  `dep_mensual` decimal(20,2) DEFAULT NULL,
  `dep_acumulada` decimal(20,2) DEFAULT NULL,
  `valor_neto` decimal(20,2) DEFAULT NULL,
  `observaciones` varchar(100) DEFAULT NULL,
  `dias_transcurrido` int(11) DEFAULT NULL,
  `no_docu` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`,`ano`,`mes`),
  UNIQUE KEY `glpi_historico_un` (`id`,`ano`,`mes`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `glpi_plugin_depreciacion_localizacion` (
  `id_compania` int(11) NOT NULL,
  `id_centro_costo` int(11) DEFAULT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `no_cia` varchar(10) DEFAULT NULL,
  `no_centro_costo` varchar(10) DEFAULT NULL,
  `cia_master` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id_compania`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
