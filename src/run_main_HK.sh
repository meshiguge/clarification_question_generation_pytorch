#!/bin/bash

#SBATCH --job-name=pretrain_util_HK_emb200
#SBATCH --output=pretrain_util_HK_emb200
#SBATCH --qos=gpu-medium
#SBATCH --partition=gpu
#SBATCH --gres=gpu
#SBATCH --time=24:00:00
#SBATCH --mem=64g

SITENAME=Home_and_Kitchen

CQ_DATA_DIR=/fs/clip-scratch/raosudha/clarification_question_generation/joint_learning/$SITENAME
SCRIPT_DIR=/fs/clip-amr/clarification_question_generation_pytorch/src
#EMB_DIR=/fs/clip-amr/ranking_clarification_questions/embeddings
EMB_DIR=/fs/clip-amr/clarification_question_generation_pytorch/embeddings/$SITENAME/200

CURR_METH_DIR=$CQ_DATA_DIR

#CURR_METH_DIR=$CQ_DATA_DIR/tf_ratio
#mkdir -p $CURR_METH_DIR

export PATH=/cliphomes/raosudha/anaconda2/bin:$PATH

python $SCRIPT_DIR/main.py    --train_context $CQ_DATA_DIR/train_context.txt \
                                    --train_ques $CQ_DATA_DIR/train_question.txt \
                                    --train_ans $CQ_DATA_DIR/train_answer.txt \
                                    --tune_context $CQ_DATA_DIR/tune_context.txt \
                                    --tune_ques $CQ_DATA_DIR/tune_question.txt \
                                    --tune_ans $CQ_DATA_DIR/tune_answer.txt \
                                    --test_context $CQ_DATA_DIR/test_context.txt \
                                    --test_ques $CQ_DATA_DIR/test_question.txt \
                                    --test_ans $CQ_DATA_DIR/test_answer.txt \
                                    --test_pred_ques $CURR_METH_DIR/test_pred_question.txt \
                                    --test_pred_ans $CURR_METH_DIR/test_pred_answer.txt \
                                    --q_encoder_params $CURR_METH_DIR/q_encoder_params \
                                    --q_decoder_params $CURR_METH_DIR/q_decoder_params \
                                    --a_encoder_params $CURR_METH_DIR/a_encoder_params \
                                    --a_decoder_params $CURR_METH_DIR/a_decoder_params \
                                    --context_params $CURR_METH_DIR/context_params \
                                    --question_params $CURR_METH_DIR/question_params \
                                    --answer_params $CURR_METH_DIR/answer_params \
                                    --utility_params $CURR_METH_DIR/utility_params \
                                    --word_embeddings $EMB_DIR/word_embeddings.p \
                                    --vocab $EMB_DIR/vocab.p \
                                    --n_epochs 40 \
                                    --max_post_len 100 \
									--max_ques_len 20 \
									--max_ans_len 20 \
                                    --pretrain_util True \
                                    #--pretrain_ques True \
                                    #--pretrain_ans True \

