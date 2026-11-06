-- Évolution du chiffre d'affaires par année
SELECT
    strftime('%Y', InvoiceDate) AS annee,
    COUNT(*)                    AS nb_factures,
    ROUND(SUM(Total), 2)        AS chiffre_affaires
FROM Invoice
GROUP BY annee
ORDER BY annee;