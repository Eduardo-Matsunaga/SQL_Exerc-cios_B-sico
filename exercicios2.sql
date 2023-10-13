
--1 ) Fazer um exercício em pl/sql com declaração de variável que mostre os
--números de 1 a 100 que são múltiplos de 4, e quais são impares e pares.
/* DECLARE @cont as int
set @cont=1


WHILE @cont <100
	BEGIN
		if @cont %4 = 0
			BEGIN
				SELECT @cont,'Multiplo de 4'
			END
		if @cont %2 = 0
			BEGIN
				SELECT @cont,'Numero par'
			END
			else
			select @cont,'numero impar'
		set @cont=@cont +1
	END
	*/




-- 2)Desenvolver um programa em pl/sql com declaração de variável que mostre de 1
--a 200, apenas os números múltiplos de 5 e no final a soma de todos e a qtde dos
--múltiplos. 

/*DECLARE @cont as int, @soma as int,@qtde as int 
SET @cont=1
SET @soma=0
SET @qtde=0

WHILE @cont <=200 
	BEGIN	
		IF @cont %5=0
			BEGIN
				SELECT @cont,'Multiplo de 5'
				SET @soma=@soma+@cont
				SET @qtde=@qtde+1
			END
		SET @cont=@cont+1
	END

SELECT 'A soma é ',@soma,'e a quantidade de multiplos é ',@qtde */



--3)Utilizando declaração de variável em pl/sql mostre os meses por extenso a
--partir da funçaõ getdate()./*DECLARE @mes as intSET @mes=  month(getdate())SELECT @mes as Mês,CASE	WHEN @mes=1 then 'Janeiro'	WHEN @mes=2 then 'Fevereiro'	WHEN @mes =3 then 'Março'	WHEN @mes =4 then 'abril'	when @mes = 5 then 'Maio'
	when @mes = 6 then 'Junho'
	when @mes = 7 then 'Julho'
	when @mes = 8 then 'Agosto'
	when @mes = 9 then 'Setembro'
	when @mes = 10 then 'Outubro'
	when @mes = 11 then 'Novembro'
	when @mes = 12 then 'Dezembro'END as 'Mês por extenso'*/-- 4)Verificar se o número de alunos de uma turma é maior que 5.
/*CREATE TABLE [Alun]
(Cont Int NOT NULL Identity(1,1) --Contador automático
,NomeFunc Varchar(100) NOT NULL
,CPF CHAR(11) NOT NULL
,DataNcto SMALLDATETIME NOT NULL
,salario NUMERIC(6,2) NOT NULL,
)INSERT alun VALUES ('Eduardo','1234567','20010824',1000,'ADS B')
INSERT alun VALUES ('Eduardo','1234567','20010824',1000,'ADS B')
INSERT alun VALUES ('Eduardo','1234567','20010824',1000,'ADS B')


INSERT alun VALUES ('Eduardo','1234567','20010824',1000,'ADS B')
select*from alun

DECLARE @qtdeAlunos as int
DECLARE @turma as char(10)

SET @turma ='ADS B'
SET @qtdeAlunos=  (SELECT count(*) FROM alun where Turma=@turma)

IF @qtdeAlunos>5 
	print ('Maior que 5 e numero de alunos igual a '+ CONVERT(char(10),@qtdeAlunos))
ELSE
	print ('Menor que 5 e numero de alunos igual a '+CONVERT(char(10),@qtdeAlunos))

	ALTER TABLE alun
	drop column Matricula;
	delete from alun
	where Turma= 'ADS B';
	*/


-- 5)Usar declaração de variáveis para mostrar um desconto de 10% para mensalidade
--maior que 1000, e para menores desconto de 5% a um determinado aluno apenas.

	

/*INSERT aluno VALUES ('Eduardo','1234567','20010824',1500,'ADS B')
INSERT aluno VALUES ('Matheus','1234567','20010824',1000,'ADS A')
INSERT aluno VALUES ('Vitor','1234567','20010824',800,'ADS C') */

/* update Aluno
set mensalidade=Case
					WHEN mensalidade>1000 then mensalidade - (mensalidade*0.1)
					WHEN mensalidade <1000 then mensalidade -(mensalidade *0.05)
					ELSE mensalidade

				END;
SELECT*FROM Aluno */

