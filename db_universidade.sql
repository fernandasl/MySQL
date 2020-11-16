create database if not exists db_Atividade;
use db_Atividade;

/* 1. Crie, no seu banco de dados, a tabela abaixo, insira os valores apresentados e em
seguida escreva as consultas solicitadas abaixo.
OBS: Os valores em branco devem ser nulos no banco de dados. */
create table tbl_vendas(
id_NF tinyint not null,
id_Item tinyint not null,
cod_Produto tinyint not null,
primary key(id_NF, id_Item, cod_Produto),
valor_Unit float not null,
Quantidade integer not null,
Desconto integer
);

insert into tbl_vendas(id_NF, id_Item, cod_Produto, valor_Unit, Quantidade, Desconto)
values('1', '1', '1', '25.00', '10', '5');

insert into tbl_vendas(id_NF, id_Item, cod_Produto, valor_Unit, Quantidade)
values(1, 2, 2, 13.50, 3),
(1, 3, 3, 15.00, 2),
(1, 4, 4, 10.00, 1),
(1, 5, 5, 30.00, 1),
(2, 1, 3, 15.00, 4),
(2, 2, 4, 10.00, 5),
(2, 3, 5, 30.00, 7),
(3, 1, 1, 25.00, 5),
(3, 2, 4, 10.00, 4),
(3, 3, 5, 30.00, 5),
(3, 4, 2, 13.50, 7);

insert into tbl_vendas(id_NF, id_Item, cod_Produto, valor_Unit, Quantidade, Desconto)
values(4, 1, 5, 30.00, 10, 15),
(4, 2, 4, 10.00, 12, 5),
(4, 3, 1, 25.00, 13, 5),
(4, 4, 2, 13.50, 15, 5);

insert into tbl_vendas(id_NF, id_Item, cod_Produto, valor_Unit, Quantidade)
values(5, 1, 3, 15.00, 3),
(5, 2, 5, 30.00, 6);

insert into tbl_vendas(id_NF, id_Item, cod_Produto, valor_Unit, Quantidade, Desconto)
values(6, 1, 1, 25.00, 22, 15),
(6, 2, 3, 15.00, 25, 20),
(7, 1, 1, 25.00, 10, 3),
(7, 2, 2, 13.50, 10, 4),
(7, 3, 3, 15.00, 10, 4),
(7, 4, 5, 30.00, 10, 1);

SELECT * FROM tbl_vendas;

/* A) Pesquise os itens que foram vendidos sem desconto. As colunas presentes no
resultado da consulta são: ID_NF, ID_ITEM, COD_PROD E VALOR_UNIT. */ 
select id_NF,id_Item,cod_Produto,valor_Unit from tbl_vendas where Desconto is null;

/* B) Pesquise os itens que foram vendidos com desconto. As colunas presentes no
resultado da consulta são: ID_NF, ID_ITEM, COD_PROD, VALOR_UNIT E O VALOR
VENDIDO. OBS: O valor vendido é igual ao VALOR_UNIT -
(VALOR_UNIT*(DESCONTO/100)). */
select id_NF,id_Item,valor_Unit, valor_Unit-(valor_Unit*(Desconto/100)) from tbl_vendas;

/* C) Altere o valor do desconto (para zero) de todos os registros onde este campo é nulo. */
update tbl_vendas set Desconto = 0 where Desconto is null;

/* D) Pesquise os itens que foram vendidos. As colunas presentes no resultado da consulta
são: ID_NF, ID_ITEM, COD_PROD, VALOR_UNIT, VALOR_TOTAL, DESCONTO,
VALOR_VENDIDO. OBS: O VALOR_TOTAL é obtido pela fórmula: QUANTIDADE *
VALOR_UNIT. O VALOR_VENDIDO é igual a VALOR_UNIT -
(VALOR_UNIT*(DESCONTO/100)). */
select id_NF, id_Item, cod_Produto, valor_Unit,(Quantidade * valor_unit), Desconto, (valor_Unit - (valor_unit*(Desconto/100))) from tbl_vendas;

/* E) Pesquise o valor total das NF e ordene o resultado do maior valor para o menor. As
colunas presentes no resultado da consulta são: ID_NF, VALOR_TOTAL. OBS: O VALOR_TOTAL é obtido pela fórmula: ∑ QUANTIDADE * VALOR_UNIT. Agrupe o
resultado da consulta por ID_NF */
select id_NF, Quantidade * valor_Unit from tbl_vendas
group by id_NF order by Quantidade * valor_Unit desc;

/* F) Pesquise o valor vendido das NF e ordene o resultado do maior valor para o menor. As
colunas presentes no resultado da consulta são: ID_NF, VALOR_VENDIDO. OBS: O
VALOR_TOTAL é obtido pela fórmula: ∑ QUANTIDADE * VALOR_UNIT. O
VALOR_VENDIDO é igual a ∑ VALOR_UNIT - (VALOR_UNIT*(DESCONTO/100)). Agrupe
o resultado da consulta por ID_NF. */
select id_NF, valor_Unit - (valor_Unit * (Desconto/100)) from tbl_vendas group by id_NF
order by valor_Unit  - (valor_Unit * (Desconto/100)) desc;

/* G) Consulte o produto que mais vendeu no geral. As colunas presentes no resultado da
consulta são: COD_PROD, QUANTIDADE. Agrupe o resultado da consulta por
COD_PROD. (PERGUNTAR P/ O PROFESSOR) */
select cod_Produto, Quantidade from tbl_vendas 
group by cod_Produto order by Quantidade desc;

/* H) Consulte as NF que foram vendidas mais de 10 unidades de pelo menos um produto.
As colunas presentes no resultado da consulta são: ID_NF, COD_PROD, QUANTIDADE.
Agrupe o resultado da consulta por ID_NF, COD_PROD. */
select id_NF, cod_Produto, Quantidade from tbl_vendas 
group by id_NF, cod_Produto having Quantidade > 10 order by Quantidade desc;

/* I) Pesquise o valor total das NF, onde esse valor seja maior que 500, e ordene o
resultado do maior valor para o menor. As colunas presentes no resultado da consulta
são: ID_NF, VALOR_TOT. OBS: O VALOR_TOTAL é obtido pela fórmula: ∑ QUANTIDADE
* VALOR_UNIT. Agrupe o resultado da consulta por ID_NF. (PERGUNTAR P/ O PROFESSOR)*/

/* J) Qual o valor médio dos descontos dados por produto. As colunas presentes no
resultado da consulta são: COD_PROD, MEDIA. Agrupe o resultado da consulta por
COD_PROD. */
select cod_Produto, avg(Desconto) from tbl_vendas group by cod_Produto;

/* K) Qual o menor, maior e o valor médio dos descontos dados por produto. As colunas
presentes no resultado da consulta são: COD_PROD, MENOR, MAIOR, MEDIA. Agrupe
o resultado da consulta por COD_PROD. */
select cod_Produto, min(Desconto), max(Desconto), avg(Desconto) from tbl_vendas group by cod_Produto;

/* L) Quais as NF que possuem mais de 3 itens vendidos. As colunas presentes no resultado
da consulta são: ID_NF, QTD_ITENS. OBS:: NÃO ESTÁ RELACIONADO A QUANTIDADE
VENDIDA DO ITEM E SIM A QUANTIDADE DE ITENS POR NOTA FISCAL. Agrupe o
resultado da consulta por ID_NF. */
select id_NF, Quantidade from tbl_vendas
group by id_NF having Quantidade > 3 order by id_NF desc;