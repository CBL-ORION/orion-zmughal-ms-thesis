#!/bin/sh

CURDIR=`dirname "$0"`
cd "$CURDIR"
#CURDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" # works in sourced files, only works for bash
wget -O HGP.jpg -c http://humangenomeproject.yolasite.com/resources/HGPlogosm.jpg 
if [ ! -r "HGP.png" ]; then
	convert HGP.jpg HGP.png
	mogrify -trim -transparent black -fuzz 5% HGP.png
fi

wget -c http://www.openworm.org/img/OpenWormLogo.png
wget -c https://upload.wikimedia.org/wikipedia/commons/d/da/Galaxyzoo.jpg

wget -c http://cdn.geekwire.com/wp-content/uploads/2014/10/alleninsitute12.jpg

wget -O michael-nielsen.jpg -c 'http://michaelnielsen.org/images/mn.jpg'

wget -O vaa3d-logo.png -c 'http://alleninstitute.org/media/filer_public/2a/9d/2a9d05db-8388-44b8-98c3-99204bdaf626/vaa3d_logo_small.jpg.250x272_q85.png'

wget -O mathworks-logo.gif -c http://www.mathworks.com/cmsimages/64848_wl_cc_logo_membrane_2002_wl.gif
if [ ! -r "mathworks-logo.png" ]; then
	convert mathworks-logo.gif mathworks-logo.png
	mogrify -trim -transparent white -fuzz 5% mathworks-logo.png
fi

# via <https://en.wikipedia.org/wiki/File:Golgi_Hippocampus.jpg>
wget -c 'https://upload.wikimedia.org/wikipedia/commons/5/5e/Golgi_Hippocampus.jpg'
# via <https://en.wikipedia.org/wiki/File:CajalCerebellum.jpg>
wget -c 'http://sharpbrains.com/wp-content/uploads/2008/02/cajal-chick-cerebellum.jpg'
