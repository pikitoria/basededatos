
// Visual.cs - Firulais + reacciones + accesorios
// solo usa cuadrado + letra, sin fotos
using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Graphics;

namespace MascotaVirtual
{
    public class Visual
    {
        SpriteBatch spriteBatch;
        SpriteFont letra;
        Texture2D cuadrado;

        public Visual(SpriteBatch sb, SpriteFont f, Texture2D c)
        { spriteBatch = sb; letra = f; cuadrado = c; }

        // accesorio: -1 ninguno, 0 comer, 1 jugar, 2 asear, 3 dormir
        public void DibujarTodo(Mascota m, int accesorio, int salto)
        {
            string estado = m.Estado();
            int x = 450, y = 150 - salto;

            Color cuerpo = Color.Brown;
            if (estado == "sucio") cuerpo = Color.Olive;
            if (estado == "enfermo") cuerpo = Color.PaleVioletRed;
            if (estado == "muerto") cuerpo = Color.Gray;

            // --- FIRULAIS ---
            spriteBatch.Draw(cuadrado, new Rectangle(x, y, 150, 100), cuerpo);
            spriteBatch.Draw(cuadrado, new Rectangle(x + 25, y - 50, 100, 60), cuerpo);
            spriteBatch.Draw(cuadrado, new Rectangle(x + 10, y - 50, 20, 40), Color.Black);
            spriteBatch.Draw(cuadrado, new Rectangle(x + 120, y - 50, 20, 40), Color.Black);
            spriteBatch.Draw(cuadrado, new Rectangle(x + 10, y + 100, 30, 20), Color.Black);
            spriteBatch.Draw(cuadrado, new Rectangle(x + 110, y + 100, 30, 20), Color.Black);
            spriteBatch.Draw(cuadrado, new Rectangle(x + 150, y + 20, 30, 10), Color.Black);
            spriteBatch.Draw(cuadrado, new Rectangle(x + 25, y + 10, 100, 10), Color.Red); // collar

            // --- CARA SEGUN ESTADO ---
            if (estado == "muerto")
            {
                spriteBatch.DrawString(letra, "X       X", new Vector2(x + 45, y - 35), Color.Black);
                spriteBatch.DrawString(letra, "X_X", new Vector2(x + 65, y - 5), Color.Black);
            }
            else if (estado == "cansado" || accesorio == 3)
            {
                spriteBatch.DrawString(letra, "-       -", new Vector2(x + 45, y - 35), Color.Black);
                spriteBatch.DrawString(letra, "zZz", new Vector2(x + 65, y - 5), Color.Black);
            }
            else
            {
                spriteBatch.Draw(cuadrado, new Rectangle(x + 50, y - 30, 10, 10), Color.Black);
                spriteBatch.Draw(cuadrado, new Rectangle(x + 100, y - 30, 10, 10), Color.Black);
                string boca = ":)";
                if (estado == "triste") boca = ":(";
                if (estado == "enfermo") boca = ":S";
                if (estado == "hambriento") boca = ":O";
                spriteBatch.DrawString(letra, boca, new Vector2(x + 65, y - 5), Color.Black);
            }

            // --- REACCIONES SOLAS ---
            if (estado == "hambriento") spriteBatch.DrawString(letra, "tengo hambre!", new Vector2(x - 10, y - 80), Color.Red);
            if (estado == "sucio") spriteBatch.DrawString(letra, "zzz", new Vector2(x + 160, y - 40), Color.Green);
            if (estado == "triste") spriteBatch.DrawString(letra, "lagrima", new Vector2(x + 140, y - 20), Color.Cyan);
            if (estado == "enfermo")
            {
                spriteBatch.Draw(cuadrado, new Rectangle(x + 45, y - 55, 20, 20), Color.White);
                spriteBatch.Draw(cuadrado, new Rectangle(x + 52, y - 55, 6, 20), Color.Red);
            }

            // --- ACCESORIOS ---
            if (accesorio == 0) // COMER
            {
                spriteBatch.Draw(cuadrado, new Rectangle(x - 20, y + 120, 120, 20), Color.White);
                spriteBatch.Draw(cuadrado, new Rectangle(x, y + 105, 15, 15), Color.Brown);
                spriteBatch.Draw(cuadrado, new Rectangle(x + 30, y + 105, 15, 15), Color.Brown);
                spriteBatch.Draw(cuadrado, new Rectangle(x + 60, y + 105, 15, 15), Color.Brown);
                spriteBatch.DrawString(letra, "nom nom!", new Vector2(x + 10, y + 80), Color.Yellow);
            }
            if (accesorio == 1) // JUGAR
            {
                spriteBatch.Draw(cuadrado, new Rectangle(x + 170, y + 80, 35, 35), Color.Red);
                spriteBatch.Draw(cuadrado, new Rectangle(x + 182, y + 80, 10, 35), Color.White);
                spriteBatch.DrawString(letra, "a jugar!", new Vector2(x + 140, y + 50), Color.Green);
            }
            if (accesorio == 2) // ASEAR
            {
                spriteBatch.Draw(cuadrado, new Rectangle(x - 20, y - 20, 15, 15), Color.Cyan);
                spriteBatch.Draw(cuadrado, new Rectangle(x + 140, y - 30, 20, 20), Color.Cyan);
                spriteBatch.DrawString(letra, "limpio!", new Vector2(x + 40, y - 80), Color.Cyan);
            }
            if (accesorio == 3) // DORMIR
            {
                spriteBatch.DrawString(letra, "Z", new Vector2(x + 140, y - 70), Color.White);
                spriteBatch.DrawString(letra, "Z", new Vector2(x + 160, y - 95), Color.White);
                spriteBatch.DrawString(letra, "Z", new Vector2(x + 180, y - 120), Color.White);
            }
        }

        public void DibujarBarra(int x, int y, int valor, Color color)
        {
            spriteBatch.Draw(cuadrado, new Rectangle(x, y, 200, 20), Color.Gray);
            spriteBatch.Draw(cuadrado, new Rectangle(x, y, valor * 2, 20), color);
        }

        public Color ColorFondo(string estado, int accesorio)
        {
            if (estado == "enfermo") return Color.DarkRed;
            if (estado == "triste") return Color.Gray;
            if (estado == "cansado" || accesorio == 3) return Color.DarkBlue;
            return Color.CornflowerBlue;
        }
    }
}
