CREATE VIEW glpi_plugin_depreciacion_vista_activos as
SELECT  i.id,i.itemtype,c.name,i.bill ,i.buy_date,i.value ,i.sink_time,l.id id_ubicacion,l.locations_id, l.completename ubicacion, 
u.name user,i.date_creation,null cuenta_depreciacion ,null cuenta_gasto,null familia
         from glpi_infocoms i 
         LEFT join glpi_computers c                       /* COMPUTADORAS*/
         on i.items_id = c.id             
         left join glpi_locations l 
         on c.locations_id = l.id 
         LEFT JOIN glpi_users u 
         on c.users_id = u.id
         where i.itemtype='computer' AND i.value >= 1000  AND i.sink_time >=3 
union all 
SELECT DISTINCT i.id,i.itemtype,m.name ,i.bill,i.buy_date ,i.value, i.sink_time,l.id id_ubicacion,l.locations_id, l.completename ubicacion, u.name user,
        i.date_creation,null cuenta_depreciacion ,null cuenta_gasto ,null familia
        from glpi_infocoms i 
        LEFT join glpi_monitors m
        on i.items_id = m.id                           /* MONITOR */
        LEFT join glpi_locations l 
        on m.locations_id = l.id   
        LEFT join glpi_users u
        on m.users_id = u.id 
        where i.itemtype='monitor' AND i.value >= 1000  AND i.sink_time >= 3    
 UNION ALL
SELECT DISTINCT i.id,i.itemtype,p.name ,i.bill,i.buy_date ,i.value,i.sink_time,l.id id_ubicacion,l.locations_id,l.completename ubicacion, 
         u.name user,i.date_creation,null cuenta_depreciacion ,null cuenta_gasto,null familia
        from glpi_infocoms i 
        LEFT join glpi_printers p
        on i.items_id = p.id    
        LEFT join glpi_locations l                       /* IMPRESORAS*/
        on p.locations_id = l.id  
        LEFT join glpi_users u
        on p.users_id = u.id 
        where i.itemtype='printer' AND i.value >= 1000  AND i.sink_time >=3 
Union all
SELECT DISTINCT i.id,i.itemtype,ct.name ,i.bill,i.buy_date ,i.value,         
        i.sink_time,l.id id_ubicacion,l.locations_id,l.completename , null,i.date_creation,null cuenta_depreciacion,
        null cuenta_gasto,null familia
        from glpi_infocoms i 
        LEFT join glpi_cartridgeitems ct
        on i.items_id = ct.id                           /* CARTUCHOS  */
        LEFT join glpi_locations l 
        on ct.locations_id = l.id   
        /*  LEFT join glpi_users u     --- NO TIENE USUARIO_ID SINO TECNICO_ID ---
        on ct.users_id = u.id */
        where i.itemtype='glpi_cartridgeitem'  AND i.value >= 1000  AND i.sink_time >=3 
UNION ALL 
SELECT DISTINCT i.id,i.itemtype,ne.name ,i.bill,i.buy_date ,i.value,i.sink_time,l.id id_ubicacion,l.locations_id,l.completename ubicacion, 
u.name user,   i.date_creation,null cuenta_depreciacion ,null cuenta_gasto,null familia
         from glpi_infocoms i 
         LEFT join glpi_networkequipments ne
         on i.items_id = ne.id                           /* EQUIPO DE REDES */
         LEFT join glpi_locations l 
         on ne.locations_id = l.id   
         LEFT join glpi_users u
         on ne.users_id = u.id 
         where i.itemtype='networkequipment' AND i.value >= 1000  AND i.sink_time >=3
         union all
SELECT DISTINCT i.id,i.itemtype,pe.name ,i.bill,i.buy_date ,i.value, i.sink_time,l.id id_ubicacion,l.locations_id,l.completename ubicacion, u.name user,i.date_creation,null cuenta_depreciacion,
         null cuenta_gasto,null familia
         from glpi_infocoms i 
         LEFT join glpi_peripherals pe
         on i.items_id = pe.id                           /* DISPOSITIVOS*/
         LEFT join glpi_locations l 
         on pe.locations_id = l.id   
         LEFT join glpi_users u
         on pe.users_id = u.id 
         where i.itemtype='peripheral'   AND i.value >= 1000  AND i.sink_time >= 3 
  UNION ALL    
