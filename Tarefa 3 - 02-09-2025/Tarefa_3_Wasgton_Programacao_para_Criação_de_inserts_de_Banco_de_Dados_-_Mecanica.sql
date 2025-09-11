#Tarefa 3 - Programação para insets de Banco de Dados - Mecânica - PRAZO: 02/09/2025 Wasgton Gomes Pereira

#1. Programe o SCRIPT SQL para criação do banco de dados da Mecânica conforme o Modelo ER em anexo. 
create database bd_3_mecanica_01_WASGTON;
use bd_3_mecanica_01_WASGTON;

create table Despesas (
id_desp integer not null primary key auto_increment,
nome_desp varchar (200),
valor_desp double,
parcela_desp integer
);

create table Fornecedor (
id_forn integer not null primary key auto_increment,
razao_social_forn varchar (200),
cnpj_forn varchar (30),
contato_forn varchar (15)
);

create table Peca (
id_pec int primary key not null auto_increment,
nome_pec varchar (50) not null,
valor_pec double,
marca_pec varchar (50),
estoque_pec int,
descricao_pec varchar (50) not null
);

create table Servico (
id_serv int not null primary key auto_increment,
nome_serv varchar(300) not null,
valor_serv float not null,
tempo_serv time
);

create table Cliente (
id_cli integer not null primary key auto_increment,
nome_cli varchar (200) not null,
cpf_cli varchar (20) not null,
contato_cli varchar (50),
email_cli varchar (50) not null
);

create table Carro (
id_car int primary key not null auto_increment,
descricao_car varchar(300) not null,
placa_car varchar (50) not null,
chassi_car varchar (100) not null,
id_cli_fk int,
foreign key (id_cli_fk) references Cliente (id_cli)
);

create table Funcionario (
id_func integer not null primary key auto_increment,
nome_func varchar (200) not null,
cpf_func varchar (20) not null,
salario_func double not null,
funcao_func varchar (50) not null
);

create table Compra(
id_comp integer not null primary key auto_increment,
valor_comp double not null,
data_comp date not null,
forma_pagamento_comp varchar (30) not null
);

create table Itens_Compra (
id_itc integer not null primary key auto_increment,
quant_itc integer not null,
valor_itc float not null,
id_pec_fk integer,
id_comp_fk integer,
foreign key (id_pec_fk) references Peca (id_pec),
foreign key (id_comp_fk) references Compra (id_comp)
);

create table Caixa (
id_cai integer not null primary key auto_increment,
data_cai date not null,
saldo_inicial_cai double not null,
total_entrada_cai double not null,
total_saida_cai double not null,
saldo_final_cai double not null
);

create table Pagamento (
id_pag integer not null primary key auto_increment,
data_vencimento_pag date not null,
valor_pag float not null,
parcela_pag varchar (100) not null,
status_pag varchar (100) not null,
id_cai_fk integer ,
id_desp_fk integer,
foreign key (id_cai_fk) references Caixa (id_cai),
foreign key (id_desp_fk) references Despesas (id_desp)
);

create table Orcamento (
id_orc integer not null primary key auto_increment,
data__orc date not null,
valor_orc float ,
horario_orc time 
);

create table Orcamento_Cliente (
id_orccli integer not null primary key auto_increment,
valor_orccli float,
id_orc_fk integer,
id_cli_fk integer,
foreign key (id_orc_fk) references Orcamento (id_orc),
foreign key (id_cli_fk) references Cliente (id_cli)
);

create table Venda (
id_vend integer not null primary key auto_increment,
data_vend date,
valor_vend double not null,
forma_recebimento_vend varchar (50),
id_func_fk integer,
id_cli_fk integer,
foreign key (id_func_fk) references Funcionario (id_func),
foreign key (id_cli_fk) references Cliente (id_cli)
);

create table Orcamento_Servico (
id_orc_serv integer not null primary key auto_increment,
descrecao_orc_serv varchar (300) not null, 
id_orc_fk integer,
id_serv_fk integer,
foreign key (id_orc_fk) references Orcamento (id_orc),
foreign key (id_serv_fk) references Servico (id_serv)
);

