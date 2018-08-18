/*Crear una consulta para que muestre 3 niveles de categorías, mostrar para cada nivel el código y
el nombre de la categoría, utilizar producto cartesiano con el operador (+).*/

SELECT *
FROM TBL_CATEGORIAS;

--Categoria 2>-Categoria3->Categoria9


select  A.CODIGO_CATEGORIA, 
        A.NOMBRE, 
        B.NOMBRE AS NOMBRE_CATEGORIA_PADRE,
        C.NOMBRE AS NOMBRE_CATEGORIA_ABUELA
FROM    TBL_CATEGORIAS A,
        TBL_CATEGORIAS B,
        TBL_CATEGORIAS C
WHERE   A.CODIGO_CATEGORIA_PADRE = B.CODIGO_CATEGORIA(+)
AND     B.CODIGO_CATEGORIA_PADRE = C.CODIGO_CATEGORIA(+);