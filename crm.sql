-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 30/08/2024 às 21:39
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `crm`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `condominios`
--

CREATE TABLE `condominios` (
  `id` int(11) NOT NULL,
  `nome` varchar(255) NOT NULL,
  `cnpj` varchar(18) NOT NULL,
  `endereco` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `contratos`
--

CREATE TABLE `contratos` (
  `id` int(11) NOT NULL,
  `unidade_id` int(11) DEFAULT NULL,
  `condominio_id` int(11) DEFAULT NULL,
  `proprietario_id` int(11) DEFAULT NULL,
  `inquilino_id` int(11) DEFAULT NULL,
  `numero_contrato` varchar(50) NOT NULL,
  `data_inicio` date DEFAULT NULL,
  `data_encerramento` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `inquilinos`
--

CREATE TABLE `inquilinos` (
  `id` int(11) NOT NULL,
  `nome` varchar(255) NOT NULL,
  `cpf` varchar(14) NOT NULL,
  `rg` varchar(20) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `telefone` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `proprietarios`
--

CREATE TABLE `proprietarios` (
  `id` int(11) NOT NULL,
  `nome` varchar(255) NOT NULL,
  `cpf` varchar(14) NOT NULL,
  `rg` varchar(20) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  `condominio_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `registroenvio`
--

CREATE TABLE `registroenvio` (
  `id` int(11) NOT NULL,
  `data_envio` date DEFAULT NULL,
  `hora_envio` time DEFAULT NULL,
  `condominio_id` int(11) DEFAULT NULL,
  `proprietario_id` int(11) DEFAULT NULL,
  `inquilino_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `unidades`
--

CREATE TABLE `unidades` (
  `id` int(11) NOT NULL,
  `numero_unidade` varchar(10) NOT NULL,
  `condominio_id` int(11) DEFAULT NULL,
  `proprietario_id` int(11) DEFAULT NULL,
  `inquilino_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `condominios`
--
ALTER TABLE `condominios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `cnpj` (`cnpj`);

--
-- Índices de tabela `contratos`
--
ALTER TABLE `contratos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `numero_contrato` (`numero_contrato`),
  ADD KEY `unidade_id` (`unidade_id`),
  ADD KEY `condominio_id` (`condominio_id`),
  ADD KEY `proprietario_id` (`proprietario_id`),
  ADD KEY `inquilino_id` (`inquilino_id`);

--
-- Índices de tabela `inquilinos`
--
ALTER TABLE `inquilinos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `cpf` (`cpf`);

--
-- Índices de tabela `proprietarios`
--
ALTER TABLE `proprietarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `cpf` (`cpf`),
  ADD KEY `condominio_id` (`condominio_id`);

--
-- Índices de tabela `registroenvio`
--
ALTER TABLE `registroenvio`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_condominio` (`condominio_id`),
  ADD KEY `fk_proprietario` (`proprietario_id`),
  ADD KEY `fk_inquilino` (`inquilino_id`);

--
-- Índices de tabela `unidades`
--
ALTER TABLE `unidades`
  ADD PRIMARY KEY (`id`),
  ADD KEY `condominio_id` (`condominio_id`),
  ADD KEY `proprietario_id` (`proprietario_id`),
  ADD KEY `inquilino_id` (`inquilino_id`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `condominios`
--
ALTER TABLE `condominios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `contratos`
--
ALTER TABLE `contratos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `inquilinos`
--
ALTER TABLE `inquilinos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `proprietarios`
--
ALTER TABLE `proprietarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `registroenvio`
--
ALTER TABLE `registroenvio`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `unidades`
--
ALTER TABLE `unidades`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `contratos`
--
ALTER TABLE `contratos`
  ADD CONSTRAINT `contratos_ibfk_1` FOREIGN KEY (`unidade_id`) REFERENCES `unidades` (`id`),
  ADD CONSTRAINT `contratos_ibfk_2` FOREIGN KEY (`condominio_id`) REFERENCES `condominios` (`id`),
  ADD CONSTRAINT `contratos_ibfk_3` FOREIGN KEY (`proprietario_id`) REFERENCES `proprietarios` (`id`),
  ADD CONSTRAINT `contratos_ibfk_4` FOREIGN KEY (`inquilino_id`) REFERENCES `inquilinos` (`id`);

--
-- Restrições para tabelas `proprietarios`
--
ALTER TABLE `proprietarios`
  ADD CONSTRAINT `proprietarios_ibfk_1` FOREIGN KEY (`condominio_id`) REFERENCES `condominios` (`id`);

--
-- Restrições para tabelas `registroenvio`
--
ALTER TABLE `registroenvio`
  ADD CONSTRAINT `fk_condominio` FOREIGN KEY (`condominio_id`) REFERENCES `condominios` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_inquilino` FOREIGN KEY (`inquilino_id`) REFERENCES `inquilinos` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_proprietario` FOREIGN KEY (`proprietario_id`) REFERENCES `proprietarios` (`id`) ON DELETE SET NULL;

--
-- Restrições para tabelas `unidades`
--
ALTER TABLE `unidades`
  ADD CONSTRAINT `unidades_ibfk_1` FOREIGN KEY (`condominio_id`) REFERENCES `condominios` (`id`),
  ADD CONSTRAINT `unidades_ibfk_2` FOREIGN KEY (`proprietario_id`) REFERENCES `proprietarios` (`id`),
  ADD CONSTRAINT `unidades_ibfk_3` FOREIGN KEY (`inquilino_id`) REFERENCES `inquilinos` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
