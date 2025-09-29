drop database if exists CineStar;
create database CineStar;
use CineStar;

create table Distrito (
  id int auto_increment primary key,
  Detalle char(30) unique );

create table Genero (
  id int primary key auto_increment,
  Detalle char(30) unique );

create table Pelicula (
  id int primary key auto_increment,
  Titulo char(80) not null,
  FechaEstreno char(10) not null,
  Director char(50) not null,
  Generos char(10) not null,
  idClasificacion int not null,
  idEstado int not null,
  Duracion char(3) not null,
  Link char(20),
  Reparto text(300),
  Sinopsis text(800) );  

create table Cine (
  id int primary key auto_increment,
  RazonSocial char(30) not null,
  Salas int not null,
  idDistrito int references Distrito,
  Direccion char(100) not null,
  Telefonos char(20) not null );

create table CinePelicula (
  idCine int references Cine,
  idPelicula int references Pelicula,
  Sala int not null,
  Horarios char(150) not null );

create table CineTarifa (
  idCine int references Cine,
  DiasSemana char(80) not null,
  Precio decimal(5,2) not null );

create table Cliente(
	id int primary key auto_increment,
    Nombres char(50) not null,
    Correo char(50) not null,
    Passwordd char(20) not null );

/* --------------------------------------------------------------------------------- */

insert Distrito(Detalle) values ('Breña'),('Comas'),('Jesús Maria'),('Lima'),('Rímac'),('San Borja'),('San Juan de Lurigancho'),('San Juan de Miraflores'),('Santiago de Surco');
insert Genero(Detalle) values ('Acción'),('Animación'),('Aventura'),('Biografico'),('Ciencia Ficción'),('Comedia'),('Drama'),('Familiar'),('Fantasía'),('Histórico'),('Musical'),('Romance'),('Suspenso'),('Terror'),('Thriller');

