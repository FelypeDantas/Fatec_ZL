import java.time.LocalDate;
import javafx.beans.property.ObjectProperty;
import javafx.beans.property.SimpleObjectProperty;
import javafx.beans.property.SimpleStringProperty;
import javafx.beans.property.StringProperty;

public class Paciente {
    private StringProperty nome = new SimpleStringProperty("");
    private StringProperty dataNascimento = new SimpleStringProperty("");
    private StringProperty sexo = new SimpleStringProperty("");
    private StringProperty endereco = new SimpleStringProperty("");
    private StringProperty telefone = new SimpleStringProperty("");
    private StringProperty email = new SimpleStringProperty("");
    private StringProperty cartaoSUS = new SimpleStringProperty("");
    private int id;

    public Paciente() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getNome() { return nome.get(); }
    public void setNome(String nome) { this.nome.set(nome); }
    public StringProperty nomeProperty() { return nome; }

    public String getDataNascimento() { return dataNascimento.get(); }
    public void setDataNascimento(String dataNascimento) { this.dataNascimento.set(dataNascimento); }
    public StringProperty dataNascimentoProperty() { return dataNascimento; }

    public String getSexo() { return sexo.get(); }
    public void setSexo(String sexo) { this.sexo.set(sexo); }
    public StringProperty sexoProperty() { return sexo; }

    public String getEndereco() { return endereco.get(); }
    public void setEndereco(String endereco) { this.endereco.set(endereco); }
    public StringProperty enderecoProperty() { return endereco; }

    public String getTelefone() { return telefone.get(); }
    public void setTelefone(String telefone) { this.telefone.set(telefone); }
    public StringProperty telefoneProperty() { return telefone; }

    public String getEmail() { return email.get(); }
    public void setEmail(String email) { this.email.set(email); }
    public StringProperty emailProperty() { return email; }

    public String getCartaoSUS() { return cartaoSUS.get(); }
    public void setCartaoSUS(String cartaoSUS) { this.cartaoSUS.set(cartaoSUS); }
    public StringProperty cartaoSUSProperty() { return cartaoSUS; }
}