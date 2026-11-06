-- Contrôle : la requête 6 doit renvoyer autant de lignes que de pays ayant des factures.
SELECT
    COUNT(DISTINCT c.Country) AS nb_pays_clients,
    COUNT(DISTINCT CASE WHEN i.InvoiceId IS NOT NULL THEN c.Country END) AS nb_pays_avec_factures
FROM Customer AS c
LEFT JOIN Invoice AS i ON i.CustomerId = c.CustomerId;