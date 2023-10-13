-- 1) Elabore um exercício em PL/SQL com declaração de variável que mostre os números de 1 a 100 quais 
-- são múltiplos do quarto digito do seu RA (9), bem como a soma e a quantidade de todos os múltiplos.
/* DECLARE @cont int, @qtd int, @soma int
SET @cont= 0
SET @qtd =0
SET @soma=0
WHILE @cont <= 100 
	BEGIN	
		IF @cont %9= 0 
			BEGIN
				SET @soma= @cont +@soma
				SET @qtd= @qtd+1
				print CONVERT(char(10),@cont)+' é multiplo de 9'
			END
		SET @cont=@cont+1
	END
print convert(char(10),@soma)+'é a soma dos multiplos de 9'
print convert(char(10),@qtd)+'é a quantidade de multiplos de 9 de 1 até 100' */


-- 2) Crie um exercício em PL/SQL com declaração de variável que mostre a soma de todos os números de seu RA no caso 220921572.

/* DECLARE @soma int, @ra varchar(10)

set @ra='220921572'

-- Convert pois soma é int e substing para pegar em uma posição 
SET @soma = CONVERT(INT, SUBSTRING(@RA, 1, 1)) +
 CONVERT(INT, SUBSTRING(@RA, 2, 1)) +
 CONVERT(INT, SUBSTRING(@RA, 3, 1)) +
 CONVERT(INT, SUBSTRING(@RA, 4, 1)) +
 CONVERT(INT, SUBSTRING(@RA, 5, 1)) +
 CONVERT(INT, SUBSTRING(@RA, 6, 1)) +
 CONVERT(INT, SUBSTRING(@RA, 7, 1 )) +
 CONVERT(INT, SUBSTRING(@RA, 8, 1 )) +
 CONVERT(INT, SUBSTRING(@RA, 9, 1 ))

-- Exibe o resultado da soma
SELECT @soma AS SOMA        */

-- 3) Construa um exercício em PL/SQL com declaração de variável que mostre a partir dos dois últimos dígitos do 
-- seu RA e mostre se acima de 50 mostre maior que meu RA senão mostrar abaixo do meu RA.

 /* DECLARE @ra int, @ultimos int
SET @ra= '220921572'
--rigth pega numeros da direta e passa como parametro a variavel e o 2 para pegar os dois numeros da direita
SET @ultimos= right(@ra,2)
IF @ultimos>50
	BEGIN	
		print 'maior que meu RA'
	END
ELSE
	BEGIN	
		print 'menor que meu RA'
	END */


-- 4) Desenvolva um script em PL/SQL que mostre o mês por extenso a partir do quinto digito do
-- seu RA (usar case) caso seja zero mostrar mês não existe. 


/* DECLARE @ra varchar(10), @mes int

SET @ra='220921572'
SET @mes=  SUBSTRING(@ra,5,1)
SELECT @MES as mes
CASE
	WHEN @mes = 1 THEN 'Janeiro'
	WHEN @mes = 2 THEN 'Fevereiro'
	WHEN @mes = 3 THEN 'Março'
	WHEN @mes = 4 THEN 'Abril'
	WHEN @mes = 5 THEN 'Maio'
	WHEN @mes = 6 THEN 'Junho'
	WHEN @mes = 7 THEN 'Julho'
	WHEN @mes = 8 THEN 'Agosto'
	WHEN @mes = 9 THEN 'Setembro'
	WHEN @mes = 10 THEN 'Outubro'
	WHEN @mes = 11 THEN 'Novembro'
	WHEN @mes = 12 THEN 'Dezembro'
	WHEN @mes = 0 THEN 'MES INEXISTENTE'
END

 */


-- 5) Relacione todas as tabelas cliente, produto, transportadora e 
--liste todos os campos em uma stored procedure.


--CRIANDO TABELA
/*CREATE TABLE [transportadora]
(Cont Int NOT NULL Identity(1,1) --Contador automático
,cod int NOT NULL
,nome CHAR(11) NOT NULL
,cofins int NOT NULL
,email char(50) NOT NULL,
)


CREATE TABLE [produto]
(Cont Int NOT NULL Identity(1,1) --Contador automático
,cod int NOT NULL
,nome CHAR(11) NOT NULL
,valor numeric (6,2) NOT NULL
,ipi int NOT NULL,
)

CREATE TABLE [cliente2]
(Cont Int NOT NULL Identity(1,1) --Contador automático
,cod int NOT NULL
,nome CHAR(20) NOT NULL
,icms int NOT NULL
,codPro int NOT NULL
,codTra int NOT NULL,
) */