create table Venda_Servico (
id_vend_serv integer not null primary key auto_increment,
quant_vend_serv integer not null,
id_serv_fk integer  ,
id_vend_fk integer  ,
foreign key (id_serv_fk) references Servico (id_serv),
foreign key (id_vend_fk) references Venda (id_vend)
);

create table Venda_Peca (
id_vend_pec integer not null primary key auto_increment,
quant_vend_pec integer not null,
id_pec_fk integer ,
id_vend_fk integer,
foreign key (id_pec_fk) references Peca (id_pec),
foreign key (id_vend_fk) references Venda (id_vend)
);

create table Orcamento_Peca (
id_orc_pec integer not null primary key auto_increment,
descrecao_orc_pec varchar (300) not null, 
id_orc_fk integer not null,
id_pec_fk integer not null,
foreign key (id_orc_fk) references Orcamento (id_orc),
foreign key (id_pec_fk) references Peca (id_pec)
);

create table Recebimento (
id_rec integer not null primary key auto_increment,
data_vencimento_rec date,
valor_rec double,
parcela_rec varchar(100),
status_rec varchar (100),
id_cai_fk integer,
id_vend_fk integer,
foreign key (id_cai_fk) references Caixa (id_cai),
foreign key (id_vend_fk) references Venda (id_vend)
);

create table Orcamento_Funcionario (
id_orc_func integer not null primary key auto_increment,
descrecao_orc_func varchar (300) not null, 
id_orc_fk integer ,
id_func_fk integer ,
foreign key (id_orc_fk) references Orcamento (id_orc),
foreign key (id_func_fk) references Funcionario (id_func)
);

#2. Crie a tabela Agendamento e faça relações com ALTER TABLE.

create table Agendamento (
id_agend integer not null primary key auto_increment,
data_agend date not null, 
horario_agend time not null,
descricao_agend varchar(300) 
);

alter table Agendamento add column id_cli_fk integer,
add column id_car_fk integer,
add column id_func_fk integer,
add column id_serv_fk integer;
alter table Agendamento add foreign key (id_cli_fk) references Cliente (id_cli),
add  foreign key (id_car_fk) references Carro (id_car),
add  foreign key (id_func_fk) references Funcionario (id_func),
add  foreign key (id_serv_fk) references Servico (id_serv);

#3. Faça as seguintes normalizações: CONTATO (celular, telefone, e-mail) e ENDEREÇO (rua, numero, bairro, cidade, UF) 
#e relacione com as tabelas necessárias. As relações devem ser feitas com ALTER TABLE, assim como as exclusões dos atributos simples desnecessários.


create table Contato(
id_cont integer not null primary Key auto_increment,
celular_cont varchar(20) not null,
telefone_cont varchar(20) not null,
email_cont varchar(120) not null
);

create table Endereco(
id_end integer not null primary Key auto_increment,
rua_end varchar(100) not null,
numero_end varchar(10) not null,
bairro_end varchar(60) not null,
cidade_end varchar(80) not null,
uf_end char(2) not null
);

alter table Cliente add column id_cont_fk integer ;
alter table Cliente add column id_end_fk integer ;
alter table Cliente add  foreign key (id_cont_fk) references Contato (id_cont);
alter table Cliente add  foreign key (id_end_fk) references Endereco (id_end);

alter table Fornecedor add column id_cont_fk integer ;
alter table Fornecedor add column id_end_fk integer ;
alter table Fornecedor add  foreign key (id_cont_fk) references Contato (id_cont);
alter table Fornecedor add  foreign key (id_end_fk) references Endereco (id_end);

alter table Funcionario add column id_cont_fk integer ;
alter table Funcionario add column id_end_fk integer ;
alter table Funcionario add foreign key (id_cont_fk) references Contato (id_cont);
alter table Funcionario add  foreign key (id_end_fk) references Endereco (id_end);


#4. Adicione pelo menos 1 atributo novo em cada tabela, com ALTER TABLE.

