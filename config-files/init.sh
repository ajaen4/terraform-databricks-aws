#!/bin/bash

echo "Setting core-site.xml configs at `date`"

START_DRIVER_SCRIPT=/databricks/spark/scripts/start_driver.sh
START_WORKER_SCRIPT=/databricks/spark/scripts/start_spark_slave.sh

TMP_DRIVER_SCRIPT=/tmp/start_driver_temp.sh
TMP_WORKER_SCRIPT=/tmp/start_spark_slave_temp.sh

TMP_SCRIPT=/tmp/set_core-site_configs.sh

config_xml="/tmp/core-site.xml"

cat >"$TMP_SCRIPT" <<EOL
#!/bin/bash
## Setting core-site.xml configs

sed -i '/<\/configuration>/{
    r $config_xml
    a \</configuration>
    d
}' /databricks/spark/dbconf/hadoop/core-site.xml

EOL
cat "$TMP_SCRIPT" > "$TMP_DRIVER_SCRIPT"
cat "$TMP_SCRIPT" > "$TMP_WORKER_SCRIPT"

cat "$START_DRIVER_SCRIPT" >> "$TMP_DRIVER_SCRIPT"
mv "$TMP_DRIVER_SCRIPT" "$START_DRIVER_SCRIPT"

cat "$START_WORKER_SCRIPT" >> "$TMP_WORKER_SCRIPT"
mv "$TMP_WORKER_SCRIPT" "$START_WORKER_SCRIPT"

echo "Completed core-site.xml config changes `date`"