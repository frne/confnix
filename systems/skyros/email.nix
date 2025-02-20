{ config, pkgs, lib, ... }:
with config;
let
  shelterHttpPort = builtins.toString config.services.shelter.httpPort;
  shelterDb = config.services.shelter.databaseFile;
  shelterAuth = "${pkgs.shelter}/bin/shelter_auth";
  eximCfg = config.services.exim4;
  checkPassword = ''
     #!/bin/sh

     REPLY="$1"
     INPUT_FD=3
     ERR_FAIL=1
     ERR_NOUSER=3
     ERR_TEMP=111

     read -d ''$'\x0' -r -u $INPUT_FD USER
     read -d ''$'\x0' -r -u $INPUT_FD PASS

     [ "$AUTHORIZED" != 1 ] || export AUHORIZED=2

     if [ "$CREDENTIALS_LOOKUP" = 1 ]; then
       exit $ERR_FAIL
     else
       if ${shelterAuth} localhost:${shelterHttpPort} $USER $PASS mail; then
           exec $REPLY
       else
           exit $ERR_FAIL
       fi
     fi
    '';
  checkpasswordScript = pkgs.writeScript "checkpassword-dovecot.sh" checkPassword;
  subdomain = "webmail";
in
{
  imports =
    [ ./spam.nix ];

  services.exim4 = {
    enable = settings.enableMailServer;
    primaryHostname = settings.primaryDomain;
    localDomains = [ "@" "localhost" ("lists."+settings.primaryDomain) ];
    postmaster = "eike";
    #debug = true;
    moreRecipientAcl = ''
     accept  local_parts = ''${lookup sqlite {${shelterDb} \
                select login from shelter_account_app where login = '$local_part' and appid = 'mailinglist';}}
             domains = ${"lists."+settings.primaryDomain}
    '';

    moreRouters = ''
    allusers:
      driver = redirect
      local_parts = all-users
      domains = lists.${settings.primaryDomain}
      data = ''${lookup sqlite {${shelterDb} \
                    select distinct login from shelter_account_app where appid = 'mail';}}
      forbid_pipe
      forbid_file
      errors_to = ${eximCfg.postmaster}@${settings.primaryDomain}
      no_more

    lists:
      driver = redirect
      domains = lists.${settings.primaryDomain}
      file = /var/data/mailinglists/$local_part
      headers_add = "List-Id: <$local_part.lists.${settings.primaryDomain}>"
      headers_add = "Reply-To: $local_part@lists.${settings.primaryDomain}"
      forbid_pipe
      forbid_file
      errors_to = ${eximCfg.postmaster}@${settings.primaryDomain}
      no_more
    '';

    localUsers = ''
     ''${lookup sqlite {${shelterDb} \
         select a.login from shelter_account a join shelter_account_app aa on a.login = aa.login where a.login = '$local_part' and aa.appid = 'mail' and a.locked = 0;}}
     '';

    mailAliases = ''
    ''${if eq{$local_part_suffix}{}\
      {''${lookup sqlite {${shelterDb} \
           select login from shelter_alias where loginalias = '$local_part';}}}\
      {''${lookup sqlite {${shelterDb} \
           select login || "$local_part_suffix" from shelter_alias where loginalias = '$local_part';}}}}
    '';

    plainAuthCondition = ''
      ''${run{${shelterAuth} localhost:${shelterHttpPort} $auth2 $auth3 mail}{true}{false}}
    '';

    loginAuthCondition = ''
      ''${run{${shelterAuth} localhost:${shelterHttpPort} $auth1 $auth2 mail}{true}{false}}
    '';

    tlsCertificate = if (settings.useCertificate) then settings.certificate else "";
    tlsPrivatekey = if (settings.useCertificate) then settings.certificateKey else "";
  };

  services.dovecot2imap = {
    enable = settings.enableMailServer;
#    extraConfig = "mail_debug = yes";
    enableImap = true;
    enablePop3 = true;
    mailLocation = "maildir:${eximCfg.usersDir}/%u/Maildir";
    userDb = ''
      driver = static
      args = uid=exim gid=exim home=${eximCfg.usersDir}/%u
    '';
    passDb = ''
      driver = checkpassword
      args = ${checkpasswordScript}
    '';
    sslServerCert = if (settings.useCertificate) then settings.certificate else "";
    sslServerKey = if (settings.useCertificate) then settings.certificateKey else "";
    sslCACert = if (settings.useCertificate) then settings.caCertificate else "";
  };


  services.roundcube = {
    enable = with settings; enableWebServer && enableMailServer && enableWebmail;
    productName = "eknet webmail";
    supportUrl = (if (settings.useCertificate) then "https://" else "http://") + settings.primaryDomain;
    nginxEnable = true;
    nginxListen = settings.primaryIp + ":" + (if (settings.useCertificate) then "443 ssl" else "80");
    nginxServerName = (subdomain+ "." + settings.primaryDomain);
    nginxFastCgiPass = services.phpfpmExtra.fastCgiBinding;
  };

  services.nginx.httpConfig = if (with settings; enableWebServer && enableMailServer && enableWebmail && useCertificate) then ''
    server {
      listen ${settings.primaryIp}:80;
      server_name ${subdomain}.${settings.primaryDomain};
      return 301 https://${subdomain}.${settings.primaryDomain}$request_uri;
    }
  '' else "";

  services.bindExtra.subdomains = if (settings.enableWebmail) then [ subdomain "lists" ] else [];
  services.shelter.apps = [
    { id = "mail";
      name = "Email";
      url= ((if (settings.useCertificate) then "https://" else "http://")+subdomain+"."+settings.primaryDomain);
      description = "SMTP and IMAP services.";}
    { id = "mailinglist";
      name = "Mailing-Lists";
      url = "";
      description = "Grouping for virtual accounts denoting mailinglists."; }
  ];
}
