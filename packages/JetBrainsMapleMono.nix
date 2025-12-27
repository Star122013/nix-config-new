{
  lib,
  stdenv,
  fetchzip,
}:

stdenv.mkDerivation rec {
  pname = "jetbrains-maple-mono";
  version = "1.2304.79";

  src = fetchzip {
    url = "https://github.com/SpaceTimee/Fusion-JetBrainsMapleMono/releases/download/${version}/JetBrainsMapleMono-NF-XX-XX-XX.zip";
    sha256 = "sha256-S/lmbgiazPLVk6zA7DMH1qNtl9nJGXhcFMzvI2SMr0A=";
    stripRoot = false;
  };

  installPhase = ''
    runHook preInstall

    # 创建字体目录
    fontDir=$out/share/fonts/truetype/JetBrainsMapleMono
    mkdir -p $fontDir

    # 复制所有字体文件
    find . -name "*.ttf" -exec cp {} $fontDir/ \;

    # 如果包含 OTF 字体
    find . -name "*.otf" -exec cp {} $fontDir/ \;

    runHook postInstall
  '';

  meta = with lib; {
    description = "A fusion font combining JetBrains Mono and Maple Mono";
    homepage = "https://github.com/SpaceTimee/Fusion-JetBrainsMapleMono";
    license = licenses.ofl;
    maintainers = [ ];
    platforms = platforms.all;
  };
}
