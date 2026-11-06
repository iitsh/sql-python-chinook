-- Question 5 : quels artistes génèrent le plus de chiffre d'affaires ?
SELECT
    ar.Name                                              AS artiste,
    SUM(il.Quantity)                                     AS morceaux_vendus,
    ROUND(SUM(il.UnitPrice * il.Quantity), 2)            AS chiffre_affaires,
    ROUND(100.0 * SUM(il.UnitPrice * il.Quantity)
          / SUM(SUM(il.UnitPrice * il.Quantity)) OVER (), 1) AS part_pct
FROM InvoiceLine AS il
JOIN Track  AS t  ON t.TrackId   = il.TrackId
JOIN Album  AS al ON al.AlbumId  = t.AlbumId
JOIN Artist AS ar ON ar.ArtistId = al.ArtistId
GROUP BY ar.ArtistId, ar.Name
ORDER BY chiffre_affaires DESC, artiste
LIMIT 10;