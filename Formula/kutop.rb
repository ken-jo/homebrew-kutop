class Kutop < Formula
  desc "btop-like Kubernetes TUI for pods, nodes, events, PVCs, alerts, and health"
  homepage "https://github.com/ken-jo/kutop"
  url "https://github.com/ken-jo/kutop/releases/download/v0.3.3/kutop-homebrew-0.3.3.tar.gz"
  sha256 "c1c598140fbb47a7a36d0cce2f3b2027feb4526f54b0f4ecc8faa09d56002041"
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
    assert_match "kutop 0.3.3", shell_output("#{bin}/kutop --version")
    assert_match "self-test OK", shell_output("#{bin}/kutop --self-test")
  end
end
