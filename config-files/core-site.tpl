<property>
    <name>fs.s3a.server-side-encryption-algorithm</name>
    <value>SSE-KMS</value>
 </property>
 <property>
    <name>fs.s3a.server-side-encryption.key</name>
    <value>${kms_key_arn}</value>
 </property>