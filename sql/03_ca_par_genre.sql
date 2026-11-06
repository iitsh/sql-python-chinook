-- Chiffre d'affaires par genre musical : top 10
SELECT
    g.Name                                             AS genre,
    SUM(il.Quantity)                                   AS morceaux_vendus,
    ROUND(SUM(il.UnitPrice * il.Quantity), 2)          AS chiffre_affaires,
    ROUND(100.0 * SUM(il.UnitPrice * il.Quantity)
          / SUM(SUM(il.UnitPrice * il.Quantity)) OVER (), 1) AS part_pct
FROM InvoiceLine AS il
JOIN Track AS t ON t.TrackId = il.TrackId
JOIN Genre AS g ON g.GenreId = t.GenreId
GROUP BY g.GenreId, g.Name
ORDER BY chiffre_affaires DESC
LIMIT 10;