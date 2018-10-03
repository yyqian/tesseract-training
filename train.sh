#FZHei-B01S, 20, 50%wide
#Times New Roman, Bold, 11
#SimHei, 8
TRAIN_INPUT=$(pwd)/training_text.txt
TRAIN_LANG=apn
TRAIN_FONT=TimesBold
TRAIN_FONT_DIR=$(pwd)/fonts
TRAIN_DATA_DIR=data

echo $TRAIN_FONT_NAME
rm -rf output && mkdir -p output && cd output \
&& text2image --text=$TRAIN_INPUT --outputbase=$TRAIN_LANG.$TRAIN_FONT.exp0 --fonts_dir=$TRAIN_FONT_DIR --font='FZHei-B01S' --ptsize=20 --resolution=300 \
&& tesseract $TRAIN_LANG.$TRAIN_FONT.exp0.tif $TRAIN_LANG.$TRAIN_FONT.exp0 nobatch box.train \
&& unicharset_extractor $TRAIN_LANG.$TRAIN_FONT.exp0.box \
&& echo $TRAIN_FONT" 0 0 0 0 0" >> font_properties \
&& mftraining -F font_properties -U unicharset $TRAIN_LANG.$TRAIN_FONT.exp0.tr \
&& cntraining $TRAIN_LANG.$TRAIN_FONT.exp0.tr \
&& mkdir -p $TRAIN_DATA_DIR \
&& mv inttemp $TRAIN_DATA_DIR/$TRAIN_LANG.inttemp \
&& mv normproto $TRAIN_DATA_DIR/$TRAIN_LANG.normproto \
&& mv pffmtable $TRAIN_DATA_DIR/$TRAIN_LANG.pffmtable \
&& mv shapetable $TRAIN_DATA_DIR/$TRAIN_LANG.shapetable \
&& mv unicharset $TRAIN_DATA_DIR/$TRAIN_LANG.unicharset \
&& combine_tessdata $TRAIN_DATA_DIR/$TRAIN_LANG. \
&& cp $TRAIN_DATA_DIR/$TRAIN_LANG.traineddata /usr/share/tesseract/tessdata/ \
&& tesseract $TRAIN_LANG.$TRAIN_FONT.exp0.tif stdout -l $TRAIN_LANG