-- #4. Adicione pelo menos 1 atributo novo em cada tabela, com ALTER TABLE.

alter table Despesas add column categoria_desp varchar(100);

alter table Fornecedor add column site_forn varchar(150);

alter table Peca add column garantia_pec int;

alter table Servico add column prazo_execucao_serv varchar(50);

alter table Cliente add column genero_cli varchar(20);

alter table Carro add column cor_car varchar(30);

alter table Funcionario add column turno_func varchar(20);

alter table Compra add column observacao_comp text;

alter table Itens_Compra add column desconto_itc double;

alter table Caixa add column responsavel_cai varchar(100);

alter table Pagamento add column metodo_pag varchar(50);

alter table Orcamento add column status_orc varchar(50);

alter table Orcamento_Cliente add column observacao_orccli text;

alter table Venda add column status_vend varchar(50);

alter table Orcamento_Servico add column desconto_orc_serv double;

alter table Venda_Servico add column desconto_vend_serv double;

alter table Venda_Peca add column desconto_vend_pec double;

alter table Orcamento_Peca add column desconto_orc_pec double;

alter table Recebimento add column metodo_rec varchar(50);

alter table Orcamento_Funcionario add column observacao_orc_func text;

alter table Agendamento add column status_agend varchar(50);

alter table Contato add column tipo_cont varchar(30);

alter table Endereco add column cep_end varchar(15);

#Faça as alterações a seguir, caso não execute por causa da dependência, deixe comentado: 

#1. Adicione a coluna telefone do tipo VARCHAR(15) na tabela Cliente.

alter table Cliente add column telefone_cli varchar(15);

#2. Adicione a coluna email_secundario do tipo VARCHAR(100) na tabela Fornecedor.

alter table Fornecedor add column email_secundario varchar(100);

#3. Adicione a coluna data_nascimento do tipo DATE na tabela Funcionario.

alter table Funcionario add column data_nascimento_func date;

#4. Adicione a coluna observacoes do tipo TEXT na tabela Carro.

alter table Carro add column observacoes_car text;

#5. Adicione a coluna codigo_interno do tipo INT após a coluna id na tabela Peca.

alter table peca add column  codigo_interno_pec int after id_pec;

#6. Remova a coluna cpf da tabela Funcionario.

#alter table Funcionario drop column cpf_func;

#7. Remova a coluna email da tabela Cliente.

alter table Cliente drop column email_cli;

#8. Remova a coluna status da tabela Recebimento.

alter table Recebimento drop column status_rec;

#9. Remova a coluna parcela da tabela Pagamento.

alter table Pagamento drop column parcela_pag;

#10. Remova a coluna descricao da tabela Carro.

#alter table Carro drop column descricao_car;

#11. Altere a coluna valor da tabela Peca para o tipo FLOAT.

alter table Peca modify column valor_pec float;

#12. Altere a coluna nome da tabela Cliente para nome_completo do tipo VARCHAR(150).

alter table Cliente change column nome_cli nome_completo_cli varchar(150) not null;

#13. Altere a coluna contato da tabela Fornecedor para telefone_principal mantendo o tipo VARCHAR(50).

alter table Fornecedor change column contato_forn telefone_principal_forn varchar(50);

#14. Altere a coluna salario da tabela Funcionario para FLOAT e defina como NOT NULL.

alter table Funcionario modify column salario_func float not null;

#15. Altere a coluna tempo da tabela Servico para o tipo VARCHAR.

alter table Servico modify column tempo_serv varchar (50);

#ATENÇÃO: O script deve ser programado para EXECUÇÃO ÚNICA, não sem adimitido erros de execução.

#ENTREGA: Envio o script .SQL com o seu banco de dados e codigos de manipulação. Adicione seu nome na primeira linha como comentário.

-- INSERTS (4 registros em cada tabela) -- ORDEM PRÓPRIA PARA FKs

-- 1) CONTATO
insert into Contato (id_cont, celular_cont, telefone_cont, email_cont, tipo_cont) 
values (null,'69990000001','322200001','contato1@ex.com','pessoal');