SELECT DISTINCT i.id,i.itemtype,r.name ,i.bill,i.buy_date ,i.value, i.sink_time,l.id id_ubicacion,l.locations_id,
   l.completename ubicacion, null,i.date_creation ,null cuenta_depreciacion,
     null cuenta_gasto,null familia
         from glpi_infocoms i 
         LEFT join glpi_racks r
         on i.items_id = r.id                           /* RACK */
         LEFT join glpi_locations l 
         on r.locations_id = l.id   
       /*  LEFT join glpi_users u      --- NO TIENE USUARIO_ID SINO TECNICO_ID ---
        on r.users_id = u.id  */       
         where i.itemtype='rack' AND i.value >= 1000  AND i.sink_time >=3 
 UNION ALL          
SELECT DISTINCT i.id,i.itemtype,pdu.name ,i.bill,i.buy_date ,i.value,i.sink_time,l.id id_ubicacion,l.locations_id,l.completename ubicacion,
null,i.date_creation,null cuenta_depreciacion,null cuenta_gasto,null familia
         from glpi_infocoms i 
         LEFT join glpi_pdus pdu
         on i.items_id = pdu.id                           /* PDU´S */
         LEFT join glpi_locations l 
         on pdu.locations_id = l.id   
         /*  LEFT join glpi_users u  NO TIENE USUARIO_ID SINO TECNICO_ID 
         on r.users_id = u.id  */ 
         where i.itemtype='pdu' AND i.value >= 1000  AND i.sink_time >=3 
 UNION ALL                    
SELECT DISTINCT i.id,i.itemtype,ph.name ,i.bill,i.buy_date ,i.value,i.sink_time,l.id id_ubicacion,l.locations_id,l.completename , u.name user,i.date_creation ,   
null cuenta_depreciacion,  null cuenta_gasto,null familia
         from glpi_infocoms i 
         LEFT join glpi_phones ph
         on i.items_id = ph.id                           /* TELEFONOS */
         LEFT join glpi_locations l 
         on ph.locations_id = l.id   
         LEFT join glpi_users u
         on ph.users_id = u.id 
         where i.itemtype='phone'  AND i.value >= 1000  AND i.sink_time >=3 
  union all 
   SELECT  i.id,i.itemtype,c.name,i.bill ,i.buy_date,i.value ,i.sink_time,l.id id_ubicacion,l.locations_id, l.completename ubicacion, 
 null user ,i.date_creation,null cuenta_depreciacion ,null cuenta_gasto,null familia
         from glpi_infocoms i 
         LEFT join glpi_consumableitems c                       /* CONSUMIBLES */
         on i.items_id = c.id             
         left join glpi_locations l 
         on c.locations_id = l.id 
        -- LEFT JOIN glpi_users u 
        -- on c.users_id = u.id
         where i.itemtype='ConsumableItem' AND i.value >= 1000  AND i.sink_time >=3
  UNION ALL                                      
 SELECT i.id,i.itemtype,s.name ,i.bill,i.buy_date ,i.value,i.sink_time,l.id id_ubicacion,l.locations_id,l.completename ubicacion,
 u.name user,i.date_creation, null cuenta_depreciacion ,null cuenta_gasto,null familia
         from glpi_infocoms i 
         LEFT join glpi_softwares s 
         on i.items_id = s.id                                 /*  SOFTWARE */
         left join glpi_locations l 
         on s.locations_id = l.id  
         LEFT join glpi_users u
         on s.users_id = u.id 
         where i.itemtype='software' AND i.value >= 1000  AND i.sink_time >= 3
UNION ALL  
SELECT DISTINCT i.id,tg.name tipo , pgm.name ,i.bill,i.buy_date ,i.value,i.sink_time,l.id id_ubicacion,l.locations_id,l.completename ubicacion, u.name user,i.date_creation , fam.cuenta_depreciacion , fam.cuenta_gasto,fam.id familia
         from glpi_infocoms i 
         LEFT join glpi_plugin_genericobject_mesas pgm  -- CAMBIAR EL NOMBRE POR LA DE PRODUCCION -- 
         on i.items_id = pgm.id    
         LEFT join glpi_locations l                  /* MESA  *FAMILIA MOBILIARIA*/
         on pgm.locations_id = l.id                    
         LEFT join glpi_users u
         on pgm.users_id = u.id 
         left join glpi_plugin_genericobject_types tg
         on i.itemtype = tg.itemtype
         left join glpi_plugin_genericobject_typefamilies fam
         on tg.plugin_genericobject_typefamilies_id = fam.id
         where i.itemtype='PluginGenericobjectMesa'   AND i.value >= 1000  AND i.sink_time >=3
