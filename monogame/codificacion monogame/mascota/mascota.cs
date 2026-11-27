// Mascota.cs - registro + estado
// el Estado() es lo que usa Visual.cs para cambiar la cara
using System;

namespace MascotaVirtual
{
    public struct Mascota
    {
        public string nombre;
        public int hambre, diversion, higiene, energia, salud;

        public Mascota(string n)
        {
            nombre = n;
            hambre = 50; diversion = 50;
            higiene = 50; energia = 50; salud = 80;
        }

        public void Limitar()
        {
            hambre = Math.Clamp(hambre, 0, 100);
            diversion = Math.Clamp(diversion, 0, 100);
            higiene = Math.Clamp(higiene, 0, 100);
            energia = Math.Clamp(energia, 0, 100);
            salud = Math.Clamp(salud, 0, 100);
        }

        public string Estado()
        {
            if (salud <= 0) return "muerto";
            if (salud < 30) return "enfermo";
            if (diversion < 30) return "triste";
            if (hambre > 80) return "hambriento";
            if (higiene < 30) return "sucio";
            if (energia < 30) return "cansado";
            return "feliz";
        }
    }
}


