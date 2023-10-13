-- 1) Criar uma tabela produto com os campos codigo, nome, UF, cidade, valor, percentual
--ICMS e percentual de IPI, inserir 5 registros na tabela e mostrar com uso de cursor todos
--os produtos da UF SP, PR, SC o nome o valor e os percentuais de ICMS e IPI, bem como
--os respectivos valores (valor multiplicado pelo percentual de ICMS e IPI). No final
--apresentar o valor total dos produtos e os valores totais de ICMS e IPI.

 create table produto2
(
 Cod int primary key,
 Nome varchar(50),
 UF int,
 Cidade varchar(50),
 valor numeric (12,2),
 ICMS numeric (3,1),
 IPI numeric  (3,1),
)

insert into produto2 values(1,'Monitor', 41, 'Curitiba', 1500, 24.6, 15)
insert into produto2 values(2,'Desktop', 30, 'Acre', 4500, 89.4, 7.2)
insert into produto2 values(3,'Processador', 40, 'Acre', 3000, 40.7, 3.7)
insert into produto2 values(4,'Mouse', 40, 'Acre', 430, 20.3, 8.5)
insert into produto2 values(5,'Teclado', 30, 'Acre', 200, 12.5, 4.8)

--Declaração do cursor
DECLARE produto_cursor CURSOR FOR
SELECT nome, valor, icms, ipi from produto2 where UF IN (35,41,42)

--Declaração para valores totais
DECLARE
  @valor_total Numeric(12, 2),
  @valor_icms_total Numeric(12, 2),
  @valor_ipi_total numeric(12, 2)

--Declaração valores do cursor
DECLARE @nome varchar(50), @valor numeric(12,2), @icms numeric(3,1), @ipi numeric(3,1);

OPEN produto_cursor 
FETCH NEXT FROM produto_cursor INTO @nome,@valor,@icms,@ipi WHILE @@FETCH_STATUS=0

-- Exibir informações do produto
BEGIN
	print('Nome: ' + @nome)
	print('Valor: ' + CAST(@valor as varchar(10)))
	print('Percentual de ICMS: ' + CAST((@icms/100) as varchar(10)))
	print('Percentual de IPI: '+ CAST((@ipi/100) as varchar(10)))

--Calcula percentual icms, ipi e valores totais
	DECLARE @valor_icms numeric (12,2), @valor_ipi numeric (12,2)
	SET @valor_icms= @valor*(@icms/100)
	SET @valor_ipi= @valor*(@ipi/100)
	SET @valor_total = @valor + @valor_icms+@valor_ipi
	SET @valor_icms_total = @valor_icms_total + @valor_icms
	SET @valor_ipi_total = @valor_ipi_total + @valor_ipi

	print ('Valor ICMS: '+CAST(@valor_icms as varchar(10)))
	print ('Valor IPI: '+CAST(@valor_ipi as varchar(10)))
	print ('Valor total: '+ CAST(@valor_total as varchar(10)))

	FETCH NEXT FROM produto_cursor INTO @nome,@valor,@icms,@ipi;
END;
CLOSE produto_cursor
DEALLOCATE produto_cursor


/* 2) Criar uma tabela aluno com os campos codigo, nome, sexo, UF, cidade, nota1, nota2,
curso, mensalidade inserir 5 registros na tabela e mostrar com uso de cursor quantos alunos
são de cada curso e quantos são mulheres e homens, bem como o valor total das
mensalidades dos alunos por curso. Para os alunos que tem média acima 8 conceder um
desconto de 10% na mensalidade */

 create table aluno 
(
 Cod int primary key,
 Nome varchar(50),
 Sexo varchar(50),
 UF int,
 Cidade varchar(50),
 Nota1 float,
 Nota2 float,
 Curso varchar(50),
 Mensalidade numeric (12,6),
)

INSERT INTO aluno values (1,'Eduardo','M',41,'Curitiba',78,100,'ADS',420.70)
INSERT INTO aluno values (2,'Vitor','M',31,'São Paulo',59,61,'Direito',1420.70) 
INSERT INTO aluno values (3,'Juliana','F',35,'Amazonas',90,60,'Psicologia',2420.70) 
INSERT INTO aluno values (4,'Deide Costa','f',41,'Curitiba',40,87,'Enfermagem',3420.70) 
INSERT INTO aluno values (5,'Marcelo','M',41,'Curitiba',92,65,'ADS',420.70) 



