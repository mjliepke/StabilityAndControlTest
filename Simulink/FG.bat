C:
cd C:\Program Files\FlightGear
SET FG_ROOT=C:\Program Files\FlightGear\\data
.\\bin\\win64\\fgfs --aircraft=c172p --fdm=network,localhost,5501,5502,5503 --multiplay=in,25,localhost,5701 --multiplay=out,25,localhost,5702 --enable-hud --fog-fastest --enable-clouds3d --start-date-lat=2004:06:01:09:00:00 --disable-sound --in-air --enable-freeze --airport=KSFO --runway=10L --altitude=5000 --heading=90 --offset-distance=4.72 --offset-azimuth=0

