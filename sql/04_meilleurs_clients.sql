-- Meilleurs clients : CA, part du total et part cumulée
WITH ca_client AS (
    SELECT
        c.CustomerId,
        c.FirstName || ' ' || c.LastName AS client,
        c.Country                        AS pays,
        COUNT(i.InvoiceId)               AS nb_factures,
        ROUND(SUM(i.Total), 2)           AS chiffre_affaires
    FROM Customer AS c
    JOIN Invoice AS i ON i.CustomerId = c.CustomerId
    GROUP BY c.CustomerId, c.FirstName, c.LastName, c.Country
)
SELECT
    RANK() OVER (ORDER BY chiffre_affaires DESC)         AS rang,
    client,
    pays,
    nb_factures,
    chiffre_affaires,
    ROUND(100.0 * chiffre_affaires
          / SUM(chiffre_affaires) OVER (), 1)            AS part_pct,
    ROUND(100.0 * SUM(chiffre_affaires) OVER (
              ORDER BY chiffre_affaires DESC, CustomerId
              ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
          / SUM(chiffre_affaires) OVER (), 1)            AS part_cumulee_pct
FROM ca_client
ORDER BY chiffre_affaires DESC, CustomerId
LIMIT 10;