-- Declaração do cursor 

DECLARE aluno_cursor CURSOR FOR 
SELECT cod,Curso, Sexo, Mensalidade, AVG((Nota1 + Nota2) / 2) AS Media
FROM aluno
GROUP BY cod,Curso, Sexo, Mensalidade;

-- Variáveis para contagem e totalização
DECLARE @curso VARCHAR(50);
DECLARE @sexo VARCHAR(50);
DECLARE @mensalidade NUMERIC(12, 6);
DECLARE @media FLOAT;
DECLARE @total_mensalidade NUMERIC(12, 6) = 0;
DECLARE @num_alunos_curso INT = 0;
DECLARE @num_alunas_curso INT = 0;
DECLARE @num_alunos_total INT = 0;
DECLARE @cod INT =0;

--Abrir Cursor 

OPEN aluno_cursor

FETCH NEXT FROM aluno_cursor INTO @cod, @curso,@sexo,@mensalidade,@media WHILE @@FETCH_STATUS=0
BEGIN
	IF @sexo ='M'
	BEGIN	
		SET @num_alunos_curso = @num_alunos_curso + 1
		SET @num_alunos_total = @num_alunos_total + 1
	END
	ELSE IF @sexo ='F'
	BEGIN	
		SET @num_alunas_curso = @num_alunas_curso + 1
		SET @num_alunos_total = @num_alunos_total + 1
	END

IF @media > 8
	BEGIN
		SET @total_mensalidade =@mensalidade - (@mensalidade * 0.1) 
	END

-- Exibir informações do aluno
  PRINT 'Curso: ' + @curso;
  PRINT 'Sexo: ' + @sexo;
  PRINT 'Mensalidade Total: ' + CAST(@total_mensalidade AS VARCHAR(20));
  PRINT 'Média: ' + CAST(@media AS VARCHAR(10));
  PRINT '-------------------';

FETCH NEXT FROM aluno_cursor INTO @Cod, @curso, @sexo, @mensalidade, @media;
END

PRINT 'Total de alunos por curso: ' + CAST(@num_alunos_curso AS VARCHAR(10));
PRINT 'Total de alunas por curso: ' + CAST(@num_alunas_curso AS VARCHAR(10));
PRINT 'Total de alunos: ' + CAST(@num_alunos_total AS VARCHAR(10));

-- Fechar o cursor
CLOSE aluno_cursor;

-- Desalocar o cursor
DEALLOCATE aluno_cursor;  

/*
 3) A partir das tabelas departamento e funcionário faça o relacionamento e desenvolva
usando cursor em programa em SQL que mostre o nome do funcionário, departamento,
salário total, valor de FGTS e Valor do INSS, no final apresentar o total geral do salário, do
FGTS e INSS, apenas dos departamentos 3 e 2, cuja a quantidade de horas seja maior que
200 e menor que 360 e o mês referente a data seja 2 e 4 apenas. */


 create table Funcionario
(
 Cod int primary key,
 Nome varchar(50),
 Salario numeric(12,2),
 Fgts int,
 Inss int,
)
INSERT INTO funcionario values(10,'Marcondes',3850.45,8,12)
INSERT INTO funcionario values(20,'Marcia Luz',4800,5,10)

create table Departamento
(
 Cod int primary key,
 Nome varchar(50),
 Qtde_horas int,
 Dataa date,
 CodFun int,
)
INSERT INTO Departamento values(2,'Financeiro',220,'20230428',10)
INSERT INTO Departamento values(3,'Qualidade',260,'20230218',20)

DECLARE @CodFuncionario int
DECLARE @NomeFuncionario varchar(50)
DECLARE @Departamento varchar(50)
DECLARE @SalarioTotal numeric(12, 2)
DECLARE @ValorFGTS int
DECLARE @ValorINSS int
DECLARE @TotalSalario numeric(12, 2)
DECLARE @TotalFGTS int
DECLARE @TotalINSS int

SET @TotalSalario = 0
SET @TotalFGTS = 0
SET @TotalINSS = 0


--Declaração do cursor e Relacionamento
DECLARE Funcionario_Cursor CURSOR FOR 
SELECT F.cod, F.nome, D.nome as Departamento, F.fgts, f.inss From Funcionario F
INNER JOIN Departamento D
ON F.Cod=D.CodFun

-- Abrir cursor
OPEN Funcionario_Cursor 