insert Pelicula values
	( null,'Jumanji: En la Selva (Todo Público)','2018/01/11','Jake Kasdan','3,9',1,1,'120','6maujJFcuxA','Dwayne Johnson, Kevin Hart, Jack Black, Karen Gillan','Remake de la película homónima de 1995 adaptado a la época actual, en donde cuatro adolescentes se introducen en un nueva aventura a partir de “Jumanji”, un videojuego que sirve como un portal a través del espacio-tiempo. Absorbidos por el mundo de Jumanji, este juego no se puede abandonar hasta que acaba la partida' ),
	( null,'Django: Sangre de mi Sangre (+18)','2018/01/25','Aldo Salvini','7,1',3,1,'110','faXp0Q3glPU','Melania Urbina, Giovanni Ciccia, Sergio Galliani','Después de cumplir la condena de 15 años en prisión, Orlando Hernández “Django“, sale en libertad sin saber el destino que le aguarda. Un mundo criminal más hostil que el que él conoció en su pasado, plagado de enemigos que harán lo posible por truncar su sueño de volver con su familia y recuperar a sus hijos. La lucha de un hombre por caminar derecho en una ciudad corrompida por el crimen.' ),
	( null,'La Noche del Demonio: La Última Llave (+14)','2018/02/01','Adam Robitel','14',2,1,'110','AlcCJkJCqOM','Javier Botet, Lin Shaye, Tessa Ferrer, Josh Stewart, Spencer Locke, Kirk Acevedo','La parapsicóloga Dra. Elise Rainier debe enfrentar la aparición más terrible y personal hasta el momento: la que se esconde en su propia casa.' ),
	( null,'Paddington 2 (Todo Público)','2018/02/01','Paul King','2,8,3',1,1,'110','U-z9i1tfJjQ','Brendan Gleeson, Sally Hawkins, Hugh Grant, Michael Gambon','El oso Paddington ya está felizmente integrado en casa de la familia Brown. Se ha convertido además en un miembro muy popular de la comunidad de Windsor Gardens. Su tía Lucy cumple 100 años y él tiene el regalo perfecto para ella: un maravilloso libro pop-up de la tienda de antigüedades de Mr. Gruber. Para poder comprar el libro, Paddington decidirá realizar una serie de extraños trabajos. Pero todo se complica cuando el libro es robado.' ),
	( null,'Vikingos (+14)','2018/02/08','Andrey Kravchuk','1,7,10',2,1,'100','Y9M-LfX5td8','Danila Kozlovsky, Svetlana Khodchenkova, Maxim Sukhanov, Aleksandr Ustyugov','Basada en una historia real sucedida en los tiempos precristianos de la Rus y relatada tanto en la ‘Primera Crónica Eslava’, como en ‘Las Sagas de los Reyes’ nórdica, cuando el antiguo pueblo eslavo aún mantenía fuertes lazos culturales y de sangre con los vikingos. Tras la muerte de su padre, Sviatoslav I, el joven príncipe Vladímir se ve obligado a huir de las manos de su hermanastro mayor Yaropolk, quien asesinó a su otro hermano, Oleg, para entronarse en Kiev, capital ancestral de la Rus. Exiliado en Escandinavia, el menor de los tres hermanos reúne a su alrededor fuerzas vikingas, con el fin de vengar a Oleg y ocupar el trono de su padre. Después de su travesía, el nuevo monarca se despide de las sanguinarias tradiciones paganas, llevando el cristianismo a la antigua Rus y convirtiéndose en San Vladímir el Grande.' ),
	( null,'La Maldición de la Casa Winchester (+14)','2018/02/08','Peter Spierig','14',2,1,'100','npU31mqbviA','Helen Mirren, Jason Clarke','Basada en la historia real de Sarah Winchester (Helen Mirren), una millonaria viuda convencida de tener una maldición. Después de la repentina muerte de su marido y su hijo, cree que las almas de todas las personas que murieron por culpa del famoso rifle creado por su familia se dedican a perseguirla. Para intentar despistar a los espíritus en pena, construyó una mansión de casi 200 habitaciones con escaleras que no daban a ninguna parte y puertas que al abrirse descubrían un muro… todo con la intención de esquivar a los seres del otro mundo.' ),
	( null,'Cincuenta Sombras Liberadas (+18) (HD - Doblada)','2018/02/08','James Foley','7',3,1,'120','B1Qdbbo0Tlw','Dakota Johnson, Jamie Dornan, Eric Johnson, Rita Ora, Marcia Gay Harden','Jamie Dornan y Dakota Johnson regresan como Christian Grey y Anastasia Steele en Cincuenta Sombras Liberadas, el tercer capítulo basado en el fenómeno "Cincuenta sombras", best seller a nivel mundial. Ampliando los eventos que se desencadenaron en las películas taquilleras del 2015 y 2017, que recaudaron casi $ 950 millones en todo el mundo, llega la nueva entrega para el Día de los Enamorados' ),
	( null,'Locos de Amor 2 (+14)','2018/02/14','Frank Pérez Garland','6,11',2,1,'110','v3fspveODBI','Johanna San Miguel, Marco Zunino, Vanessa Saba, Bruno Ascenzo, Carlos Alcántara, Érika Villalobos','¡Vuelve la comedia musical del año! Un hombre descorazonado que empieza a salir con una conductora que da consejos de amor en la radio. Una mujer desesperada por ser mamá y un padre soltero en sus cincuentas que solo piensa en ella. Una mujer madura que llega de Miami buscando nuevas experiencias. Una mujer divorciada que solo quiere divertirse y el hombre que no la ha olvidado desde que tenía 23 años. El resultado, una divertida comedia romántica donde los personajes descubren que nunca es tarde para volvernos Locos de Amor.' ),
	( null,'El Despertar de los Muertos Vivientes (+14) (HD - Doblada)','2018/02/15','Héctor Hernández Vicens','14',2,1,'100','xAq_0OIirnE','Jeff Gum, Johnathon Schaech, Marcus Vanco, Sophie Skelton','Un pequeño grupo de servicio militar sufre una gran tragedia, todos los sobrevivientes logran convivir en un búnker subterráneo, pero no se esperan que esto tendría que ser por mucho tiempo. Todos los refugiados buscarán desesperadamente encontrar una cura, ya que todo se ha convertido en un mundo invadido por zombis, el problema será cuando ya no puedan mantenerse a salvo y el tiempo vaya contra su favor. Una película que demuestra que el miedo no se puede controlar.' ),
	( null,'15:17 Tren a París (+14) (HD - Doblada)','2018/02/15','Clint Eastwood','7,10',2,1,'100','bHn-yCw0-VU','Spencer Stone, Anthony Sadler, Alek Skarlatos, Judy Greer, Jenna Fischer, Ray Corasani, Tony Hale, Thomas Lennon, Sinqua Walls','El 21 de agosto de 2015, Ayoub El-Khazzani subió al tren 9364 en Bruselas rumbo a París. No había dudas de sus intenciones: tenía una AK-47, una pistola y suficientes balas para dominar a los pasajeros a bordo. Un nuevo ataque de ISIS estaba por comenzar. Lo que no esperaba encontrar Khazzani en su misión eran tres amigos estadounidenses, Anthony Sadler, Alek Skarlatos y Spencer Stone que estaban dispuestos a deternerlo. Basada en una historia real.' ),
	( null,'Pantera Negra','2018/02/22','Ryan Coogler','3,1',2,1,'150','JcIye2DaZwI','Chadwick Boseman, Michael B. Jordan, Lupita Nyong o, Martin Freeman, Daniel Kaluuya, Forest Whitaker','Tras los acontecimientos ocurridos en CAPITÁN AMÉRICA: CIVIL WAR, T’Challa regresa a Wakanda, su solitaria nación africana de tecnología avanzada, para asumir como rey. Sin embargo, cuando un antiguo enemigo reaparece, el temple y la fortaleza de T’Challa como rey y superhéroe son puestos a prueba al desatarse un conflicto que pone en peligro el destino de Wakanda y del mundo entero.' ),
	( null,'La forma del Agua','2018/02/22','Guillermo del Toro','7,12',2,1,'120','K8xMDEXzX-0','Sally Hawkins, Octavia Spencer, Michael Shannon, Richard Jenkins, Doug Jones','Del maestro de la narrativa Guillermo del Toro, viene LA FORMA DEL AGUA —un cuento de hadas místico, que de fondo tiene la época de la Guerra Fría en los Estados Unidos, cerca de 1962. En el laboratorio secreto de alta seguridad del gobierno donde trabaja, la solitaria Elisa (Sally Hawkins) está atrapada en una vida de retraimiento. La vida de Elisa cambia para siempre cuando ella y su compañera de trabajo, Zelda (Octavia Spencer), descubren un experimento confidencial.' ),
	( null,'El cavernícola','2018/02/22','Nick Park','3,2',1,1,'90','VDvsFizDL9Y','','En el film, Dug, humano y Hognob, jabalí, son los héroes de una aventura en la que dos civilizaciones, la de la Edad de Piedra y la de Bronce, compiten por hacerse hueco en la historia, mientras que, por casualidad, inventan el fútbol. Dug y Hognob tendrán que ayudar a su tribu, sorteando con gracia y astucia múltiples peligros, y derrotando al malvado Lord Nooth para no perder su hogar.' ),
	( null,'Leatherface: La Máscara del Terror','2018/03/01','Alexandre Bustillo, Julien Maury','14,15',2,1,'120','ezk5eepqL_c','Sam Strike, James Bloor, Lili Taylor, Nicole Andrews, Stephen Dorff, Finn Jones, Jessica Madsen, Vanessa Grasse, Simona Williams, Julian Kostov','Precuela de la saga "La Matanza de Texas", centrada en los años de adolescencia de Leatherface, su protagonista. El joven Leatherface escapa de un hospital psiquiátrico con otros tres reclusos y secuestra a una enfermera a la que llevará a un viaje por carretera de pesadilla.' ),
    ( null,'Operación Red Sparrow','2018/03/01','Francis Lawrence','13,15',2,1,'120','LL1_H6ePE1o','Jennifer Lawrence, Charlotte Rampling, Jeremy Irons, Joel Edgerton','Dominika Egorova (Jennifer Lawrence) es reclutada contra su voluntad para convertirse en “gorrión”, una mujer seductora entrenada por el servicio de seguridad ruso. Dominika aprende a utilizar su cuerpo como arma, pero lucha por mantener su sentido de identidad durante el deshumanizador proceso de entrenamiento. Al encontrar su poder en un sistema injusto, Dominika emerge como una de las herramientas más eficaces del programa. Su primer objetivo es Nate Nash (Joel Edgerton), un agente de la CIA que, por su lado, está encargado de infiltrarse en los altos mandos de la inteligencia rusa. Los dos agentes jóvenes caen en un espiral de atracción y decepción, que amenaza sus carreras, lealtades y la seguridad de ambos países.' ),
    ( null,'Una Jungla de Locura','2018/03/01','David Alaux','3,2',1,1,'100','CWhbu8m5-h4','','Maurice es un pingüino… ¡Pero hay un tigre dentro de él! Y es que, este pingüino fue criado por una tigresa, así que se ha convertido en un profesional del kung-fu. Acompañado por sus amigos, un gorila, un lemur, un pez, dos sapos y una murciélaga, Maurice tratará de hacer reinar el orden y la justicia en la jungla. Claro que el diabólico koala Igor, acompañado por sus secuaces babuinos tiene la intención de destruir la jungla… Será entonces cuando la panda de la selva acudirá al rescate.' ),
	( null,'A tu lado','2018/03/01','Martín Casapía','6,12',2,1,'100','eAFo1okmA4s','Andrés Vílchez, Leslie Shaw, Alessandra Fuller, Joaquín Escobar, Guillermo Castañeda','Sumida en la tristeza, Paz decide aceptar la invitación de su tío Martín y escapar de Lima para pasar unas vacaciones en un exclusivo Resort de Punta Cana. Ahí es donde conoce a Edu, el salvavidas del resort, y a todos sus amigos, con los que compartirá un frenético pero divertido viaje en la paradisíaca República Dominicana.' ),

	( null,'Titanes del Pacífico: La Insurrección','2018/03/22','Steven S. DeKnight','3,1,5',2,2,'90','9GokIVXlVVw','Scott Eastwood, John Boyega , Adria Arjona, Charlie Day, Tian Jing','Debido a la amenaza de invasión de terribles criaturas del océano, el programa Jeager, responsable por la creación de robots gigantes, vuelve a reactivarse. Deberán perfeccionar la construcción de robotos y evitar que estos malévolos seres acuáticos logren tomar control de la Tierra, como casi ocurrió hace años.' ),
	( null,'Mazinger Z: Infinity','2018/04/05','Junji Shimizu','2',2,2,'','MYMXZ7Oba3Y','','Cuando el malvado Doctor Hell ataca la Tierra, el poderoso robot gigante Mazinger Z se decide a detenerlo.' ),
	( null,'Rascacielo: Rescate en las Alturas','2018/07/19','Rawson Marshall Thurber','1',2,2,'','TFWRIO0a4Qs','Dwayne Johnson, Neve Campbell, Pablo Schreiber, Byron Mann, Hannah Quinlivan, Noah Taylor, Roland Moller y Chin Han','La estrella mundial Dwayne Johnson lidera el elenco de esta producción de Legendary Entertainment; Rascacielos, como el ex líder del equipo de rescate de rehenes del FBI y veterano de guerra, Will Ford, quien ahora evalúa la seguridad para diversos rascacielos. En una misión en China, él encuentra al edificio más alto y seguro del mundo completamente en llamas, por lo cual ha sido incriminado. Huyendo de quienes lo buscan, Will debe encontrar a los responsables, limpiar su nombre y de algún modo rescatar a su familia que se encuentra atrapada dentro del edificio…por encima de la línea de fuego.' );

