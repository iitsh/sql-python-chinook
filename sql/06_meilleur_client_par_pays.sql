-- Question 6 : quel est le meilleur client de chaque pays ?
WITH ca_client AS (
    SELECT
        c.CustomerId,
        c.FirstName || ' ' || c.LastName AS client,
        c.Country                        AS pays,
        ROUND(SUM(i.Total), 2)           AS chiffre_affaires
    FROM Customer AS c
    JOIN Invoice  AS i ON i.CustomerId = c.CustomerId
    GROUP BY c.CustomerId, c.FirstName, c.LastName, c.Country
),
classement AS (
    SELECT
        pays,
        client,
        chiffre_affaires,
        ROW_NUMBER() OVER (
            PARTITION BY pays
            ORDER BY chiffre_affaires DESC, CustomerId
        ) AS rang_pays,
        COUNT(*) OVER (PARTITION BY pays) AS nb_clients_pays,
        ROUND(100.0 * chiffre_affaires
              / SUM(chiffre_affaires) OVER (PARTITION BY pays), 1) AS part_du_pays_pct
    FROM ca_client
)
SELECT pays, client, chiffre_affaires, nb_clients_pays, part_du_pays_pct
FROM classement
WHERE rang_pays = 1
ORDER BY chiffre_affaires DESC, pays;