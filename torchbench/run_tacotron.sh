#!/usr/bin/env sh
/usr/bin/python3 /app/benchmark/install.py models hf_bert hf_Bert_large resnet50 tacotron2 && pytest /app/benchmark/test_bench.py -k "(tacotron2)" --cuda_only --ignore_machine_config --benchmark-json=/app/benchmark_results.json
