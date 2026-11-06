-- Contrôle : quels genres et types de média ont un prix unitaire supérieur à 0,99 ?
SELECT
    il.UnitPrice  AS prix_unitaire,
    mt.Name       AS type_media,
    g.Name        AS genre,
    SUM(il.Quantity) AS morceaux
FROM InvoiceLine AS il
JOIN Track     AS t  ON t.TrackId = il.TrackId
JOIN MediaType AS mt ON mt.MediaTypeId = t.MediaTypeId
JOIN Genre     AS g  ON g.GenreId = t.GenreId
WHERE il.UnitPrice > 0.99
GROUP BY il.UnitPrice, mt.MediaTypeId, mt.Name, g.GenreId, g.Name
ORDER BY morceaux DESC;