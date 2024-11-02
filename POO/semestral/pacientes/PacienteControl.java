import java.time.LocalDate;
import java.util.List;

public class PacienteControl {
    private Observable<Paciente> pacientes = FXCollections.observableArrayList();
    private IntegerProperty id = new SimpleIntegerProperty(0);
    private StringProperty nome = new SimpleStringProperty("");
    private StringProperty email = new SimpleStringProperty("");
    private StringProperty telefone = new SimpleStringProperty("");
    private ObjectProperty<LocalDate> nascimento = new SimpleObjectProperty<>(LocalDate.now());
    private int nextId = 1;

    public void gravar() { 
        if (id.get() == 0) { 
            Paciente paciente = new Paciente();
            nextId += 1;
            paciente.setId(nextId);
            paciente.setNome( this.nome.get() );
            paciente.setTelefone( this.telefone.get() );
            paciente.setEmail( this.email.get() );
            paciente.setNascimento( this.nascimento.get() );
            paciente.add( paciente );
        } else { 
            for (Paciente paciente : pacientes) { 
                if (paciente.getId() == this.id.get()) { 
                    paciente.setNome( this.nome.get() );
                    paciente.setTelefone( this.telefone.get() );
                    paciente.setEmail( this.email.get() );
                    paciente.setNascimento( this.nascimento.get() );
                }
            }
        }
        limparTudo();
        System.out.println("Lista tamanho: " + lista.size());
    }

    public void entidadeParaTela(Paciente paciente) { 
        this.id.set( paciente.getId());
        this.nome.set(paciente.getNome());
        this.telefone.set(paciente.getTelefone());
        this.email.set(paciente.getEmail());
        this.nascimento.set(paciente.getNascimento());
        this.sexo.set(paciente.getSexo());
        this.endereco.set(paciente.getEndereco());
        this.cartaoSUS.set(paciente.getCartaoSUS());
    }


    public List<Paciente> getPacientes() {
        return pacientes;
    }

    @SuppressWarnings("unchecked")
    public void excluir( Paciente paciente ) { 
        System.out.println("Excluido contato com nome: " + paciente.getNome());
        ((List<Paciente>) paciente).remove( paciente );
    }

    public void updatePaciente(Paciente paciente) {
        for (int i = 0; i < pacientes.size(); i++) {
            if (pacientes.get(i).getId() == paciente.getId()) {
                pacientes.set(i, paciente);
                return;
            }
        }
    }
}
