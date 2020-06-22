<!DOCTYPE html>
<html lang="{{ app()->getLocale() }}">
<html>
<head>
<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">

    <!-- CSRF Token -->
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <title>@yield('title') - {{ config('app.name', 'POS') }}</title> 

<!--===============================================================================================-->	
	<link rel="icon" type="image/png" href="{{ asset('Login_v1/images/icons/favicon.ico') }}"/>
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="{{ asset('Login_v1/vendor/bootstrap/css/bootstrap.min.css') }}">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="{{ asset('Login_v1/fonts/font-awesome-4.7.0/css/font-awesome.min.css') }}">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="{{ asset('Login_v1/vendor/animate/animate.css') }}">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="{{ asset('Login_v1/vendor/css-hamburgers/hamburgers.min.css') }}">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="{{ asset('Login_v1/vendor/select2/select2.min.css') }}">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="{{ asset('Login_v1/css/util.css') }}">
    <link rel="stylesheet" type="text/css" href="{{ asset('Login_v1/css/main.css') }}">

<!--===============================================================================================-->
</head>
<body>
@inject('request', 'Illuminate\Http\Request')
    @if (session('status'))
        <input type="hidden" id="status_span" data-status="{{ session('status.success') }}" data-msg="{{ session('status.msg') }}">
    @endif
	<div class="limiter">
		<div class="container-login100">
			<div class="wrap-login100">
				<div class="login100-pic js-tilt" data-tilt>
					<img src="{{ asset('Login_v1/images/img-01.png')}}" alt="IMG">
				</div>
                <form class="login100-form validate-form" method="POST" action="{{ route('login') }}">
                {{ csrf_field() }}
            <div class="form-group has-feedback {{ $errors->has('username') ? ' has-error' : '' }}">
                @php
                    $username = old('username');
                    $password = null;
                    if(config('app.env') == 'demo'){
                        $username = 'admin';
                        $password = '123456';

                        $demo_types = array(
                            'all_in_one' => 'admin',
                            'super_market' => 'admin',
                            'pharmacy' => 'admin-pharmacy',
                            'electronics' => 'admin-electronics',
                            'services' => 'admin-services',
                            'restaurant' => 'admin-restaurant',
                            'superadmin' => 'superadmin',
                            'woocommerce' => 'woocommerce_user',
                            'essentials' => 'admin-essentials',
                            'manufacturing' => 'manufacturer-demo',
                        );

                        if( !empty($_GET['demo_type']) && array_key_exists($_GET['demo_type'], $demo_types) ){
                            $username = $demo_types[$_GET['demo_type']];
                        }
                    }
                @endphp
					<span class="login100-form-title">
				<img src="{{ asset('Login_v1/images/logo_spoint.jpg')}}" alt="Login">
				<span style="font-size:18px; margin-top:10px;">Sistema de Gestión para Negocios</span>					

								</span>
					<div class="wrap-input100 validate-input" data-validate = "Valid email is required: ex@abc.xyz">
						<input class="input100" type="text" name="username" id="username" value="{{ $username }}" required autofocus placeholder="@lang('lang_v1.username')">
             
                        <span class="focus-input100"></span>
						<span class="symbol-input100">
							<i class="fa fa-user" aria-hidden="true"></i>
                        </span>
                    
					</div>

					<div class="wrap-input100 validate-input" data-validate = "Password is required">
						<input class="input100" type="password" name="password" value="{{ $password }}" required placeholder="@lang('lang_v1.password')">
                   
                        <span class="focus-input100"></span>
						<span class="symbol-input100">
							<i class="fa fa-lock" aria-hidden="true"></i>
                        </span>
                   
					</div>
					
					<div class="container-login100-form-btn">
						<button class="login100-form-btn">
							Login
						</button>
                    </div>
                    <div class="text-center p-t-12">
                    @if ($errors->has('username'))

						
						<a class="txt2" href="#">
                        {{ $errors->first('username') }}                        </a>
                        @endif

					</div>

                   
					<div class="text-center p-t-12">
                    @if ($errors->has('password'))

						
						<a class="txt2" href="#">
                        {{ $errors->first('password') }}
                    
                    </a>
                    @endif

					</div>
                    <div class="text-center p-t-12">
						<span class="txt1">
							
						</span>
						<a class="txt2" href="#">
					</div>

					<div class="text-center p-t-136">
						<a class="txt2" href="#">
							
						</a>
					</div>
				

                 
                
				</form>
				
			</div>
		</div>
	</div>
	
	

	
<!--===============================================================================================-->	
	<script src="{{ asset('Login_v1/vendor/jquery/jquery-3.2.1.min.js')}}"></script>
<!--===============================================================================================-->
	<script src="{{ asset('Login_v1/vendor/bootstrap/js/popper.js')}}"></script>
	<script src="{{ asset('Login_v1/vendor/bootstrap/js/bootstrap.min.js')}}"></script>
<!--===============================================================================================-->
	<script src="{{ asset('Login_v1/vendor/select2/select2.min.js')}}"></script>
<!--===============================================================================================-->
	<script src="{{ asset('Login_v1/vendor/tilt/tilt.jquery.min.js')}}"></script>
	<script >
		$('.js-tilt').tilt({
			scale: 1.1
		})
	</script>
<!--===============================================================================================-->
	<script src="{{ asset('Login_v1/js/main.js')}}"></script>

</body>
</html>