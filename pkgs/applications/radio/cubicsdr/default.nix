{ stdenv, fetchFromGitHub, cmake, fftw, hamlib, libpulseaudio, libGL, libX11, liquid-dsp,
  pkgconfig, soapysdr-with-plugins, wxGTK31-gtk3, enableDigitalLab ? false }:

stdenv.mkDerivation rec {
  pname = "cubicsdr";
  version = "0.2.5";

  src = fetchFromGitHub {
    owner = "cjcliffe";
    repo = "CubicSDR";
    rev = version;
    sha256 = "1ihbn18bzdcdvwpa4hnb55ns38bj4b8xy53hkmra809f9qpbcjhn";
  };

  nativeBuildInputs = [ cmake pkgconfig ];

  buildInputs = [ fftw hamlib libpulseaudio libGL libX11 liquid-dsp soapysdr-with-plugins wxGTK31-gtk3 ];

  cmakeFlags = [ "-DUSE_HAMLIB=ON" ]
    ++ stdenv.lib.optional enableDigitalLab "-DENABLE_DIGITAL_LAB=ON";

  meta = with stdenv.lib; {
    homepage = "https://cubicsdr.com";
    description = "Software Defined Radio application";
    license = licenses.gpl2Plus;
    maintainers = with maintainers; [ lasandell ];
    platforms = platforms.linux;
  };
}

