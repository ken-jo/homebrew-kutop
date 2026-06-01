class Kutop < Formula
  desc "btop-like Kubernetes TUI for pods, nodes, events, PVCs, alerts, and health"
  homepage "https://github.com/ken-jo/kutop"
  url "https://github.com/ken-jo/kutop/releases/download/v0.2.2/kutop-homebrew-0.2.2.tar.gz"
  sha256 "666ea8759e1c6cbbdcff633accc4cd99a5ce6d6a26226dea19b9a900110a7a1c"
  license "MIT"

  depends_on "python@3.12"

  def install
    libexec.install Dir["*"]

    (bin/"kutop").write <<~EOS
      #!/bin/bash
      export PYTHONPATH="#{libexec}/lib/python${PYTHONPATH:+:$PYTHONPATH}"
      exec "#{Formula["python@3.12"].opt_bin}/python3" -m kutop "$@"
    EOS
    chmod 0755, bin/"kutop"

    (bin/"kubetop").write <<~EOS
      #!/bin/bash
      export PYTHONPATH="#{libexec}/lib/python${PYTHONPATH:+:$PYTHONPATH}"
      exec "#{Formula["python@3.12"].opt_bin}/python3" -m kutop "$@"
    EOS
    chmod 0755, bin/"kubetop"
  end

  test do
    assert_match "kutop 0.2.2", shell_output("#{bin}/kutop --version")
    assert_match "self-test OK", shell_output("#{bin}/kutop --self-test")
  end
end
