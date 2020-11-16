create database if not exists db_Faculdade;
use db_Faculdade;

create table if not exists tbl_Departamento (
 id_Departamento tinyint auto_increment primary key,
 Nome_departamento varchar(20) not null
);

create table if not exists tbl_Professor (
 id_Professor tinyint auto_increment primary key,
 Nome_professor varchar(40) not null,
 Sobrenome_professor varchar(40) not null,
 CPF varchar(20),
 Status_professor varchar(10),
 id_Departamento tinyint,
 constraint fk_id_Departamento foreign key(id_Departamento) references tbl_Departamento (id_Departamento)
);

ALTER TABLE tbl_professor MODIFY COLUMN Status_professor varchar(10);

 create table if not exists tbl_Curso (
 id_Curso tinyint auto_increment primary key,
 Nome_curso varchar(50),
 id_Departamento tinyint,
 constraint fk_idDepartament foreign key (id_Departamento) references tbl_Departamento (id_Departamento)
 );
 
 create table if not exists tbl_Turma (
 id_Turma tinyint primary key auto_increment,
 id_Curso tinyint not null,
 Periodo varchar(10),
 Num_Alunos varchar(5) not null,
 Data_Inicio date,
 Data_Fim date,
constraint fk_id_Curso foreign key (id_Curso) references tbl_Curso (id_Curso)
);

create table if not exists tbl_Disciplina (
 id_Disciplina smallint auto_increment primary key,
 Nome_disciplina varchar(50),
 id_Departamento tinyint not null,
 Carga_horaria integer not null,
 Descrição varchar(100),
 Num_alunos integer not null,
 constraint fk_id_Departamento_Disciplina foreign key (id_Departamento) references tbl_Departamento (id_Departamento)
);

create table if not exists tbl_Prof_Disciplina (
 id_Disciplina smallint not null,
 id_Professor tinyint not null,
 primary key (id_Professor, id_Disciplina),
 constraint fk_Prof_Disc_Prof foreign key (id_Professor) references tbl_Professor (id_Professor),
 constraint fk_Disc_Prof_Disc foreign key (id_Disciplina) references tbl_Disciplina (id_Disciplina)
);

create table if not exists tbl_Curso_Disciplina (
 id_Curso tinyint not null,
 id_Disciplina smallint not null,
 primary key (id_Curso, id_Disciplina), 
 constraint fk__Curso_Disc_Curso foreign key (id_Curso) references tbl_Curso (id_Curso),
 constraint fk_Disc_Curso_Disc foreign key (id_Disciplina) references tbl_Disciplina (id_Disciplina)
);

create table if not exists tbl_Aluno (
 RA integer auto_increment primary key,
 Nome_aluno varchar(40) not null,
 Sobrenome_aluno varchar(40) not null,
 CPF varchar(20) not null,
 Status_aluno varchar(10),
 id_Turma tinyint not null,
 id_Curso tinyint,
 Email varchar(50) not null,
 constraint fk_Turma_Aluno foreign key (id_Turma) references tbl_Turma (id_Turma),
 constraint fk_Curso_Aluno foreign key (id_Curso) references tbl_Curso (id_Curso)
);

ALTER TABLE tbl_aluno MODIFY COLUMN Status_aluno varchar(10);

create table if not exists tbl_Periodo(
id_Periodo tinyint primary key auto_increment,
Periodo varchar(10) not null,
id_turma tinyint,
constraint fk_Turma_Periodo foreign key (id_Turma) references tbl_turma (id_Turma)
);

create table if not exists tbl_Aluno_Disc (
 RA integer not null,
 id_Disciplina smallint not null,
 primary key (RA, id_Disciplina),
 constraint fk_RA_Aluno foreign key (RA) references tbl_Aluno (RA),
 constraint fk_Disciplina_Aluno foreign key (id_Disciplina) references tbl_Disciplina (id_Disciplina)
);

create table if not exists tbl_Historico (
 id_Historico tinyint auto_increment primary key,
 RA integer not null,
 periodo varchar(10),
 constraint fk_RA foreign key (RA) references tbl_Aluno (RA)
);

create table if not exists tbl_Disc_Hist (
 id_Historico tinyint not null,
 id_Disciplina smallint not null,
 Nota integer,
 Frequência integer,
 primary key (id_Historico, id_Disciplina), 
 constraint fk_id_Historico foreign key (id_Historico) references tbl_Historico (id_Historico),
 constraint fk_Disciplina_Hist foreign key (id_Disciplina) references tbl_Disciplina (id_Disciplina)
);

