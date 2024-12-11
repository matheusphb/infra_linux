#!/bin/bash

# Verificar se o script está sendo executado como root
if [ "$(id -u)" -ne 0 ]; then
    echo "Este script deve ser executado como root."
    exit 1
fi

# Configurações iniciais
LOG_FILE="/var/log/setup_script.log"
GROUPS=("grupo1" "grupo2" "grupo3") # Defina os grupos
USERS=("usuario1:grupo1" "usuario2:grupo2" "usuario3:grupo3") # Formato: usuario:grupo
DIRECTORIES=("/app/grupo1" "/app/grupo2" "/app/grupo3") # Diretórios por grupo

# Função para log
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

# Criar Grupos
log_message "Iniciando a criação de grupos..."
for group in "${GROUPS[@]}"; do
    if ! getent group "$group" > /dev/null 2>&1; then
        groupadd "$group"
        log_message "Grupo '$group' criado com sucesso."
    else
        log_message "Grupo '$group' já existe. Pulando..."
    fi
done

# Criar Usuários e associá-los aos grupos
log_message "Iniciando a criação de usuários..."
for user_group in "${USERS[@]}"; do
    IFS=":" read -r user group <<< "$user_group"
    if ! id "$user" > /dev/null 2>&1; then
        useradd -m -g "$group" "$user"
        log_message "Usuário '$user' criado e adicionado ao grupo '$group'."
    else
        log_message "Usuário '$user' já existe. Pulando..."
    fi
done

# Criar Diretórios e aplicar permissões
log_message "Iniciando a criação de diretórios e configuração de permissões..."
for dir in "${DIRECTORIES[@]}"; do
    if [ ! -d "$dir" ]; then
        mkdir -p "$dir"
        log_message "Diretório '$dir' criado."
    else
        log_message "Diretório '$dir' já existe. Pulando..."
    fi
    
    group=$(basename "$dir") # Grupo é baseado no nome do diretório
    chown :$group "$dir"
    chmod 770 "$dir"
    log_message "Permissões configuradas para o diretório '$dir'."
done

log_message "Configuração concluída com sucesso!"
