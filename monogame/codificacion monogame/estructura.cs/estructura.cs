
// Estructuras.cs - array 1d, array 2d, pila, cola, lista enlazada
using System.Collections.Generic;

namespace MascotaVirtual
{
    public class Estructuras
    {
        // array 1d
        public string[] acciones = { "alimentar", "jugar", "asear", "dormir" };

        // array 2d: fila = accion, columna = hambre, diversion, higiene, energia, salud
        public int[,] efectos = {
            { -30, 0, 0, 0, 10 },    // alimentar
            { 10, 40, -10, -20, 5 }, // jugar
            { 0, 0, 50, -10, 5 },    // asear
            { -10, 0, 0, 50, 10 } }; // dormir

        // pila: ultimo que entra, primero que sale
        public Stack<string> historial = new Stack<string>();
        // cola: primero que entra, primero que sale
        public Queue<string> eventos = new Queue<string>();
        // lista enlazada
        public LinkedList<string> logs = new LinkedList<string>();
    }
}


        public int cantidadEventos = 0;

        // Registro de lo que pasa en el juego: arreglo de 10 espacios
        public string[] logs = new string[10];
        public int cantidadLogs = 0;

        // Mascotas: arreglo de 5 espacios
        public Mascota[] mascotas = new Mascota[5];
        public int cantidadMascotas = 0;

        public void GuardarAccion(string accion)
        {
            if (cantidadHistorial < historial.Length)
            {
                historial[cantidadHistorial] = accion;
                cantidadHistorial++;
            }
        }

        public string UltimaAccion()
        {
            if (cantidadHistorial == 0) return "ninguna";
            return historial[cantidadHistorial - 1];
        }

        public void GuardarEvento(string evento)
        {
            if (cantidadEventos < eventos.Length)
            {
                eventos[cantidadEventos] = evento;
                cantidadEventos++;
            }
        }

        public void GuardarLog(string texto)
        {
            if (cantidadLogs < logs.Length)
            {
                logs[cantidadLogs] = texto;
                cantidadLogs++;
            }
        }

        public void GuardarMascota(Mascota m)
        {
            if (cantidadMascotas < mascotas.Length)
            {
                mascotas[cantidadMascotas] = m;
                cantidadMascotas++;
            }
        }

        public void Probar()
        {
            GuardarAccion("jugar");
            GuardarAccion("alimentar");
            string ultimo = UltimaAccion(); // "alimentar"

            GuardarEvento("se enferma");
            GuardarEvento("encuentra juguete");
            string primero = eventos[0]; // "se enferma"

            GuardarLog("sesion 1 empezo");
            GuardarLog("accion alimentar");

            GuardarMascota(new Mascota("firulais", "perro"));
            GuardarMascota(new Mascota("michi", "gato"));
        }
    }
}