insert Cine values 
	( null, 'Cinestar Excelsior',8,4,'Jr. De la Unión 780','714-1865' ),
	( null, 'Cinestar Sur',8,8,'Av Los Héroes 240','710-9439' ),
	( null, 'Cinestar Metro San Juan',7,7,'Av. Los Proceres de la Independencia 1632','719-1064' ),
	( null, 'Cinestar Metro UNI',10,5,'Av. Gerardo Unger s/n cuadra 16','719-5142' ),
	( null, 'Cinestar Metro Comas',6,2,'Av. Tupac Amaru cdra 39 sn - La Pascana',' 715-2602' ),
	( null, 'Cinestar Las Américas',7,3,'Av. Hermilio Valdizán 121 (altura de la cuadra 18 de la Av. Brasil)','714-1718' ),
	( null, 'Cinestar Aviación',5,6,'Calle Tiziano 100 Alt. Cuadra 24 de la Av. Aviación','715-8598' ),
	( null, 'Cinestar Benavides',6,9,'Av. Benavides 4981','7141288' ),
	( null, 'Cinestar Metro Breña',8,1,'Jr. Iquique Nº 315 - Breña Av. Alfonso Ugarte y Venezuela','719-2445' );

insert CinePelicula values
	( 1,  8, 1, '13:30 / 21:30' ),
	( 1,  9, 1, '17:30 / 22:00' ),
	( 1, 11, 1, '13:30 / 16:00 / 18:45 / 19:15 / 21:20' ),
	( 1, 13, 1, '13:30 / 15:15' ),
	( 1, 17, 1, '13:15 / 15:15 / 17:15 / 19:15 / 21:15' ),
	( 1, 16, 1, '13:00 / 15:00 / 17:00 / 19:00 / 21:00' ),
	
	( 2,  8, 1, '16:00' ),
	( 2,  9, 1, '18:00 / 22:15' ),
	( 2, 11, 1, '15:30 / 16:30 / 18:00 / 19:15 / 20:00 / 20:30 / 21:45' ),
	( 2, 13, 1, '15:45' ),
	( 2, 16, 1, '15:15 / 17:15 / 19:15 / 21:15' ),
	( 2, 17, 1, '16:00 / 18:00 / 20:00 / 22:00' ),

	( 3,  8, 1, '15:20 / 17:20 / 19:30 / 21:40' ),
    ( 3, 11, 1, '15:45 / 16:45 / 18:15 / 19:15 / 20:45 / 21:45' ),
	( 3, 16, 1, '15:30 / 17:20 / 19:10 / 21:00' ),
	( 3, 17, 1, '16:00 / 17:50 / 19:40 / 21:30' ),

	( 4,  8, 1, '15:45 / 17:45 / 19:45' ),
	( 4,  9, 1, '21:30' ),
	( 4, 11, 4, '15:30 / 16:30 / 18:15 / 19:15 / 21:00 / 21:50' ),
	( 4, 13, 1, '14:45' ),
	( 4, 16, 1, '15:15 / 17:15 / 19:15 / 21:15' ),
	( 4, 17, 1, '16:00 / 18:00 / 20:00 / 22:00' ),
	
	( 5, 11, 1, '16:45 / 19:15 / 21:45' ),
	( 5, 16, 1, '15:15 / 17:15 / 19:15 / 21:15' ),
	( 5, 17, 1, '15:30 / 17:30 / 19:30 / 21:30' ),

	( 6,  8, 1, '18:00 / 22:15' ),
	( 6, 11, 1, '15:30 / 16:30 / 18:00 / 19:15 / 20:45 / 22:00' ),
	( 6, 15, 1, '16:15 / 19:00 / 21:45' ),
	( 6, 16, 1, '15:15 / 17:15 / 19:15 / 21:15' ),
	( 6, 17, 1, '16:00 / 18:00 / 20:00 / 22:00' ),

	( 7, 11, 1, '16:15 / 19:00 / 21:35' ),
	( 7, 16, 1, '15:45 / 17:45' ),
	( 7, 17, 1, '19:45 / 21:45'),

	( 8, 11, 1, '16:45 / 19:20 / 22:00' ),
	( 8, 16, 1, '15:15 / 17:00 / 18:45' ),
	( 8, 17, 1, '15:45 / 17:45 / 19:45 / 21:45' ),
	
	( 9,  8, 1, '15:10 / 17:20 ' ),
	( 9, 11, 1, '15:30 / 16:30 / 18:15 / 19:15 / 21:00 / 22:00' ),
	( 9, 15, 1, '17:00 / 19:40 / 22:20' ),
	( 9, 16, 1, '15:15 / 17:15 / 19:15 / 21:15' ),
	( 9, 17, 1, '16:00 / 18:00 / 20:00 / 22:00' );