UNION ALL  
 SELECT DISTINCT i.id,tg.name tipo,pge.name ,i.bill,i.buy_date ,i.value,i.sink_time,l.id id_ubicacion,l.locations_id,l.completename ubicacion,u.name user,i.date_creation,fam.cuenta_depreciacion , fam.cuenta_gasto,fam.id familia
         from glpi_infocoms i 
         LEFT join glpi_plugin_genericobject_escritorios pge  -- CAMBIAR EL NOMBRE POR LA DE PRODUCCION -- 
         on i.items_id = pge.id    
         LEFT join glpi_locations l                  /* ESCRITORIO  *FAMILIA MOBILIARIA**/
         on pge.locations_id = l.id                    
         LEFT join glpi_users u
         on pge.users_id = u.id 
          left join glpi_plugin_genericobject_types tg
         on i.itemtype = tg.itemtype
         left join glpi_plugin_genericobject_typefamilies fam
         on tg.plugin_genericobject_typefamilies_id = fam.id
         where i.itemtype='PluginGenericobjectEscritorio' 
         AND i.value >= 1000  AND i.sink_time >=3       
Union all 
SELECT DISTINCT i.id,tg.name tipo,pgm.name ,i.bill,i.buy_date ,i.value,i.sink_time,l.id id_ubicacion,l.locations_id,l.completename ubicacion,
         u.name user,i.date_creation,fam.cuenta_depreciacion,fam.cuenta_gasto,fam.id familia
         from glpi_infocoms i 
         LEFT join glpi_plugin_genericobject_airesacondicionados pgm  -- CAMBIAR EL NOMBRE POR LA DE PRODUCCION -- 
         on i.items_id = pgm.id    
         LEFT join glpi_locations l                  /* AIRE ACONDICIONADO  *FAMILIA MOBILIARIA*/
         on pgm.locations_id = l.id                    
         LEFT join glpi_users u
         on pgm.users_id = u.id 
         left join glpi_plugin_genericobject_types tg
         on i.itemtype = tg.itemtype
         left join glpi_plugin_genericobject_typefamilies fam
         on tg.plugin_genericobject_typefamilies_id = fam.id
         where i.itemtype='PluginGenericobjectAiresacondicionado'
         AND i.value >= 1000  AND i.sink_time >=3
UNION ALL 
   SELECT DISTINCT i.id,tg.name tipo,pgm.name ,i.bill,i.buy_date ,i.value,i.sink_time,l.id id_ubicacion,l.locations_id,l.completename ubicacion,
   u.name user,i.date_creation,fam.cuenta_depreciacion, fam.cuenta_gasto,fam.id familia
         from glpi_infocoms i 
         LEFT join glpi_plugin_genericobject_repisas pgm  -- CAMBIAR EL NOMBRE POR LA DE PRODUCCION -- 
         on i.items_id = pgm.id    
         LEFT join glpi_locations l                  /* REPISAS  *FAMILIA MOBILIARIA**  */ 
         on pgm.locations_id = l.id                    
         LEFT join glpi_users u
         on pgm.users_id = u.id 
         left join glpi_plugin_genericobject_types tg
         on i.itemtype = tg.itemtype
         left join glpi_plugin_genericobject_typefamilies fam
         on tg.plugin_genericobject_typefamilies_id = fam.id
         where i.itemtype='PluginGenericobjectRepisa'  AND i.value >= 1000  AND i.sink_time >=3
union all
        SELECT DISTINCT i.id,tg.name tipo,pgm.name ,i.bill,i.buy_date ,i.value,i.sink_time,l.id id_ubicacion,l.locations_id,l.completename ubicacion,u.name user,
        i.date_creation,fam.cuenta_depreciacion,fam.cuenta_gasto,fam.id familia
         from glpi_infocoms i 
         LEFT join glpi_plugin_genericobject_tableros pgm  -- CAMBIAR EL NOMBRE POR LA DE PRODUCCION -- 
         on i.items_id = pgm.id    
         LEFT join glpi_locations l                  /* TABLERO  *FAMILIA MOBILIARIA*/
         on pgm.locations_id = l.id                    
         LEFT join glpi_users u
         on pgm.users_id = u.id 
          left join glpi_plugin_genericobject_types tg
         on i.itemtype = tg.itemtype
         left join glpi_plugin_genericobject_typefamilies fam
         on tg.plugin_genericobject_typefamilies_id = fam.id
         where i.itemtype='PluginGenericobjectTablero' AND i.value >= 1000  AND i.sink_time >=3  
