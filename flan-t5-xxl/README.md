# FLAN-T5 XXL

FLAN-T5 is a combination of two: a network and a model. Here, FLAN is Finetuned Language Net and T5 is a language model developed and published by Google in 2020. This model provides an improvement on the T5 model by improving the effectiveness of the zero-shot learning. FLAN-T5 model comes with many variants based on the numbers of parameters: FLAN-T5 small (80M); FLAN-T5 base (250M); FLAN-T5 large (780M); FLAN-T5 XL (3B); FLAN-T5 XXL (11B).
This deployment uses the XXL variant with 11B parameters.

Hugging Face repository https://huggingface.co/google/flan-t5-xxl

## Usage
Min GPU NVIDIA 3090. At the first start will be downloaded files of models with a total weight of about 45 GB. After that checkpoint shards will be loaded, thal also take a some time.
For running just deploy [this SDL](https://github.com/urichPasser/awesome-akash/blob/flan-t5-xxl/flan-t5-xxl/deploy.yaml) and wait for the models to finish loading, watching the process in the logs.

## Logs
The logs on the screenshot show that the loading of the models has completed and the application web server has started and the application is ready to work:
![Screenshot_20230704_225210](https://github.com/urichPasser/awesome-akash/assets/75273628/83666f96-c008-421e-907a-af128865ccc1)


## Demo Video
https://github.com/urichPasser/awesome-akash/assets/75273628/b6988076-81d1-4c79-9a01-f795cd6279fc


