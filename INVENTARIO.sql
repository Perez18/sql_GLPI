CREATE TABLE "INVENTARIO"."GLPI_ACTIVOS" 
   (	"ID_ITEMS" NUMBER(12,0) NOT NULL ENABLE, 
	"TIPO" VARCHAR2(100), 
	"NOMBRE_EQUIPO" VARCHAR2(255), 
	"FECHA_COMPRA" VARCHAR2(100), 
	"VALOR" NUMBER(12,2) NOT NULL ENABLE, 
	"VIDA_UTIL" VARCHAR2(50), 
	"UBICACION" VARCHAR2(100), 
	"COD_UBICACION" VARCHAR2(10), 
	"CENTRO_COSTO" VARCHAR2(100), 
	"USUARIO" VARCHAR2(100), 
	"CLASIFICACION" VARCHAR2(100), 
	"CUENTA_DEPRECIACION" VARCHAR2(15), 
	"CUENTA_GASTO" VARCHAR2(15), 
	"CIA_MASTER" VARCHAR2(10), 
	"FECHA_REGISTRO" DATE, 
	 CONSTRAINT "GLPI_ACTIVOS_PK" PRIMARY KEY ("ID_ITEMS")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "TSUMI_DAT"  ENABLE
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "TSUMI_DAT";

CREATE TABLE "INVENTARIO"."GLPI_DEPRECIACION" 
   (	"ID" NUMBER(12,0), 
	"ANO_DEPRECIACION" NUMBER(12,0), 
	"MES_DEPRECIACION" NUMBER(12,0), 
	"DEPRECIACION_MENSUAL" NUMBER(12,2), 
	"DEPRECIACION_ACUMULADA" NUMBER(12,2), 
	"VALOR_NETO" NUMBER(12,2), 
	"NO_DOCU" VARCHAR2(20), 
	"ESTADO" VARCHAR2(10), 
	 CONSTRAINT "GLPI_DEPRECIACION_UN" UNIQUE ("ID", "ANO_DEPRECIACION", "MES_DEPRECIACION")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "TSUMI_DAT"  ENABLE
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "TSUMI_DAT";

---------

CREATE OR REPLACE PROCEDURE INVENTARIO.GLPI_ASIENTO(ano NUMBER , mes NUMBER) IS

n_asiento  VARCHAR2(6);
n_linea NUMBER(5);

 CURSOR MAESTRO
  IS 
    SELECT  A.COD_UBICACION NO_CIA,D.ANO_DEPRECIACION ano ,D.MES_DEPRECIACION mes,
    A.CLASIFICACION DESC1,SUM(VALOR_NETO) T_DEBITO, SUM(VALOR_NETO) T_CREDITO, D.ESTADO
    FROM GLPI_DEPRECIACION D  , GLPI_ACTIVOS A                -- declaracion de curso 
    WHERE  D.ID = A.ID_ITEMS
    AND MES_DEPRECIACION = mes 
    AND ANO_DEPRECIACION= ano 
    AND D.ESTADO IS NULL
    GROUP BY A.COD_UBICACION,D.MES_DEPRECIACION,D.ANO_DEPRECIACION,A.CLASIFICACION,D.ESTADO;
 
CURSOR DETALLE(V_CIA VARCHAR2 , V_CLASIFICACION VARCHAR2) -- V_CIA SE UTILIZA EN EL VARIABLE FOR PARA REALIZAR UN MISMO INSERT DEL MISMO DATOS EN LAS DOS TABLA
   IS 
      SELECT A.COD_UBICACION NO_CIA,D.ANO_DEPRECIACION ANO,D.MES_DEPRECIACION MES,A.UBICACION DESCRI,
      SUM(D.VALOR_NETO) MONTO, A.CENTRO_COSTO CENTRO, D.NO_DOCU NO_DOCU,A.CUENTA_DEPRECIACION,A.CUENTA_GASTO,A.CIA_MASTER
      FROM GLPI_DEPRECIACION D,GLPI_ACTIVOS A
      WHERE   D.ID = A.ID_ITEMS
      AND MES_DEPRECIACION = mes 
      AND  ANO_DEPRECIACION = ano 
      AND A.COD_UBICACION=V_CIA 
      AND A.CLASIFICACION = V_CLASIFICACION
      AND D.ESTADO IS NULL
      GROUP BY A.CENTRO_COSTO,A.UBICACION,A.COD_UBICACION,D.ANO_DEPRECIACION,D.MES_DEPRECIACION,D.NO_DOCU,A.CUENTA_DEPRECIACION,A.CUENTA_GASTO,A.CIA_MASTER;
   
  BEGIN   
FOR p_i IN MAESTRO LOOP

  
	    SELECT LPAD(TO_CHAR(NVL(MAX(TO_NUMBER(c.NO_ASIENTO)),0)+1),6,'0')
        INTO   n_asiento
        FROM   CONTABILIDAD.ARCGAE c
        WHERE  c.NO_CIA = p_i.no_cia 
        AND    c.ANO = p_i.ano
        AND    c.MES = p_i.mes;
       
 
     
	   INSERT INTO CONTABILIDAD.ARCGAE(NO_CIA,ANO,MES,NO_ASIENTO,FECHA,DESCRI1,T_DEBITOS,T_CREDITOS, ORIGEN, ESTADO)
	   VALUES(
	   p_i.no_cia,
	   p_i.ano,
	   p_i.mes,
	   n_asiento,
	   SYSDATE,
	   p_i.DESC1,
	   p_i.T_DEBITO,
	   p_i.T_CREDITO,
	   'CG',
	   'A');
	 	

       n_linea := 0;
   	   
 FOR p IN DETALLE (p_i.no_cia,p_i.DESC1) LOOP
 	 n_linea := n_linea + 1;

  
	   INSERT INTO CONTABILIDAD.ARCGAL(NO_CIA,ANO,MES,NO_ASIENTO,NO_LINEA,DESCRI,NIVEL_1,NIVEL_2,NIVEL_3,NIVEL_4,NIVEL_5,NO_DOCU,MONTO,TIPO,FECHA,CENTRO_COSTO,
	   CIA_MASTER)
	   VALUES(
	   p.no_cia,
	   p.ano,
	   p.mes,
	   n_asiento,
	   n_linea,
	   p.DESCRI,
	   substr(p.CUENTA_DEPRECIACION,1,3),
	   substr(p.CUENTA_DEPRECIACION,4,3) ,
	   substr(p.CUENTA_DEPRECIACION,7,3) ,
	   substr(p.CUENTA_DEPRECIACION,10,3),
	   substr(p.CUENTA_DEPRECIACION,13,3),
	   p.no_docu,
	   p.MONTO,
	   'C',
	   SYSDATE,                                         --TIPO C   
	   p.centro,
	   p.cia_master 
	  	   );
	  
	 n_linea := n_linea + 1;

   INSERT INTO CONTABILIDAD.ARCGAL(NO_CIA,ANO,MES,NO_ASIENTO,NO_LINEA,DESCRI,NIVEL_1,NIVEL_2,NIVEL_3,NIVEL_4,NIVEL_5,NO_DOCU,MONTO,TIPO,FECHA,CENTRO_COSTO,
	   CIA_MASTER)
	   VALUES(
	   p.no_cia,
	   p.ano,
	   p.mes,
	   n_asiento,
	   n_linea,
	   p.DESCRI,
	   substr(p.CUENTA_GASTO,1,3),
	   substr(p.CUENTA_GASTO,4,3) ,
	   substr(p.CUENTA_GASTO,7,3) ,
	   substr(p.CUENTA_GASTO,10,3),
	   substr(p.CUENTA_GASTO,13,3),
	   p.no_docu,
	   p.MONTO,
	   'D',
	   SYSDATE,                                         --TIPO D   
	   p.centro,
	   p.cia_master 
	   );
	 
	    
    END LOOP;	  
    --dbms_output.put_line( p_i.no_cia  ||':' || p_i.ano || ':' || ':'||p_i.mes || ':'|| p_i.registro || p_i.DESC1 
      	    --                  ||':' || p_i.T_DEBITO ||':' || p_i.T_CREDITO ); --imprimir 	
      	    
   
END LOOP;

   UPDATE GLPI_DEPRECIACION SET ESTADO='S' WHERE ANO_DEPRECIACION = ano AND MES_DEPRECIACION=mes ;


  --close c1; se cierra el cursor
  COMMIT;
  END GLPI_ASIENTO;

------------------
CREATE OR REPLACE PROCEDURE INVENTARIO.GLPI_INSERTAR_ACTIVOS(P_DATAJSON CLOB)IS
   obj          admin_app.pljson;
  obj_n        admin_app.pljson;
  obj_list     admin_app.pljson_list;
  clob_prueba  clob;
  
 
  bj_valor     admin_app.pljson_value;

 
BEGIN

    obj_list := admin_app.pljson_list();
    obj_list := admin_app.pljson_list(p_datajson);
   
   for j in 1 .. obj_list.count  loop 
   
    BEGIN
	    
     obj    := admin_app.pljson(obj_list.get(j));

  	
  insert into INVENTARIO.GLPI_ACTIVOS(ID_ITEMS,TIPO,NOMBRE_EQUIPO,FECHA_COMPRA,VALOR,VIDA_UTIL,UBICACION,COD_UBICACION,CENTRO_COSTO,USUARIO,CLASIFICACION,CUENTA_DEPRECIACION,CUENTA_GASTO,CIA_MASTER,FECHA_REGISTRO)
         values(obj.json_data(1).num,obj.json_data(2).str,obj.json_data(3).str,obj.json_data(4).str,obj.json_data(5).num,obj.json_data(6).str,obj.json_data(7).str,obj.json_data(8).str, 
         obj.json_data(9).str,obj.json_data(10).str,obj.json_data(11).str,obj.json_data(12).str,obj.json_data(13).str,obj.json_data(14).str,SYSDATE);

     END;
  END loop; 
 
COMMIT;

END GLPI_INSERTAR_ACTIVOS;
---------------------------------
CREATE OR REPLACE PROCEDURE INVENTARIO.GLPI_INSERTAR_DEPRE(P_DATAJSON clob)IS
  obj          admin_app.pljson;
  obj_n        admin_app.pljson;
  obj_list     admin_app.pljson_list;
  clob_prueba  clob;
  ano NUMBER(5) ;
  mes NUMBER(5);

 
  bj_valor     admin_app.pljson_value;


BEGIN
	   obj_list := admin_app.pljson_list();
       obj_list := admin_app.pljson_list(p_datajson);
      
   for j in 1 .. obj_list.count  loop 
   
    BEGIN
	    
     obj    := admin_app.pljson(obj_list.get(j));
    
  INSERT into INVENTARIO.GLPI_DEPRECIACION(ID,ANO_DEPRECIACION,MES_DEPRECIACION,DEPRECIACION_MENSUAL,DEPRECIACION_ACUMULADA,VALOR_NETO,NO_DOCU)
         values(obj.json_data(1).str,obj.json_data(2).num,obj.json_data(3).num,obj.json_data(4).num,obj.json_data(5).num,obj.json_data(6).num,obj.json_data(7).str);
                
        
     
     END;
  END loop; 

 
 COMMIT;
 

END GLPI_INSERTAR_DEPRE;
----------------------------------------