UNION ALL
SELECT DISTINCT i.id,tg.name tipo,pgm.name ,i.bill,i.buy_date ,i.value,i.sink_time,l.id id_ubicacion,l.locations_id,l.completename ubicacion,u.name user,i.date_creation,fam.cuenta_depreciacion,fam.cuenta_gasto,fam.id familia
         from glpi_infocoms i 
         LEFT join glpi_plugin_genericobject_lineablancas pgm  -- CAMBIAR EL NOMBRE POR LA DE PRODUCCION -- 
         on i.items_id = pgm.id    
         LEFT join glpi_locations l                  /* LINEA BLANCA  *FAMILIA MOBILIARIA*/
         on pgm.locations_id = l.id                    
         LEFT join glpi_users u
         on pgm.users_id = u.id 
         left join glpi_plugin_genericobject_types tg
         on i.itemtype = tg.itemtype
         left join glpi_plugin_genericobject_typefamilies fam
         on tg.plugin_genericobject_typefamilies_id = fam.id
         where i.itemtype='PluginGenericobjectLineablanca'   AND i.value >= 1000  AND i.sink_time >=3 
UNION ALL
 SELECT DISTINCT i.id,tg.name tipo,pga.name ,i.bill,i.buy_date ,i.value,i.sink_time,l.id id_ubicacion,l.locations_id,l.completename ubicacion,u.name user,i.date_creation,fam.cuenta_depreciacion,fam.cuenta_gasto,fam.id familia
          from glpi_infocoms i 
          LEFT join glpi_plugin_genericobject_automoviles pga  -- CAMBIAR EL NOMBRE POR LA DE PRODUCCION -- 
          on i.items_id = pga.id    
          LEFT join glpi_locations l                                /* AUTOMOVILES  *FAMILIA EQUIPO RODANTE*/    
          on pga.locations_id = l.id                    
          LEFT join glpi_users u
          on pga.users_id = u.id     
          left join glpi_plugin_genericobject_types tg
          on i.itemtype = tg.itemtype
          left join glpi_plugin_genericobject_typefamilies fam
          on tg.plugin_genericobject_typefamilies_id = fam.id
          where i.itemtype='PluginGenericobjectAutomovile' and  value >= 5000
 union all 
SELECT DISTINCT i.id,tg.name tipo,pged.name ,i.bill,i.buy_date ,i.value,i.sink_time,l.id id_ubicacion,l.locations_id,l.completename ubicacion,u.name  user,i.date_creation,fam.cuenta_depreciacion,fam.cuenta_gasto,fam.id familia
         from glpi_infocoms i 
         LEFT join glpi_plugin_genericobject_edificios pged  -- CAMBIAR EL NOMBRE POR LA DE PRODUCCION -- 
         on i.items_id = pged.id    
         LEFT join glpi_locations l                  /* EDIFICIO *FAMILIA PROPIEDADES*/
         on pged.locations_id = l.id                    
         LEFT join glpi_users u
         on pged.users_id = u.id
         left join glpi_plugin_genericobject_types tg
         on i.itemtype = tg.itemtype
         left join glpi_plugin_genericobject_typefamilies fam
         on tg.plugin_genericobject_typefamilies_id = fam.id
         where i.itemtype='PluginGenericobjectEdificio'  and i.value >= 1000  AND i.sink_time >=3 
UNION ALL 
     SELECT DISTINCT i.id,tg.name tipo,pgls.name ,i.bill,i.buy_date ,i.value,
    i.sink_time,l.id id_ubicacion,l.locations_id,l.completename ubicacion, u.name user,i.date_creation,
    fam.cuenta_depreciacion,fam.cuenta_gasto,fam.id familia
          from glpi_infocoms i 
          LEFT join glpi_plugin_genericobject_impuestos pgls    -- CAMBIAR EL NOMBRE POR LA DE PRODUCCION -- 
          on i.items_id = pgls.id    
          LEFT join glpi_locations l                             /* IMPUESTOS *FAMILIA AMORTIZABLE*/
          on pgls.locations_id = l.id                    
          LEFT join glpi_users u
          on pgls.users_id = u.id 
          left join glpi_plugin_genericobject_types tg
         on i.itemtype = tg.itemtype
         left join glpi_plugin_genericobject_typefamilies fam
         on tg.plugin_genericobject_typefamilies_id = fam.id
         where i.itemtype='PluginGenericobjectImpuesto' 
