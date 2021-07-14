using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data;
using MySql.Data.MySqlClient;

namespace TesteTempus
{
    public partial class viewClientes : System.Web.UI.Page
    {
        private string conexao = ConfigurationManager.ConnectionStrings["conexao_mysql"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            populaClientes();
            populaCards();
        }

        private void populaClientes()
        {
            using (MySqlConnection con = new MySqlConnection(conexao))
            {
                try
                {
                    string consulta = "SELECT ID_Cliente,Nome,SUBSTRING(CONCAT('R$ ',Renda) FROM 1 FOR CHAR_LENGTH(CONCAT('R$ ',Renda)) - 3) AS Renda, Renda AS RendaFull FROM clientes";
                    DataSet ds = new DataSet();
                    MySqlCommand cmd = new MySqlCommand(consulta, con);
                    con.Open();
                    MySqlDataAdapter adp = new MySqlDataAdapter(cmd);
                    adp.Fill(ds);
                    rptClientes.DataSource = ds;
                    rptClientes.DataBind();
                }
                catch (MySqlException ex)
                {
                    System.Diagnostics.Debug.WriteLine(ex.Message);
                }
                finally
                {
                    con.Close();
                }
            }
        }

        protected void rptClientes_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            var lblId = (Label)e.Item.FindControl("lblIdCliente");
            var lblRenda = (Label)e.Item.FindControl("lblRenda");
            var hidRenda = (HiddenField)e.Item.FindControl("hidRenda");

            if(lblId != null)//pula a linha de cabeçalho da tabela
            {
                if(Convert.ToDouble(hidRenda.Value) <= 980)
                {
                    lblRenda.Attributes.Add("class", "badge classea");
                }
                else if(Convert.ToDouble(hidRenda.Value) >= 980.01 && Convert.ToDouble(hidRenda.Value) <= 2500)
                {
                    lblRenda.Attributes.Add("class", "badge classeb");
                }
                else if(Convert.ToDouble(hidRenda.Value) > 2500)
                {
                    lblRenda.Attributes.Add("class", "badge classec");
                }
            }
        }

        protected void populaCards()
        {
            using (MySqlConnection con = new MySqlConnection(conexao))
            {
                try
                {
                    string consulta = "";
                    if (ddlRange.SelectedValue == "Hoje")
                    {
                        consulta = "SELECT (SELECT COUNT(*) FROM clientes WHERE Renda <= 980 AND DAY(NOW())-DAY(DT_Cadastro) = 0 AND MONTH(NOW())-MONTH(DT_Cadastro) = 0 AND YEAR(NOW())-YEAR(DT_Cadastro) = 0) AS 'Classe A'," +
                            "(SELECT COUNT(*) FROM clientes WHERE Renda >= 980.01 AND Renda <= 2500 AND DAY(NOW())-DAY(DT_Cadastro) = 0 AND MONTH(NOW())-MONTH(DT_Cadastro) = 0 AND YEAR(NOW())-YEAR(DT_Cadastro) = 0) AS 'Classe B'," +
                            "(SELECT COUNT(*) FROM clientes WHERE Renda > 2500 AND DAY(NOW())-DAY(DT_Cadastro) = 0 AND MONTH(NOW())-MONTH(DT_Cadastro) = 0 AND YEAR(NOW())-YEAR(DT_Cadastro) = 0) AS 'Classe C'," +
                            "(SELECT COUNT(*) FROM clientes WHERE TIMESTAMPDIFF(YEAR, DT_Nascimento, CURDATE()) >= 18 AND Renda > (SELECT AVG(Renda) FROM clientes) AND DAY(NOW())-DAY(DT_Cadastro) = 0 AND MONTH(NOW())-MONTH(DT_Cadastro) = 0 AND YEAR(NOW())-YEAR(DT_Cadastro) = 0) AS '18Media'";
                    }
                    else if(ddlRange.SelectedValue == "Mes")
                    {
                        consulta = "SELECT (SELECT COUNT(*) FROM clientes WHERE Renda <= 980 AND MONTH(NOW())-MONTH(DT_Cadastro) = 0 AND YEAR(NOW())-YEAR(DT_Cadastro) = 0) AS 'Classe A'," +
                            "(SELECT COUNT(*) FROM clientes WHERE Renda >= 980.01 AND Renda <= 2500 AND MONTH(NOW())-MONTH(DT_Cadastro) = 0 AND YEAR(NOW())-YEAR(DT_Cadastro) = 0) AS 'Classe B'," +
                            "(SELECT COUNT(*) FROM clientes WHERE Renda > 2500 AND MONTH(NOW())-MONTH(DT_Cadastro) = 0 AND YEAR(NOW())-YEAR(DT_Cadastro) = 0) AS 'Classe C'," +
                            "(SELECT COUNT(*) FROM clientes WHERE TIMESTAMPDIFF(YEAR, DT_Nascimento, CURDATE()) >= 18 AND Renda > (SELECT AVG(Renda) FROM clientes) AND MONTH(NOW())-MONTH(DT_Cadastro) = 0 AND YEAR(NOW())-YEAR(DT_Cadastro) = 0) AS '18Media'";
                    }
                    else if(ddlRange.SelectedValue == "Semana")
                    {
                        consulta = "SELECT (SELECT COUNT(*) FROM clientes WHERE Renda <= 980 AND YEARWEEK(DT_Cadastro) = YEARWEEK(NOW())) AS 'Classe A'," +
                            "(SELECT COUNT(*) FROM clientes WHERE Renda >= 980.01 AND Renda <= 2500 AND YEARWEEK(DT_Cadastro) = YEARWEEK(NOW())) AS 'Classe B'," +
                            "(SELECT COUNT(*) FROM clientes WHERE Renda > 2500 AND YEARWEEK(DT_Cadastro) = YEARWEEK(NOW())) AS 'Classe C'," +
                            "(SELECT COUNT(*) FROM clientes WHERE TIMESTAMPDIFF(YEAR, DT_Nascimento, CURDATE()) >= 18 AND Renda > (SELECT AVG(Renda) FROM clientes) AND YEARWEEK(DT_Cadastro) = YEARWEEK(NOW())) AS '18Media'"; 
                    }
                    MySqlCommand cmd = new MySqlCommand(consulta, con);
                    con.Open();
                    MySqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        cliA.Text = reader["Classe A"].ToString();
                        cliB.Text = reader["Classe B"].ToString();
                        cliC.Text = reader["Classe C"].ToString();
                        rendaplus.Text = reader["18Media"].ToString();
                    }
                }
                catch (MySqlException ex)
                {
                    System.Diagnostics.Debug.WriteLine(ex.Message);
                }
                finally
                {
                    con.Close();
                }
            }
        }

    }
}