--inserindo valores
insert transportadora values(34,'TRANSNORTE',5,'TRANSNORTE@gmail.com')
insert transportadora values (35,'TRANSPAULA',7,'TRANSPAULA@gmail.com')

insert produto values(48,'MONITOR',895.00,10)
insert produto values(49,'HD SSD',425.00,15)
insert produto values(51,'teclado',1000.00,13)

insert cliente2 values(5050,'MASTER CORP',15,48,34)
insert cliente2 values(5067,'IBMDOBRASIL',16,49,35)

/* CREATE PROCEDURE sp_relacao
as
SELECT* FROM cliente2 c
inner join produto p
on c.codPro=p.cod
inner join transportadora t 
on c.codTra=t.cod

exec sp_relacao */

-- 6) Crie um script em PL/SQL que liste a partir da stored procedure qual o valor 
--do ICMS, regra: VALOR do produto * ICMS do cliente.

/* CREATE PROCEDURE sp_valorICMS
as
SELECT p.valor*cliente2.icms as 'valor do icms' FROM cliente2
inner join produto p
on p.cod=cliente2.codPro
exec sp_valorICMS */

-- 7) Elabore uma procedure que atualize a tabela transportadora o campo email, 
-- conforme regra: nome do cliente + nome do produto+ @ + nome da transportadora +.com.br.


/* CREATE PROCEDURE sp_attCampos
as

UPDATE transportadora
SET email= c.nome+p.nome+'@'+t.nome+'.com.br'
FROM transportadora t
INNER JOIN cliente2 c
ON c.codTra= t.cod 
INNER JOIN produto p
ON p.cod=c.codPro

EXEC sp_attCampos
-- resultado
select email from transportadora */

-- 8) Desenvolva uma procedure com declaração de variáveis que liste o produto com maior valor
-- e mostre o campo nome de todas as tabelas e o valor do IPI (VALOR do produto * IPI), valor do
-- ICMS (VALOR do produto * ICMS) e valor do Cofins (VALOR do produto * Cofins). 



/* alter PROCEDURE sp_listaMaior
as

DECLARE @prodMaior int 
SET @prodMaior= (SELECT MAX(valor) FROM produto)
SELECT p.nome,(@prodMaior*p.ipi) as 'valor_att', c.nome,(@prodMaior*c.icms)as 'valor_att',t.nome,(@prodMaior*t.cofins) as 'valor'
FROM cliente2 c
inner join produto p
ON c.codPro=p.cod
inner join transportadora t
ON t.cod=c.codTra
exec sp_listaMaior */


--9) Elabore um script em PL/SQL que mostre por parâmetro do código do cliente e aplique 10% de aumento no 
--valor do produto de 500,00 caso seja menor aplique 15%. Após atualize a tabela produto com o novo valor.

/* ALTER PROCEDURE sp_valorProd
@codCli int
as
UPDATE produto
SET valor=CASE
			WHEN valor>500.00 THEN valor+(valor*0.1)
			WHEN valor<500.00 THEN valor-(valor*0.15)
			else valor
		   END
			
FROM produto p
inner join cliente2 C
ON p.cod=c.codPro

SELECT VALOR FROM produto
exec sp_valorProd 50 */

-- 10) Crie um script em PL/SQL com declaração de variáveis que mostre a partir da nota 1 
--(sendo o seu primeiro digito do RA) e a nota 2 (sendo o último digito do seu RA),mostrar a media 
--(nota1+nota2)/2  caso a média foi menor que 4 mostrar reprovado, maior ou igual a 6 aprovado senão em recuperação.


DECLARE @ra varchar(10), @nota1 int, @nota2 int, @media numeric(3,2)

SET @ra='220921572'
SET @nota1= left(@ra,1)
SET @nota2= right(@ra,1)
SET @media= (@nota1*@nota2)/2

IF @media < 4 
	BEGIN	
		print 'Aluno reprovado com media: '+CONVERT(CHAR(10),@media)
	END
ELSE IF @media>=6
	BEGIN
		print 'Aluno aprovado com media: '+CONVERT(CHAR(10),@media)
	END
ELSE
	BEGIN
		print 'Aluno em recuperação com media: '+CONVERT(CHAR(10),@media)
	END







