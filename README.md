# Projeto de Autenticação REST API em Delphi
Este projeto foi desenvolvido para fornecer autenticação segura para usuários em uma REST API usando Delphi. 
Utilizamos os frameworks Horse, Horse-JWT, Jhonson para o tratamento de JSON, e BCrypt para a criptografia de senhas.
O projeto foi desenvolvido utilizando conceitos de herança, o que permitiu a criação de uma arquitetura mais limpa e 
modular, promovendo o reuso de código e facilitando a manutenção.

## Funcionalidades
* Autenticação de usuários: Utiliza tokens JWT (JSON Web Tokens) para autenticação e autorização de usuários.
* Criptografia de senhas: Implementado com BCrypt para garantir a segurança das senhas.
* Manipulação de JSON: Usamos Jhonson para tratar os dados no formato JSON.
* Middleware JWT: Verificação automática dos tokens de autenticação nas rotas protegidas.

## Tecnologias Utilizadas
* Horse: Um framework minimalista para criar APIs RESTful em Delphi.
* Horse-JWT: Middleware para o Horse que permite autenticação via JWT.
* Jhonson: Biblioteca para manipulação de JSON em Delphi.
* BCrypt: Biblioteca para criptografia de senhas com o algoritmo BCrypt.
