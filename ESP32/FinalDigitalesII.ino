
#include <WiFi.h>
#include <WiFiMulti.h>
#include <WiFiClient.h>
//#include <Wire.h>

#define ssid1        "_________"
#define password1    "________"

unsigned int distancia = 0;

const int TRIGGER = 35;
const int ECHO = 34;
const int MI1 = 15;
const int MI2 = 2;
const int MD1 = 4;
const int MD2 = 5;


WiFiMulti wifiMulti;
WiFiServer server(80);

String header;

String laberinto[20][20];

String color="F323EF";

// Diseño de la pagina que va a ser mostrada
String pagina = "<!DOCTYPE html>"
                "<html>"
                "<head>"
                "<title> Control carro recorredor de laberinto </title>"
                "</head>"
                "<body>"
                "<center>"
                "<p><a href='/forw'><button> Adelante </button></p>"
                "<p><a href='/izq'><button> Izquierda </button>"
                "<a href='/stop'><button> Detener </button>"
                "<a href='/der'><button> Derecha </button></p>"
                "<p><a href='/back'><button> Atras </button></p>"
                "<table width='280' cellspacing='1' cellpadding='3' border='0' bgcolor='#1E679A'>"
                "<tr>"
                "<td><font color='FFFFFF' face='arial, verdana, helvetica'>"
                "<b>Color captado por la camara</b>"
                "</font></td>"
                "</tr>"
                "<tr>"
                "<td bgcolor=#"+color+
                "rowspan='20'>"
                "<font face='arial, verdana, helvetica'>"
                " &nbsp; <br>   "
                " &nbsp; <br> "
                " &nbsp; <br> "
                " &nbsp; <br> "
                " &nbsp;"
                "</font>"
                "</td>"
                "</tr>"
                "</table>"
                "</center>"
                "</body>"
                "</html>";


//SetUP
void setup() {
  Serial.begin(115200);//iniciailzamos la comunicación
  pinMode(TRIGGER, OUTPUT); //pin como salida
  pinMode(ECHO, INPUT);  //pin como entrada
  digitalWrite(TRIGGER, LOW);//Inicializamos el pin con 0
  pinMode(MI1, OUTPUT); //pin como salida
  pinMode(MI2, OUTPUT); //pin como salida
  pinMode(MD1, OUTPUT); //pin como salida
  pinMode(MD2, OUTPUT); //pin como salida

//  Wire.begin();
  
  wifiMulti.addAP(ssid1, password1);        //Conexion con la red wi-fi
  Serial.println("Connecting Wifi...");
  if (wifiMulti.run() == WL_CONNECTED) {
    Serial.println("");
    Serial.println("WiFi connected");
    Serial.println("IP address: ");
    Serial.println(WiFi.localIP());
  }
  server.begin();
}


//Loop
void loop()
{
  servidor();
}



//Interaccion entre la pagina y los pines del microcontrolador
void servidor() {
  WiFiClient client = server.available();
  if (client)
  {
    //Serial.println("New Client.");
    String currentLine = "";
    while (client.connected())
    {
      if (client.available())
      {
        char c = client.read();
        //Serial.write(c);
        header += c;
        if (c == '\n')
        {
          if (currentLine.length() == 0)
          {
            client.println("HTTP/1.1 200 OK");
            client.println("Content-type:text/html");
            client.println("Connection: close");
            client.println();

            if (header.indexOf("GET /forw") >= 0) {
              digitalWrite(MI2, HIGH);
              digitalWrite(MI1, LOW);
              digitalWrite(MD2, HIGH);
              digitalWrite(MD1, LOW);
            } else if (header.indexOf("GET /izq") >= 0) {
              digitalWrite(MI2, LOW);
              digitalWrite(MI1, LOW);
              digitalWrite(MD2, HIGH);
              digitalWrite(MD1, LOW);
              
            } else if (header.indexOf("GET /der") >= 0) {
              digitalWrite(MI2, HIGH);
              digitalWrite(MI1, LOW);
              digitalWrite(MD2, LOW);
              digitalWrite(MD1, LOW);
              
            } else if (header.indexOf("GET /back") >= 0) {
              digitalWrite(MI2, LOW);
              digitalWrite(MI1, HIGH);
              digitalWrite(MD2, LOW);
              digitalWrite(MD1, HIGH);
              
            } else if (header.indexOf("GET /stop") >= 0) {
              digitalWrite(MI2, LOW);
              digitalWrite(MI1, LOW);
              digitalWrite(MD2, LOW);
              digitalWrite(MD1, LOW);
              
            }

            client.println(pagina);
            client.println();
            break;
          }
          else
          {
            currentLine = "";
          }
        } else if (c != '\r') {
          currentLine += c;
        }
      }
    }
    header = "";
    // close the connection:
    client.stop();
    //Serial.println("Client Disconnected.");
  }
}


// Uso del ultrasonido

// digitalWrite(MI2, HIGH);
//   digitalWrite(MI1, HIGH);
//   digitalWrite(MD2, HIGH);
//   digitalWrite(MD1, HIGH);
//
//
//  long t; //timepo que demora en llegar el eco
//  long d; //distancia en centimetros
//
//  digitalWrite(TRIGGER, HIGH);
//  delayMicroseconds(10);          //Enviamos un pulso de 10us
//  digitalWrite(TRIGGER, LOW);
//
//  t = pulseIn(ECHO, HIGH); //obtenemos el ancho del pulso
//  d = t/59;             //escalamos el tiempo a una distancia en cm
//
//  Serial.print(t);
//  Serial.println();
//  Serial.print("Distancia: ");
//  Serial.print(d);      //Enviamos serialmente el valor de la distancia
//  Serial.print("cm");
//  Serial.println();
//  delay(1000);          //Hacemos una pausa de 100ms
