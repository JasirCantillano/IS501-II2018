
/*
1. Mostrar todos los usuarios que no han creado ningún tablero, para dichos usuarios mostrar el
nombre completo y correo, utilizar producto cartesiano con el operador (+).
*/

--51 REGISTRO
SELECT A.NOMBRE || ' ' ||A.APELLIDO AS NOMBRE_COMPLETO, 
        A.CORREO
FROM TBL_USUARIOS A,
    TBL_TABLERO B
WHERE A.CODIGO_USUARIO = B.CODIGO_USUARIO_CREA (+)
AND B.CODIGO_USUARIO_CREA IS NULL;


/*
Mostrar la cantidad de usuarios que se han registrado por cada red social, mostrar inclusive la
cantidad de usuarios que no están registrados con redes sociales.
*/


SELECT *
FROM TBL_USUARIOS;

SELECT * 
FROM TBL_REDES_SOCIALES;
--119 EN FACEBOOK
SELECT NVL(B.NOMBRE_RED_SOCIAL,'SIN RED SOCIAL') AS RED_SOCIAL, 
        COUNT(*) AS CANTIDAD_USUARIOS
FROM TBL_USUARIOS A
LEFT JOIN TBL_REDES_SOCIALES B
ON (A.CODIGO_RED_SOCIAL = B.CODIGO_RED_SOCIAL)
GROUP BY NVL(B.NOMBRE_RED_SOCIAL,'SIN RED SOCIAL');

/*
3. Consultar el usuario que ha hecho más comentarios sobre una tarjeta (El más prepotente), para
este usuario mostrar el nombre completo, correo, cantidad de comentarios y cantidad de
tarjetas a las que ha comentado (pista: una posible solución para este último campo es utilizar
count(distinct campo))

*/

SELECT A.CODIGO_USUARIO, A.NOMBRE, A.APELLIDO, COUNT(*) cantidad_comentarios
FROM TBL_USUARIOS  A
INNER JOIN TBL_COMENTARIOS B
ON A.CODIGO_USUARIO = B.CODIGO_USUARIO
GROUP BY A.CODIGO_USUARIO, A.NOMBRE, A.APELLIDO
having count(*) = (
                    SELECT max(cantidad_comentarios)
                    FROM (
                        SELECT codigo_usuario,count(*) as cantidad_comentarios
                        FROM TBL_COMENTARIOS
                        group by codigo_usuario
                    )
                )
ORDER BY CODIGO_USUARIO;

/*
Mostrar TODOS los usuarios con plan FREE, de dichos usuarios mostrar la siguiente información:
• Nombre completo
• Correo
• Red social (En caso de estar registrado con una)
• Cantidad de organizaciones que ha creado, mostrar 0 si no ha creado ninguna.
*/

SELECT A.CODIGO_USUARIO, nombre || ' '|| apellido as nombre_completo,
        correo,
        NVL(b.NOMBRE_RED_SOCIAL, 'Ninguna') NOMBRE_RED_SOCIAL,
        --C.CODIGO_ORGANIZACION
        COUNT(C.CODIGO_ORGANIZACION) CANTIDAD_ORGANIZACIONES
FROM TBL_USUARIOS a
LEFT JOIN TBL_REDES_SOCIALES b
ON (a.CODIGO_RED_SOCIAL = b.CODIGO_RED_SOCIAL)
LEFT JOIN TBL_ORGANIZACIONES C
ON (a.CODIGO_USUARIO = C.CODIGO_ADMINISTRADOR)
WHERE codigo_plan = 1
GROUP BY A.CODIGO_USUARIO,nombre || ' '|| apellido,
        correo,
        NVL(b.NOMBRE_RED_SOCIAL, 'Ninguna')
ORDER BY A.CODIGO_USUARIO;

SELECT CODIGO_ADMINISTRADOR, COUNT(*) CANTIDAD_ORGANIZACIONES
FROM TBL_ORGANIZACIONES
GROUP BY CODIGO_ADMINISTRADOR
ORDER BY CODIGO_ADMINISTRADOR;