insert CineTarifa values
	( 1, 'Lunes y Miércoles', 5.00 ),
	( 1, 'Martes', 4.50 ),
	( 1, 'Jueves y Viernes', 7.00 ),
	( 1, 'Sábado, Domingo y Feriados', 8.00 ),
	( 1, 'Adulto mayor y niños de 2 hasta 8 años (Jueves a Domingos)', 6.00 ),
	( 1, '3D - Lunes y Miércoles', 7.50 ),
	( 1, '3D - Martes', 6.00 ),
	( 1, '3D - Jueves a Domingos', 11.00 ),
	
	( 2, 'Lunes, Martes y Miércoles', 5.00 ),
	( 2, 'Jueves y Viernes', 7.00 ),
	( 2, 'Sábado y Domingo', 9.00 ),
	( 2, 'Feriados', 10.00 ),
	( 2, 'Adulto mayor y niños de 2 hasta 8 años (Jueves a Domingos)', 6.00 ),
	( 2, '3D - Lunes, Martes y Miércoles', 10.00 ),
	( 2, '3D - Jueves a Domingo', 12.00 ),
	( 2, 'Adulto mayor y niños de 2 hasta 8 años (Sábados y Domingos)', 10.00 ),
	
	( 3, 'Lunes, Martes y Miércoles', 7.50 ),
	( 3, 'Jueves y Viernes', 12.00 ),
	( 3, 'Sábados, Domingos y Feriados', 15.00 ),
	( 3, 'Adulto mayor y niños de 2 hasta 8 años (Jueves a Domingos)', 8.00 ),
	( 3, '3D - Lunes y Miércoles', 14.00 ),
	( 3, '3D - Martes', 13.50 ),
	( 3, '3D - Jueves a Domingos', 17.00 ),
	( 3, 'Adulto mayor y niños de 2 hasta 8 años (Sábados y Domingos)', 14.50 ),

	( 4, 'Lunes y Miércoles', 5.00 ),
	( 4, 'Martes', 4.50 ),
	( 4, 'Jueves y Viernes', 7.50 ),
	( 4, 'Sábado, Domingo y Feriados', 10.50 ),
	( 4, 'Adulto mayor y niños de 2 hasta 8 años (Jueves a Domingos)', 7.00 ),
	( 4, '3D - Lunes a Miércoles', 10.50 ),
	( 4, '3D - Jueves a Domingo', 15.50 ),
	( 4, 'Adulto mayor y niños de 2 hasta 8 años (Sábados y Domingos)', 12.50 ),

	( 5, 'Lunes, Martes y Miércoles', 5.00 ),
	( 5, 'Jueves a Domingos y Feriados', 8.00 ),
	( 5, 'Adulto mayor y niños de 2 hasta 8 años (Jueves a Domingos)', 6.50 ),
	( 5, '3D - Lunes, Martes y Miércoles', 10.50 ),
	( 5, '3D - Jueves a Domingo y Feriados', 15.50 ),
	( 5, 'Adulto mayor y niños de 2 hasta 8 años (Sábados y Domingos)', 12.50 ),

	( 6, 'Lunes y Miércoles', 6.50),
	( 6, 'Martes', 6.00 ),
	( 6, 'Jueves y Viernes', 8.50 ),
	( 6, 'Sábado y Domingo', 11.00 ),
	( 6, 'Feriados', 11.50 ),
	( 6, 'Adulto mayor y niños de 2 hasta 8 años (Jueves a Domingos)', 7.00 ),

	( 7, 'Lunes, Martes y Miércoles', 5.50),
	( 7, 'Jueves y Viernes', 8.50),
	( 7, 'Sábado, Domingo y Feriados', 10.50),
	( 7, 'Adulto mayor y niños de 2 hasta 8 años (Jueves a Domingos)', 8.00 ),
	( 7, '3D - Lunes, Martes y Miércoles', 10.50),
	( 7, '3D - Jueves a Domingo', 15.50),
	( 7, 'Adulto mayor y niños de 2 hasta 8 años (Sábados y Domingos)', 12.50 ),

	( 8, 'Lunes, Martes y Miércoles', 7.50),
	( 8, 'Jueves y Viernes', 9.00),
	( 8, 'Sábado y Domingo', 10.00),
	( 8, 'Feriados', 10.50),
	( 8, 'Adulto mayor y niños de 2 hasta 8 años (Jueves a Domingos)', 7.50 ),
	( 8, '3D - Lunes, Martes y Miércoles', 10.50),
	( 8, '3D - Jueves a Domingo', 15.50),
	( 8, 'Adulto mayor y niños de 2 hasta 8 años (Sábados y Domingos)', 12.50 ),

	( 9, 'Lunes y Miércoles', 6.50),
	( 9, 'Martes', 5.50),
	( 9, 'Jueves y Viernes', 10.50),
	( 9, 'Sábados, Domingos y Feriados', 13.00),
	( 9, 'Adulto mayor y niños de 2 hasta 8 años (Jueves a Domingos)', 8.50 ),
	( 9, '3D - Lunes, Martes y Miércoles', 11.50),
	( 9, '3D - Jueves a Domingo', 16.50),
	( 9, 'Adulto mayor y niños de 2 hasta 8 años (Sábados y Domingos)', 13.50 );

