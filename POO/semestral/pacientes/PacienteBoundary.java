import javafx.application.Application;
import javafx.beans.binding.Bindings;
import javafx.beans.property.SimpleIntegerProperty;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.GridPane;
import javafx.stage.Stage;

public class PacienteBoundary extends Application {
    private Label lblId = new Label("");
    private TextField txtNome = new TextField();
    private TextField txtDataNascimento = new TextField();
    private ComboBox<String> cbSexo = new ComboBox<>();
    private TextField txtEndereco = new TextField();
    private TextField txtTelefone = new TextField();
    private TextField txtEmail = new TextField();
    private TextField txtCartaoSUS = new TextField();

    private TableView<Paciente> tableView = new TableView<>();
    private PacienteControl control = new PacienteControl();

    @Override
    public void start(Stage stage) {
        BorderPane panePrincipal = new BorderPane();

        GridPane paneForm = new GridPane();
        paneForm.add(new Label("Id: "), 0, 0);
        paneForm.add(lblId, 1, 0);
        paneForm.add(new Label("Nome: "), 0, 1);
        paneForm.add(txtNome, 1, 1);
        paneForm.add(new Label("Data de Nascimento: "), 0, 2);
        paneForm.add(txtDataNascimento, 1, 2);
        paneForm.add(new Label("Sexo: "), 0, 3);
        cbSexo.getItems().addAll("Masculino", "Feminino", "Outro");
        paneForm.add(cbSexo, 1, 3);
        paneForm.add(new Label("Endereço: "), 0, 4);
        paneForm.add(txtEndereco, 1, 4);
        paneForm.add(new Label("Telefone: "), 0, 5);
        paneForm.add(txtTelefone, 1, 5);
        paneForm.add(new Label("Email: "), 0, 6);
        paneForm.add(txtEmail, 1, 6);
        paneForm.add(new Label("Cartão SUS: "), 0, 7);
        paneForm.add(txtCartaoSUS, 1, 7);

        Button btnGravar = new Button("Gravar");
        btnGravar.setOnAction(e -> {
            control.gravar();
            tableView.refresh();
        });

        Button btnLimpar = new Button("Limpar");
        btnLimpar.setOnAction(e -> control.limparTudo());

        paneForm.add(btnGravar, 0, 8);
        paneForm.add(btnLimpar, 1, 8);

        generateColumns();
        vincularPropriedades();

        panePrincipal.setTop(paneForm);
        panePrincipal.setCenter(tableView);

        Scene scn = new Scene(panePrincipal, 600, 400);
        stage.setScene(scn);
        stage.setTitle("Cadastro de Pacientes");
        stage.show();
    }

    public void generateColumns() {
        TableColumn<Paciente, Integer> col1 = new TableColumn<>("Id");
        col1.setCellValueFactory(cellData -> new SimpleIntegerProperty(cellData.getValue().getId()).asObject());

        TableColumn<Paciente, String> col2 = new TableColumn<>("Nome");
        col2.setCellValueFactory(cellData -> cellData.getValue().nomeProperty());

        TableColumn<Paciente, String> col3 = new TableColumn<>("Data de Nascimento");
        col3.setCellValueFactory(cellData -> cellData.getValue().dataNascimentoProperty());

        TableColumn<Paciente, String> col4 = new TableColumn<>("Sexo");
        col4.setCellValueFactory(cellData -> cellData.getValue().sexoProperty());

        TableColumn<Paciente, String> col5 = new TableColumn<>("Endereço");
        col5.setCellValueFactory(cellData -> cellData.getValue().enderecoProperty());

        TableColumn<Paciente, String> col6 = new TableColumn<>("Telefone");
        col6.setCellValueFactory(cellData -> cellData.getValue().telefoneProperty());

        TableColumn<Paciente, String> col7 = new TableColumn<>("Email");
        col7.setCellValueFactory(cellData -> cellData.getValue().emailProperty());

        TableColumn<Paciente, String> col8 = new TableColumn<>("Cartão SUS");
        col8.setCellValueFactory(cellData -> cellData.getValue().cartaoSUSProperty());

        tableView.getColumns().addAll(col1, col2, col3, col4, col5, col6, col7, col8);
        tableView.setItems(control.getLista());

        tableView.getSelectionModel().selectedItemProperty().addListener((obs, antigo, novo) -> {
            if (novo != null) {
                control.entidadeParaTela(novo);
            }
        });
    }

    public void vincularPropriedades() {
        Bindings.bindBidirectional(lblId.textProperty(), control.idProperty(), new IntegerStringConverter());
        Bindings.bindBidirectional(txtNome.textProperty(), control.nomeProperty());
        Bindings.bindBidirectional(txtDataNascimento.textProperty(), control.dataNascimentoProperty());
        Bindings.bindBidirectional(cbSexo.valueProperty(), control.sexoProperty());
        Bindings.bindBidirectional(txtEndereco.textProperty(), control.enderecoProperty());
        Bindings.bindBidirectional(txtTelefone.textProperty(), control.telefoneProperty());
        Bindings.bindBidirectional(txtEmail.textProperty(), control.emailProperty());
        Bindings.bindBidirectional(txtCartaoSUS.textProperty(), control.cartaoSUSProperty());
    }

    public static void main(String[] args) {
        Application.launch(PacienteBoundary.class, args);
    }
}
