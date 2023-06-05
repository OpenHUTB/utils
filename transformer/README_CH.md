# Transformer Models for MATLAB
[![CircleCI](https://img.shields.io/circleci/build/github/matlab-deep-learning/transformer-models?label=tests)](https://app.circleci.com/pipelines/github/matlab-deep-learning/transformer-models)

This repository implements deep learning transformer models in MATLAB.

## 差异
###语言模型
Bert和GPT-2虽然都采用`transformer`，但是Bert使用的是`transformer`的`encoder`，即：Self Attention，是双向的语言模型；而GPT-2用的是transformer中去掉中间`Encoder-Decoder Attention`层的decoder，即：Masked Self Attention，是单向语言模型。

### 结构
Bert是`pre-training + fine-tuning`的结构；而GPT-2只有`pre-training`。

### 输入向量
GPT-2是token embedding + prosition embedding；Bert是 token embedding + position embedding + segment embedding。

### 参数量
Bert是3亿参数量；而GPT-2是15亿参数量。

### 其他
Bert引入Masked LM和Next Sentence Prediction；而GPT-2只是单纯的用单向语言模型进行训练，没引入这两个。
Bert不能做生成式任务，而GPT-2可以。



## Translations
* [日本語](./README_JP.md)

## Requirements
### BERT and FinBERT
- MATLAB R2021a or later
- Deep Learning Toolbox
- Text Analytics Toolbox
### GPT-2
- MATLAB R2020a or later
- Deep Learning Toolbox

## Getting Started
Download or [clone](https://www.mathworks.com/help/matlab/matlab_prog/use-source-control-with-projects.html#mw_4cc18625-9e78-4586-9cc4-66e191ae1c2c) this repository to your machine and open it in MATLAB. 

## 功能
### bert
`mdl = bert` 加载预训练的 BERT transformer(Bidirectional Encoder Representation from Transformers) 模型（如有必要，下载模型权重）。输出 `mdl` 是带有字段的结构Tokenizer，Parameters分别包含 BERT 分词器和模型参数。

BERT利用Transformer学会如何编码、存储信息知识。

`mdl = bert("Model",modelName)` specifies which BERT model variant to use:
- `"base"` (default) - A 12 layer model with hidden size 768.
- `"multilingual-cased"` - A 12 layer model with hidden size 768. The tokenizer is case-sensitive. This model was trained on multi-lingual data.
- `"medium"` - An 8 layer model with hidden size 512. 
- `"small"` - A 4 layer model with hidden size 512.
- `"mini"` - A 4 layer model with hidden size 256.
- `"tiny"` - A 2 layer model with hidden size 128.

### bert.model
`Z = bert.model(X,parameters)` performs inference with a BERT model on the input `1`-by-`numInputTokens`-by-`numObservations` array of encoded tokens with the specified parameters. The output `Z` is an array of size (`NumHeads*HeadSize`)-by-`numInputTokens`-by-`numObservations`. The element `Z(:,i,j)` corresponds to the BERT embedding of input token `X(1,i,j)`.

`Z = bert.model(X,parameters,Name,Value)` specifies additional options using one or more name-value pairs:
- `"PaddingCode"` - Positive integer corresponding to the padding token. The default is `1`.
- `"InputMask"` - Mask indicating which elements to include for computation, specified as a logical array the same size as `X` or as an empty array. The mask must be false at indices positions corresponds to padding, and true elsewhere. If the mask is `[]`, then the function determines padding according to the `PaddingCode` name-value pair. The default is `[]`.
- `"DropoutProb"` - Probability of dropout for the output activation. The default is `0`.
- `"AttentionDropoutProb"` - Probability of dropout used in the attention layer. The default is `0`.
- `"Outputs"` - Indices of the layers to return outputs from, specified as a vector of positive integers, or `"last"`. If `"Outputs"` is `"last"`, then the function returns outputs from the final encoder layer only. The default is `"last"`.
- `"SeparatorCode"` - Separator token specified as a positive integer. The default is `103`.

### finbert
`mdl = finbert` loads a pretrained BERT transformer model for sentiment analysis of financial text. The output `mdl` is structure with fields `Tokenizer` and `Parameters` that contain the BERT tokenizer and the model parameters, respectively.

`mdl = finbert("Model",modelName)` specifies which FinBERT model variant to use:
- `"sentiment-model"` (default) - The fine-tuned sentiment classifier model.
- `"language-model"` - The FinBERT pretrained language model, which uses a BERT-Base architecture.

### finbert.sentimentModel
`sentiment = finbert.sentimentModel(X,parameters)` classifies the sentiment of the input `1`-by-`numInputTokens`-by-`numObservations` array of encoded tokens with the specified parameters. The output sentiment is a categorical array with categories `"positive"`, `"neutral"`, or `"negative"`.

`[sentiment, scores] = finbert.sentimentModel(X,parameters)` also returns the corresponding sentiment scores in the range `[-1 1]`.

### gpt2
`mdl = gpt2` loads a pretrained GPT-2(Generative Pre-Training) transformer model and if necessary, downloads the model weights.

GPT(Generative Pre-Training)，利用Transformer模型来解决各种自然语言问题，例如分类、推理、问答、相似度等应用的模型。GPT采用了Pre-training + Fine-tuning的训练模式，使得大量无标记的数据得以利用，大大提高了这些问题的效果。


### generateSummary
`summary = generateSummary(mdl,text)` generates a summary of the string or `char` array `text` using the transformer model `mdl`. The output summary is a char array.

`summary = generateSummary(mdl,text,Name,Value)` specifies additional options using one or more name-value pairs.

* `"MaxSummaryLength"` - The maximum number of tokens in the generated summary. The default is 50.
* `"TopK"` - The number of tokens to sample from when generating the summary. The default is 2.
* `"Temperature"` - Temperature applied to the GPT-2 output probability distribution. The default is 1.
* `"StopCharacter"` - Character to indicate that the summary is complete. The default is `"."`.

## 示例：使用 BERT 对文本数据进行分类
预训练 BERT 模型的最简单用途是将其用作特征提取器。特别是，您可以使用 BERT 模型将文档转换为特征向量，然后将其用作输入来训练深度学习分类网络。

该示例 [`ClassifyTextDataUsingBERT.m`](./ClassifyTextDataUsingBERT.m) 展示了如何使用预训练的 BERT 模型对给定工厂报告数据集的故障事件进行分类。

## 示例：微调预训练 BERT 模型
要充分利用预训练的 BERT 模型，您可以针对您的任务重新训练和微调 BERT 参数权重。

该示例 [`FineTuneBERT.m`](./FineTuneBERT.m) 展示了如何微调预训练的 BERT 模型，以便在给定工厂报告数据集的情况下对故障事件进行分类。

## 示例：使用 FinBERT 分析情绪
FinBERT 是一种情绪分析模型，在金融文本数据上进行训练，并针对情绪分析进行微调。

该示例 [`SentimentAnalysisWithFinBERT.m`](./SentimentAnalysisWithFinBERT.m) 展示了如何使用预训练的 FinBERT 模型对财经新闻报道的情绪进行分类。

## 示例：使用 BERT 和 FinBERT 预测屏蔽令牌
BERT 模型经过训练可以执行各种任务。其中一项任务被称为掩码语言建模，它是预测文本中已被掩码值替换的标记的任务。

该示例 [`PredictMaskedTokensUsingBERT.m`](./PredictMaskedTokensUsingBERT.m) 展示了如何使用预训练的 BERT 模型预测屏蔽标记并计算标记概率。

该示例 [`PredictMaskedTokensUsingFinBERT.m`](./PredictMaskedTokensUsingFinBERT.m) 展示了如何使用预训练的 FinBERT 模型预测金融文本的掩码标记并计算标记概率。

## 示例：使用 GPT-2 总结文本
可以使用 GPT-2 等 Transformer 网络来概括一段文本。训练有素的 GPT-2 转换器可以在给定初始单词序列作为输入的情况下生成文本。该模型是根据各种网页和互联网论坛上留下的评论进行训练的。

因为很多这些评论本身包含由语句“TL;DR”（太长，没读）指示的摘要，您可以使用转换器模型通过将“TL;DR”附加到输入文本来生成摘要。该`generateSummary`函数获取输入文本，自动附加字符串"TL;DR"并生成摘要。

该示例 [`SummarizeTextUsingTransformersExample.m`](./SummarizeTextUsingTransformersExample.m) 展示了如何使用 GPT-2 总结一段文本。


[参考](https://github.com/matlab-deep-learning/transformer-models)