
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

