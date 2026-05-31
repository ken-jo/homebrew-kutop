class Kutop < Formula
  desc "btop-style Kubernetes resource dashboard for the terminal"
  homepage "https://github.com/ken-jo/kutop"
  url "https://github.com/ken-jo/kutop/releases/download/v0.1.0/kutop-homebrew-0.1.0.tar.gz"
  sha256 "6fda5e8d2f59f10e4b38edf16cc00f910459c63fab820b14b74472c9d7768435"
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
    assert_match "kutop 0.1.0", shell_output("#{bin}/kutop --version")
    assert_match "self-test OK", shell_output("#{bin}/kutop --self-test")
  end
end
