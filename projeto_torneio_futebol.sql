
--Criação do banco de dados
create database db_copadonordeste;
-- A criação da Schema foi feita no navegador

-- Tabela Estados
create table db_copadonordeste.Estados(
	idestado integer primary key,
	nome VARCHAR(60) not null,
	uf CHAR(2) not null
);

-- Tabela Cidades
create table db_copadonordeste.Cidades(
	idcidade integer primary key,
	nome varchar(60),
	idestado integer,
	foreign key (idestado) references db_copadonordeste.Estados(idestado)
);


-- Tabela Time
create table db_copadonordeste.Time(
	idtime integer primary key,
	nome VARCHAR(60),
	idcidade INTEGER,
	foreign key (idcidade) references db_copadonordeste.Cidades(idcidade)
);

--Tabela Jogadores
create table db_copadonordeste.Jogadores(
	idjogador integer primary key,
	nome VARCHAR(60),
	idtime integer,
	idade integer,
	foreign key (idtime) references db_copadonordeste.Time(idtime)
	);


--Tabela Jogos
create table db_copadonordeste.Jogos(
	idjogo integer primary key,
	idtime1 integer,
	idtime2 integer,
	data_2 timestamp,
	golstime1 integer,
	golstime2 integer,
	foreign key (idtime1) references db_copadonordeste.Time(idtime),
	foreign key (idtime2) references db_copadonordeste.Time(idtime)
);

-- Inserção dos estados do nordeste
insert into db_copadonordeste.Estados (idestado, nome, uf)
values 
(01, 'Ceará', 'CE'),
(02, 'Rio Grande do Norte', 'RN'),
(03, 'Piauí', 'PI'),
(04, 'Pernambuco', 'PE'),
(05, 'Paraíba', 'PB'),
(06, 'Maranhão', 'MA'),
(07, 'Alagoas', 'AL'),
(08, 'Sergipe', 'SE'),
(09, 'Bahia', 'BA');

select * from Estados;

--Inserção das cidades do Nordeste
insert into db_copadonordeste.Cidades (idcidade, nome, idestado)
values
(01, 'Fortaleza', 01),
(02, 'Natal', 02),
(03, 'Teresina', 03),
(04, 'Recife', 04),
(05, 'João Pessoa', 05),
(06, 'São Luis', 06),
(07, 'Maceió', 07),
(08, 'Aracaju', 08),
(09, 'Salvador', 09);

select * from Cidades;


--Inserção dos Times
insert into db_copadonordeste.Time (idtime, nome, idcidade)
values
(01, 'Fortaleza', 01),
(02, 'América', 02),
(03, 'Fluminese', 03),
(04, 'Sport', 04),
(05, 'Treze FC', 05),
(06, 'Sampaio Correia', 06),
(07, 'CRB', 07),
(08, 'Confiança', 08),
(09, 'Vitória', 09);

select * from Time;




--Inserção dos Jogadores
insert into db_copadonordeste.Jogadores (idjogador, nome, idtime, idade)
values
(01, 'Benzema', 01, 36),
(02, 'Sadio', 01, 29),
(03, 'Bruyne', 02, 46),
(04, 'Lewandowski', 02, 20),
(05, 'Mohamed Salah', 03, 18),
(06, 'Kylian Mbappé', 03, 36),
(07, 'Thibaut Courtois', 04, 50),
(08, 'Vini Jr', 04, 19),
(09, 'Luka Modric', 05, 39),
(10, 'Erling Haaland', 05, 32),
(11, 'Cristiano Ronaldo', 06, 32),
(12, 'Casemiro ', 06, 36),
(13, 'Sébastien Haller', 07, 25),
(14, 'Joshua Kimmich', 07, 24),
(15, 'Lionel Messi', 08, 23),
(16, 'Riyad Mahrez', 08, 25),
(17, 'Virgil van Dijk', 09, 22),
(18, 'Trent Alexander-Arnold', 09, 20);

select * from Jogadores;

--Inserção dos Jogos
insert into db_copadonordeste.Jogos (idjogo, idtime1, idtime2, data_2, golstime1, golstime2)
values
(01, 01, 02,'2023-01-01 12:00:00', 3, 1),
(02, 01, 03,'2023-01-02 12:00:00', 1, 1),
(03, 01, 04,'2023-01-03 12:00:00', 2, 2),
(04, 01, 05,'2023-01-04 12:00:00', 3, 1),
(05, 01, 06,'2023-01-05 12:00:00', 1, 2),
(06, 01, 07,'2023-01-06 12:00:00', 2, 1),
(07, 02, 03,'2023-01-07 12:00:00', 7, 1),
(08, 01, 04,'2023-01-08 12:00:00', 1, 2),
(09, 01, 05,'2023-01-09 12:00:00', 1, 1),
(10, 01, 06,'2023-01-10 12:00:00', 1, 1),
(11, 01, 07,'2023-01-11 12:00:00', 3, 2);

select * from db_copadonordeste.Jogos;

-------------------------------------------------------------------------------------
--Perguntas




--○ Quantos jogos cada jogador jogou?
select jogadores.nome_jogador, count(distinct partidas.idjogo) as partidas_disputadas
from jogos
join jogos.time on jogadores.idtime = time.id
join jogos.partidas on time.id = partidas.idtime1 or time.id = partidas.idtime2
group by jogadores.nome_jogador
order by partidas_disputadas desc;



--○ Qual time mais venceu partidas?
select
	times.nome as "time",
	vencedores.total_vitorias
from (
	select 
		count(*) as total_vitorias,
		CASE 
			WHEN gols_time_1 > gols_time_2 THEN id_time_1
		    WHEN gols_time_1 = gols_time_2 THEN null
		    ELSE id_time_2
		END AS vencedor
	FROM jogos 
	group by vencedor
) as vencedores inner join times 
on vencedores.vencedor = times.id
group by vencedores.total_vitorias, times.nome
order by vencedores.total_vitorias desc;


--○ Qual time teve a melhor defesa?
select 
  time, 
  sum(case when idtime1 = id then golstime2 else golstime1 end) as total_goals_sofridos
from jogos
join jogos.time
on jogos.partidas.idtime1 = jogos.time.id or jogos.partidas.idtime2 = jogos.time.id
group by time
order by total_goals_sofridos asc;


-------------------------------------------------------------------------------------



