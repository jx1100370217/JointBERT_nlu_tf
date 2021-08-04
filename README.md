# 基于BERT+Tensorflow-1.15+Horovod-0.22的NLU（意图识别+槽位填充）分布式GPU训练模块
## 1.目录结构

|  **name**   | **function**  |
|  ----  | ----  |
| config  | 配置文件 |
| data/input  | 输入数据 |
| data/output  | 输出模型 |
| data/res  | 结果文件 |
| data/logs  | 日志文件 |
| docker  | docker相关文件 |
| scripts/intent_task  | 单独意图识别（训练/测试）脚本 |
| scripts/slot_task  | 单独槽位填充（训练/测试）脚本 |
| scripts/join_task  | 意图槽位联合任务（训练/测试）脚本 |
| utils/model  | BERT模型相关代码 |
| utils/calculate_model_score.py  | 模型评分代码 |
| run_intent_bert.py  | 单独意图识别模型代码 |
| run_slot_bert.py  | 单独槽位填充模型代码 |
| run_intent_slot_join_task_bert.py  | 意图槽位联合任务模型代码 |
## 2.环境构建
### 方法1.直接拉取docker image后创建容器
```bash
## 拉取镜像
docker pull rivia/tensorflow-1:ngc-21.06

## 创建容器
cd JointBERT_nlu_tf/docker/ && bash create_tf_container.sh

## 启动容器
docker exec -it jx_ngc_tf bash
```
### 方法2.通过Dockerfile构建images后创建容器
```bash
## cd到docker目录
cd JointBERT_nlu_tf/docker

## 创建镜像
bash build_ngc.sh

## 创建容器
bash create_ngc_container.sh

## 启动容器
docker exec -it jx_ngc bash
```
## 3.数据获取
### 1）数据集获取并保存至data/input下
Atis数据集：
https://github.com/yvchen/JointSLU/tree/master/data

Snips数据集：
https://github.com/snipsco/nlu-benchmark/tree/master/2017-06-custom-intent-engines
### 2）预训练模型获取
```bash
cd ../pretrained_model/ && \
wget https://storage.googleapis.com/bert_models/2020_02_20/uncased_L-12_H-768_A-12.zip
```
## 4.相关配置
```python
import os

curPath = os.path.abspath(os.path.dirname(__file__))
rootPath = os.path.split(curPath)[0]

pretrain_models_path = "/root/jx/pretrained_model"

data_Path = os.path.join(rootPath, 'data')
configPath = os.path.join(rootPath, 'config')
bert_base = os.path.join(pretrain_models_path, 'uncased_L-12_H-768_A-12')

MAX_SEQ_LENGTH = 128
```
## 5.模型训练
### 单独意图识别（intent_task）
```bash
bash scripts/intent_task/run.sh 4
```
### 单独槽位填充（slot_task）
```bash
bash scripts/slot_task/run.sh 4
```
### 意图识别/槽位填充联合任务（join_task）
```bash
bash scripts/join_task/run.sh 4
```
## 6.模型测试
### 单独意图识别（intent_task）
```bash
bash scripts/intent_task/test.sh
```
### 单独槽位填充（slot_task）
```bash
bash scripts/slot_task/test.sh
```
### 意图识别/槽位填充联合任务（join_task）
```bash
bash scripts/join_task/test.sh
```