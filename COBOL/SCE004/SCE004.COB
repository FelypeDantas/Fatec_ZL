       IDENTIFICATION DIVISION.
       PROGRAM-ID. SCE004.
      *AUTHOR. Felype Dantas Dos Santos.
      ******************************
      *     CADASTRO DE PRODUTOS   *
      ******************************
      *----------------------------------------------------------------
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
             DECIMAL-POINT IS COMMA.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT ARQPRO ASSIGN TO DISK
                      ORGANIZATION IS INDEXED
                      ACCESS MODE  IS DYNAMIC
                      RECORD KEY   IS PRO-CODIGO
                  ALTERNATE RECORD KEY IS PRO-DESCRICAO WITH DUPLICATES
                      FILE STATUS  IS ST-ERRO.
      *
           SELECT ARQFOR ASSIGN TO DISK
                    ORGANIZATION IS INDEXED
                    ACCESS MODE  IS DYNAMIC
                    RECORD KEY   IS FOR-CODIGO
                    FILE STATUS  IS ST-ERRO
                    ALTERNATE RECORD KEY IS FOR-CODIGO
                                   WITH DUPLICATES.


      *
      *-----------------------------------------------------------------
       DATA DIVISION.
       FILE SECTION.
       FD ARQPRO
             LABEL RECORD IS STANDARD
             VALUE OF FILE-ID IS "ARQPRO.DAT".
       01 REGPRO.
         03 CADASTRO.
           05 PRO-CODIGO            PIC 9(06).
         03 PRO-DESCRICAO           PIC X(30).
         03 PRO-UNIDADE             PIC X(02).
         03 PRO-TPPRODUTO           PIC 9(01).
         03 PRO-ULTIMO-PRECO        PIC 9(06)V99.
         03 PRO-DATACOMPRA          PIC 9(08).
         03 PRO-ESTOQUE             PIC 9(06).
      *>*****************************************************************
       FD ARQFOR
               LABEL RECORD IS STANDARD
               VALUE OF FILE-ID IS "ARQFOR.DAT".
       01 REGFOR.
          03 CADASTRO.
            05 FOR-CODIGO            PIC 9(06).
          03 FOR-TIPOFORNECEDOR      PIC X(01).
          03 FOR-CPF                 PIC 9(11).
          03 FOR-CNPJ                PIC 9(14).
          03 FOR-NOME                PIC X(30).
          03 FOR-APELIDO             PIC X(30).
          03 FOR-CEP                 PIC 9(08).
          03 FOR-LOGRADOURO          PIC X(24).
          03 FOR-NUMERO              PIC X(11).
          03 FOR-COMPLEMENTO         PIC X(24).
          03 FOR-BAIRRO              PIC X(40).
          03 FOR-CIDADE              PIC X(24).
          03 FOR-ESTADO              PIC X(02).
          03 FOR-TELEFONE            PIC 9(11).
          03 FOR-EMAIL               PIC X(33).
          03 FOR-CONTATO             PIC X(32).
      *>*****************************************************************
       WORKING-STORAGE SECTION.
       01 W-OPCAO       PIC X(01) VALUE SPACES.
       01 W-UPPERCASE   PIC X(01) VALUE SPACES.
       01 W-ACT         PIC 9(02) VALUE ZEROS.
       01 ST-ERRO       PIC X(02) VALUE "00".


       01 DFOR-TIPOFORNECEDOR    PIC X(20) VALUE SPACES.
       01 DPRO-TPPRODUTO         PIC X(10) VALUE SPACES.

       01 W-CONT        PIC 9(06) VALUE ZEROS.
       01 MENS          PIC X(50) VALUE SPACES.
       01 W-SEL         PIC 9(01) VALUE ZEROS.

       01 TXPRO.
           03 TP-NUM   PIC 9(02) VALUE ZEROS.
           03 TP-DES   PIC X(20) VALUE SPACES.
       01 TABTIPOPRODUTO.
          03 TBTIPOPRODUTO   PIC X(30) OCCURS 10 TIMES.
             01 IND       PIC 9(02) VALUE ZEROS.

      *--------------------------------------------
      *
        SCREEN SECTION.

       01  TELANOVA.
        05  LINE 01  COLUMN 01
               VALUE  "                           CADASTRO DE P".
           05  LINE 01  COLUMN 41
               VALUE  "RODUTO ".
           05  LINE 03  COLUMN 01
               VALUE  " -----------------------------DADOS EMPR".
           05  LINE 03  COLUMN 41
               VALUE  "ESARIAIS --------------------------------".
           05  LINE 04  COLUMN 01
               VALUE  "   Informe o Tipo de produto :  -".
           05  LINE 04  COLUMN 41
               VALUE  "              Codigo:                   ".
           05  LINE 06  COLUMN 01
               VALUE  "   descricao                 :".
           05  LINE 07  COLUMN 01
               VALUE  "   unidade                   :".
           05  LINE 08  COLUMN 01
               VALUE  "   ultimo preco              :".
           05  LINE 09  COLUMN 01
               VALUE  "   data de compra            :".
           05  LINE 10  COLUMN 01
               VALUE  "   Quantidade em estoque     :".
           05  LINE 12  COLUMN 01
               VALUE  "---------------------------------INFORMA".
           05  LINE 12  COLUMN 41
               VALUE  "COES-------------------------------------".
           05  LINE 14  COLUMN 01
               VALUE  "  MENSAGENS :".
           05  LINE 24  COLUMN 01
               VALUE  "----------------------------------------".
           05  LINE 24  COLUMN 41
               VALUE  "----------------------------------------".
           05  TPRO-TIPOPRODUTO
               LINE 04  COLUMN 32  PIC X(01)
               USING  PRO-TPPRODUTO.
           05  TDTIPOPRODUTO
               LINE 04  COLUMN 34  PIC X(20)
               USING  DPRO-TPPRODUTO.
           05  TPRO-CODIGO
               LINE 04  COLUMN 62  PIC 9(11)
               USING  PRO-CODIGO.
           05  TPRO-DESCRICAO
               LINE 06  COLUMN 32  PIC X(30)
               USING  PRO-DESCRICAO.
           05  TPRO-UNIDADE
               LINE 07  COLUMN 32  PIC X(30)
               USING  PRO-UNIDADE.
           05  TULTIMOPRECO
               LINE 08  COLUMN 32  PIC 9(06)V99
               USING  PRO-ULTIMO-PRECO.
           05  TPRO-DATACOMPRA
               LINE 09  COLUMN 32  PIC 99.99.9999
               USING  PRO-DATACOMPRA.
           05  TPRO-ESTOQUE
               LINE 10  COLUMN 32  PIC X(11)
               USING  PRO-ESTOQUE.
      *
       01  TELACARGOS.

           05  LINE 19  COLUMN 01
               VALUE  " |                               LISTA D".
           05  LINE 19  COLUMN 41
               VALUE  "E CARGOS                               |".
           05  LINE 20  COLUMN 01
               VALUE  " |   01 - ANALISTA DE SISTEMAS     05 -".
           05  LINE 20  COLUMN 41
               VALUE  "MEDICO            09 - PROFESSOR       |".
           05  LINE 21  COLUMN 01
               VALUE  " |   02 - CONTADOR                 06 -".
           05  LINE 21  COLUMN 41
               VALUE  "AUX. PRODUCAO     10 - GERENTE RH      |".
           05  LINE 22  COLUMN 01
               VALUE  " |   03 - GERENTE FINANCEIRO       07 -".
           05  LINE 22  COLUMN 41
               VALUE  "MOTORISTA                              |".
           05  LINE 23  COLUMN 01
               VALUE  " |   04 - ESTAGIARIO               08 -".
           05  LINE 23  COLUMN 41
               VALUE  "ENFERMEIRO                             |".


       01  TELADEPARTAMENTOS.
           05  LINE 19  COLUMN 01
               VALUE  " |                            LISTA DE D".
           05  LINE 19  COLUMN 41
               VALUE  "EPARTAMENTOS".
           05  LINE 20  COLUMN 01
               VALUE  " |    01 - CONTABILIDADE         05 - FI".
           05  LINE 20  COLUMN 41
               VALUE  "NANCEIRO            09 - PRODUCAO      |".
           05  LINE 21  COLUMN 01
               VALUE  " |    02 - RECURSOS HUMANOS      06 - CO".
           05  LINE 21  COLUMN 41
               VALUE  "MERCIAL             10 - T.I           |".
           05  LINE 22  COLUMN 01
               VALUE  " |    03 - FINANCEIRO            07 - OP".
           05  LINE 22  COLUMN 41
               VALUE  "ERACIONAL                              |".
           05  LINE 23  COLUMN 01
               VALUE  " |    04 - VENDAS                08 - LO".
           05  LINE 23  COLUMN 41
               VALUE  "GISTICA                                |".
           05  LINE 24  COLUMN 01
               VALUE  " |--------------------------------------".
           05  LINE 24  COLUMN 41
               VALUE  "---------------------------------------|".

        01  TELATIPOSALARIO.

           05  LINE 19  COLUMN 01
               VALUE  " |                         LISTA DE TIPO".
           05  LINE 19  COLUMN 41
               VALUE  "S DE SALARIO                           |".
           05  LINE 20  COLUMN 01
               VALUE  " |                               D - DIA".
           05  LINE 20  COLUMN 41
               VALUE  "RISTA                                  |".
           05  LINE 21  COLUMN 01
               VALUE  " |                               M - MEN".
           05  LINE 21  COLUMN 41
               VALUE  "SALISTA                                |".
           05  LINE 22  COLUMN 01
               VALUE  " |                               H - HOR".
           05  LINE 22  COLUMN 41
               VALUE  "ISTA                                   |".
           05  LINE 23  COLUMN 01
               VALUE  " |".
           05  LINE 23  COLUMN 41
               VALUE  "                                       |".
           05  LINE 24  COLUMN 01
               VALUE  " |--------------------------------------".
           05  LINE 24  COLUMN 41
               VALUE  "---------------------------------------|".

        01  TELALIMPAR.
           05  LINE 19  COLUMN 01
               VALUE  "                                              ".
           05  LINE 19  COLUMN 41
               VALUE  "                                              ".
           05  LINE 20  COLUMN 01
               VALUE  "                                               ".
           05  LINE 20  COLUMN 41
               VALUE  "                                               ".
           05  LINE 21  COLUMN 01
               VALUE  "                                               ".
           05  LINE 21  COLUMN 41
               VALUE  "                                              ".
           05  LINE 22  COLUMN 01
               VALUE  "                                               ".
           05  LINE 22  COLUMN 41
               VALUE  "                                               ".
           05  LINE 23  COLUMN 01
               VALUE  "                                               ".
           05  LINE 23  COLUMN 41
               VALUE  "                                               ".
           05  LINE 24  COLUMN 01
               VALUE  "                                               ".
           05  LINE 24  COLUMN 41
               VALUE  "                                               ".

       01  TELATIPOPRODUTO.
           05  LINE 18  COLUMN 01
               VALUE  "|".
           05  LINE 19  COLUMN 01
               VALUE  "|".
           05  LINE 19  COLUMN 41
               VALUE  "                                       |".
           05  LINE 20  COLUMN 01
               VALUE  "|         1-SAUDE                     2-".
           05  LINE 20  COLUMN 41
               VALUE  "ALIMENTO          3-VESTUARIO          |".
           05  LINE 21  COLUMN 01
               VALUE  "|         4-AGROPECUARIA              5-".
           05  LINE 21  COLUMN 41
               VALUE  "PET               6-VESTUARIO          |".
           05  LINE 22  COLUMN 01
               VALUE  "|         7-UTENSILIOS                8-".
           05  LINE 22  COLUMN 41
               VALUE  "COMPONENTES       9-AUTOMOTIVOS        |".
           05  LINE 23  COLUMN 01
               VALUE  "|".
           05  LINE 23  COLUMN 41
               VALUE  "                                       |".
           05  LINE 24  COLUMN 01
               VALUE  "|---------------------------------------".
           05  LINE 24  COLUMN 41
               VALUE  "---------------------------------------|".
      *-----------------------------------------------------------------
       PROCEDURE DIVISION.
       INICIO.
            MOVE "SAUDE"                         TO TBTIPOPRODUTO(1)
            MOVE "ALIMENTO"                      TO TBTIPOPRODUTO(2)
            MOVE "VESTUARIO"                     TO TBTIPOPRODUTO(3)
            MOVE "AGROPECUARIA"                  TO TBTIPOPRODUTO(4)
            MOVE "PET"                           TO TBTIPOPRODUTO(5)
            MOVE "VESTUARIO"                     TO TBTIPOPRODUTO(6)
            MOVE "UTENSILIOS"                    TO TBTIPOPRODUTO(7)
            MOVE "COMPONENTES"                   TO TBTIPOPRODUTO(8)
            MOVE "AUTOMOTIVO"                    TO TBTIPOPRODUTO(9)
            MOVE "GRAFICO"                       TO TBTIPOPRODUTO(10).

      *-------------ABERTURA DO ARQUIVO -------------------
       R0.
           OPEN I-O ARQPRO
           IF ST-ERRO NOT = "00"
            IF ST-ERRO = "30"
              OPEN OUTPUT ARQPRO
              MOVE "CRIANDO ARQUIVO CADASTRO DE FUNCIONARIOS " TO MENS
              PERFORM ROT-MENS THRU ROT-MENS-FIM
              CLOSE ARQPRO
              GO TO R0
            ELSE
              IF ST-ERRO = "95"
                MOVE "ISAM NAO CARREGADO " TO MENS
                PERFORM ROT-MENS THRU ROT-MENS-FIM
                GO TO ROT-FIM
              ELSE
                MOVE "ERRO NA ABERTURA DO ARQUIVO CDAMIGOS" TO MENS
                PERFORM ROT-MENS THRU ROT-MENS-FIM
                GO TO ROT-FIM.

       R0A.
           OPEN I-O ARQFOR
           IF ST-ERRO NOT = "00"
              IF ST-ERRO = "30"
                 OPEN OUTPUT ARQFOR
                 MOVE "*** ARQUIVO DE FOR NAO ENCONTRADO **" TO MENS
                 PERFORM ROT-MENS THRU ROT-MENS-FIM
                 GO TO ROT-FIM
              ELSE
                 MOVE "ERRO NA ABERTURA DO ARQUIVO DE FOR " TO MENS
                 PERFORM ROT-MENS THRU ROT-MENS-FIM
                 GO TO ROT-FIM
           ELSE
                 NEXT SENTENCE.

      *------------- INICIALIZACAO DAS VARIAVEIS------------
       INC-001.
           MOVE SPACES TO DPRO-TPPRODUTO DFOR-TIPOFORNECEDOR
           MOVE SPACES TO PRO-DESCRICAO PRO-UNIDADE
           MOVE ZEROS TO PRO-CODIGO PRO-TPPRODUTO PRO-ULTIMO-PRECO
           MOVE ZEROS TO PRO-DATACOMPRA PRO-ESTOQUE
      *-------------VISUALIZACAO DA TELA ------------------

           DISPLAY TELANOVA.
      *----------ENTRADA DE DADOS---------------

       INC-002.
           ACCEPT  TPRO-TIPOPRODUTO.
           ACCEPT W-ACT FROM ESCAPE KEY
           IF W-ACT = 01
                  CLOSE ARQFOR
                  STOP RUN.
           IF PRO-TPPRODUTO = SPACES
              MOVE "*** TIPO NAO PODE FICAR EM BRANCO ***" TO MENS
              PERFORM ROT-MENS THRU ROT-MENS-FIM
              GO TO INC-002.
       INC-002B.
             DISPLAY TELATIPOPRODUTO
           ACCEPT TPRO-TIPOPRODUTO.
           IF W-ACT = 01
             GO TO INC-002B
           IF PRO-TPPRODUTO = 0 OR DPRO-TPPRODUTO > 10
                 MOVE "*** DIGITE APENAS DE 1 ATE 9 ***" TO MENS
                 PERFORM ROT-MENS THRU ROT-MENS-FIM
                 GO TO INC-002.
           MOVE TBTIPOPRODUTO(PRO-TPPRODUTO) TO DPRO-TPPRODUTO
           DISPLAY TDTIPOPRODUTO.
       INC-002C.
           MOVE TBTIPOPRODUTO(PRO-TPPRODUTO) TO DPRO-TPPRODUTO
           DISPLAY TDTIPOPRODUTO.
           DISPLAY TELALIMPAR.
           DISPLAY TELANOVA.

       INC-003.
                ACCEPT TPRO-CODIGO
                ACCEPT W-ACT FROM ESCAPE KEY
                IF W-ACT = 02 GO TO INC-002.
                IF PRO-CODIGO = SPACES
                   MOVE "CODIGO DEVE SER DIFERENTE DE BRANCOS" TO MENS
                   PERFORM ROT-MENS THRU ROT-MENS-FIM
                   GO TO INC-003.

       LER-ARQPRO.
           READ ARQPRO
           IF ST-ERRO NOT = "23"
              IF ST-ERRO = "00"
                PERFORM INC-004
                PERFORM INC-005
                PERFORM INC-009A THRU INC-009B
                DISPLAY TELANOVA
                MOVE "*** PRODUTO JA CADASTRAD0 ***" TO MENS
                PERFORM ROT-MENS THRU ROT-MENS-FIM
                GO TO ACE-001
             ELSE
                MOVE "ERRO NA LEITURA ARQUIVO PRODUTOS" TO MENS
                PERFORM ROT-MENS THRU ROT-MENS-FIM
                GO TO ROT-FIM
           ELSE
                MOVE "*** PRODUTO NAO CADASTRAD0 ***" TO MENS
                PERFORM ROT-MENS THRU ROT-MENS-FIM.

       INC-004.
                ACCEPT TPRO-DESCRICAO
                ACCEPT W-ACT FROM ESCAPE KEY
                IF W-ACT = 02 GO TO INC-003.
                IF PRO-DESCRICAO = SPACES
                   MOVE "DESCRICAO DEVE SER DIFERENTE DE BRANCOS"
                   TO MENS
                   PERFORM ROT-MENS THRU ROT-MENS-FIM
                   GO TO INC-004.

       INC-005.
                ACCEPT TPRO-UNIDADE
                ACCEPT W-ACT FROM ESCAPE KEY
                IF W-ACT = 02 GO TO INC-004.
                 IF PRO-UNIDADE = SPACES
                   MOVE "UNIDADE DEVER DIFERENTE DE BRANCO" TO MENS
                   PERFORM ROT-MENS THRU ROT-MENS-FIM
                   GO TO INC-005.

       INC-006.
                ACCEPT TULTIMOPRECO
                ACCEPT W-ACT FROM ESCAPE KEY
                IF W-ACT = 02 GO TO INC-005.
                 IF PRO-ULTIMO-PRECO = SPACES
                   MOVE "ULTIMO PREÇO DEVE DIFERENTE DE BRANCO" TO MENS
                   PERFORM ROT-MENS THRU ROT-MENS-FIM
                   GO TO INC-006.

       INC-007.
                ACCEPT TPRO-DATACOMPRA
                ACCEPT W-ACT FROM ESCAPE KEY
                IF W-ACT = 02 GO TO INC-006.
                IF PRO-DATACOMPRA = ZEROS
                   MOVE "DATA DE COM. DEVE DIFERENTE DE BRANCO" TO MENS
                   PERFORM ROT-MENS THRU ROT-MENS-FIM
                   GO TO INC-007.

       INC-008.
                ACCEPT TPRO-ESTOQUE
                ACCEPT W-ACT FROM ESCAPE KEY
                IF W-ACT = 02 GO TO INC-007.
                  IF PRO-ESTOQUE = ZEROS
                   MOVE "ESTOQUE DEVE DIFERENTE DE BRANCO" TO MENS
                   PERFORM ROT-MENS THRU ROT-MENS-FIM
                   GO TO INC-008.

       INC-009.
           ACCEPT TPRO-CODIGO
           ACCEPT W-ACT FROM ESCAPE KEY
           IF W-ACT = 01
                   DISPLAY TELANOVA
                   GO TO INC-007.
           IF PRO-CODIGO = 0
               MOVE "*** CPF/CNPJ FORNECEDOR NÃO INFORMADO  ***" TO MENS
                PERFORM ROT-MENS THRU ROT-MENS-FIM
                 GO TO INC-009.

       INC-009A.
           MOVE PRO-CODIGO TO FOR-CODIGO.
           READ ARQFOR
           IF ST-ERRO NOT = "00"
              IF ST-ERRO = "23"
               MOVE "*** FORNECEDOR DIGITADO NAO ENCONTRADO ***" TO MENS
                PERFORM ROT-MENS THRU ROT-MENS-FIM
                 GO TO INC-008
               ELSE
               MOVE "ERRO NA LEITURA ARQUIVO FORNECEDORES" TO MENS
                  PERFORM ROT-MENS THRU ROT-MENS-FIM
                  GO TO ROT-FIM
           ELSE
                MOVE 1 TO IND.
                DISPLAY TELANOVA.
       INC-009B.
               MOVE 1 TO IND.

            IF W-SEL = 1
            GO TO ALT-OPC.

            IF W-SEL = 1
            GO TO ALT-OPC.
       INC-OPC.
                MOVE "S" TO W-OPCAO
                DISPLAY (16, 30) "Deseja Salvar (S/N) : ".
                ACCEPT (16, 55) W-OPCAO WITH UPDATE
                ACCEPT W-ACT FROM ESCAPE KEY
                IF W-ACT = 01 GO TO INC-001.
                IF W-OPCAO = "N" OR "n"
                   MOVE "*** DADOS RECUSADOS PELO OPERADOR ***" TO MENS
                   PERFORM ROT-MENS THRU ROT-MENS-FIM
                   GO TO INC-001.
                IF W-OPCAO NOT = "S" AND "s"
                   MOVE "*** DIGITE APENAS S=SIM e N=NAO ***" TO MENS
                   PERFORM ROT-MENS THRU ROT-MENS-FIM
                   GO TO INC-OPC.
       INC-WR1.
                WRITE REGPRO
                IF ST-ERRO = "00" OR "02"
                      MOVE "*** DADOS GRAVADOS *** " TO MENS
                      PERFORM ROT-MENS THRU ROT-MENS-FIM
                      GO TO INC-001.
                IF ST-ERRO = "22"
                MOVE "* PRODUTO JA EXISTE,DADOS NAO GRAVADOS *" TO MENS
                  PERFORM ROT-MENS THRU ROT-MENS-FIM
                  GO TO INC-001
                ELSE
                      MOVE "ERRO NA GRAVACAO DO ARQUIVO DE PRODUTO"
                                                       TO MENS
                      PERFORM ROT-MENS THRU ROT-MENS-FIM
                      GO TO ROT-FIM.

      *
      *****************************************
      * ROTINA DE CONSULTA/ALTERACAO/EXCLUSAO *
      *****************************************
      *
       ACE-001.
                DISPLAY (20, 18)
                     "N=NOVO REGISTRO | A=ALTERAR | E=EXCLUIR | S=SAIR:"
                ACCEPT (20, 67) W-OPCAO
                IF W-OPCAO NOT = "N" AND W-OPCAO NOT = "A"
                    AND W-OPCAO NOT = "E" AND W-OPCAO NOT = "S"
                    GO TO ACE-001.
                MOVE SPACES TO MENS
                DISPLAY (20, 18) MENS
                IF W-OPCAO = "N" OR "n"
                   GO TO INC-001
                ELSE
                   IF W-OPCAO = "A" OR "a"
                      MOVE 1 TO W-SEL
                      GO TO INC-003
                ELSE
                   IF W-OPCAO = "S" OR "s"
                      MOVE 1 TO W-SEL
                      GO TO ROT-FIM.
      *
       EXC-OPC.
                DISPLAY (16, 30) "Deseja EXCLUIR   (S/N) : ".
                ACCEPT (16, 55) W-OPCAO
                IF W-OPCAO = "N" OR "n"
                   MOVE "*** REGISTRO NAO EXCLUIDO ***" TO MENS
                   PERFORM ROT-MENS THRU ROT-MENS-FIM
                   GO TO INC-001.
                IF W-OPCAO NOT = "S" AND "s"
                   MOVE "* DIGITE APENAS S=SIM  e  N=NAO *" TO MENS
                   PERFORM ROT-MENS THRU ROT-MENS-FIM
                   GO TO EXC-OPC.
       EXC-DL1.
                DELETE ARQPRO RECORD
                IF ST-ERRO = "00"
                   MOVE "*** REGISTRO PRODUTO EXCLUIDO ***" TO MENS
                   PERFORM ROT-MENS THRU ROT-MENS-FIM
                   GO TO INC-001.
                MOVE "ERRO NA EXCLUSAO DO REGISTRO "   TO MENS
                PERFORM ROT-MENS THRU ROT-MENS-FIM
                GO TO ROT-FIM.

       ALT-OPC.
                DISPLAY (16, 30) "Deseja ALTERAR  (S/N) : ".
                ACCEPT (16, 55) W-OPCAO
                ACCEPT W-ACT FROM ESCAPE KEY

                IF W-OPCAO = "N" OR "n"
                   MOVE "*** INFORMACOES NAO ALTERADAS *** " TO MENS
                   PERFORM ROT-MENS THRU ROT-MENS-FIM
                   GO TO INC-001.

                IF W-OPCAO NOT = "S" AND "s"
                   MOVE "*** DIGITE APENAS S=SIM  e  N=NAO ***" TO MENS
                   PERFORM ROT-MENS THRU ROT-MENS-FIM
                   GO TO ALT-OPC.
       ALT-RW1.
                REWRITE REGPRO
                IF ST-ERRO = "00" OR "02"
                   MOVE "*** REGISTRO ALTERADO ***" TO MENS
                   PERFORM ROT-MENS THRU ROT-MENS-FIM

                   GO TO INC-001.
                   DISPLAY TELALIMPAR.
                MOVE "ERRO NA EXCLUSAO DO REGISTRO AMIGO"   TO MENS
                PERFORM ROT-MENS THRU ROT-MENS-FIM
                GO TO ROT-FIM.

      *-------------------------------------------------------------------------------------------
       ROT-FIM.
           CLOSE ARQPRO ARQFOR.
           STOP RUN.
      *--------------------------------------------------------------
      *---------[ ROTINA DE MENSAGEM ]---------------------
       ROT-MENS.
                MOVE ZEROS TO W-CONT.
       ROT-MENS1.
               DISPLAY (16, 21) MENS.
       ROT-MENS2.
                ADD 1 TO W-CONT
                IF W-CONT < 3000
                   GO TO ROT-MENS2
                ELSE
                   MOVE SPACES TO MENS
                   DISPLAY (16, 21) MENS.
       ROT-MENS-FIM.
                EXIT.
       FIM-ROT-TEMPO.

      *    FILE STATUS
      *    00 = OPERAÇÃO REALIZADO COM SUCESSO
      *    22 = REGISTRO JÁ CADASTRADO
      *    23 = REGISTRO NÃO ENCONTRADO
      *    30 = ARQUIVO NÃO ENCONTRADO
      *    95 = ISAM NAO CARREGADO
      *    10 = FIM DA LEITURA ARQUIVO SEQUENCIAL