UNION ALL
SELECT DISTINCT i.id,tg.name tipo,pgs.name ,i.bill,i.buy_date ,i.value,i.sink_time,l.id id_ubicacion,l.locations_id, l.completename ubicacion, u.name user,i.date_creation,
         fam.cuenta_depreciacion,fam.cuenta_gasto,fam.id familia
          from glpi_infocoms i 
          LEFT join glpi_plugin_genericobject_seguros pgs   -- CAMBIAR EL NOMBRE POR LA DE PRODUCCION -- 
          on i.items_id = pgs.id    
          LEFT join glpi_locations l                             /* SEGUROS *FAMILIA AMORTIZABLE*/
          on pgs.locations_id = l.id                    
          LEFT join glpi_users u
          on pgs.users_id = u.id 
          left join glpi_plugin_genericobject_types tg
          on i.itemtype = tg.itemtype
          left join glpi_plugin_genericobject_typefamilies fam
          on tg.plugin_genericobject_typefamilies_id = fam.id
          where i.itemtype='PluginGenericobjectSeguro'
union all
SELECT DISTINCT i.id,tg.name tipo,pgls.name ,i.bill,i.buy_date ,i.value,i.sink_time,l.id id_ubicacion,l.locations_id,l.completename ubicacion, u.name user,
i.date_creation,  fam.cuenta_depreciacion, fam.cuenta_gasto,fam.id familia
          from glpi_infocoms i 
          LEFT join glpi_plugin_genericobject_contratos pgls    -- CAMBIAR EL NOMBRE POR LA DE PRODUCCION -- 
          on i.items_id = pgls.id    
          LEFT join glpi_locations l                             /* CONTRATOS *FAMILIA AMORTIZABLE  */
          on pgls.locations_id = l.id                    
          LEFT join glpi_users u
          on pgls.users_id = u.id 
          left join glpi_plugin_genericobject_types tg
          on i.itemtype = tg.itemtype
          left join glpi_plugin_genericobject_typefamilies fam
          on tg.plugin_genericobject_typefamilies_id = fam.id
          where i.itemtype='PluginGenericobjectContrato'
          union all 
 SELECT DISTINCT i.id,tg.name tipo,pgls.name ,i.bill,i.buy_date ,i.value,i.sink_time,l.id id_ubicacion,l.locations_id,l.completename ubicacion,u.name user,
 i.date_creation,fam.cuenta_depreciacion,fam.cuenta_gasto,fam.id familia
          from glpi_infocoms i 
          LEFT join glpi_plugin_genericobject_fianzas pgls    -- CAMBIAR EL NOMBRE POR LA DE PRODUCCION -- 
          on i.items_id = pgls.id    
          LEFT join glpi_locations l                             /* FIANZAS *FAMILIA AMORTIZABLE  */
          on pgls.locations_id = l.id                    
          LEFT join glpi_users u
          on pgls.users_id = u.id 
          left join glpi_plugin_genericobject_types tg
          on i.itemtype = tg.itemtype
          left join glpi_plugin_genericobject_typefamilies fam
          on tg.plugin_genericobject_typefamilies_id = fam.id 
          where i.itemtype='PluginGenericobjectFianza'
union all
SELECT DISTINCT i.id,tg.name tipo,pgls.name ,i.bill,i.buy_date ,i.value,
    i.sink_time,l.id id_ubicacion,l.locations_id,l.completename ubicacion, u.name user,
    i.date_creation,fam.cuenta_depreciacion, fam.cuenta_gasto,fam.id familia
          from glpi_infocoms i 
          LEFT join glpi_plugin_genericobject_leasings pgls    -- CAMBIAR EL NOMBRE POR LA DE PRODUCCION -- 
          on i.items_id = pgls.id    
          LEFT join glpi_locations l                             /* LEASINGS *FAMILIA AMORTIZABLE  */
          on pgls.locations_id = l.id                    
          LEFT join glpi_users u
          on pgls.users_id = u.id 
          left join glpi_plugin_genericobject_types tg
          on i.itemtype = tg.itemtype
          left join glpi_plugin_genericobject_typefamilies fam
          on tg.plugin_genericobject_typefamilies_id = fam.id 
          where i.itemtype='PluginGenericobjectLeasing' 
 	union all 
