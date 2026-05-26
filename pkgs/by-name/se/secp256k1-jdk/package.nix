{
  lib,
  fetchFromGitHub,
  maven_4,
  jdk25,
}:

maven_4.buildMavenPackage (finalAttrs: {
  pname = "secp256k1-jdk";
  version = "0.2.3-SNAPSHOT";

  src = fetchFromGitHub {
    owner = "bitcoinj";
    repo = "secp256k1-jdk";
    rev = "43bb6ec1cd926ec041398091b57f2bf51d3eaf98"; # working Maven WIP
    hash = "sha256-fMEfyc1b/HHFYMbn5HR02Z4ez08uklUfl/3tOrX/hfg=";
  };

  patches = [ ./pom-maven-4.patch ];

  mvnJdk = jdk25;
  mvnHash = "sha256-+5ozfvSXPk+PkpJ21KJgqqJ9KqV6MjRY5YjiaPCmfcQ=";

  strictDeps = true;
  __structuredAttrs = true;
  buildOffline = true;
  doCheck = false;

  installPhase = ''
    runHook preInstall

    install -Dm644 secp-api/target/*.jar -t "$out/share/java"
    install -Dm644 secp-bouncy/target/*.jar -t "$out/share/java"
    install -Dm644 secp-ffm/target/*.jar -t "$out/share/java"

    runHook postInstall
  '';

  meta = {
    changelog = "https://github.com/bitcoinj/secp256k1-jdk/blob/master/CHANGELOG.adoc";
    description = "Java library providing Elliptic Curve Cryptography on curve secp256k1";
    longDescription = ''
      secp256k1-jdk is a Java library providing Bitcoin-related Elliptic Curve Cryptography functions using the
      SECG curve secp256k1. It provides ECDSA and Schnorr message signing, verification, and other functions.
    '';
    homepage = "https://github.com/bitcoinj/secp256k1-jdk";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [
      msgilligan
    ];
    platforms = jdk25.meta.platforms;
    sourceProvenance = with lib.sourceTypes; [
      fromSource
      binaryBytecode # dependencies pulled via FOD from Maven Central
    ];
  };
})
