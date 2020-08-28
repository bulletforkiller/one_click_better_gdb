#!/bin/sh

cd ~ 
if [ ! -d "pwndbg" ]; then
    echo "Not found pwndbg"
    git clone https://github.com/pwndbg/pwndbg && cd pwndbg && ./setup.sh
else
    echo "Found pwndbg"
fi

if [ ! -d "peda" ]; then
    echo "Not found peda"
    git clone https://github.com/longld/peda.git ~/peda
else
    echo "Found peda"
fi

echo "define init-peda" > .gdbinit
echo "source ~/peda/peda.py" >> .gdbinit
echo "end" >> .gdbinit
echo "document init-peda" >> .gdbinit
echo "Initializes the PEDA (Python Exploit Development sistant # for GDB) framework" >> .gdbinit
echo "end\n" >> .gdbinit

echo "define init-pwndbg" >> .gdbinit
echo "source ~/pwndbg/gdbinit.py" >> .gdbinit
echo "end" >> .gdbinit
echo "document init-pwndbg" >> .gdbinit
echo "Initializes PwnDBG" >> .gdbinit
echo "end" >> .gdbinit

echo "#!/bin/sh\nexec gdb -q -ex init-pwndbg \$@" > /usr/local/bin/gdb-pwndbg
echo "#!/bin/sh\nexec gdb -q -ex init-peda \$@" > /usr/local/bin/gdb-peda
chmod +x /usr/local/bin/gdb-peda /usr/local/bin/gdb-pwndbg
