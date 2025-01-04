-- Query solicitadas
use ecommerce;
-- Recuperações Simples com Instrução SELECT

SELECT Fname, Lname, Address
FROM clients;

-- Filtros com Declaração WHERE

SELECT Pname, category, avaliação
FROM product
WHERE category = 'Eletrônico' AND avaliação > 4.0;

-- Crie Expressões para Gerar Atributos Derivados

SELECT 
    po.idPOorder AS PedidoID,
    p.Pname AS Produto,
    po.poQuantity AS Quantidade,
    (po.poQuantity * p.avaliação) AS ValorTotal
FROM productOrder po
JOIN product p ON po.idPOproduct = p.idProduct;

-- Defina Ordenações dos Dados com ORDER BY

SELECT SocialName, contact
FROM supplier
ORDER BY SocialName ASC;

-- Condições de Filtros aos Grupos – Declaração HAVING

SELECT category, COUNT(*) AS TotalProdutos
FROM product
GROUP BY category
HAVING COUNT(*) > 5;

-- Crie Junções entre Tabelas para Perspectiva Mais Complexa

-- a) Relacionar clientes com os pedidos realizados:

SELECT 
    c.Fname AS Nome,
    c.Lname AS Sobrenome,
    o.idOrder AS PedidoID,
    o.orderStatus AS Status
FROM clients c
JOIN orders o ON c.idClient = o.idOrderClient;

-- b) Obter informações de estoque e localização:

SELECT 
    p.Pname AS Produto,
    ps.storageLocation AS LocalEstoque,
    ps.quantity AS Quantidade
FROM productStorage ps
JOIN storageLocation sl ON ps.idProdStorage = sl.idLstorage
JOIN product p ON sl.idLproduct = p.idProduct;

-- Quantos pedidos foram feitos por cada cliente?

SELECT idOrderClient AS cliente_id, COUNT(*) AS quantidade_pedidos
FROM orders
GROUP BY idOrderClient;


-- Algum vendedor também é fornecedor?

SELECT s.SocialName AS vendedor_nome, f.SocialName AS fornecedor_nome
FROM seller s
JOIN supplier f ON s.CNPJ = f.CNPJ;

-- Relação de produtos, fornecedores e estoques

SELECT p.Pname AS produto_nome, f.SocialName AS fornecedor_nome, ps.quantity AS quantidade_estoque
FROM product p
JOIN productSupplier ps ON p.idProduct = ps.idPsProduct
JOIN supplier f ON ps.idPsSupplier = f.idSupplier
JOIN storageLocation sl ON p.idProduct = sl.idLproduct
JOIN productStorage st ON sl.idLstorage = st.idProdStorage;

-- Relação de nomes de fornecedores e nomes de produtos

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
