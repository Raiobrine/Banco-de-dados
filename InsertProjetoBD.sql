USE projetobd;


INSERT INTO Candidato(cpf_candidato, nome_candidato ,identidade_candidato, número_de_inscrição_título_de_eleitor)
VALUES
(2345678910, 'João', 13141341, 1111),
(2345678911, 'Maicon', 13141342, 2222),
(2345678912, 'Jonas', 13141343, 3333),
(2345678913, 'Horacio', 13141344, 4444),
(2345678914, 'Marcia', 13141345, 5555),
(2345678915,'Leticia',13141346,6666),
(12345678916,'Thiago',	13141347,	7777),
(22345678917,'Paulo',	13141348,	8888),
(22345678918,'Renato',	13141349,	9999),
(22345678919,'Marcos',	13141350,	1010),
(22345678920,'Bruno',	13141351,	11111);

INSERT INTO Título_de_eleitor(número_de_inscrição_título_de_eleitor, zona_de_inscrição_titulo_de_eleitor , região_titulo_de_eleitor)
VALUES
(1111, 1, 'Norte'),
(2222, 2, 'Nordeste'),
(3333, 3, 'Nordeste'),
(4444, 4, 'Nordeste'),
(5555, 6, 'Nordeste'),
(6666,	7,	'Nordeste'),
(7777,	6,	'Nordeste'),
(8888,	8,	'Norte'),
(9999,	9,	'Norte'),
(1010,	10,	'Norte'),
(11111,	11,	'Norte');

INSERT INTO Candidatura(ano_da_candidatura, número_do_partido_ficha_de_filiação,cpf_candidato)
VALUES
('2018',1,'2345678910'),
('2018',2,'2345678911'),
('2018',3,'2345678912'),
('2018',4,'2345678913'),
('2018',5,'2345678914'),
('2018',6,'2345678915'),
('2018',7,'12345678916'),
('2022',8,'22345678917'),
('2022',9,'22345678918'),
('2018',10,'22345678919'),
('2022',11,'22345678920');

INSERT INTO Mandato(código_da_candidatura)
VALUES
(0001),
(0002),
(0003),
(0004),
(0005),
(0006),
(0007),
(0008),
(0009),
(0010),
(0011);

INSERT INTO Ficha_de_filiação(número_do_partido_ficha_de_filiação, nome_do_partido_ficha_de_filiação)
VALUES
(1 ,  'CDU'),
(2 ,  'Partido de direita'),
(3 , 'Partido de esquerda'),
(4 ,'TARD'),
(5 , 'Partido central'),
(6,'BTA'),
(7,	'WOW'),
(8,	'JOOJ'),
(9,	'PNG'),
(10,'CDU'),
(11,'CDU');

INSERT INTO Declaração_de_bens(`código_da_candidatura`)
VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10),
(11);

INSERT INTO Bem(tipo_do_bem, descrição_do_bem, valor_de_mercado_do_bem,código_da_declaração_de_bens)
VALUES
('Imóvel',    'Casarão Branco',  '800000.00',    1),
('Automóvel',    'BMW 2015',    '290000.00',    2),
('Imóvel',    'Casarão Cinza',    '80000.00',    3),
('Joias',    'Bonitas',    '12000.00', 4),
('Ouro ativo',    'Brilhante',    '10000.00', 5),
('Imóvel', 'top', 120000.00,5),
('Imóvel',	'top',	120000.00,	6),
('Imóvel',	'Apartamento',	400000.00,	7),
('Ouro ativo',	'Ouro',	10000.00,	8),
('Ouro ativo',	'Ouro',	36000.00,	9),
('Imóvel',	'Apartamento',	512000.00,	10),
('Automóvel',	'Fusca',	44000.00,	11);

INSERT INTO `Votação`(`resultado_da_votação`, `situação_de_registro_de_candidatura_da_votação`, `código_da_candidatura`)
VALUES
('eleito', 'apto' , 1),
('eleito', 'apto' , 2),
('suplente','apto', 3),
('eleito', 'apto' , 4),
('eleito',  'apto', 5),
('eleito',  'apto', 6),
('eleito',	'apto',	7),
('eleito',	'apto',	8),
('eleito',	'apto',	9),
('eleito',	'apto',	10),
('eleito',	'apto',	11);

INSERT INTO `Votação_possui_urna`(`código_da_votação`, `código_da_urna`,`turno`,`ano`)
VALUES
(1,1,   '1°',    '2018'),
(2,2,    '1°',    '2018'),
(3,3,    '1°',    '2018'),
(4,4,    '2°',    '2018'),
(5,5,   '1°',   '2018'),
(6,6,   '1°',   '2018'),
(6,7,   '1°',   '2018'),
(7,	7,	'2°',	2018),
(8,	8,	'1°',	2018),
(9,	9,	'2°',	2018),
(10,12,	'2°',	2018),
(11,13,	'1°',	2018);

INSERT INTO Urna(`quantidade_de_votos_da_urna`,zona_da_urna,`região_da_urna` ,`município_da_urna` ,estado_da_urna)
VALUES
('50000',   1 ,   'Nordeste',    'Campina Grande',    'Paraíba'),
('60000',   2,    'Nordeste' ,   'Campina Grande',    'Paraíba'),
('60000',   3,    'Nordeste',    'Campina Grande',   'Paraíba'),
('80000',   4,    'Oeste',    'Campina Grande',   'Paraíba'),
('40000',  5,    'Sul',    'Campina Grande',    'Paraíba'),
('500',   6,    'Sul',    'Campina Grande',    'Paraíba'),
('10',    6,    'Norte',    'Campina Grande',    'Paraíba'),
('500',	6,	'Oeste',	'Campina Grande',    'Paraíba'),
('800',	7,	'Leste',	'Campina Grande',    'Paraíba'),
('8000',8,	'Nordeste',	'Campina Grande',    'Paraíba'),
('10000',9,	'Nordeste',	'Campina Grande',    'Paraíba'),
('70000',10,'Sul',	'Queimadas',    'Paraíba'),
('90000',11,'Sul',	'Barra de Santana',    'Paraíba');

