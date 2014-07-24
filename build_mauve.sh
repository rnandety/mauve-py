#!/bin/sh

# see http://asap.ahabs.wisc.edu/mauve/mauve-developer-guide/compiling-mauvealigner-from-source.html
# need boost > 1.34 and pkg-config
# curl http://voxel.dl.sourceforge.net/project/boost/boost/1.38.0/boost_1_38_0.tar.bz2 > boost_1_38_0.tar.bz2 2> /dev/null

VERSION="2-1-0"
BPATH=`pwd`
export PATH=$PATH:$BPATH/bin
export PKG_CONFIG_PATH=$BPATH/lib/pkgconfig


# svn co https://svn.code.sf.net/p/mauve/code/libGenome/trunk libGenome
# svn co https://svn.code.sf.net/p/mauve/code/muscle/trunk muscle
# svn co https://svn.code.sf.net/p/mauve/code/libMems/trunk libMems
# svn co https://svn.code.sf.net/p/mauve/code/mauveAligner/trunk mauveAligner

# build order:
# 1. libGenome
# 2. muscle
# 3. libMems
# 4. mauveAligner

cd libGenome
./autogen.sh && ./configure --prefix=$BPATH && make clean && make -j2 install
cd ..


cd muscle
./autogen.sh && ./configure --prefix=$BPATH && make clean && make -j2 ; make && make install
cd ..

cd libMems
# ./autogen.sh && ./configure --prefix=$BPATH --with-boost=$HOME && make clean && make -j2 install
./autogen.sh && ./configure --prefix=$BPATH && make clean && make -j2 install
cd ..

cd mauveAligner
./autogen.sh && ./configure --prefix=$BPATH && cd src && make clean && make mauveStatic && make progressiveMauveStatic && make install
cd ..