insert into Contato (id_cont, celular_cont, telefone_cont, email_cont, tipo_cont) 
values (null,'69990000002','322200002','contato2@ex.com','fornecedor');

insert into Contato
values (null,'69990000003','322200003','contato3@ex.com','fornecedor');

insert into Contato 
values (null,'69990000004','322200004','contato4@ex.com','fornecedor');

-- 2) ENDERECO
insert into Endereco (id_end, rua_end, numero_end, bairro_end, cidade_end, uf_end, cep_end) 
values (null,'Rua Titã','100','Centro','Porto Velho','RO','76800-100');

insert into Endereco (id_end, rua_end, numero_end, bairro_end, cidade_end, uf_end, cep_end) 
values (null,'Av Asgard','200','Nobre','Porto Velho','RO','76800-200');

insert into Endereco  
values (null,'Rua Caos','300','Gotham','Porto Velho','RO','76800-300');

insert into Endereco 
values (null,'Av Lex','400','Metropolis','Porto Velho','RO','76800-400');

-- 3) DESPESAS
insert into Despesas (id_desp, nome_desp, valor_desp, parcela_desp, categoria_desp) 
values (null,'Caerd',153.69,1,'Serviço Público');

insert into Despesas (id_desp, nome_desp, valor_desp, parcela_desp, categoria_desp) 
values (null,'Energisa',478.93,1,'Energia');

insert into Despesas  
values (null,'Internet OI',129.90,1,'Telecom');

insert into Despesas  
values (null,'Aluguel do imóvel',4500.00,1,'Imobiliário');

-- 4) CAIXA
insert into Caixa (id_cai, data_cai, saldo_inicial_cai, total_entrada_cai, total_saida_cai, saldo_final_cai, responsavel_cai) 
values (null,'2025-07-01',10000.00,2500.00,1800.00,10700.00,'Rafael Gomes');

insert into Caixa (id_cai, data_cai, saldo_inicial_cai, total_entrada_cai, total_saida_cai, saldo_final_cai, responsavel_cai) 
values (null,'2025-07-02',5000.00,1200.00,400.00,5800.00,'Luana Martins');

insert into Caixa 
values (null,'2025-07-03',3000.00,800.00,200.00,3600.00,'Pedro Henrique');

insert into Caixa  
values (null,'2025-07-04',1500.00,400.00,150.00,1750.00,'Ana Beatriz');

-- 5) FORNECEDOR 
insert into Fornecedor (id_forn, razao_social_forn, cnpj_forn, telefone_principal_forn, id_cont_fk, id_end_fk, site_forn)
values (null,'Thanos Ltda','11111111000111','69990000011',1,1,'https://thanos.example','justice@gmailcom');

insert into Fornecedor 
values (null,'LexCorp Indústria','44444444000144','69990000014',4,4,'https://lexcorp.example', 'injustice@gmail.com');

-- 6) PECA 
insert into Peca (id_pec, codigo_interno_pec, nome_pec, valor_pec, marca_pec, estoque_pec, descricao_pec, garantia_pec)
values (null,1001,'Manopla do Infinito',99999.90, 'PowerCo',1,'Manopla com gemas do infinito',12);

insert into Peca (id_pec, codigo_interno_pec, nome_pec, valor_pec, marca_pec, estoque_pec, descricao_pec, garantia_pec)
values (null,1002,'Cetro de Loki',30000.00,'AsgardTech',1,'Cetro com energia mística',12);

insert into Peca 
values (null,1003,'Núcleo Ultron',1200.00,'UltronCorp',5,'Núcleo de inteligência artificial',6);

insert into Peca 
values (null,1004,'Kriptonita',500.00,'KryptonLabs',3,'Amostra de kriptonita verde',24);

-- 7) SERVICO
insert into Servico (id_serv, nome_serv, valor_serv, tempo_serv, prazo_execucao_serv)
values (null,'Troca de Óleo',120.00,'00:45','Até 1 hora');

insert into Servico (id_serv, nome_serv, valor_serv, tempo_serv, prazo_execucao_serv)
values (null,'Revisão Elétrica',300.00,'02:00','Até 2 horas');