FETCH NEXt FROM Funcionario_Cursor INTO @CodFuncionario, @NomeFuncionario, @Departamento, @SalarioTotal, @ValorFGTS, @ValorINSS

WHILE @@FETCH_STATUS = 0 
BEGIN
	PRINT 'Nome do Funcionário: ' + @NomeFuncionario
    PRINT 'Departamento: ' + @Departamento
    PRINT 'Salário Total: ' + CAST(@SalarioTotal AS varchar)
    PRINT 'Valor do FGTS: ' + CAST(@ValorFGTS AS varchar)
    PRINT 'Valor do INSS: ' + CAST(@ValorINSS AS varchar)
    PRINT '---------------------------------'

    IF @Departamento IN ('Financeiro', 'Qualidade') AND Departamento.Qtde_horas > 200 AND Departamento.Qtde_horas < 360 AND MONTH(Departamento.Dataa) IN (2, 4)
    BEGIN
        SET @TotalSalario = @TotalSalario + @SalarioTotal
        SET @TotalFGTS = @TotalFGTS + @ValorFGTS
        SET @TotalINSS = @TotalINSS + @ValorINSS
    END

    FETCH NEXT FROM Funcionario_Cursor INTO @CodFuncionario, @NomeFuncionario, @Departamento, @SalarioTotal, @ValorFGTS, @ValorINSS
END

CLOSE Funcionario_Cursor
DEALLOCATE Funcionario_Cursor

PRINT '---------------------------------'
PRINT 'Total Geral do Salário: ' + CAST(@TotalSalario AS varchar)
PRINT 'Total do FGTS: ' + CAST(@TotalFGTS AS varchar)
PRINT 'Total do INSS: ' + CAST(@TotalINSS AS varchar)





/* 4) Fazer uma alteração a partir das tabelas departamento e funcionário faça o
relacionamento e desenvolva usando cursor em programa em SQL que altere o valor do
salário do funcionário para salário + valor de FGTS + Valor do INSS, apenas dos
departamentos ímpar, onde o dia referente a data do departamento seja maior que 10 e
menor de 30.*/


DECLARE @CodFuncionario int
DECLARE @Salario numeric(12, 2)
DECLARE @ValorFGTS int
DECLARE @ValorINSS int

DECLARE cursorFuncionario Cursor FOR
SELECT F.cod,F.Salario, F.fgts, f.inss From Funcionario F
INNER JOIN Departamento D
ON F.Cod=D.CodFun
WHERE D.Cod %2 != 0 
and DAY(D.dataa) > 10 
and DAY(D.dataa) < 30 

OPEN cursorFuncionario
FETCH NEXT FROM cursorFuncionario INTO @CodFuncionario, @Salario, @valorFgts, @valorInss
WHILE @@FETCH_STATUS = 0
BEGIN
	Update Funcionario
	SET Salario = @Salario + @ValorFGTS + @ValorINSS

	FETCH NEXT FROM cursorFuncionario INTO @CodFuncionario, @salario, @valorfgts, @valorinss
END
 CLOSE cursorFuncionario
 DEALLOCATE cursorFuncionario 
 

 /* 5) Fazer uma exclusão a partir das tabelas departamento e funcionário faça o
relacionamento e desenvolva usando cursor em programa em SQL que exclua os
departamentos onde os funcionários tem salário maior que 4000 e menor de 6000 e o
departamento seja diferente de compras e RH. */

DECLARE @CodDepartamento int
DECLARE @NomeDepartamento varchar(50)
DECLARE @SalarioFuncionario float

DECLARE DepartamentoCursor CURSOR FOR 
SELECT D.cod,D.nome,F.Salario from Departamento D 
INNER JOIN Funcionario F
ON d.CodFun=f.cod
WHERE f.Salario > 4000 AND f.Salario < 6000

--abrir o cursor
OPEN DepartamentoCursor 

FETCH NEXT FROM DepartamentoCursor INTO @codDepartamento, @NomeDepartamento, @SalarioFuncionario
WHILE @@FETCH_STATUS = 0 
BEGIN
	DELETE FROM Departamento WHERE Nome NOT IN ('compras','RH')
	PRINT 'Deparatmento ' + @NomeDepartamento + ' deletado com sucesso'
	FETCH NEXT FROM DepartamentoCursor INTO @CodDepartamento, @NomeDepartamento, @SalarioFuncionario
END

CLOSE DepartamentoCursor
DEALLOCATE DepartamentoCursor




























