class Kutop < Formula
  desc "btop-like Kubernetes TUI for pods, nodes, events, PVCs, alerts, and health"
  homepage "https://github.com/ken-jo/kutop"
  url "https://github.com/ken-jo/kutop/releases/download/v0.5.0/kutop-homebrew-0.5.0.tar.gz"
  sha256 "7e9937d776b1708fda0686a50746d502ab6a0db4f59ba713fd8cd19a3747549e"
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
    assert_match "kutop 0.5.0", shell_output("#{bin}/kutop --version")
    assert_match "self-test OK", shell_output("#{bin}/kutop --self-test")
  end
end
