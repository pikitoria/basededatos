// Estructuras.cs - array 1d, array 2d, lista enlazada
using System.Collections.Generic;

namespace MascotaVirtual
{
    public class Estructuras
    {
        // array 1d
        public string[] acciones = { "alimentar", "jugar", "asear", "dormir" };

        // array 2d: fila = accion, columna = hambre, diversion, higiene, energia, salud
        public int[,] efectos = {
            { -30, 0, 0, 0, 10 }, // alimentar
            { 10, 40, -10, -20, 5 }, // jugar
            { 0, 0, 50, -10, 5 }, // asear
            { -10, 0, 0, 50, 10 } }; // dormir

        // lista enlazada
        public LinkedList<string> logs = new LinkedList<string>();
    }
}