/*
Mostrar los usuarios que han creado más de 5 tarjetas, para estos usuarios mostrar:
Nombre completo, correo, cantidad de tarjetas creadas
*/


SELECT  B.CODIGO_USUARIO,B.NOMBRE||' '||B.APELLIDO AS NOMBRE_COMPLETO,
        B.CORREO,
        COUNT(*) CANTIDAD_TARJETAS
FROM TBL_TARJETAS A
INNER JOIN TBL_USUARIOS B
ON (A.CODIGO_USUARIO = B.CODIGO_USUARIO)
GROUP BY B.CODIGO_USUARIO,B.NOMBRE||' '||B.APELLIDO,
        B.CORREO
HAVING COUNT(*)>5
ORDER BY B.CODIGO_USUARIO;


/*
6. Un usuario puede estar suscrito a tableros, listas y tarjetas, de tal forma que si hay algún cambio
se le notifica en su teléfono o por teléfono, sabiendo esto, se necesita mostrar los nombres de
todos los usuarios con la cantidad de suscripciones de cada tipo, en la consulta se debe mostrar:
• Nombre completo del usuario
• Cantidad de tableros a los cuales está suscrito
• Cantidad de listas a las cuales está suscrito
• Cantidad de tarjetas a las cuales está suscrito



*/

SELECT *
FROM TBL_SUSCRIPCIONES;

SELECT  B.codigo_usuario, 
        B.NOMBRE ||' '||B.APELLIDO AS NOMBRE,
        count(codigo_lista) as cantidad_listas, 
        count(codigo_tablero) as cantidad_tableros, 
        count(codigo_tarjeta) as cantidad_tarjetas
FROM TBL_SUSCRIPCIONES A
INNER JOIN TBL_USUARIOS B
ON (A.CODIGO_USUARIO = B.CODIGO_USUARIO)
group by B.codigo_usuario,
        B.NOMBRE ||' '||B.APELLIDO;
        
/*
Consultar todas las organizaciones con los siguientes datos:
• Nombre de la organización
• Cantidad de usuarios registrados en cada organización
• Cantidad de Tableros por cada organización
• Cantidad de Listas asociadas a cada organización
• Cantidad de Tarjetas asociadas a cada organización 
*/
--ong: 4	uSUARIOS: 2
--Cantidad de usuarios por organizacion
SELECT  CODIGO_ORGANIZACION, 
        COUNT(*) CANTIDAD_USUARIOS
FROM TBL_USUARIOS_X_ORGANIZACION
 GROUP BY CODIGO_ORGANIZACION
 ORDER BY CODIGO_ORGANIZACION;
 
--ong:4 tABLEROS:2
--Cantidad de tableros por organizacion
SELECT CODIGO_ORGANIZACION, COUNT(*) CANTIDAD_TABLEROS
FROM TBL_TABLERO
GROUP BY CODIGO_ORGANIZACION
ORDER BY CODIGO_ORGANIZACION;

--Cantidad de listas por organizacion
SELECT B.CODIGO_ORGANIZACION, COUNT(*) CANTIDAD_LISTAS
FROM TBL_LISTAS A
INNER JOIN TBL_TABLERO B
ON A.CODIGO_tABLERO = B.CODIGO_TABLERO
GROUP BY B.CODIGO_ORGANIZACION;


--Cantidad de TARJETAS por organizacion
SELECT C.CODIGO_ORGANIZACION, COUNT(*) CANTIDAD_TARJETAS
FROM TBL_TARJETAS A
INNER JOIN TBL_LISTAS B
ON (A.CODIGO_LISTA = B.CODIGO_LISTA)
INNER JOIN TBL_TABLERO C
ON (B.CODIGO_tABLERO = C.CODIGO_TABLERO)
GROUP BY C.CODIGO_ORGANIZACION
ORDER BY C.CODIGO_ORGANIZACION;
