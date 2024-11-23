package pacientes;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import pacientes.Paciente;

public class PacienteDAOImpl {
    private static final String DB_CLASS = "org.mariadb.jdbc.Driver";
    private static final String DB_URL = "jdbc:mariadb://localhost:3306/hospitaldb?allowPublicKeyRetrieval=true";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "123456";
    private Connection con = null;

    public PacienteDAOImpl() throws PacienteException {
        try {
            Class.forName(DB_CLASS);
            con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            throw new PacienteException(e);
        }
    }

    @Override
    public void inserir(Paciente p) throws PacienteException {
      try {
        String SQL = """
            INSERT INTO estoque (id, nome, cadastro, sexo, endereco, telefone, email, cartaoSus )
            VALUES (?, ?, ?, ?, ?, ?, ?, ? )
            """;
        PreparedStatement stm = con.prepareStatement(SQL);
        stm.setInt(1, 0);
        stm.setString(2, p.getNome());
        stm.setDate(3, p.getCadastro());
        stm.setString(4, p.getSexo());
        stm.setString(5, p.getEndereco());
        stm.setString(6, p.getTelefone());
        stm.setString(5, p.getEmail());
        stm.setString(5, p.getCartaoSus());
        int i = stm.executeUpdate();
        System.out.println(i);
      } catch (SQLException er) {
        er.printStackTrace();
        throw new EstoqueException(er);
      }
    }

    @Override
    public void atualizar(Paciente p) throws EstoqueException {
      try {
        String SQL = """
            UPDATE paciente SET nome=?, cadastro=?, sexo=?, endereco=?, telefone=?, email=?, cartaoSus=?
            WHERE id=?
            """;
        PreparedStatement stm = con.prepareStatement(SQL);
        stm.setString(1, e.getNome());
        stm.setDate(2, e.getCadastro());
        stm.setString(3, e.getSexo());
        stm.setString(4, e.getEndereco());
        stm.setString(4, e.getTelefone());
        stm.setString(4, e.getEmail());
        stm.setString(4, e.getCartaoSus());
        stm.setInt(5, e.getId());
        int i = stm.executeUpdate();
      } catch (SQLException er) {
        er.printStackTrace();
        throw new EstoqueException(er);
      }
    }

    @Override
    public void remover(Paciente p) throws PacienteException {
      try {
        String SQL = """
                DELETE FROM estoque WHERE id=?
            """;
        PreparedStatement stm = con.prepareStatement(SQL);
        stm.setInt(1, e.getId());
        int i = stm.executeUpdate();
      } catch (SQLException er) {
        er.printStackTrace();
        throw new PacienteException(er);
      }
    }

    @Override
    public List<Paciente> pesquisarPorNome(String nome) throws PacienteException {
      List<Paciente> lista = new ArrayList<>();
      try {
        String SQL = """
              SELECT * FROM paciente WHERE nome LIKE ?
            """;
        PreparedStatement stm = con.prepareStatement(SQL);
        stm.setString(1, "%" + nome + "%");
        // Lista com o resultado da query
        ResultSet rs = stm.executeQuery();
        // Enquanto existir elementos na lista continua o while
        while (rs.next()) {
          Paciente p = new Paciente();
          p.setId(rs.getInt("id"));
          p.setNome(rs.getString("nome"));
          p.setCadastro(rs.getDate("cadastro"));
          p.setSexo(rs.getString("sexo"));
          p.setEndereco(rs.getString("endereco"));
          p.setTelefone(rs.getString("telefone"));
          p.setEmail(rs.getString("email"));
          p.setCartaoSus(rs.getString("cartao"));
          lista.add(p);
        }
      } catch (SQLException er) {
        er.printStackTrace();
        throw new PacienteException(er);
      }
      return lista;
    }

    @Override
    public List<Paciente> pesquisarTodos() throws EstoqueException {
      List<Paciente> lista = new ArrayList<>();
      try {
        String SQL = """
            SELECT * FROM paciente
            """;
        PreparedStatement stm = con.prepareStatement(SQL);
        ResultSet rs = stm.executeQuery();
        while (rs.next()) {
          Paciente p = new Paciente();
          p.setId(rs.getInt("id"));
          p.setNome(rs.getString("nome"));
          p.setCadastro(rs.getDate("cadastro"));
          p.setSexo(rs.getString("sexo"));
          p.setEndereco(rs.getString("endereco"));
          p.setTelefone(rs.getString("telefone"));
          p.setEmail(rs.getString("email"));
          p.setCartaoSus(rs.getString("cartao"));
          lista.add(p);
        }
      } catch (SQLException er) {
        er.printStackTrace();
        throw new PacienteException(er);
      }
      return lista;
    }
  
}
