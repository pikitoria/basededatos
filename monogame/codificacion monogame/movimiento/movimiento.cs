using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Content;
using Microsoft.Xna.Framework.Graphics;
using Microsoft.Xna.Framework.Input;

namespace MascotaVirtual
{
    public class Movimiento
    {
        public Texture2D perritodefrente;
        public Texture2D perritoAtras;
        public Texture2D perritodecostadoizquierdo;
        public Texture2D perritodecostadopderecho;
        public Texture2D perritoActual;

        public int x = 450;
        public int y = 150;
        public int ancho = 150;
        public int alto = 150;
        public int velocidadNormal = 2;
        public int velocidadSprint = 5;
        public int velocidad = 2;
        public bool estaCorriendo = false;
        public bool seEstaMoviendo = false;
        public string direccion = "frente";
        public int limiteIzquierda = 0;
        public int limiteDerecha = 550;
        public int limiteArriba = 0;
        public int limiteAbajo = 300;

        public Movimiento()
        {
            x = 450;
            y = 150;
            ancho = 150;
            alto = 150;
            velocidadNormal = 2;
            velocidadSprint = 5;
            velocidad = velocidadNormal;
            estaCorriendo = false;
            seEstaMoviendo = false;
            direccion = "frente";
        }

        public Movimiento(int xInicial, int yInicial)
        {
            x = xInicial;
            y = yInicial;
            ancho = 150;
            alto = 150;
            velocidadNormal = 2;
            velocidadSprint = 5;
            velocidad = velocidadNormal;
            estaCorriendo = false;
            seEstaMoviendo = false;
            direccion = "frente";
        }

        public void Cargar(ContentManager Content)
        {
            perritodefrente = Content.Load<Texture2D>("perritodefrente");
            perritoAtras = Content.Load<Texture2D>("perritoAtras");
            perritodecostadoizquierdo = Content.Load<Texture2D>("perritodecostadoizquierdo");
            perritodecostadopderecho = Content.Load<Texture2D>("perritodecostadopderecho");
            perritoActual = perritodefrente;
        }

        public void Cargar(Texture2D perritodefrente, Texture2D perritoAtras, Texture2D perritodecostadoizquierdo, Texture2D perritodecostadopderecho)
        {
            this.perritodefrente = perritodefrente;
            this.perritoAtras = perritoAtras;
            this.perritodecostadoizquierdo = perritodecostadoizquierdo;
            this.perritodecostadopderecho = perritodecostadopderecho;
            perritoActual = perritodefrente;
        }

        public void Cargar(Texture2D perritodefrente, Texture2D perritoAtras, Texture2D perritodecostadoizquierdo, Texture2D perritodecostadopderecho, int xInicial, int yInicial)
        {
            this.perritodefrente = perritodefrente;
            this.perritoAtras = perritoAtras;
            this.perritodecostadoizquierdo = perritodecostadoizquierdo;
            this.perritodecostadopderecho = perritodecostadopderecho;
            perritoActual = perritodefrente;
            x = xInicial;
            y = yInicial;
        }

        public void Update(GameTime gameTime)
        {
            KeyboardState tecla = Keyboard.GetState();
            estaCorriendo = tecla.IsKeyDown(Keys.LeftShift) || tecla.IsKeyDown(Keys.RightShift);

            if (estaCorriendo)
            {
                velocidad = velocidadSprint;
            }
            else
            {
                velocidad = velocidadNormal;
            }

            seEstaMoviendo = false;

            if (tecla.IsKeyDown(Keys.Left) || tecla.IsKeyDown(Keys.A))
            {
                x -= velocidad;
                perritoActual = perritodecostadoizquierdo;
                direccion = "izquierda";
                seEstaMoviendo = true;
            }
            if (tecla.IsKeyDown(Keys.Right) || tecla.IsKeyDown(Keys.D))
            {
                x += velocidad;
                perritoActual = perritodecostadopderecho;
                direccion = "derecha";
                seEstaMoviendo = true;
            }
            if (tecla.IsKeyDown(Keys.Up) || tecla.IsKeyDown(Keys.W))
            {
                y -= velocidad;
                perritoActual = perritoAtras;
                direccion = "atras";
                seEstaMoviendo = true;
            }
            if (tecla.IsKeyDown(Keys.Down) || tecla.IsKeyDown(Keys.S))
            {
                y += velocidad;
                perritoActual = perritodefrente;
                direccion = "frente";
                seEstaMoviendo = true;
            }

            if (x < limiteIzquierda) x = limiteIzquierda;
            if (x > limiteDerecha) x = limiteDerecha;
            if (y < limiteArriba) y = limiteArriba;
            if (y > limiteAbajo) y = limiteAbajo;
        }

