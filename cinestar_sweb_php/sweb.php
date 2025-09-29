<?php

  include('db.php');
  BaseDatos('localhost','root','','cinestar');
 
  $parametros = $_SERVER['REQUEST_URI'];
  $parametros = str_replace("%20", " ", $parametros);
  $parametros = explode("/",$parametros);
  $parametros = array_slice($parametros,2);

  if ( isset( $parametros[0] ) )
    if ( $parametros[0] == "formatos" ) getFormatos();
    else if ( $parametros[0] == 'ciudades' ) getCiudades();
    else if ( $parametros[0] == 'cines' ) getCines();
    else if ( $parametros[0] == 'peliculas' ) getPeliculas();
    else if ( $parametros[0] == 'cinepeliculas' ) getCinePeliculass();
    else if ( $parametros[0] == 'usuarios' ) getUsuarios();
    else if ( $parametros[0] == 'socios' ) getSocios();
  
  function getFormatos() {
    global $_SQL;
    $_SQL = "call sp_getFormatos()";

    $data = getRegistros();
		$success = count( $data ) > 0 ? true : false;
		$message = $success ? "Registros encontrados" : "Registros no encontrados";

    echo getJSON($success, $data, $message);
  }

  function getCiudades() {
    global $_SQL;
    $_SQL = "call sp_getCiudades()";

    $data = getRegistros();
		$success = count( $data ) > 0 ? true : false;
		$message = $success ? "Registros encontrados" : "Registros no encontrados";

    echo getJSON($success, $data, $message);
  }

  function getCines () {
    global $parametros;
    global $_SQL;

    if ( isset( $parametros[2] ) )
      $_SQL = $parametros[2] == "peliculas" ? "call sp_getCinePeliculas('$parametros[1]')" : "call sp_getCineTarifas('$parametros[1]')";
    else { 
        if ( isset( $parametros[1] ) ) {
            $_SQL = "call sp_getCinePeliculas('$parametros[1]')";
            $peliculas = getRegistros();
            
            $_SQL = "call sp_getCineTarifas('$parametros[1]')";
            $tarifas = getRegistros();
        }
        $_SQL = isset( $parametros[1] ) ? "call sp_getCine('$parametros[1]')" : "call sp_getCines()";
    }

    $data = getRegistros();
	$success = count( $data ) > 0 ? true : false;
	$message = $success ? "Registros encontrados" : "Registros no encontrados";

    if ( isset( $peliculas ) ) {
        $data['peliculas'] = $peliculas;
        $data['tarifas'] = $tarifas;
    }
    
	echo getJSON($success, $data, $message);
  }
    
  function getPeliculas () {
    global $parametros;  
    global $_SQL;

    if ( isset( $parametros[1] ) ) 
      if ( is_numeric( $parametros[1] ) ) $_SQL = "call sp_getPelicula('$parametros[1]')";
      else {
        $parametros[1] = $parametros[1] == "cartelera" ? 1 : ( $parametros[1] == "estrenos" ? 2 : 3 );
        $_SQL = "call sp_getPeliculas('$parametros[1]')";
    } else $_SQL = "call sp_getPeliculass()";

    $data = getRegistros();
		$success = count( $data ) > 0 ? true : false;
		$message = $success ? "Registros encontrados" : "Registros no encontrados";

		echo getJSON($success, $data, $message);
  }
  
  function getCinePeliculass() {
    global $_SQL;
    $_SQL = "call sp_getCinePeliculass()";

    $data = getRegistros();
		$success = count( $data ) > 0 ? true : false;
		$message = $success ? "Registros encontrados" : "Registros no encontrados";

    echo getJSON($success, $data, $message);
  }
  
  function getUsuarios() {
    global $parametros;
    
    if ( isset( $parametros[1] ) ) {
      if ( $parametros[1] == "guardar" ) echo getUsuarioGuardar();
      else if ( $parametros[1] == "login" ) echo getUsuarioLogin();
      else if ( $parametros[1] == "correo" ) echo getUsuarioCorreo();
      else if ( $parametros[1] == "passwordd" ) echo setUsuarioPasswordd();
      else if ( $parametros[1] == "usuarios" ) echo getUsuariosList();
    }
  }
  
  function getUsuariosList() {
      global $_SQL;
      
      $_SQL = "call sp_getUsuarios()";
      $data = getRegistros();
	  $success = count( $data ) > 0 ? true : false;
	  $message = $success ? "Lista de usuarios" : "No hay usuarios registrados";

	  return getJSON($success, $data, $message);
  }

  function getUsuarioGuardar() {
    global $_SQL;

    $nombres = $_POST['nombres'];
    $apellidos = $_POST['apellidos'];
    $dni = $_POST['dni'];
    $passwordd = $_POST['passwordd'];
    $telefono = $_POST['telefono'];
    $correo = $_POST['correo'];

    if ( isset( $nombres ) && isset( $apellidos ) && 
         isset( $dni ) && isset( $passwordd ) && 
         isset( $telefono ) && isset( $correo )  )  {
      $_SQL = sprintf("call sp_Usuario_Guardar( '%s','%s','%s','%s','%s','%s')", $nombres, $apellidos, $dni, $passwordd, $telefono, $correo );

      $data = ejecutarSQL();
		  $success = $data > 0 ? true : false;
		  $message = $success ? "Usuario registrado" : "Usuario no pudo registrarse";

      if ( $success ) {
        $_SQL = "call sp_getUsuario('$dni','$passwordd')";
        $data = getRegistros();
      }

	  return getJSON($success, $data, $message);
    } else return getJSON(false, null, "Parámetros inválidos");
  }

  function getUsuarioLogin() {
    global $_SQL;

    $dni = $_POST['dni'];
    $passwordd = $_POST['passwordd'];
    
    if ( isset($dni) && isset($passwordd) ) {
        if ( empty($dni) || empty($passwordd) || strlen($dni) != 8 )
            return getJSON(false, null, "Parámetros inválidos");
            
      $_SQL = sprintf("call sp_getUsuario('%s','%s')", $dni, $passwordd );

      $data = getRegistros();
		  $success = count( $data ) > 0 ? true : false;
		  $message = $success ? "Usuario encontrado" : "Dni y/o password inválidos";

		  return getJSON($success, $data, $message);
    } else return getJSON(false, null, "Parámetros inválidos");
  }

  function getUsuarioCorreo() {
    global $_SQL;

    $correo = $_POST['correo'];
    if ( isset( $correo ) ) {
        if ( empty($correo) ) return getJSON(false, null, "Correo inválidos");
      
      $_SQL = "call sp_getUsuario_Correo('$correo')";

      $data = getRegistros();
		  $success = count( $data ) > 0 ? true : false;
		  $message = $success ? "Usuario encontrado" : "Correo inválido";

		  return getJSON($success, $data, $message);
    } else return getJSON(false, null, "Parámetros inválidos");
  }

  function setUsuarioPasswordd() {
    global $_SQL;

    $correo = $usuario['correo'];
    $passwordd = $usuario['passwordd']; 
    if ( isset( $correo ) && isset( $passwordd ) ) {
      $_SQL = "call sp_setUsuario_Passwordd('$correo','$passwordd')";

      $data = ejecutarSQL();
		  $success = $data > 0 ? true : false;
		  $message = $success ? "Password actualizado" : "Correo inválido";

		  return getJSON($success, $data, $message);
    } else return getJSON(false, null, "Parámetros inválidos");
  }

  function getSocios() {
    global $parametros;
    
    if ( isset( $parametros[1] ) ) {
      if ( $parametros[1] == "guardar" ) echo getSocioGuardar();
      else if ( $parametros[1] == "login" ) echo getSocioLogin();
      else if ( $parametros[1] == "correo" ) echo getSocioCorreo();
      else if ( $parametros[1] == "passwordd" ) echo setSocioPasswordd();
    }
  }

  function getSocioLogin() {
    global $_SQL;

    $dni = $_POST['dni'];
    $passwordd = $_POST['passwordd'];
    
    if ( isset($dni) && isset($passwordd) ) {
        if ( empty($dni) || empty($passwordd) || strlen($dni) != 8 )
            return getJSON(false, null, "Parámetros inválidos");
            
      $_SQL = sprintf("call sp_getSocio('%s','%s')", $dni, $passwordd );

      $data = getRegistros();
      $success = count( $data ) > 0 ? true : false;
	  $message = $success ? "Usuario encontrado" : "Dni y/o password inválidos";

	  return getJSON($success, $data, $message);
    } else return getJSON(false, null, "Parámetros inválidos");
  }
  
  function getSocioGuardar() { return getJSON(false, null, "Parámetros inválidos"); }
  function getSocioCorreo() { return getJSON(false, null, "Parámetros inválidos"); }
  function getSocioPasswordd() { return getJSON(false, null, "Parámetros inválidos"); }
 
  
  function getJSON( $success, $data, $message ) {
    $json = array("success" => $success, "data" => $success ? $data : null, "message" => $message );

		return json_encode( $json, JSON_UNESCAPED_UNICODE );
  }
  
  //$usuario = json_decode( file_get_contents("php://input"), true );
?>