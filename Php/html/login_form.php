
<!-- The above form looks like this -->
<form id="form1">

    <div class="row">
        <div class="four columns">
            <label for="username">Usuário</label>
            <input class="u-full-width" type="text" placeholder="" name="username" value="">
        </div>
    </div>

    <div class="row">
        <div class="four columns">
            <label for="password">Senha</label>
            <input class="u-full-width" type="text" placeholder="" name="password">
        </div>    
    </div>

    <input type="button" onClick="JavaScript:callapi('api/login.php', form1, 'msg');" value="Entrar">

    <br>
    <br>
    <div id="msg">resultado</div>    

</form>