        public void Update(KeyboardState tecla)
        {
            estaCorriendo = tecla.IsKeyDown(Keys.LeftShift) || tecla.IsKeyDown(Keys.RightShift);

            if (estaCorriendo)
            {
                velocidad = velocidadSprint;
            }
            else
            {
                velocidad = velocidadNormal;
            }

            seEstaMoviendo = false;

            if (tecla.IsKeyDown(Keys.Left) || tecla.IsKeyDown(Keys.A))
            {
                x -= velocidad;
                perritoActual = perritodecostadoizquierdo;
                direccion = "izquierda";
                seEstaMoviendo = true;
            }
            if (tecla.IsKeyDown(Keys.Right) || tecla.IsKeyDown(Keys.D))
            {
                x += velocidad;
                perritoActual = perritodecostadopderecho;
                direccion = "derecha";
                seEstaMoviendo = true;
            }
            if (tecla.IsKeyDown(Keys.Up) || tecla.IsKeyDown(Keys.W))
            {
                y -= velocidad;
                perritoActual = perritoAtras;
                direccion = "atras";
                seEstaMoviendo = true;
            }
            if (tecla.IsKeyDown(Keys.Down) || tecla.IsKeyDown(Keys.S))
            {
                y += velocidad;
                perritoActual = perritodefrente;
                direccion = "frente";
                seEstaMoviendo = true;
            }

            if (x < limiteIzquierda) x = limiteIzquierda;
            if (x > limiteDerecha) x = limiteDerecha;
            if (y < limiteArriba) y = limiteArriba;
            if (y > limiteAbajo) y = limiteAbajo;
        }

        public void MoverIzquierda()
        {
            x -= velocidad;
            perritoActual = perritodecostadoizquierdo;
            direccion = "izquierda";
            seEstaMoviendo = true;
        }

        public void MoverDerecha()
        {
            x += velocidad;
            perritoActual = perritodecostadopderecho;
            direccion = "derecha";
            seEstaMoviendo = true;
        }

        public void MoverArriba()
        {
            y -= velocidad;
            perritoActual = perritoAtras;
            direccion = "atras";
            seEstaMoviendo = true;
        }

        public void MoverAbajo()
        {
            y += velocidad;
            perritoActual = perritodefrente;
            direccion = "frente";
            seEstaMoviendo = true;
        }

        public void ActivarSprint()
        {
            estaCorriendo = true;
            velocidad = velocidadSprint;
        }

        public void DesactivarSprint()
        {
            estaCorriendo = false;
            velocidad = velocidadNormal;
        }

        public void CambiarVelocidad(int nuevaNormal, int nuevaSprint)
        {
            velocidadNormal = nuevaNormal;
            velocidadSprint = nuevaSprint;
            if (estaCorriendo)
            {
                velocidad = velocidadSprint;
            }
            else
            {
                velocidad = velocidadNormal;
            }
        }

        public void CambiarPosicion(int nuevoX, int nuevoY)
        {
            x = nuevoX;
            y = nuevoY;
        }

        public void CambiarTamano(int nuevoAncho, int nuevoAlto)
        {
            ancho = nuevoAncho;
            alto = nuevoAlto;
        }

        public void CambiarLimites(int izquierda, int derecha, int arriba, int abajo)
        {
            limiteIzquierda = izquierda;
            limiteDerecha = derecha;
            limiteArriba = arriba;
            limiteAbajo = abajo;
        }

        public void Reiniciar()
        {
            x = 450;
            y = 150;
            velocidad = velocidadNormal;
            estaCorriendo = false;
            seEstaMoviendo = false;
            direccion = "frente";
            perritoActual = perritodefrente;
        }

        public Rectangle ObtenerRectangulo()
        {
            return new Rectangle(x, y, ancho, alto);
        }

        public Vector2 ObtenerPosicion()
        {
            return new Vector2(x, y);
        }

        public string ObtenerDireccion()
        {
            return direccion;
        }

        public bool EstaCorriendo()
        {
            return estaCorriendo;
        }

        public bool SeEstaMoviendo()
        {
            return seEstaMoviendo;
        }

        public void Dibujar(SpriteBatch spriteBatch)
        {
            spriteBatch.Draw(perritoActual, new Rectangle(x, y, ancho, alto), Color.White);
            
        }

        public void Dibujar(SpriteBatch spriteBatch, int dibujarX, int dibujarY)
        {
            spriteBatch.Draw(perritoActual, new Rectangle(dibujarX, dibujarY, ancho, alto), Color.White);
        }

        public void Dibujar(SpriteBatch spriteBatch, Color color)
        {
            spriteBatch.Draw(perritoActual, new Rectangle(x, y, ancho, alto), color);
        }
    }
}