insert into Servico 
values (null,'Alinhamento e Balanceamento',150.00,'01:15','Até 2 horas');

insert into Servico 
values (null,'Troca de Pastilhas',180.00,'01:30','Até 1.5 horas');

desc cliente;
-- 8) CLIENTE 
insert into Cliente (id_cli, nome_completo_cli, cpf_cli, contato_cli, telefone_cli, genero_cli, id_cont_fk, id_end_fk)
values (null,'Woody','11111111111','WhatsApp','69990000111','M',1,1);

insert into Cliente (id_cli, nome_completo_cli, cpf_cli, contato_cli, telefone_cli, genero_cli, id_cont_fk, id_end_fk)
values (null,'Buzz Lightyear','22222222222','Telefone','69990000112','M',2,2);

insert into Cliente 
values (null,'Mike Wazowski','33333333333','E-mail',3,3,'M','69990000113');

insert into Cliente 
values (null,'Relâmpago McQueen','44444444444','App',4,4,'M','69990000114');

desc funcionario;
-- 9) FUNCIONARIO 
insert into Funcionario (id_func, nome_func, cpf_func, salario_func, funcao_func, data_nascimento_func)
values (null,'Tony Stark','55555555555',8000.00,'Mecânico Chefe','1970-05-29');

insert into Funcionario (id_func, nome_func, cpf_func, salario_func, funcao_func, data_nascimento_func)
values (null,'Steve Rogers','66666666666',7000.00,'Gerente','1918-07-04');

insert into Funcionario 
values (null,'Peter Parker','77777777777',2500.00,'Atendente',4,4,'Noite','1995-08-10');

insert into Funcionario 
values (null,'Clark Kent','88888888888',3000.00,'Auxiliar',3,3,'Manhã','1985-06-18');


-- 10) COMPRA
insert into Compra (id_comp, valor_comp, data_comp, forma_pagamento_comp, observacao_comp)
values (null,1200.00,'2025-06-15','Boleto','Compra de filtros e correias');

insert into Compra (id_comp, valor_comp, data_comp, forma_pagamento_comp, observacao_comp)
values (null,2400.00,'2025-06-20','Cartão','Pastilhas e baterias');

insert into Compra 
values (null,3600.00,'2025-06-22','Transferência','Peças diversas');

insert into Compra 
values (null,500.00,'2025-06-25','PIX','Compra de lubrificante');

desc Itens_Compra;
-- 11) ITENS_COMPRA (referenciando Peca e Compra)
insert into Itens_Compra (id_itc, quant_itc, valor_itc, desconto_itc, id_pec_fk, id_comp_fk)
values (null,10,35.90,0.00,1,1);

insert into Itens_Compra (id_itc, quant_itc, valor_itc, desconto_itc, id_pec_fk, id_comp_fk)
values (null,5,89.50,5.00);

insert into Itens_Compra 
values (null,8,129.00,2,2,0.0);

insert into Itens_Compra 
values (null,3,549.00,4,2,30);

-- 12) CARRO (referencia Cliente)
insert into Carro (id_car, descricao_car, placa_car, chassi_car, id_cli_fk, cor_car, observacoes_car)
values (null,'HB20 1.0 Comfort','QTA1A23','9BWZZZ377VT004251',1,'Prata','Ruído ao frear');

insert into Carro (id_car, descricao_car, placa_car, chassi_car, id_cli_fk, cor_car, observacoes_car)
values (null,'Onix 1.4 LTZ','QTB2B34','9BWZZZ377VT004252',2,'Preto','Revisão 40.000km');

insert into Carro 
values (null,'Gol 1.6 MSI','QTC3C45','9BWZZZ377VT004253',3,'Branco','Trocar correia');

insert into Carro 
values (null,'Sandero 1.6','QTD4D56','9BWZZZ377VT004254',4,'Vermelho','Luz da injeção acesa');

