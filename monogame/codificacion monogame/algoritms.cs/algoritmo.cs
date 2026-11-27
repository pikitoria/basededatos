// Algoritmos.cs - busquedas, ordenamiento y recursion
namespace MascotaVirtual
{
    public class Algoritmos
    {
        // busqueda secuencial O(n)
        public int BuscarSecuencial(string[] n, string buscar)
        {
            for (int i = 0; i < n.Length; i++)
                if (n[i] == buscar) return i;
            return -1;
        }

        // busqueda binaria O(log n), solo si esta ordenado
        public int BuscarBinaria(int[] n, int buscar)
        {
            int ini = 0, fin = n.Length - 1;
            while (ini <= fin)
            {
                int medio = (ini + fin) / 2;
                if (n[medio] == buscar) return medio;
                if (n[medio] < buscar) ini = medio + 1;
                else fin = medio - 1;
            }
            return -1;
        }

        // burbuja O(n2)
        public void Burbuja(int[] n)
        {
            for (int i = 0; i < n.Length - 1; i++)
                for (int j = 0; j < n.Length - 1 - i; j++)
                    if (n[j] > n[j + 1]) { int a = n[j]; n[j] = n[j + 1]; n[j + 1] = a; }
        }

        // ordenamiento por insercion O(n2)
        public void Insercion(int[] n)
        {
            for (int i = 1; i < n.Length; i++)
            {
                int aux = n[i];
                int j = i - 1;
                while (j >= 0 && n[j] > aux) { n[j + 1] = n[j]; j--; }
                n[j + 1] = aux;
            }
        }

        // ordenamiento por seleccion O(n2)
        public void Seleccion(int[] n)
        {
            for (int i = 0; i < n.Length - 1; i++)
            {
                int menor = i;
                for (int j = i + 1; j < n.Length; j++)
                    if (n[j] < n[menor]) menor = j;
                int aux = n[i]; n[i] = n[menor]; n[menor] = aux;
            }
        }

        // recursion: se llama a si misma
        public int SumarFelicidad(int[] f, int n)
        {
            if (n <= 0) return 0; // caso base
            return f[n - 1] + SumarFelicidad(f, n - 1);
        }
    }
}
