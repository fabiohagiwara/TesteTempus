using System;
using System.Configuration;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.EnterpriseServices;

namespace TesteTempus
{
    public partial class index : System.Web.UI.Page
    {
        private string conexao = ConfigurationManager.ConnectionStrings["conexao_mysql"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnCadCliente_Click(object sender, EventArgs e)
        {
            string cpf = txtCpf.Value;
            if(checkCpf(cpf.Replace(".", string.Empty).Replace("-", string.Empty))) {
                using (MySqlConnection con = new MySqlConnection(conexao))
                {
                    try
                    {
                        string nome = txtNome.Value;
                        string dtNasc = dataNasc.Value;
                        string renda = numRenda.Value;
                        string consulta = "INSERT INTO clientes (Nome, CPF, DT_Nascimento, DT_Cadastro, Renda) VALUES (@Nome,@CPF,@DT_Nascimento,NOW(),@Renda)";
                        MySqlCommand cmd = new MySqlCommand(consulta, con);
                        cmd.Parameters.AddWithValue("@Nome", nome);
                        cmd.Parameters.AddWithValue("@CPF", cpf.Replace(".", string.Empty).Replace("-", string.Empty));
                        cmd.Parameters.AddWithValue("@DT_Nascimento", dtNasc);
                        cmd.Parameters.AddWithValue("@Renda", renda);

                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                    catch (MySqlException ex)
                    {
                        System.Diagnostics.Debug.WriteLine(ex.Message);
                    }
                    finally
                    {
                        con.Close();
                    }
                    cpfResponse.InnerText = string.Empty;
                }
            }
            else
            {
                cpfResponse.InnerText = "CPF já cadastrado";
                cpfResponse.Attributes.Add("style","color:red");
            }
            limpaCampos();
        }

        protected void limpaCampos()
        {
            txtNome.Value = string.Empty;
            txtCpf.Value = string.Empty;
            dataNasc.Value = string.Empty;
            numRenda.Value = string.Empty;
        }

        protected bool checkCpf(string cpf)
        {
            using (MySqlConnection con = new MySqlConnection(conexao))
            {
                try
                {
                    string consulta = "SELECT * FROM clientes WHERE CPF = " + cpf;
                    MySqlCommand cmd = new MySqlCommand(consulta, con);
                    con.Open();
                    MySqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        return false;
                    }
                    else
                    {
                        return true;
                    }
                }
                catch (MySqlException ex)
                {
                    System.Diagnostics.Debug.WriteLine(ex.Message);
                    return false;
                }
                finally
                {
                    con.Close();
                }
            }
        }
    }
}