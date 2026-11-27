using System;
using System.IO;

namespace MascotaVirtual
{
    public class Archivos
    {
        // guardar log en txt
        public void GuardarTxt(string texto)
        {
            // append = agrega al final, no borra lo anterior
            // streamwriter = escribe en archivo
            using (StreamWriter w = new StreamWriter("backup.txt", true))
            {
                w.WriteLine(DateTime.Now + " - " + texto);
            }
        }

        // leer txt
        public string LeerTxt()
        {
            if (File.Exists("backup.txt") == false) return "no hay backup";
            return File.ReadAllText("backup.txt");
        }

        // guardar en binario
        public void GuardarBinario(Mascota m)
        {
            // binarywriter = escribe numeros y texto en binario
            using (BinaryWriter w = new BinaryWriter(File.Open("mascota.dat", FileMode.Create)))
            {
                w.Write(m.nombre);
                w.Write(m.hambre);
                w.Write(m.diversion);
                w.Write(m.salud);
            }
        }

        // leer binario
        public Mascota LeerBinario()
        {
            Mascota m = new Mascota("firulais", "perro");
            using (BinaryReader r = new BinaryReader(File.Open("mascota.dat", FileMode.Open)))
            {
                m.nombre = r.ReadString();
                m.hambre = r.ReadInt32();
                m.diversion = r.ReadInt32();
                m.salud = r.ReadInt32();
            }
            return m;
        }
    }
}
