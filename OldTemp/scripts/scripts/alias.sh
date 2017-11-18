# Función para crear alias MSDOS de funcionalidades standard 
        echo '' >> ~/.bashrc && . ~/.bashrc 
        echo '# ----------------------------------------------------------------' >> ~/.bashrc && . ~/.bashrc 
        echo '# Alias de Snoopix Base - v.1.0.0. MAR 2K15' >> ~/.bashrc && . ~/.bashrc 
        echo '# Copyright © 2015 By Peke Soft, Ltd. Madrid. All Rights Reserved.' >> ~/.bashrc && . ~/.bashrc 
        echo '# ----------------------------------------------------------------' >> ~/.bashrc && . ~/.bashrc 
        echo '' >> ~/.bashrc && . ~/.bashrc 
        echo '# Alias de emulación MSDOS' >> ~/.bashrc && . ~/.bashrc 
        echo '' >> ~/.bashrc && . ~/.bashrc 

        #Creamos los alias MSDOS básicos.
        
        #DIR
        echo 'alias dir="ls -la"' >> ~/.bashrc && . ~/.bashrc 

        #MD
        echo 'alias md="mkdir"' >> ~/.bashrc && . ~/.bashrc 

        #CD..
        echo 'alias cd..="cd .."' >> ~/.bashrc && . ~/.bashrc 

        #DEL
        echo 'alias del="rm"' >> ~/.bashrc && . ~/.bashrc 

        #DELTREE
        echo 'alias deltree="rm -R"' >> ~/.bashrc && . ~/.bashrc 

	#MOVE
        echo 'alias move="mv"' >> ~/.bashrc && . ~/.bashrc 

	#RENAME
        echo 'alias ren="mv"' >> ~/.bashrc && . ~/.bashrc 
        echo 'alias rename="mv"' >> ~/.bashrc && . ~/.bashrc 

	#COPY
        echo 'alias copy="cp"' >> ~/.bashrc && . ~/.bashrc 
        echo 'alias xcopy="cp -r"' >> ~/.bashrc && . ~/.bashrc 


# Alias de utilidades del sistema
        echo '' >> ~/.bashrc && . ~/.bashrc 
        echo '# Alias de Utilidades del Sistema' >> ~/.bashrc && . ~/.bashrc 
        echo '' >> ~/.bashrc && . ~/.bashrc 

	#Listar paquetes APT
        echo 'alias apt-list="dpkg -l"' >> ~/.bashrc && . ~/.bashrc 
        echo 'alias apt-orphan="dpkg -l '\"\\\$\"'(deborphan --find-config)"' >> ~/.bashrc && . ~/.bashrc 
	
	#Limpiar paquetes y configuraciones huérfanas.
        echo 'alias apt-clean="dpkg --purge '\"\\\$\"'(deborphan)"' >> ~/.bashrc && . ~/.bashrc 

	#Buscar paquetes grandes --> Si falla esta línea, poner las " y ' con \" y \' para que las pille como símbolos...
        echo 'alias bf="find / -type f -size +10000k -exec ls -lh {} \; | awk '\''{ print '\"\\\$\"'NF '\"\\\"\"': '\"\\\"\"' '\"\\\$\"'5 }'\''"' >> ~/.bashrc && . ~/.bashrc 
        echo 'alias bigfiles="bf"' >> ~/.bashrc && . ~/.bashrc 

	#Espacio de uso del disco
        echo 'alias dh="df -h"' >> ~/.bashrc && . ~/.bashrc 

	#Puertos abiertos.
        echo 'alias ports="netstat -tlnp"' >> ~/.bashrc && . ~/.bashrc 


#Alias para compresión y descompresión.
        echo '' >> ~/.bashrc && . ~/.bashrc 
        echo '# Alias de Utilidades de Compresión' >> ~/.bashrc && . ~/.bashrc 
        echo '' >> ~/.bashrc && . ~/.bashrc 

	#TAR
        echo 'alias .tar="tar -cvf"' >> ~/.bashrc && . ~/.bashrc 
        echo 'alias un.tar="tar -xvf"' >> ~/.bashrc && . ~/.bashrc 

	#GZ
        echo 'alias .gz="gzip -9"' >> ~/.bashrc && . ~/.bashrc 
        echo 'alias un.gz="gzip -d"' >> ~/.bashrc && . ~/.bashrc 

	#BZ2
        echo 'alias .bz2="bzip"' >> ~/.bashrc && . ~/.bashrc 
        echo 'alias un.bz2="bzip -d"' >> ~/.bashrc && . ~/.bashrc 

	#TAR.GZ
        echo 'alias .tar.gz="tar -czfv"' >> ~/.bashrc && . ~/.bashrc 
        echo 'alias un.tar.gz="tar -xzfv"' >> ~/.bashrc && . ~/.bashrc 

	#TAR.BZ2
        #echo 'alias .tar.bz2="tar -czfv"' >> ~/.bashrc && . ~/.bashrc 

	#ZIP
        echo 'alias .zip="zip"' >> ~/.bashrc && . ~/.bashrc 
        echo 'alias un.zip="unzip"' >> ~/.bashrc && . ~/.bashrc 

	#RAR
        echo 'alias .rar="rar -a"' >> ~/.bashrc && . ~/.bashrc 
        echo 'alias un.rar="unrar -x"' >> ~/.bashrc && . ~/.bashrc 

	#7Z
        echo 'alias .7z="7z a -t7z -m0=lzma -mx=9 -mfb=64 -md=32m -ms=on"' >> ~/.bashrc && . ~/.bashrc 
        echo 'alias un.7z="7z x"' >> ~/.bashrc && . ~/.bashrc 