/* DECLARE @mensalidade  NUMERIC(6,2)
DECLARE @nome VARCHAR(30)

set @nome ='Eduardo'
set @mensalidade=(SELECT top 1 mensalidade from aluno where NomeAluno =@nome)

IF @mensalidade > 1000
	BEGIN
		set @mensalidade =@mensalidade*0.1
		print ('10%: '+convert(char(10),@mensalidade))
	END
ELSE
	BEGIN
		set @mensalidade=@mensalidade*0.05
		print ('5%: '+ convert(char (10),@mensalidade))
	END */ 


	/* 6) Conceder gratificação de 10% para os funcionários que fazem aniversário no mês corrente.
declare @mesCorrente int, @salario numeric(7,2), @nome varchar(50)
set @mesCorrente= Month(getdate()) */


/* CREATE TABLE funcionario
(Cont Int NOT NULL Identity(1,1) --Contador automático
,NomeFunc Varchar(100) NOT NULL
,CPF CHAR(11) NOT NULL
,DataNcto SMALLDATETIME NOT NULL
,SALARIO NUMERIC(6,2) NOT NULL
,departamento char(11) NOT NULL
)INSERT funcionario VALUES ('Eduardo','1234567','20010424',1000,'RH')
INSERT funcionario VALUES ('Vitor','1234567','20010824',1000,'TI')
INSERT funcionario VALUES ('Matheus','1234567','20010424',1000,'RH') 

UPDATE funcionario
set DataNcto='20010122'
WHERE NomeFunc LIKE 'E%'
SELECT * FROM funcionario */

/* SELECT * FROM funcionario 

DECLARE @salario numeric(7,2)
DECLARE @nome varchar(50) 
DECLARE @msg varchar(50)
DECLARE @mesCorrente as int

set @mesCorrente=Month(getdate())



IF ((SELECT count(*) FROM funcionario where month(DataNcto)=@mescorrente)=0) 
	BEGIN	
		print 'Nenhum funcionario faz aniversario este mes'
	END
ELSE
	BEGIN
		SElECT top 1 @nome=NomeFunc, @salario=SALARIO FROM funcionario where Month(DataNcto)=@mesCorrente

		set @salario = @salario+(@salario * 0.1)

		print ('Olá ' + @nome + ' você é o Aniversariante do mês, você recebeu um
		gratificação de 10% este mês!!!')

		print ('Deste modo seu salário este mês vai ser igual a R$' +
		CONVERT(VARCHAR(50),@salario))
	END */
	

/* 7)Calcular desconto de 1,5% para os funcionários do departamento de RH
declare @salario numeric(7,2), @departamento varchar(50), @nome varchar(50) */

/* DECLARE @salario numeric (7,2)
DECLARE @departamento varchar(50)
DECLARE @nome varchar(50)

SET @departamento='RH'

IF (SELECT count(*) from funcionario where departamento=@departamento)=0
	BEGIN	
		PRINT 'nao existe funcionarios no departamento do RH'
	END
ELSE
	BEGIN
		SELECT top 1  @nome=NomeFunc,@salario=SALARIO from funcionario where departamento=@departamento
		SET @salario= @salario-(@salario * 0.015)
		print 'Ola '+@nome+'Seu salario atual apos o calculo é: '+convert(varchar(50),@salario)
	END */


-- 8) Calcular aumento 15% para os funcionários do departamento de TI

 /*DECLARE @salario numeric(7,2), @nome varchar(50), @departamento varchar(50)

set @departamento='TI'

IF(SELECT count(*) from funcionario where departamento=@departamento)=0
	BEGIN
		print 'Niguem no seto de t.i'
	END
ELSE
	BEGIN
		SELECT top 1 @nome=NomeFunc, @salario=@SALARIO from funcionario where departamento=@departamento
		set @salario = @salario * 1.15
		print ('PARABENS '+@nome+' VC RECEBEU UM AUMENTO AGORA SEU SALARIO É: '+CONVERT(char(50),@salario))
	END 

	print CONVERT(char(50),@salario)*/



	
 /* declare @salario numeric(7,2), @departamento varchar(50), @nome varchar(50)
set @departamento = 'TI'
-------------------------------------------------------
--Verifica se tem algum Funcionário no derpatamento de TI no Banco de Dados
If (select COUNT(*) from funcionario where DEPARTAMENTO=@departamento) = 0
 print 'Não temos nenhum Funcionário no derpatamento de TI.'
ELSE
 begin
 select top 1 @nome=NomeFunc,
 @salario=SALARIO
 from funcionario where DEPARTAMENTO=@departamento

 
 print ('SR(a). ' + @nome + ', voce recebeu um aumento em seu salario este
mês.')
 print ('Deste modo seu salário este mês vai ser igual a R$' +
CONVERT(VARCHAR(50),@salario))
 end */





 -- 1) Crie uma stored procedure que selecione os alunos do município de Curitiba
  create table ALUNO2
(matricula int primary key,
nome varchar(100),
turma varchar(100),
mensalidade numeric(7,2),
nota1 numeric(3,1),
nota2 numeric(3,1),
municipio varchar(100))


