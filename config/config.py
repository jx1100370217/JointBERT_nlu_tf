#!/usr/bin/env python
# encoding: utf-8
'''
@author: jianxiong
@contact: jack18588951684@163.com
@software: pycharm
@file: config.py
@time: 2021/8/2 14:59
@desc: 工程配置文件
'''
import os

curPath = os.path.abspath(os.path.dirname(__file__))
rootPath = os.path.split(curPath)[0]

pretrain_models_path = "/root/jx/pretrained_model"

data_Path = os.path.join(rootPath, 'data')
configPath = os.path.join(rootPath, 'config')
bert_base = os.path.join(pretrain_models_path, 'uncased_L-12_H-768_A-12')

MAX_SEQ_LENGTH = 128
