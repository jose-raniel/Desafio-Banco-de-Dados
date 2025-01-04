-- query
use ecommerce;

-- Quantos pedidos foram feitos por cada cliente?

SELECT idOrderClient AS cliente_id, COUNT(*) AS quantidade_pedidos
FROM orders
GROUP BY idOrderClient;

-- Algum vendedor também é fornecedor?

SELECT s.SocialName AS vendedor_nome, f.SocialName AS fornecedor_nome
FROM seller s
JOIN supplier f ON s.CNPJ = f.CNPJ;

-- Relação de produtos fornecedores e estoques;

SELECT p.Pname AS produto_nome, f.SocialName AS fornecedor_nome, ps.quantity AS quantidade_estoque
FROM product p
JOIN productSupplier ps ON p.idProduct = ps.idPsProduct
JOIN supplier f ON ps.idPsSupplier = f.idSupplier
JOIN storageLocation sl ON p.idProduct = sl.idLproduct
JOIN productStorage st ON sl.idLstorage = st.idProdStorage;

-- Relação de nomes dos fornecedores e nomes dos produtos;

SELECT f.SocialName AS fornecedor_nome, p.Pname AS produto_nome
FROM supplier f
JOIN productSupplier ps ON f.idSupplier = ps.idPsSupplier
JOIN product p ON ps.idPsProduct = p.idProduct;

 -- Quais produtos são vendidos por cada vendedor?

SELECT s.SocialName AS vendedor_nome, p.Pname AS produto_nome
FROM seller s
JOIN productSeller ps ON s.idSeller = ps.idPseller
JOIN product p ON ps.idPproduct = p.idProduct;

-- Quais pedidos foram feitos por cada cliente e qual o status do pedido?

SELECT c.Fname AS nome_cliente, c.Lname AS sobrenome_cliente, o.idOrder AS id_pedido, o.orderStatus AS status_pedido
FROM orders o
JOIN clients c ON o.idOrderClient = c.idClient;
