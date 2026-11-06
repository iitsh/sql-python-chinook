-- Chiffre d'affaires par pays : top 10, avec part du total
SELECT
    c.Country                                        AS pays,
    COUNT(DISTINCT c.CustomerId)                     AS nb_clients,
    COUNT(i.InvoiceId)                               AS nb_factures,
    ROUND(SUM(i.Total), 2)                           AS chiffre_affaires,
    ROUND(SUM(i.Total) / COUNT(DISTINCT c.CustomerId), 2) AS ca_par_client,
    ROUND(100.0 * SUM(i.Total) / SUM(SUM(i.Total)) OVER (), 1) AS part_pct
FROM Invoice AS i
JOIN Customer AS c ON c.CustomerId = i.CustomerId
GROUP BY c.Country
ORDER BY chiffre_affaires DESC
LIMIT 10;