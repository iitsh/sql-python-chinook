-- Contrôle : la chaîne de 4 jointures ne doit perdre aucune ligne.
-- Résultat attendu : 2328.6
SELECT ROUND(SUM(il.UnitPrice * il.Quantity), 2) AS total_apres_jointures
FROM InvoiceLine AS il
JOIN Track  AS t  ON t.TrackId  = il.TrackId
JOIN Album  AS al ON al.AlbumId = t.AlbumId
JOIN Artist AS ar ON ar.ArtistId = al.ArtistId;