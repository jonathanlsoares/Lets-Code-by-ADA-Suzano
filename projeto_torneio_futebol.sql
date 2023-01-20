
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
	foreign key (idtime2) references db_copadonordeste.Time(idtime),
	foreign key (golstime1) references db_copadonordeste.Jogadores(idjogador),
	foreign key (golstime2) references db_copadonordeste.Jogadores(idjogador)
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

