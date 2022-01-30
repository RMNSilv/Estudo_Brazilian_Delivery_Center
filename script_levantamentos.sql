#Este dataset faz parte de uma das atividades proposta no curso SQL para Data Science, da instituição Data Science Academy,
#o qual participo no momento, e o objetivo desta atividade é consloidar alguns dos conceitos aprendidos em aula através 
#da elaboração de queries que respondam algumas das perguntas propostas a cerca dos dados disponibilizados. 

#Este dataset também pode ser obtido no site: https://www.kaggle.com/nosbielcs/brazilian-delivery-center

#O dataset refere-se aos dados de uma plataforma Delivery Center a qual integra lojistas e marketplaces, para venda de 
#comidas e produtos. Nele encontramos os seguintes datasets:

#channels - são informações referentes aos canais onde são realizadas as vendas
#deliveries (entregas) - são informações das entregas realizadas 
#drivers (entregadores) - informações referentes aos entregadores que se encontram nos hubs a fim de fazer as entregas quando requeridas
#hubs (centros) - informações dos locais onde são os centros de distribuições, local de onde saem os pedidos
#order (pedidos) - dados referentes aos pedidos realizados na plataforma
#payments (pagamentos) - informações sobre os pagamentos realizados
#stores (lojas) -  dados sobre os lojistas que realizam suas vendas na plataforma.



#Hubs por cidade

#Para responder a esta questão, pode-se utilizar a tabela centros e, com isso, fazer a contagem de nomes distintos 
#na coluna hub_name e agrupando por cidade

select hub_city, count(distinct hub_name) as total_hubs
from exe04.centros
group by 1 
order by 2 desc;


#Quantidade de Pedidos por status

#Realizado de forma similar ao item anterior, porém agora conta-se os pedidos distintos na coluna order_id
#agrupando-os por status.

select order_status, count(distinct order_id) as total_pedidos
from exe04.pedidos
group by 1
order by 1 desc;

#Em seguida, pode-se calcular a porcentagem que a quantidade de cada status representa no total de pedidos

with Porcent_status (order_status, total_pedidos, total) as 
(
select order_status, count(distinct order_id) as total_pedidos, count(order_id) as total_pedidos1
from exe04.pedidos
group by 1
order by 1 desc)
select *, (total_pedidos/(total_pedidos)) * 100 as Porcent_stats from Porcent_status
group by 1
order by 2 desc;



#Lojas por cidade dos Centros de distribuição

#Para realizar este levantamento, devemos utilizar as tabelas lojas e centros. Dado que os Hubs estão espalhados por
#cidades e atendem a uma determinada quantidade de lojas destas regiões. Cada loja está ligada a um Hub, com isso, na 
#tabela centros posso extrair as cidades desses Centros de distribuição e a partir do hub_id conectar às lojas atendidas
#por esses Centros de distribuição destas cidades. 

#obs.: Como alternativa aos Joins, utilizei o comando where, igualando-se a variável hub_id da duas tabelas. 

SELECT hub_city, count(store_id) as total_lojas
from exe04.centros, exe04.lojas
where centros.hub_id = lojas.hub_id
group by 1
order by 2 desc;

#Maior e menor valor de pagamento
select max(payment_amount) as maior_valor from exe04.pagamentos;
select min(payment_amount) as menor_valor from exe04.pagamentos;

#Pedidos por tipo de motoristas

#Este levantamento pode ser feito através da união das tabelas de motoristas e pedidos, sendo aqui, realizada por meio
#do comando left join. 

select driver_type, count(deliveries_id) as total_entregas
from exe04.motoristas m
left join exe04.entregas e
on m.driver_id = e.driver_id
group by 1
order by 2 desc;

#Distancia entregas por tipo de driver
select driver_modal, avg(delivery_distance_meters) as distancia_entregas
from exe04.motoristas m
left join exe04.entregas e
on m.driver_id = e.driver_id
group by 1
order by 2 desc;

#Pedidos por lojas
select store_name, avg(order_amount) as valor_entregas
from exe04.lojas l 
left join exe04.pedidos p 
on l.store_id = p.store_id
group by 1
order by 2 desc;

#Pagamentos com valor médio superior a 100 por método

#Primeiramente, calcula-se a média dos pagamentos realizados, no entanto, o que se pede são os pagamentos médios
#superiores a 100 o que não conseguimos filtrar na mesma query dado que a variável media_pgtos ainda não existe na 
#base analisada e está sendo criada agora, logo, utilizei o método de subquery a fim de se filtrar esses pagamentos 
#acima de 100. 

Select * from
(select payment_method, avg(payment_amount) as media_pgtos
from exe04.pagamentos
group by 1
order by 2) as pgto_medio
where media_pgtos >= 100;


#Pedido medio por hub, segmento, e canal

#Aqui, o que se solicita é o valor médio dos pedidos agrupado por estas três variáveis, logo, precisamos fazer o join da 
#tabela de pedidos com outras 3 tabelas para extrair estas informações. Sendo o segmento retirado da tabela de lojas, Hub 
#na tabela centros, canal na tabela channels e o valor dos pedidos na tabela pedidos

select hub_state, store_segment, channel_type, avg(order_amount) as valor_medio
from exe04.pedidos p 
Left join exe04.lojas l 
on p.store_id = l.store_id
join exe04.centros h 
on l.hub_id = h.hub_id
join exe04.channels c 
on p.channel_id = c.channel_id
group by 1, 2, 3
order by 4; 


#O valor total de pedidos nos Hubs do estado do  RJ, em lojas do segmento FOOD, canal MARKETPLACE E status CANCELADO 

#Para responder a este questionamento, faz-se a junção da tabela pedidos com as tabelas loja para extrair o segmento, 
#a tabela centros para obter os hubs e com a tabela channels para conseguir o Canal. No entanto, serão extraídas dessas 
#tabelas as informações filtradas conforme as condições da pergunta acima.

select hub_state, store_segment, channel_type, order_amount as valor_total
from exe04.pedidos p 
Left join exe04.lojas l 
on p.store_id = l.store_id
join exe04.centros h 
on l.hub_id = h.hub_id
join exe04.channels c 
on p.channel_id = c.channel_id
where hub_state = 'RJ'
and store_segment = 'GOOD'
and channel_type = 'MARKETPLACE'
and order_status = 'CANCELED';