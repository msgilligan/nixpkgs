{
  lib,
  bash,
  autoconf,
  mkCoqDerivation,
  coq,
  stdlib,
  version ? null,
}:

mkCoqDerivation {
  pname = "flocq";
  owner = "flocq";
  domain = "gitlab.inria.fr";
  inherit version;
  defaultVersion =
    let
      case = case: out: { inherit case out; };
    in
    with lib.versions;
    lib.switch coq.coq-version [
      (case (range "8.15" "9.1") "4.2.1")
      (case (range "8.14" "8.20") "4.2.0")
      (case (range "8.14" "8.18") "4.1.3")
      (case (range "8.14" "8.17") "4.1.1")
      (case (range "8.14" "8.16") "4.1.0")
      (case (range "8.7" "8.15") "3.4.3")
      (case (range "8.5" "8.8") "2.6.1")
    ] null;
  release."4.2.1".sha256 = "sha256-W5hcAm0GGmNsvre79/iGNcoBwFzStC4G177hZ3ds/4E=";
  release."4.2.0".sha256 = "sha256-uTeo4GCs6wTLN3sLKsj0xLlt1fUDYfozXtq6iooLUgM=";
  release."4.1.4".sha256 = "sha256-Use6Mlx79yef1CkCPyGoOItsD69B9KR+mQArCtmre4s=";
  release."4.1.3".sha256 = "sha256-os3cI885xNpxI+1p5rb8fSNnxKr7SFxqh83+3AM3t4I=";
  release."4.1.1".sha256 = "sha256-FbClxlV0ZaxITe7s9SlNbpeMNDJli+Dfh2TMrjaMtHo=";
  release."4.1.0".sha256 = "sha256:09rak9cha7q11yfqracbcq75mhmir84331h1218xcawza48rbjik";
  release."3.4.3".sha256 = "sha256-YTdWlEmFJjCcHkl47jSOgrGqdXoApJY4u618ofCaCZE=";
  release."3.4.2".sha256 = "1s37hvxyffx8ccc8mg5aba7ivfc39p216iibvd7f2cb9lniqk1pw";
  release."3.3.1".sha256 = "1mk8adhi5hrllsr0hamzk91vf2405sjr4lh5brg9201mcw11abkz";
  release."2.6.1".sha256 = "0q5a038ww5dn72yvwn5298d3ridkcngb1dik8hdyr3xh7gr5qibj";
  releaseRev = v: "flocq-${v}";

  nativeBuildInputs = [
    bash
    autoconf
  ];
  mlPlugin = true;
  useMelquiondRemake.logpath = "Flocq";

  propagatedBuildInputs = [ stdlib ];

  meta = with lib; {
    description = "Floating-point formalization for the Coq system";
    license = licenses.lgpl3;
    maintainers = with maintainers; [ jwiegley ];
  };
}