SELECT DISTINCT i.id,tg.name tipo,pgls.name ,i.bill,i.buy_date ,i.value,
    i.sink_time,l.id id_ubicacion,l.locations_id,l.completename ubicacion, u.name user,
    i.date_creation,fam.cuenta_depreciacion, fam.cuenta_gasto,fam.id familia
          from glpi_infocoms i 
          LEFT join glpi_plugin_genericobject_mejoras pgls    -- CAMBIAR EL NOMBRE POR LA DE PRODUCCION -- 
          on i.items_id = pgls.id    
          LEFT join glpi_locations l                             /* MEJORA *FAMILIA AMORTIZABLE  */
          on pgls.locations_id = l.id                    
          LEFT join glpi_users u
          on pgls.users_id = u.id 
          left join glpi_plugin_genericobject_types tg
          on i.itemtype = tg.itemtype
          left join glpi_plugin_genericobject_typefamilies fam
          on tg.plugin_genericobject_typefamilies_id = fam.id 
          where i.itemtype='PluginGenericobjectMejora'
union all 
SELECT DISTINCT i.id,tg.name tipo,pgls.name ,i.bill,i.buy_date ,i.value,
    i.sink_time,l.id id_ubicacion,l.locations_id,l.completename ubicacion, u.name user,
    i.date_creation,fam.cuenta_depreciacion, fam.cuenta_gasto,fam.id familia
          from glpi_infocoms i 
          LEFT join glpi_plugin_genericobject_licencias pgls    -- CAMBIAR EL NOMBRE POR LA DE PRODUCCION -- 
          on i.items_id = pgls.id    
          LEFT join glpi_locations l                             /* LICENCIA *FAMILIA AMORTIZABLE  */
          on pgls.locations_id = l.id                    
          LEFT join glpi_users u
          on pgls.users_id = u.id 
          left join glpi_plugin_genericobject_types tg
          on i.itemtype = tg.itemtype
          left join glpi_plugin_genericobject_typefamilies fam
          on tg.plugin_genericobject_typefamilies_id = fam.id 
          where i.itemtype='PluginGenericobjectLicencia'
 union all 
SELECT DISTINCT i.id,tg.name tipo,pgls.name ,i.bill,i.buy_date ,i.value,
    i.sink_time,l.id id_ubicacion,l.locations_id,l.completename ubicacion, u.name user,
    i.date_creation,fam.cuenta_depreciacion, fam.cuenta_gasto,fam.id familia
          from glpi_infocoms i 
          LEFT join glpi_plugin_genericobject_otrogastos pgls    -- CAMBIAR EL NOMBRE POR LA DE PRODUCCION -- 
          on i.items_id = pgls.id    
          LEFT join glpi_locations l                             /* OTRO GASTO *FAMILIA AMORTIZABLE  */
          on pgls.locations_id = l.id                    
          LEFT join glpi_users u
          on pgls.users_id = u.id 
          left join glpi_plugin_genericobject_types tg
          on i.itemtype = tg.itemtype
          left join glpi_plugin_genericobject_typefamilies fam
          on tg.plugin_genericobject_typefamilies_id = fam.id 
          where i.itemtype='PluginGenericobjectOtrogasto'
union all
SELECT DISTINCT i.id,tg.name tipo,pgls.name ,i.bill,i.buy_date ,i.value,
    i.sink_time,l.id id_ubicacion,l.locations_id,l.completename ubicacion, u.name user,
    i.date_creation,fam.cuenta_depreciacion, fam.cuenta_gasto,fam.id familia
          from glpi_infocoms i 
          LEFT join glpi_plugin_genericobject_wacoms pgls    -- CAMBIAR EL NOMBRE POR LA DE PRODUCCION -- 
          on i.items_id = pgls.id    
          LEFT join glpi_locations l                             /* WACOM *FAMILIA WACOM  */
          on pgls.locations_id = l.id                    
          LEFT join glpi_users u
          on pgls.users_id = u.id 
          left join glpi_plugin_genericobject_types tg
          on i.itemtype = tg.itemtype
          left join glpi_plugin_genericobject_typefamilies fam
          on tg.plugin_genericobject_typefamilies_id = fam.id 
          where i.itemtype='PluginGenericobjectWacom'
