-- Contrôle : total des lignes de facture
SELECT ROUND(SUM(UnitPrice * Quantity), 2) AS total_lignes FROM InvoiceLine;