insert ALUNO2 values(1,'José','3a',1500, 8,9, 'Curitiba')
insert ALUNO2 values(2,'Maira','3B',500, 2,9, 'São José dos Pinhais')
insert ALUNO2 values(3,'Pedro','3a',2500, 6,5, 'Curitiba')
insert ALUNO2 values(4,'Tereza','3B',500, 9,9, 'São José dos Pinhais')
insert ALUNO2 values(5,'Marli','3a',3500, 4,2, 'Curitiba')
insert aluno2 values(6,'Roberto','3B',750, 8,9, 'Curitiba')
insert ALUNO2 values(7,'Carlos','3a',100, 7,5, 'São José dos Pinhais')
insert aluno2 values(8,'Maria','3B',2500, 10,8, 'Curitiba')
insert aluno2 values(9,'Francisco','3a',3500, 4,3, 'Curitiba')
insert aluno2 values(10,'Marialva','3B',4500, 8,9, 'São José dos Pinhais')

select * from aluno2 /* CREATE PROCEDURE sp_alunoCwb
as
SELECT*FROM aluno2 WHERE municipio='Curitiba'
EXEC aluno_cwb */


--2) Crie uma stored procedure que selecione o número de alunos do município
--de São José dos Pinhais com média maior ou igual a 7.

/* CREATE PROCEDURE sp_alunoMedia
as
SELECT*FROM ALUNO2 WHERE municipio='São José dos Pinhais'
and (nota1+nota2)/2 >= 7
exec sp_alunoMedia */

--3) Crie uma stored procedure que some o valor das mensalidades por
--município passando o nome do município por parâmetro


/* CREATE PROCEDURE sp_mensalidadeSoma
 @municipio varchar(100)
as
SELECT sum(mensalidade) FROM ALUNO2 where municipio=@municipio
exec sp_mensalidadeSoma 'curitiba' */


--4) Crie uma stored procedure que calcule a média de um aluno, passando a
--matricula do mesmo como parâmetro e informe se o mesmo está aprovado
--para média maior igual a sete, reprovado para média menor que quatro e em
--recuperação para médias maiores ou igual a quatro e menores que sete.

 /* ALTER PROCEDURE sp_alunoMedia
@matricula int 
as 
DECLARE @media numeric(3,1), @nome varchar(50)

SET @media= (SELECT (nota1+nota2)/2 FROM ALUNO2 WHERE matricula=@matricula)
SET @nome= (SELECT nome FROM ALUNO2 WHERE matricula=@matricula)

IF @media>=7
	BEGIN
		PRINT @nome+' Aprovado com media: '+ convert(CHAR(10),@media)
	END

ELSE
	BEGIN
		IF @media <4
			BEGIN
				PRINT @nome+' REPROVADO com media: '+convert(char(10),@media)
			END
	ELSE
	BEGIN
		PRINT @nome+' em recuperação '+convert(char(10),@media)
	END
	end

EXEC sp_alunoMedia 7 */

CREATE PROCEDURE sp_MediaAlunosMun
as
select nome as 'Nome do Aluno', ((nota1+nota2)/2) as 'Média', municipio
FROM ALUNO2 WHERE municipio='Curitiba'
exec sp_MediaAlunosMun

SELECT nome from Aluno2



/* Desenvolva_o exercicio em PL/SQL de trigger utilizando as tabelas nota
(numero,codcli,data, valor qtde) e cliente (codcli,nome,cidade, pinss,pipi

Desenvolver uma trigger para controlar a geraco de uma nova nota, para isso criar uma nova
tabela com 0 nome audit e os campos (numero da nota, codcli, valor total, valor inss, valor
pipi,valor picm) */

CREATE OR ALTER TRIGGER TRproduto ON PRODUTO2FOR INSERT
AS
BEGIN
	DECLARE @prod_id int, @valor_total float, @inss float

	SELECT @prod_id = id, @inss= inss, @valor_total= (qtde*unit) from inserted

	INSERT INTO nova_tabela VALUES(@prod_id, @inss, @valor_total)
END

INSERT INTO produto (id, qtde, vlr_unit) VALUES (1, 10, 5.5)






create prod_cursor CURSOR FOR 
SELECT Cod, nome, valor from produto2

--declarações
DECLARE @cod int, @nome varchar(20), @valor FLOAT

OPEN prod_cursor 
FETCH NEXT FROM prod_cursor INTO @cod, @nome, @valor WHILE @@FETCH_STATUS = 0
BEGIN
	
FETCH NEXT FROM´prod_cursor INTO @cod, @nome, @valor
END
close prod_cursor
deallocate prod_cursor


