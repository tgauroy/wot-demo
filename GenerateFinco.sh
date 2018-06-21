#!/bin/sh


#gpg --list-secret-keys


######################## GENERATE FINCO IDENTITY WEB OF TRUST SAMPLE ########################
cat >finco <<EOF
     %echo Generating a OpenPGP key for Finco
     Key-Type: RSA
     Key-Length: 4096
     Subkey-Type: RSA
     Subkey-Length: 4096
     Name-Real: Finco Company
     Name-Comment: this is just a Test with Finco identity
     Name-Email: finco@finco.com
     Expire-Date: 0
     Passphrase: thisisfincokey
     # Do a commit here, so that we can later print "done" :-)
     %commit
     %echo done
EOF
gpg --batch --generate-key finco

gpg --armor --export "Finco Company" > FincoPubkey.asc
gpg --armor --export-secret-keys "Finco Company" > FincoPrvkey.asc


######################## GENERATE NEWCO IDENTITY WEB OF TRUST SAMPLE ########################
cat >newco <<EOF
     %echo Generating a OpenPGP key for Newco
     Key-Type: RSA
     Key-Length: 4096
     Subkey-Type: RSA
     Subkey-Length: 4096
     Name-Real: Newco Company
     Name-Comment: this is just a Test with Newco identity
     Name-Email: newco@newco.com
     Expire-Date: 0
     Passphrase: thisisnewcokey
     # Do a commit here, so that we can later print "done" :-)
     %commit
     %echo done
EOF
gpg --batch --generate-key newco

gpg --armor --export "Newco Company" > NewcoPubkey.asc


######################## GENERATE CORPO IDENTITY WEB OF TRUST SAMPLE ########################
cat >corpo <<EOF
     %echo Generating a OpenPGP key for Corpo
     Key-Type: RSA
     Key-Length: 4096
     Subkey-Type: RSA
     Subkey-Length: 4096
     Name-Real: Corpo Company
     Name-Comment: this is just a Test with Corpo identity
     Name-Email: corpo@corpo.com
     Expire-Date: 0
     Passphrase: thisiscorpokey
     # Do a commit here, so that we can later print "done" :-)
     %commit
     %echo done
EOF
gpg --batch --generate-key corpo

gpg --armor --export "Corpo Company" > CorpoPubkey.asc

######################## GENERATE BANK IDENTITY WEB OF TRUST SAMPLE ########################
cat >bank <<EOF
     %echo Generating a OpenPGP key for Bank
     Key-Type: RSA
     Key-Length: 4096
     Subkey-Type: RSA
     Subkey-Length: 4096
     Name-Real: Bank Company
     Name-Comment: this is just a Test with Corpo identity
     Name-Email: bank@bank.com
     Expire-Date: 0
     Passphrase: thisisbankkey
     # Do a commit here, so that we can later print "done" :-)
     %commit
     %echo done
EOF
gpg --batch --generate-key bank

gpg --armor --export "Bank Company" > BankPubkey.asc



######################## FINCO SIGN AND TRUST NEWCO KEY ########################
echo 'Finco Validate Newco identity'
 gpg --sign-key -u "Finco Company" --ask-cert-level "Newco Company"

######################## NEWCO SIGN AND TRUST FINCO KEY ########################
echo 'Newco Validate FINCO identity'
 gpg --sign-key -u "Newco Company" --ask-cert-level "Finco Company"

######################## FINCO SIGN AND TRUST BANK  KEY ########################
echo 'Finco Validate Bank identity'
 gpg --sign-key -u "Finco Company" --ask-cert-level "Bank Company"
######################## NEWCO SIGN AND TRUST CORPO KEY ########################
echo 'Newco Validate Corpo identity'
 gpg --sign-key -u "Newco Company" --ask-cert-level "Corpo Company"



######################## BANK SIGN LC ########################
echo 'Bank Sign PDF'
gpg  -u "Bank Company" --clearsign --output=lettre_de_credit_stand_by_signed_bank.pdf lettre_de_credit_stand_by.pdf

######################## CORPO VERIFY LC ########################
echo 'Corp Verify Signature on the  PDF'
gpg -u "Corpo Company" --verify lettre_de_credit_stand_by_signed_bank.pdf
