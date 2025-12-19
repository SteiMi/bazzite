#!/bin/bash
set -euo pipefail

MOK_PATH="/usr/share/keys/ryzen_smu/MOK.der"
if [ ! -f "$MOK_PATH" ]; then
  echo "MOK file not found: $MOK_PATH"
  exit 1
fi

cat <<'EOF'
To enroll the module-signing key so Secure Boot will accept the ryzen_smu module:

1) Import the public key into the Machine Owner Key (MOK) list:
   sudo mokutil --import /usr/share/keys/ryzen_smu/MOK.der
   (You will be prompted to create a password.)

2) Reboot the machine and follow the MOK manager UI to complete enrollment.

3) After reboot, the ryzen_smu module will load automatically.

If you prefer not to enroll the MOK, you can:
- Disable Secure Boot in UEFI firmware
- Or add kernel parameter: module.sig_enforce=0 to your grub cmdline

For enterprise/unattended enrollment, use your organization's MOK/KMS process.
EOF

exit 0