-- 13) ORCAMENTO
insert into Orcamento (id_orc, data__orc, valor_orc, horario_orc, status_orc)
values (null,'2025-06-30',320.00,'09:00:00','rascunho');

insert into Orcamento (id_orc, data__orc, valor_orc, horario_orc, status_orc)
values (null,'2025-07-01',680.00,'10:30:00','rascunho');

insert into Orcamento 
values (null,'2025-07-02',180.00,'14:00:00','rascunho');

insert into Orcamento 
values (null,'2025-07-03',450.00,'08:30:00','rascunho');

-- 14) ORCAMENTO_CLIENTE
insert into Orcamento_Cliente (id_orccli, valor_orccli, id_orc_fk, id_cli_fk, observacao_orccli)
values (null,320.00,1,1,'Troca de óleo + filtro');

insert into Orcamento_Cliente (id_orccli, valor_orccli, id_orc_fk, id_cli_fk, observacao_orccli)
values (null,680.00,2,2,'Freios + bateria');

insert into Orcamento_Cliente 
values (null,180.00,3,3,'Troca de pastilhas');

insert into Orcamento_Cliente 
values (null,450.00,4,4,'Revisão completa');

-- 15) ORCAMENTO_SERVICO
insert into Orcamento_Servico (id_orc_serv, descrecao_orc_serv, id_orc_fk, id_serv_fk, desconto_orc_serv)
values (null,'Troca de Óleo',1,1,0.00);

insert into Orcamento_Servico (id_orc_serv, descrecao_orc_serv, id_orc_fk, id_serv_fk, desconto_orc_serv)
values (null,'Revisão Elétrica',2,2,20.00);

insert into Orcamento_Servico 
values (null,'Alinhamento',3,3,0.00);

insert into Orcamento_Servico 
values (null,'Troca de Pastilhas',4,4,10.00);

-- 16) ORCAMENTO_PECA
insert into Orcamento_Peca (id_orc_pec, descrecao_orc_pec, id_orc_fk, id_pec_fk, desconto_orc_pec)
values (null,'Filtro de Óleo',1,1,0.00);

insert into Orcamento_Peca (id_orc_pec, descrecao_orc_pec, id_orc_fk, id_pec_fk, desconto_orc_pec)
values (null,'Pastilha de Freio',2,2,5.00);

insert into Orcamento_Peca 
values (null,'Correia Dentada',3,3,0.00);

insert into Orcamento_Peca 
values (null,'Bateria 60Ah',4,4,30.00);

-- 17) ORCAMENTO_FUNCIONARIO
insert into Orcamento_Funcionario (id_orc_func, descrecao_orc_func, id_orc_fk, id_func_fk, observacao_orc_func)
values (null,'Execução Orçamento 1',1,1,'Agendado de manhã');

insert into Orcamento_Funcionario (id_orc_func, descrecao_orc_func, id_orc_fk, id_func_fk, observacao_orc_func)
values (null,'Execução Orçamento 2',2,2,'Trocar peça ao chegar');

insert into Orcamento_Funcionario 
values (null,'Execução Orçamento 3',3,3,'Testes elétricos');

insert into Orcamento_Funcionario 
values (null,'Execução Orçamento 4',4,4,'Detalhes anotados');

-- 18) VENDA
insert into Venda (id_vend, data_vend, valor_vend, forma_recebimento_vend, id_func_fk, id_cli_fk, status_vend)
values (null,'2025-07-10',420.00,'PIX',1,1,'fechada');

insert into Venda (id_vend, data_vend, valor_vend, forma_recebimento_vend, id_func_fk, id_cli_fk, status_vend)
values (null,'2025-07-11',850.00,'Cartão',2,2,'fechada');

insert into Venda 
values (null,'2025-07-12',180.00,'Dinheiro',3,3,'aberta');

insert into Venda 
values (null,'2025-07-13',1250.00,'Boleto',4,4,'aberta');

-- 19) VENDA_SERVICO
insert into Venda_Servico (id_vend_serv, quant_vend_serv, id_serv_fk, id_vend_fk, desconto_vend_serv)
values (null,1,1,1,0.00);

