class Aibrowsertoolkit < Formula
  desc "Agentic browser automation CLI for AI agents"
  homepage "https://github.com/skssmd/Ai-Browser-Toolkit"
  version "0.7.8"
  license "Apache-2.0"

  # arm64 macOS only. macos-13 is GitHub's last Intel image and is being
  # retired, so the matrix stopped building macos-x86_64 -- and a formula with
  # an on_intel block pointing at an asset that is never built fails at
  # download time with no explanation. This refuses up front and says why.
  # Intel Macs are served by `pipx install ai-browser-toolkit`.
  depends_on arch: :arm64
  depends_on :macos

  url "https://github.com/skssmd/Ai-Browser-Toolkit/releases/download/v0.7.8/aibrowsertoolkit-0.7.8-macos-arm64.tar.gz"
  sha256 "aa24051ff9ffd6e66d1e7fe373ba3e48f3475182a01afa82b569b4a16a5e2e43"

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/abt"
  end

  def caveats
    <<~EOS
      Check what this needs and whether you have it:
        abt doctor

      It drives an existing Google Chrome or Microsoft Edge and bundles
      neither. `abt doctor --install-browser` will fetch Chrome via Homebrew.

      To put the desktop app in ~/Applications (Launchpad, Spotlight, the Dock):
        abt shortcut

      To start the server at logon:
        abt autostart install --browser chrome

      Homebrew has no uninstall hook, so `brew uninstall` will NOT remove that
      launchd agent. Run `abt autostart uninstall` before uninstalling, or the
      agent fails at your next login.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/abt --version")
  end
end