/* ----- Vistas ----------------------------------------------------------------------------------------------- */

create view vGenero as select * from Genero;
create view vDistrito as select * from Distrito;
create view vCines as select C.*, D.Detalle from Cine C, Distrito D where D.id = C.idDistrito;
create view vCineTarifas as select idCine, DiasSemana, CONCAT('S/. ', Precio) 'Precio' from CineTarifa;
create view vCinePeliculas as select idCine, P.Titulo, CP.Horarios from CinePelicula CP, Pelicula P where CP.idPelicula = P.id;

/* ----- Procedimiento Alamcenados ---------------------------------------------------------------------------- */

create procedure sp_getCines()
   select C.*, D.Detalle from Cine C, Distrito D where D.id = C.idDistrito;

create procedure sp_getCine( in _id int )
  select C.*, D.Detalle  from Cine C, Distrito D where C.id = _id and D.id = C.idDistrito;

create procedure sp_getCineTarifas( in _id int )
  select DiasSemana, CONCAT('S/. ', Precio) 'Precio' from CineTarifa where idCine = _id;

create procedure sp_getCinePeliculas( in _idCine int )
  select P.Titulo, CP.Horarios from CinePelicula CP, Pelicula P where CP.idCine = _idCine and CP.idPelicula = P.id;

create procedure sp_getPeliculas( in _idEstado int )
  select id,Titulo,Sinopsis,Link from Pelicula where idEstado = _idEstado;

