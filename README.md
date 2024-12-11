---

# README para o script `setup_infra.sh`

## Descrição

Este script automatiza a criação de grupos de usuários, usuários e diretórios, além de configurar permissões adequadas para os diretórios, tudo dentro de um ambiente Linux. Ele é projetado para ser executado por um usuário root, garantindo que a configuração seja aplicada com as permissões corretas.

### Funcionalidades

1. **Verificação de permissões de root**: O script verifica se está sendo executado como root. Caso contrário, ele exibe uma mensagem de erro e termina a execução.
2. **Criação de grupos**: Os grupos definidos no array `GROUPS` são criados se ainda não existirem.
3. **Criação de usuários**: Usuários são criados e adicionados aos grupos definidos no array `USERS`.
4. **Criação de diretórios**: Diretórios especificados no array `DIRECTORIES` são criados, caso não existam, e têm suas permissões configuradas para `770` (leitura, escrita e execução para o proprietário e grupo).
5. **Configuração de permissões**: As permissões de grupo para os diretórios são configuradas corretamente, garantindo que apenas os usuários do grupo tenham acesso total.

## Requisitos

- O script deve ser executado como root ou com permissões de superusuário.
- O sistema precisa ter os comandos `groupadd`, `useradd`, `mkdir`, `chown`, e `chmod` disponíveis (normalmente já estão presentes na maioria das distribuições Linux).

## Como usar

1. **Baixar o script**:
   
   Baixe ou copie o script `setup_infra.sh` para o seu servidor ou máquina Linux.

2. **Conceder permissões de execução**:

   Após garantir que o script esteja no diretório desejado, conceda permissões de execução ao script com o seguinte comando:

   ```bash
   chmod +x setup_infra.sh
   ```

3. **Executar o script como root**:

   Para executar o script, use o seguinte comando:

   ```bash
   sudo ./setup_infra.sh
   ```

   O script verificará se está sendo executado com permissões de root. Se não estiver, ele pedirá para que o script seja executado como root.

4. **Log de execução**:

   Durante a execução, o script criará um log das operações realizadas no arquivo `/var/log/setup_script.log`. Esse arquivo será útil para depuração e auditoria.

## Personalização

O script pode ser facilmente adaptado para diferentes necessidades. Para personalizar, basta editar os seguintes arrays no início do script:

- **GROUPS**: Lista dos grupos a serem criados.
- **USERS**: Lista de usuários a serem criados, no formato `usuario:grupo`.
- **DIRECTORIES**: Lista de diretórios a serem criados e configurados.

Por exemplo, para adicionar um novo grupo e usuário, basta adicionar à lista `GROUPS` e `USERS`:

```bash
GROUPS=("grupo1" "grupo2" "grupo3" "novo_grupo")
USERS=("usuario1:grupo1" "usuario2:grupo2" "usuario3:grupo3" "usuario4:novo_grupo")
```

## Logs

- O script gera logs no arquivo `/var/log/setup_script.log`, permitindo o monitoramento e auditoria das ações realizadas.
  
## Erros comuns

- **Erro: Script não está sendo executado como root**: Certifique-se de que o script seja executado com permissões de superusuário (`sudo`).
- **Erro ao criar diretórios**: Verifique se você tem permissões adequadas para criar diretórios no local especificado.

## Exemplo de Saída

Ao executar o script, você pode esperar ver algo como:

```bash
2024-12-11 12:00:00 - Iniciando a criação de grupos...
2024-12-11 12:00:01 - Grupo 'grupo1' criado com sucesso.
2024-12-11 12:00:01 - Grupo 'grupo2' criado com sucesso.
2024-12-11 12:00:01 - Grupo 'grupo3' criado com sucesso.
2024-12-11 12:00:02 - Iniciando a criação de usuários...
2024-12-11 12:00:03 - Usuário 'usuario1' criado e adicionado ao grupo 'grupo1'.
2024-12-11 12:00:03 - Usuário 'usuario2' criado e adicionado ao grupo 'grupo2'.
2024-12-11 12:00:03 - Usuário 'usuario3' criado e adicionado ao grupo 'grupo3'.
2024-12-11 12:00:04 - Iniciando a criação de diretórios e configuração de permissões...
2024-12-11 12:00:05 - Diretório '/app/grupo1' criado.
2024-12-11 12:00:06 - Permissões configuradas para o diretório '/app/grupo1'.
...
```

---