insert into Venda_Servico (id_vend_serv, quant_vend_serv, id_serv_fk, id_vend_fk, desconto_vend_serv)
values (null,1,2,2,10.00);

insert into Venda_Servico 
values (null,1,3,3,0.00);

insert into Venda_Servico 
values (null,1,4,4,5.00);

-- 20) VENDA_PECA
insert into Venda_Peca (id_vend_pec, quant_vend_pec, id_pec_fk, id_vend_fk, desconto_vend_pec)
values (null,1,1,1,0.00);

insert into Venda_Peca (id_vend_pec, quant_vend_pec, id_pec_fk, id_vend_fk, desconto_vend_pec)
values (null,1,2,2,50.00);

insert into Venda_Peca 
values (null,2,3,3,0.00);

insert into Venda_Peca 
values (null,1,4,4,100.00);

-- 21) PAGAMENTO (referencia Caixa e Despesa)
insert into Pagamento (id_pag, data_vencimento_pag, valor_pag, status_pag, metodo_pag, id_cai_fk, id_desp_fk)
values (null,'2025-07-10',153.69,'Pago','Boleto',1,1);

insert into Pagamento (id_pag, data_vencimento_pag, valor_pag, status_pag, metodo_pag, id_cai_fk, id_desp_fk)
values (null,'2025-07-10',478.93,'Pago','Débito',1,2);

insert into Pagamento 
values (null,'2025-07-10',129.90,'Pago',2,3,'PIX');

insert into Pagamento 
values (null,'2025-07-05',4500.00,'Pago',3,4,'Transferência');

-- 22) RECEBIMENTO (referencia Caixa e Venda)
insert into Recebimento (id_rec, data_vencimento_rec, valor_rec, parcela_rec, metodo_rec, id_cai_fk, id_vend_fk)
values (null,'2025-07-10',420.00,'1/1','PIX',1,1);

insert into Recebimento (id_rec, data_vencimento_rec, valor_rec, parcela_rec, metodo_rec, id_cai_fk, id_vend_fk)
values (null,'2025-07-11',850.00,'1/1','Cartão',1,2);

insert into Recebimento 
values (null,'2025-07-12',180.00,'1/1',2,3,'Dinheiro');

insert into Recebimento 
values (null,'2025-07-13',1250.00,'1/1',2,4,'Boleto');

-- 23) AGENDAMENTO (referencia Cliente, Carro, Funcionario, Servico)
insert into Agendamento (id_agend, data_agend, horario_agend, descricao_agend, id_cli_fk, id_car_fk, id_func_fk, id_serv_fk, status_agend)
values (null,'2025-07-15','09:00:00','Troca de óleo e filtro',1,1,1,1,'agendado');

insert into Agendamento (id_agend, data_agend, horario_agend, descricao_agend, id_cli_fk, id_car_fk, id_func_fk, id_serv_fk, status_agend)
values (null,'2025-07-16','11:00:00','Revisão elétrica completa',2,2,2,2,'agendado');

insert into Agendamento (id_agend, data_agend, horario_agend, descricao_agend, id_cli_fk, id_car_fk, id_func_fk, id_serv_fk, status_agend)
values (null,'2025-07-17','14:00:00','Alinhamento e balanceamento',3,3,3,3,'agendado');

insert into Agendamento (id_agend, data_agend, horario_agend, descricao_agend, id_cli_fk, id_car_fk, id_func_fk, id_serv_fk, status_agend)
values (null,'2025-07-18','16:00:00','Troca de pastilhas dianteiras',4,4,4,4,'agendado');

select * from despesas;

select * from peca;

select * from servico;

select * from cliente;

select * from carro;

select * from funcionario;

select * from compra;

select * from itens_compra;

select * from caixa;

select * from pagamento;

select * from orcamento;

select * from orcamento_cliente;

select * from venda;

select * from orcamento_servico;

select * from venda_servico;

select * from venda_peca;

select * from orcamento_peca;

select * from recebimento;

select * from orcamento_funcionario;

select * from agendamento;

select * from contato;

select * from endereco;