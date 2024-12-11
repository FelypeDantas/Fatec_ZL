# Resumo SO2

#### Capitulo 3 : Virtualização

A virtualização usa software para dividir o hardware de um computador em várias máquinas virtuais (VMs). Isso permite que recursos como processador, memória e armazenamento sejam utilizados como se fossem computadores separados com cada um executando o seu próprio sistema operacional(SO).

Segundo Tanenbaum o SO é a abstração do Hardware ou seja uma simplificação da complexidade da parte física do computador, Segundo Tanenbaum, as abstrações permitem isolar processos em "Caixas de Areia", que são ambientes controlados onde os processos podem ser executados de forma segura, sem interferir no sistema ou em outros processos.

**Failover** é um mecanismo de segurança que garante a continuidade de um serviço ou sistema em caso de falhas. Ele funciona transferindo automaticamente a operação para um sistema ou componente de backup quando o principal apresenta problemas. É amplamente utilizado em ambientes de alta disponibilidade, como servidores, bancos de dados e redes, para minimizar o tempo de inatividade.

Um hipervisor é o software que gerencia as máquinas virtuais (VMs), conectando-as ao hardware físico. Ele garante que cada VM tenha acesso aos recursos necessários e impede que interfiram umas nas outras, como no uso de memória ou processamento. Existem dois tipos de Hipervisor:
- Hipervisor tipo 1: Este interage com os recursos fisicos, substituindo o SO por completo. Eles geralmente aparecem em cenários de servidor virtual.
- Hipervisor tipo 2: Estes são executados como aplicativos em SO`s existentes. São mais utilizados em dispositivos terminais para executar SO´s alternativos

#### Capitulo 4 : Sistema de arquivos no Debian GNU/Linux

No GNU/Linux, um sistema de arquivos organiza dados em unidades de armazenamento, enquanto uma partição é uma divisão da memória que armazena dados específicos. O sistema de arquivos precisa organizar os dados de forma eficiente para facilitar o acesso rápido aos arquivos.

O computador armazena dados na memória principal, que perde as informações ao ser desligado. Por isso, o armazenamento secundário é preferido. No entanto, a arquitetura do computador exige que instruções e dados fiquem na memória principal para serem usados.

![Daemon](Daemon.png)

Um processo que executa operações de I/O em um sistema secundário utiliza o Virtual File System para executar tais operações.
O **File System** (sistema de arquivos) não é exatamente um arquivo, mas sim o método ou estrutura usada por um sistema operacional para organizar, armazenar e acessar dados em dispositivos de armazenamento, como discos rígidos, SSDs ou pen drives. Ele define como os dados são gravados, lidos e organizados no dispositivo.

Um **arquivo File System** pode se referir a um arquivo usado por alguns sistemas para simular um sistema de arquivos, como em máquinas virtuais ou sistemas emulados, mas o termo mais geral diz respeito ao conjunto de regras e estruturas que gerenciam o armazenamento. Exemplos incluem **NTFS** (Windows), **ext4** (Linux) e **FAT32** (ambos).

Um **i-node** é uma estrutura de dados que descreve objetos do sistema de arquivos, como arquivos, diretórios ou links. No Unix, segundo Tanenbaum, o i-node é um registro que inclui um número e o nome de um arquivo.

Saiba que o número de i-nodes tem um limite, geralmente é uma divisão média do espaço da partição pelo tamanho médio dos blocos, geralmente o tamanho médio dos blocos por padrão é 4096 bytes.

Um diretório é um arquivo que organiza informações sobre o sistema de arquivos. Arquivos regulares podem conter dados ou serem executáveis. Segundo o livro **Sistemas Operacionais Modernos**, o que define um arquivo como executável para o sistema operacional é a presença de um "bit mágico" ativado em uma posição específica.

No GNU/Linux, ao abrir um arquivo, ele não é carregado na memória, mas recebe um número de referência (um descritor de arquivo). A função `open()` retorna esse número, que usamos para operar no arquivo. Ao copiar, podemos processar o arquivo em blocos de 4 KB.

Caso queira realizar testes de script, navegue ao diretório `/tmp` primeiro, porque neste diretório, tudo será automaticamente excluido após a inicialização.

Arquivos especiais de Bloco e Caracter são arquivos especiais que referenciam dispositivos de I/O, estes arquivos possuem referência no diretório `/dev` .

Segundo Tanenbaum, dispositivos de bloco realizam operações de entrada e saída em blocos de bytes, enquanto dispositivos de caractere operam com um byte por vez.

No Linux encontrar arquivos sem extensão pode se tornar comum, o comando `file` pode te ajudar a ver do que se trata o arquivo, um exemplo seria `file /etc/passwd` isso retornaria em que charset está o arquivo, nesse caso retornaria `ASCII text`, pois o texto encontrado está em ASCII, já o comando `stat` informa coisas como:
- tamanho do arquivo
- permissões de acesso
- ID do usuário e do Grupo
- Hora em que foi criado
- Hora em que foi acessado

Caso necessite compilar um arquivo c++ no terminal linux o comando seria:
1. g++ -o arquivo arquivo.cpp
2.  ./arquivo 