create table if not exists tbl_Tipo_Telefone(
 id_Tipo_Telefone tinyint auto_increment primary key,
 Tipo_Telefone varchar(8)
);

create table if not exists tbl_Telefone (
 id_Telefone tinyint primary key auto_increment,
 RA integer not null,
 id_Tipo_Telefone tinyint not null,
 Telefone varchar(20) not null,
 constraint fk_RA_Tel foreign key (RA) references tbl_Aluno (RA),
 constraint fk_id_Tipo_Telefone foreign key (id_Tipo_Telefone) references tbl_Tipo_Telefone (id_Tipo_Telefone)
);

create table if not exists tbl_Tipo_Logradouro (
 id_Tipo_Logradouro tinyint primary key auto_increment,
 Tipo_Logradouro varchar(10)
);

create table if not exists tbl_Endereco_Aluno (
 id_Endereco_Aluno tinyint primary key auto_increment,
 RA integer not null,
 id_Tipo_Logradouro tinyint not null,
 Rua varchar(50) not null,
 Numero varchar(4) not null,
 bairro varchar(50) not null,
 CEP varchar(8) not null,
 cidade varchar(40) not null,
 uf varchar(3) not null,
 constraint fk_RA_Endereco foreign key (RA) references tbl_Aluno (RA),
 constraint fk_id_Tipo_Lougradouro foreign key (id_Tipo_Logradouro) references tbl_Tipo_Logradouro (id_Tipo_Logradouro)
);

insert into tbl_departamento(id_departamento, Nome_departamento)
values('2', 'Depto. professores');
select * from tbl_departamento;

insert into tbl_disciplina(Nome_Disciplina, id_Departamento, Carga_horaria, Descrição, Num_alunos)
values('Lógica de Programação', 2, '60', 'Conceitos de lógica de programação', '64');
select * from tbl_disciplina;
UPDATE tbl_disciplina
SET Num_alunos = 30
WHERE id_Disciplina = 3;

insert into tbl_professor(Nome_professor, Sobrenome_professor, CPF, Status_professor, id_Departamento)
values('João', 'Silva', '7628323', 'Ativo', 2);
select * from tbl_professor;
delete from tbl_professor where id_professor=3;

insert into tbl_curso(Nome_curso, id_Departamento)
values('Análise e desenvolvimento de sistemas', '2');
select * from tbl_curso;
delete from tbl_curso where id_Curso=3;

insert into tbl_turma(id_Curso, Periodo, Num_Alunos, Data_Inicio, Data_Fim)
values(6, 'Manhã', '20', '2020-02-01', '2020-12-20');
select * from tbl_turma;

insert into tbl_aluno(Nome_aluno, Sobrenome_aluno, CPF, Status_aluno, id_Turma, id_Curso, Email)
values('Fernanda', 'Santos', '4568292900', 'Ativo', '3', '6', 'fernandasantos@gmail.com');
select * from tbl_aluno;

insert into tbl_periodo(periodo, id_turma)
values('Manhã', '3');
select * from tbl_periodo;

insert into tbl_historico(RA, periodo)
values('4', 'Manhã');
select * from tbl_historico;

insert into tbl_disc_hist(id_historico, id_Disciplina, Nota, Frequência)
values(2, 3, '10', '80');
select * from tbl_disc_hist;

insert into tbl_curso_disciplina(id_Curso, id_Disciplina)
values('6', '3');
select * from tbl_curso_disciplina;

insert into tbl_aluno_disc(RA, id_Disciplina)
values('4', '3');
select * from tbl_aluno_disc;

insert into tbl_prof_disciplina(id_Disciplina, id_Professor)
values('3', '4');
select * from tbl_prof_disciplina;

insert into tbl_tipo_telefone(Tipo_telefone)
values('Celular');
select * from tbl_Tipo_telefone;

insert into tbl_telefone(RA, id_Tipo_telefone, Telefone)
values('4', '1', '(11) 980807-8570');
select * from tbl_telefone;

insert into tbl_tipo_logradouro(Tipo_logradouro)
values('Rua');
select * from tbl_tipo_logradouro;

insert into tbl_endereco_aluno(RA, id_Tipo_Logradouro, Rua, Numero, bairro, CEP, cidade, uf)
values('4', '1', 'Rua Margaridas', '45A', 'Bairro Cerqueira César', '08480090', 'São Paulo', 'SP');
select * from tbl_endereco_aluno;

insert into tbl_departamento(id_departamento, nome_departamento)
values('3', 'aluno');
select * from tbl_departamento;



