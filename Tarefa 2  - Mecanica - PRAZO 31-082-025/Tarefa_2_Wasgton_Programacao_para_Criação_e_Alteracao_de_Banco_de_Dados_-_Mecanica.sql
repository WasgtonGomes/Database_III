
#Tarefa 2 - Programação para Criação e Alteração de Banco de Dados - Mecânica - PRAZO: 31/08/2025 Wasgton Gomes Pereira


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
id_cli_fk int not null,
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
id_pec_fk integer not null,
id_comp_fk integer not null,
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
id_cai_fk integer not null,
id_desp_fk integer not null,
foreign key (id_cai_fk) references Caixa (id_cai),
foreign key (id_desp_fk) references Despesas (id_desp)
);

create table Orcamento (
id_orc integer not null primary key auto_increment,
data__orc date not null,
valor_orc float not null,
horario_orc time not null
);

create table Orcamento_Cliente (
id_orccli integer not null primary key auto_increment,
valor_orccli float not null,
id_orc_fk integer not null,
id_cli_fk integer not null,
foreign key (id_orc_fk) references Orcamento (id_orc),
foreign key (id_cli_fk) references Cliente (id_cli)
);

create table Venda (
id_vend integer not null primary key auto_increment,
data_vend date,
valor_vend double not null,
forma_recebimento_vend varchar (50),
id_func_fk integer not null,
id_cli_fk integer not null,
foreign key (id_func_fk) references Funcionario (id_func),
foreign key (id_cli_fk) references Cliente (id_cli)
);

create table Orcamento_Servico (
id_orc_serv integer not null primary key auto_increment,
descrecao_orc_serv varchar (300) not null, 
id_orc_fk integer not null,
id_serv_fk integer not null,
foreign key (id_orc_fk) references Orcamento (id_orc),
foreign key (id_serv_fk) references Servico (id_serv)
);

create table Venda_Servico (
id_vend_serv integer not null primary key auto_increment,
quant_vend_serv integer not null,
id_serv_fk integer not null,
id_vend_fk integer not null,
foreign key (id_serv_fk) references Servico (id_serv),
foreign key (id_vend_fk) references Venda (id_vend)
);

create table Venda_Peca (
id_vend_pec integer not null primary key auto_increment,
quant_vend_pec integer not null,
id_pec_fk integer not null,
id_vend_fk integer not null,
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
id_vend_fk integer not null,
foreign key (id_cai_fk) references Caixa (id_cai),
foreign key (id_vend_fk) references Venda (id_vend)
);

create table Orcamento_Funcionario (
id_orc_func integer not null primary key auto_increment,
descrecao_orc_func varchar (300) not null, 
id_orc_fk integer not null,
id_func_fk integer not null,
foreign key (id_orc_fk) references Orcamento (id_orc),
foreign key (id_func_fk) references Funcionario (id_func)
);


#2. Crie a tabela Agendamento e faça relações com ALTER TABLE.

create table Agendamento (
id_agend integer not null primary key auto_increment,
data_agend date not null, 
horario_agend time not null,
descricao_agend varchar(300) not null
);

alter table Agendamento add column id_cli_fk integer not null,
add column id_car_fk integer not null,
add column id_serv_fk integer not null;

alter table Agendamento add constraint id_cli_fk foreign key (id_cli_fk) references Cliente (id_cli),
add constraint id_car_fk foreign key (id_car_fk) references Carro (id_car),
add constraint id_serv_fk foreign key (id_serv_fk) references Servico (id_serv);

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

alter table Cliente add column id_cont_fk integer not null;
alter table Cliente add column id_end_fk integer not null;
alter table Cliente add constraint fk_cli_cont foreign key (id_cont_fk) references Contato (id_cont);
alter table Cliente add constraint fk_cli_end foreign key (id_end_fk) references Endereco (id_end);

alter table Fornecedor add column id_cont_fk integer not null;
alter table Fornecedor add column id_end_fk integer not null;
alter table Fornecedor add constraint fk_forn_cont foreign key (id_cont_fk) references Contato (id_cont);
alter table Fornecedor add constraint fk_forn_end foreign key (id_end_fk) references Endereco (id_end);

alter table Funcionario add column id_cont_fk integer not null;
alter table Funcionario add column id_end_fk integer not null;
alter table Funcionario add constraint fk_func_cont foreign key (id_cont_fk) references Contato (id_cont);
alter table Funcionario add constraint fk_func_end foreign key (id_end_fk) references Endereco (id_end);


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

alter table Funcionario drop column cpf_func;

#7. Remova a coluna email da tabela Cliente.

alter table Cliente drop column email_cli;

#8. Remova a coluna status da tabela Recebimento.

alter table Recebimento drop column status_rec;

#9. Remova a coluna parcela da tabela Pagamento.

alter table Pagamento drop column parcela_pag;

#10. Remova a coluna descricao da tabela Carro.

alter table Carro drop column descricao_car;

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

select * from despesas;
select * from fornecedor;
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


#Peso: 20 pontos participação (média N atividades)
