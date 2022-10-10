CREATE DATABASE /*!32312 IF NOT EXISTS*/`teste` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `teste`;

DROP TABLE IF EXISTS `cliente`;
DROP TABLE IF EXISTS `telefone`;
DROP TABLE IF EXISTS `endereco`;

CREATE TABLE cliente (
  id INT NOT NULL AUTO_INCREMENT COMMENT 'Código',
  nome VARCHAR (100) NOT NULL COMMENT 'Nome',
  tipoPessoa INT (1) NOT NULL COMMENT 'Tipo Pessoa: 0-PF; 1-PJ',
  cpfCnpj VARCHAR (18) NOT NULL COMMENT 'Número CPF ou CNPJ',
  rgIe VARCHAR (20) COMMENT 'Número do RG ou IE',
  dataCadastro DATE NOT NULL COMMENT 'Data do Cadastro',
  ativo INT NOT NULL COMMENT 'Cadastro Ativo? 0-Não; 1-Sim',
  PRIMARY KEY (id)
);

CREATE TABLE telefone (
  id INT NOT NULL AUTO_INCREMENT COMMENT 'Código',
  idCliente INT NOT NULL COMMENT 'Código do Cliente',
  ddd VARCHAR (2) NOT NULL COMMENT 'DDD',
  telefone VARCHAR (10) NOT NULL COMMENT 'Número Telefone',
  PRIMARY KEY (id),
  CONSTRAINT fk_telefone_cliente FOREIGN KEY (idCliente) REFERENCES cliente (id)
);

CREATE TABLE endereco (
  id INT NOT NULL AUTO_INCREMENT COMMENT 'Código',
  idCliente INT NOT NULL COMMENT 'Código Cliente',
  cep VARCHAR (9) NOT NULL COMMENT 'CEP',
  logradouro VARCHAR (100) NOT NULL COMMENT 'Logradouro',
  numero INT NOT NULL COMMENT 'Numero',
  complemento VARCHAR (100) COMMENT 'Complemento',
  bairro VARCHAR (50) NOT NULL COMMENT 'Bairro',
  cidade VARCHAR (50) NOT NULL COMMENT 'Cidade',
  uf VARCHAR (2) NOT NULL COMMENT 'UF',
  pais VARCHAR (50) NOT NULL COMMENT 'País',
  PRIMARY KEY (id),
  CONSTRAINT fk_endereco_cliente FOREIGN KEY (idCliente) REFERENCES cliente (id)
);  