INSERT INTO Gasto(data_gasto,`descrição_do_gasto`,fornecedor_do_gasto,valor_total_do_gasto ,categoria_do_gasto ,valor_liquido_gasto ,`código_do_mandato`)
VALUES
('2018-03-10','Carreata','Fundo eleitoral',14000000.00,'propaganda',1400000.00,1),
('2018-03-11','Propaganda eleitoral','Fundo eleitoral',13000000.00,'propaganda',1300000.00,2),
('2018-03-12','Carreata','Fundo eleitoral',12000000.00,'propaganda',1200000.00,3),
('2018-03-13','Carreata','Fundo eleitoral',11000000.00,'propaganda',1100000.00,4),
('2018-03-14','Carreata','Fundo eleitoral',10000000.00,'propaganda',1000000.00,5),
('2018-03-15','Carreata','Fundo eleitoral',500.00,'propaganda',200.00,6),
('2018-03-15','Carreata','Fundo eleitoral',500.00,'propaganda',100.00,5),
('2018-03-15',	'Outdoors',	'Fundo eleitoral',	9000000.00,	'propaganda',	6000.00,	6),
('2018-03-16',	'Propaganda eleitoral',	'Fundo eleitoral',	8000000.00,	'propaganda',	6000.00,7),
('2018-03-17',	'Outdoors',	'Fundo eleitoral',	7000000.00,	'propaganda',	2000.00,	8),
('2018-03-18',	'Outdoors',	'Fundo eleitoral',	5000000.00,	'propaganda',	1000.00,	9),
('2018-03-19',	'Propaganda eleitoral',	'Fundo eleitoral',	4000000.00,	'propaganda',	6000.00,	10),
('2018-03-20',	'Propaganda eleitoral',	'Fundo eleitoral',	3000000.00,	'propaganda',	1000.00,	11);

INSERT INTO `Doação_de_campanha`(`valor_doado_doação`,`descrição_doação`,`data_doação`,`hora_doação`,`código_da_candidatura`)
VALUES
(50000.00,    'doação para carreata',    '2018-03-01',    '18:40 PM',1),
(40000.00,    'doação para propaganda',    '2018-03-01',    '20:00 PM',2),
(30000.00,    'doação para outdoors',    '2018-03-01',    '09:35 AM',3),
(20000.00,    'doação de bezerro',    '2018-03-01',    '06:00 AM',4),
(10000.00,    'doação para carreata',    '2018-03-01',    '20:00 PM',5),
(10000.00,	'doação para propaganda',	'2018-03-01',	'20:00 PM',	6),
(10000.00,	'doação para outdoors',	'2018-03-01',	'18:00 PM',	7),
(10000.00,	'doação para propaganda',	'2018-03-01',	'08:00 AM',	8),
(10000.00,	'doação para propaganda',	'2018-03-01',	'09:35 AM',	9),
(10000.00,	'doação para outdoors',	'2018-03-01',	'09:35 AM',	10),
(10000.00,	'doação para outdoors',	'2018-03-01',	'12:30 AM',	11);

INSERT INTO Doador(`num_de_identificação_doação`)
VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10),
(11);

INSERT INTO `Pessoa_física`(`código_doador`,`cpf_pessoa_física`,`nome_pessoa_física`,`cep_pessoa_física`,`número_residência_pessoa_física`,`telefone_pessoa_física`)
VALUES
(0001,'11389128016','Roberto Pereira',19314416,08,'83988449832'),
(0002,'07745718023','Antonio da Silva',17815360,04,'83988789865'),
(0003,'11191332063','Nathan Orestes',18063520,140,'839886098476'),
(0004,'54789321125','Leonardo Alves',18961010,54,'839994512782'),
(0006,'11111111116','Ash Solsa',	111111116,	6,	'83911111116'),
(0007,'11111111117',	'Joseph Joestar',	111111117,	7,	'83911111117'),
(0008,'11111111118',	'Ana Banana',	111111118,	8,	'83911111118'),
(0009,'11111111119',	'Vitor Romano',	111111119,	9,	'83911111119'),
(0010,'11111111110',	'Rebeca Riba',	111111110,10,	'83911111110'),
(0011,'11111111102',	'Isabelly Gomes',	111111102,	11,	'84911111111');

INSERT INTO `Verba_pública`(`código_doador`,`rúbrica_verba_pública` ,`tipo_verba_pública` ,`descrição_verba_pública` )
VALUES
(0001,2345,'repasses oriundos do fundo partidário','auxílio para candidatura'),
(0002,5678,'doações do próprio partido','auxílio para candidatura'),
(0003,4356,'repasses oriundos do fundo partidário','auxílio para candidatura'),
(0004,1236,'doações do próprio partido','auxílio para candidatura'),
(0005,	500,	'doações do próprio partido',	'auxílio para candidatura'),
(0006,	600,	'doações do próprio partido',	'auxílio para candidatura'),
(0007,	700,	'doações do próprio partido',	'auxílio para candidatura'),
(0008,	800,	'doações do próprio partido',	'auxílio para candidatura'),
(0009,	900,	'doações do próprio partido',	'auxílio para candidatura'),
(0010,	1000,	'doações do próprio partido',	'auxílio para candidatura'),
(0011,	1100,	'doações do próprio partido',	'auxílio para candidatura');