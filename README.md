# schedulingAlgorithm

# CONDA
Install Anaconda: https://docs.conda.io/projects/conda/en/latest/user-guide/install/macos.html

    > Set up virtual environment with mysql.connector package: conda create --name myenv
  
    > Proceed? y
    
    > Activate environment: conda activate
  
    > Install mysql.connector (can do broadly in conda): pip install mysql-connector-python 
  
    > Install in specific conda environment: 
    pip install --install-option="--prefix=$PREFIX_PATH_TO_ENVIRONMENT" mysql-connector-python
    
   Note: VSCode requires selection of a specific python interpreter, make sure mysql-connector-python is installed in that directory




# MYSQL 
Install MySQL with Homebrew: https://gist.github.com/operatino/392614486ce4421063b9dece4dfe6c21

Set up mysql (if not installed/configured):

  - this program uses database "schedule_db" 
  
  - configure either new user with privileges: [in which case host = localhost]
  
        mysql> GRANT ALL PRIVILEGES ON schedule_db TO 'username'@'host'
      
        mysql> GRANT FILE ON *.* TO 'username'@'host'
      
    OR use root
    
  - modify credentials used in usefulFunctions.py method "runMySQLOperation" to match local
  
  
  
  
# MYSQL EXPORTATION COMMANDS (to be added into program later, but for now run through mysql server locally):
 - File with headers:
    
        mysql> SELECT 'Name', 'Gender', 'Class Name', 'Section #' UNION ALL SELECT name, gender, class_name, section_number 
        FROM formatted_output INTO OUTFILE 'file_name.csv' 
        FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n';
    
 - This outputs into the schedule_db directory (probably /usr/local/var/mysql/schedule_db) ; 
       - If you can't find where it exports run, in -u root
        
        mysql> SHOW VARIABLES LIKE “secure_file_priv”;
        
 - IF GETTING --secure-file-priv then you need to change your security permissions:
        - You need to edit your .my.cnf file to disable specific file locations. This can be found in numerous place (see sample config file)
        but if it doesn't exist you can create in root, which is the prioritized location of mysql permissions:
        
        $ cd
        $ sudo vim/my.cnf
        --> under [mysqld] set secure-file-priv to either location of choice or ""
        
        
        mysql> RESTART 
        mysql> SHOW VARIABLES LIKE "secure_file_priv" 
        
        It should pop up as: (value empty if "", else shows location)
        +------------------+-------+
        | Variable_name    | Value |
        +------------------+-------+
        | secure_file_priv |       |
        +------------------+-------+

  
