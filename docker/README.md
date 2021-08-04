
## NGC镜像(用于BERT模型训练)
- 创建镜像：bash build_ngc.sh
- 实例化容器：bash create_ngc_container.sh
- 启动容器：docker exec -it jx_ngc bash

## tensorrt镜像(用于导出engine模型)
- 创建镜像：bash build_tensorrt.sh
- 实例化容器：bash create_trt_container.sh
- 启动容器：docker exec -it jx_trt bash

## airflow镜像(容器)
- 进入docke目录：cd /data/jx/threesegcode_bert/docker
- docker-compose创建airflow容器：docker-compose -p airflow -f airflow.yaml up -d