# Mobile HR Management Application Project

This project was developed as part of the **Project IV** curricular unit during my studies, with the theme and objectives proposed by the company **Olisipo**. The main goal was to create a mobile application that allowed employees to quickly access the company's **HR system** (Human Resources). The application provides features such as **meeting requests**, **schedule management** with **work hours tracking**, and other tools to facilitate internal communication and time management for employees.

## Main Challenges and Learnings

Throughout the development of this project, I faced various challenges, with the most significant being related to **login management**, **account verification**, and **password recovery**. These challenges led me to learn and apply key concepts like sending **emails through the API** for account verification and password recovery, as well as implementing a **password change system** with secure authentication.

These functionalities required an in-depth understanding of **Node.js** and libraries like **Nodemailer**, in addition to integrating authentication and authorization systems using JWT tokens.

## Project Architecture

The project was divided into three main parts:

### 1. Database

- **Design**: The database design was crafted using **MySQL Workbench**.
- **Implementation**: The database was implemented using **PostgreSQL**, with careful consideration of table relationships and data modeling to ensure performance and scalability.

### 2. Backend (API)

The backend was developed in **JavaScript** using **Node.js** with **Express.js** as the main framework. During the API development, the following key dependencies were used:

- **bcrypt**: For password encryption.
- **cors**: For managing cross-origin resource sharing policies.
- **dotenv**: For securely handling environment variables.
- **express-fileupload**: For file uploads.
- **generate-password**: To generate secure temporary passwords.
- **jsonwebtoken**: To create JWT tokens for authentication.
- **nodemailer**: For sending account verification and password recovery emails.
- **pg**: For communication with the PostgreSQL database.
- **sequelize**: As an ORM for managing database transactions and interactions.

### 3. Frontend and Mobile Application

- **Admin Frontend**: The administrative frontend was developed using **React**, **AdminLTE**, and **Bootstrap**. This panel allowed administrators to view and manage employee requests and schedules, providing an overall view of application usage.

Unfortunately, the code for this interface is no longer available, so it is not included in this repository.

- **Mobile Application**: The mobile application was developed in **Flutter** using **Dart**. The application was tested and validated using **Android Studio** to ensure compatibility with Android devices.

## How to Run the Project

### Requirements

- **Node.js**: version 16+
- **PostgreSQL**: version 13+
- **Flutter**: version 3.0+
- **Android Studio** (to test the mobile app)

### Installation

1. Clone this repository:
    ```bash
    git clone https://github.com/username/repository.git
    ```

2. Install backend dependencies:
    ```bash
    cd backend
    npm install
    ```

3. Configure environment variables in the `.env` file.

4. Start the backend server:
    ```bash
    npm start
    ```

5. To run the mobile app, navigate to the `mobile` folder and use Flutter:
    ```bash
    flutter run
    ```

---

# Projeto de Aplicação Mobile para Gestão de HR

Este projeto foi desenvolvido no âmbito da unidade curricular **Projeto IV** durante os meus estudos, com o tema e objetivos propostos pela empresa **Olisipo**. O principal objetivo era criar uma aplicação mobile que permitisse aos funcionários acessarem rapidamente o **sistema de HR** (Recursos Humanos) da empresa. A aplicação oferece funcionalidades como **solicitações de reuniões**, **gestão de horários** com **registro de horas trabalhadas**, e outras ferramentas para facilitar a comunicação interna e a gestão de tempo dos colaboradores.

## Principais Desafios e Aprendizados

Durante o desenvolvimento deste projeto, enfrentei diversos desafios, sendo os mais significativos relacionados à **gestão de logins**, **verificação de conta**, e **recuperação de senha**. Esses desafios me levaram a aprender e aplicar conceitos importantes como o envio de **emails através da API** para verificação de conta e recuperação de senha, além de implementar o sistema de **mudança de senha** com autenticação segura.

Essas funcionalidades exigiram um conhecimento aprofundado de **Node.js** e bibliotecas como o **Nodemailer**, além da integração de sistemas de autenticação e autorização de usuários utilizando tokens JWT.

## Arquitetura do Projeto

O projeto foi dividido em três partes principais:

### 1. Base de Dados

- **Design**: O design da base de dados foi elaborado utilizando o **MySQL Workbench**.
- **Implementação**: A base de dados foi implementada utilizando **PostgreSQL**, com o relacionamento entre as tabelas e a modelagem de dados projetados para garantir o desempenho e a escalabilidade da aplicação.

### 2. Backend (API)

O backend foi desenvolvido em **JavaScript** utilizando o **Node.js** com **Express.js** como framework principal. Durante o desenvolvimento da API, as seguintes dependências principais foram utilizadas:

- **bcrypt**: Para a encriptação de senhas.
- **cors**: Para o gerenciamento de políticas de compartilhamento de recursos entre diferentes domínios.
- **dotenv**: Para o gerenciamento seguro de variáveis de ambiente.
- **express-fileupload**: Para o upload de arquivos.
- **generate-password**: Para gerar senhas temporárias seguras.
- **jsonwebtoken**: Para a criação de tokens JWT para autenticação.
- **nodemailer**: Para o envio de emails de verificação de conta e recuperação de senha.
- **pg**: Para a comunicação com o banco de dados PostgreSQL.
- **sequelize**: Como ORM para a gestão de transações e interações com o banco de dados.

### 3. Frontend e Aplicação Mobile

- **Frontend Administrativo**: O frontend administrativo foi desenvolvido com **React**, **AdminLTE**, e **Bootstrap**. Este painel permitia aos administradores visualizar e gerenciar as solicitações e horários dos funcionários, oferecendo uma visão geral sobre o uso da aplicação.

Infelizmente, o código desta interface não está mais acessível, por isso ele não consta neste repositório.

- **Aplicação Mobile**: A aplicação mobile foi desenvolvida em **Flutter** utilizando **Dart**. A aplicação foi testada e validada utilizando o **Android Studio** para garantir a compatibilidade com dispositivos Android.

## Como Executar o Projeto

### Requisitos

- **Node.js**: versão 16+
- **PostgreSQL**: versão 13+
- **Flutter**: versão 3.0+
- **Android Studio** (para testar a aplicação mobile)

### Instalação

1. Clone este repositório:
    ```bash
    git clone https://github.com/username/repository.git
    ```

2. Instale as dependências do backend:
    ```bash
    cd backend
    npm install
    ```

3. Configure as variáveis de ambiente no arquivo `.env`.

4. Inicie o servidor backend:
    ```bash
    npm start
    ```

5. Para executar a aplicação mobile, navegue até a pasta `mobile` e use o Flutter:
    ```bash
    flutter run
    ```
