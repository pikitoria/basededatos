using System;
using System.IO;
using MySqlConnector;

namespace MascotaVirtual
{
    public class Guardado
    {
        string conexion = "server=localhost;database=MascotaVirtual;user=root;password=1234;";

        public void GuardarTxt(string texto)
        {
            using (StreamWriter w = new StreamWriter("backup.txt", true))
                w.WriteLine(DateTime.Now + " - " + texto);
        }

        // CREATE: jugador
        public int CrearJugador(string nombre)
        {
            using (MySqlConnection con = new MySqlConnection(conexion))
            {
                con.Open();
                string sql = "insert into players (nombre) values (@n); select last_insert_id();";
                using (MySqlCommand cmd = new MySqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@n", nombre);
                    return Convert.ToInt32(cmd.ExecuteScalar());
                }
            }
        }

        // CREATE: mascota
        public int CrearMascota(int idJugador, string nombreMascota)
        {
            using (MySqlConnection con = new MySqlConnection(conexion))
            {
                con.Open();
                string sql = "insert into pets (idplayer, nombre, hambre, diversion, higiene, energia, salud) values (@id, @n, 50, 50, 50, 50, 80); select last_insert_id();";
                using (MySqlCommand cmd = new MySqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@id", idJugador);
                    cmd.Parameters.AddWithValue("@n", nombreMascota);
                    return Convert.ToInt32(cmd.ExecuteScalar());
                }
            }
        }

        // CREATE: guardar cada accion
        public void GuardarAccion(int idMascota, string accion)
        {
            using (MySqlConnection con = new MySqlConnection(conexion))
            {
                con.Open();
                string sql = "insert into actions_log (idpet, accion, fecha) values (@id, @a, now())";
                using (MySqlCommand cmd = new MySqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@id", idMascota);
                    cmd.Parameters.AddWithValue("@a", accion);
                    cmd.ExecuteNonQuery();
                }
            }
        }

        // READ: con JOIN
        public void LeerMascotas()
        {
            using (MySqlConnection con = new MySqlConnection(conexion))
            {
                con.Open();
                string sql = "select players.nombre as jugador, pets.nombre as mascota from players inner join pets on pets.idplayer = players.idplayer";
                using (MySqlCommand cmd = new MySqlCommand(sql, con))
                {
                    using (MySqlDataReader lector = cmd.ExecuteReader())
                    {
                        while (lector.Read())
                            Console.WriteLine(lector["jugador"] + " - " + lector["mascota"]);
                    }
                }
            }
        }

        // UPDATE: actualizar numeros
        public void ActualizarMascota(Mascota m, int idMascota)
        {
            using (MySqlConnection con = new MySqlConnection(conexion))
            {
                con.Open();
                string sql = "update pets set hambre=@h, diversion=@d, higiene=@hi, energia=@e, salud=@s where idpet=@id";
                using (MySqlCommand cmd = new MySqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@h", m.hambre);
                    cmd.Parameters.AddWithValue("@d", m.diversion);
                    cmd.Parameters.AddWithValue("@hi", m.higiene);
                    cmd.Parameters.AddWithValue("@e", m.energia);
                    cmd.Parameters.AddWithValue("@s", m.salud);
                    cmd.Parameters.AddWithValue("@id", idMascota);
                    cmd.ExecuteNonQuery();
                }
            }
        }

        // DELETE
        public void BorrarSesion(int id)
        {
            using (MySqlConnection con = new MySqlConnection(conexion))
            {
                con.Open();
                using (MySqlCommand cmd = new MySqlCommand("delete from sessions where idsession=@id", con))
                {
                    cmd.Parameters.AddWithValue("@id", id);
                    cmd.ExecuteNonQuery();
                }
            }
        }

        // STORE PROCEDURE
        public string LlamarAlimentar(int idMascota)
        {
            using (MySqlConnection con = new MySqlConnection(conexion))
            {
                con.Open();
                using (MySqlCommand cmd = new MySqlCommand("call sp_alimentar(@id, @msg)", con))
                {
                    cmd.Parameters.AddWithValue("@id", idMascota);
                    cmd.Parameters.Add("@msg", MySqlDbType.VarChar, 100).Direction = System.Data.ParameterDirection.Output;
                    cmd.ExecuteNonQuery();
                    return cmd.Parameters["@msg"].Value.ToString();
                }
            }
        }
    }
}

