class Kutop < Formula
  desc "btop-like Kubernetes TUI for pods, nodes, events, PVCs, alerts, and health"
  homepage "https://github.com/ken-jo/kutop"
  url "https://github.com/ken-jo/kutop/releases/download/v0.2.0/kutop-homebrew-0.2.0.tar.gz"
  sha256 "71eb81335fb0bd49f9fc81629b460b5e2befbbe0d32e8e780fe5aa93a9671f0e"
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
    assert_match "kutop 0.2.0", shell_output("#{bin}/kutop --version")
    assert_match "self-test OK", shell_output("#{bin}/kutop --self-test")
  end
end
