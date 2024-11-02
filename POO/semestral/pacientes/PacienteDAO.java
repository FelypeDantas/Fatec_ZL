import java.util.ArrayList;
import java.util.List;

public class PacienteDAO {
    private List<Paciente> pacientes = new ArrayList<>();
    private int nextId = 1;

    public Paciente addPaciente(Paciente paciente) {
        paciente.setId(nextId++);
        pacientes.add(paciente);
        return paciente;
    }

    public List<Paciente> getPacientes() {
        return pacientes;
    }

    public boolean deletePaciente(int id) {
        return pacientes.removeIf(p -> p.getId() == id);
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
