-- Contrôle : genre et type de média de Lost et The Office.
SELECT
    ar.Name       AS artiste,
    g.Name        AS genre,
    mt.Name       AS type_media,
    il.UnitPrice  AS prix_unitaire,
    SUM(il.Quantity) AS morceaux
FROM InvoiceLine AS il
JOIN Track     AS t  ON t.TrackId = il.TrackId
JOIN Album     AS al ON al.AlbumId = t.AlbumId
JOIN Artist    AS ar ON ar.ArtistId = al.ArtistId
JOIN MediaType AS mt ON mt.MediaTypeId = t.MediaTypeId
JOIN Genre     AS g  ON g.GenreId = t.GenreId
WHERE ar.Name IN ('Lost', 'The Office')
GROUP BY ar.Name, g.Name, mt.Name, il.UnitPrice;