create procedure sp_getPelicula( in _id int )
  select *, getGenerosDetalle(Generos) 'Geneross', DateLong(FechaEstreno) 'FechaEstrenoss' from Pelicula where id = _id;

/* ----- Funciones -------------------------------------------------------------------------------------------- */

delimiter //
create function getGenerosDetalle( _Generos char(10) ) returns char(50)
	READS SQL DATA
	begin
		declare v_idGenero char(5);
		declare v_Generos char(50);

		SET v_Generos ='';
		while ( locate(',', _Generos) > 0 ) do
			set v_idGenero = SUBSTR( _Generos, 1, locate( ',', _Generos )- 1 );
			set _Generos = SUBSTR( _Generos, locate( ',', _Generos ) + 1, LENGTH( _Generos ) );
			set v_Generos = CONCAT( RTRIM( v_Generos ), ( select RTRIM(Detalle) from Genero where id = v_idGenero), ',' );
		end while;
		return CONCAT( RTRIM(v_Generos), ( select RTRIM(Detalle) from Genero where id = _Generos) );
	end;
//

delimiter //
create function DateLong( _fecha DATE ) RETURNS varchar(40)
	begin
		set @@lc_time_names = 'es_PE';
		return CONCAT( dayname( _fecha ), ' ', day( _fecha ), ' de ', upper(left(monthname( _fecha ),1)), substring(monthname( _fecha ),2), ' del ', year( _fecha ) );
	end;
 //

/*
delimiter //
create procedure sp_GuardarCliente( in _nombres char(50), in _correo char(50), in _passwordd char(30) )
  begin
    select @id := id, @count := count(*) from Cliente where Correo = _correo;
	if ( @count = 0 ) then
		insert Cliente values ( null, _nombres, _correo, _passwordd );
	  else
        update Cliente set Passwordd = _passwordd where id = @id;
    end if;
  end;
//
*/

/*
use CineStar
call sp_getCines()
call sp_getCine(3)
call sp_getCineTarifas(1)
call sp_getCinePeliculas(1)
call sp_getPeliculas(1)
call sp_getPelicula(1)

select getGenerosDetalle('6,3,1')
select DateLong('2023-05-09')
select * from vCines
select * from vCines where id=3
*/