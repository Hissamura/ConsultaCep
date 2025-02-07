# 📌 Delphi Consulta CEP (ViaCEP)

Este projeto é um **MVP** de uma aplicação Delphi 11 que consome o **WebService ViaCEP** para consulta de endereços por **CEP** ou **Endereço Completo**.

A aplicação permite:
✅ Consultar endereços via **JSON** ou **XML**
✅ Armazenar os resultados no banco de dados
✅ Atualizar os registros caso já existam
✅ Aplicar boas práticas de **Clean Code, SOLID e POO**

---

## 🚀 Tecnologias Utilizadas

- **Delphi 11**
- **TNetHTTPClient** (para requisições HTTP)
- **FireDAC** (para conexão com banco de dados)
- **SQLite**
- **JSON e XML Parsing**

---

## ⚙️ Configuração do Banco de Dados

### 🔹 SQLite (Padrão do Projeto)
O banco SQLite já está incluído no projeto. 

```sql
CREATE TABLE CepEndereco (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    cep TEXT UNIQUE NOT NULL,
    logradouro TEXT,
    complemento TEXT,
    bairro TEXT,
    localidade TEXT,
    uf TEXT
);
```

---

## 🔧 Como Executar o Projeto

1️⃣ **Clone o repositório**:
```bash
git clone https://github.com/seu-usuario/ConsultaCep.git
```

2️⃣ **Abra o Delphi 11 e carregue o projeto** (`DesafioTec.dpr`).

3️⃣ **Execute o projeto** (`F9` ou `Run`).

---

## 📌 Funcionalidades

🔹 **Buscar endereço pelo CEP**
   - Escolha entre **JSON** ou **XML**
   - Digite um CEP e clique em **"Buscar"**
   - Os dados são exibidos na tela e podem ser salvos no banco de dados

🔹 **Buscar endereço pelo Nome Completo**
   - Informe **Estado, Cidade e Logradouro**
   - A aplicação retorna os endereços encontrados no ViaCEP
   
🔹 **Salvar e atualizar registros no banco**
   - Se o **CEP já existir**, pergunta se deseja **atualizar os dados**
   - Se o **CEP não existir**, insere um novo registro

---

## 📌 Exemplo de Uso

### 🔹 Interface da Aplicação

1️⃣ Digite o CEP **01001000**
2️⃣ Escolha **JSON** ou **XML**
3️⃣ Clique em **Buscar CEP**
4️⃣ Veja os resultados no Memo
5️⃣ Clique em **Salvar no Banco**

---

## 📜 Licença

Este projeto está sob a licença **MIT**.

---

Contribuições são sempre bem-vindas! 🚀

