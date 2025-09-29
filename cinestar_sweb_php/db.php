<?php 
	header( "Content-Type:text/html;charset=utf-8" );
	header( "Access-Control-Allow-Origin:*" );

	function BaseDatos( $ip, $user, $password, $bd ) {
	
		global $_IP, $_USER, $_PASSWORD, $_BD;
		$_IP = $ip;
		$_USER = $user;
		$_PASSWORD = $password;
		$_BD = $bd;
	}

	function getConexion() {
		global $cn;
		global $_IP, $_USER, $_PASSWORD, $_BD;
		$cn = new mysqli( $_IP, $_USER, $_PASSWORD, $_BD );
		$cn->set_charset('utf8');

		if ( $cn->connect_errno) {
    		printf("Connect failed: %s\n", $cn->connect_error);
    		exit();
		}
	}

	function ejecutarSQL() {
		getConexion();
		global $cn;
		global $_SQL;

		return mysqli_query( $cn, $_SQL );
	}

	function getRegistros() {
		getConexion();
		global $cn;
		global $_SQL;
		
		if ( $rs = mysqli_query( $cn, $_SQL ) ) {
			if ( $rs ->num_rows == 1 )
				$data = $rs->fetch_assoc();
			else {
				$data = array();
				while ( $row = $rs->fetch_assoc() )
					$data[] = $row;
			}			
		}

		return $data;
	}

?>