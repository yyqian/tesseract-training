#FZHei-B01S, 20, 50%wide
#Times New Roman, Bold, 11
#SimHei, 8
#text2image --list_available_fonts --fonts_dir=fonts
TRAIN_INPUT=$(pwd)/training_text/sn.txt
TRAIN_LANG=apn
TRAIN_FONT_DIR=$(pwd)/fonts
TRAIN_DATA_DIR=data
PTSIZE=12
RESOLUTION=600

rm -rf output && mkdir -p output \
&& g++ rm_blank.cpp && mv a.out output \
&& cd output \
&& TRAIN_FONT=times \
&& text2image --text=$TRAIN_INPUT --outputbase=$TRAIN_LANG.$TRAIN_FONT.exp0 --fonts_dir=$TRAIN_FONT_DIR --font='Times New Roman,' --ptsize=$PTSIZE --resolution=$RESOLUTION \
&& ./a.out $TRAIN_LANG.$TRAIN_FONT.exp0.box \
&& mv tmp.txt $TRAIN_LANG.$TRAIN_FONT.exp0.box \
&& tesseract $TRAIN_LANG.$TRAIN_FONT.exp0.tif $TRAIN_LANG.$TRAIN_FONT.exp0 nobatch box.train \
&& echo $TRAIN_FONT" 0 0 0 0 0" >> font_properties \
&& TRAIN_FONT=timesb \
&& text2image --text=$TRAIN_INPUT --outputbase=$TRAIN_LANG.$TRAIN_FONT.exp0 --fonts_dir=$TRAIN_FONT_DIR --font='Times New Roman, Bold' --ptsize=$PTSIZE --resolution=$RESOLUTION \
&& ./a.out $TRAIN_LANG.$TRAIN_FONT.exp0.box \
&& mv tmp.txt $TRAIN_LANG.$TRAIN_FONT.exp0.box \
&& tesseract $TRAIN_LANG.$TRAIN_FONT.exp0.tif $TRAIN_LANG.$TRAIN_FONT.exp0 nobatch box.train \
&& echo $TRAIN_FONT" 0 0 0 0 0" >> font_properties \
&& TRAIN_FONT=arial \
&& text2image --text=$TRAIN_INPUT --outputbase=$TRAIN_LANG.$TRAIN_FONT.exp0 --fonts_dir=$TRAIN_FONT_DIR --font='Arial' --ptsize=$PTSIZE --resolution=$RESOLUTION \
&& ./a.out $TRAIN_LANG.$TRAIN_FONT.exp0.box \
&& mv tmp.txt $TRAIN_LANG.$TRAIN_FONT.exp0.box \
&& tesseract $TRAIN_LANG.$TRAIN_FONT.exp0.tif $TRAIN_LANG.$TRAIN_FONT.exp0 nobatch box.train \
&& echo $TRAIN_FONT" 0 0 0 0 0" >> font_properties \
&& TRAIN_FONT=arialb \
&& text2image --text=$TRAIN_INPUT --outputbase=$TRAIN_LANG.$TRAIN_FONT.exp0 --fonts_dir=$TRAIN_FONT_DIR --font='Arial Bold' --ptsize=$PTSIZE --resolution=$RESOLUTION \
&& ./a.out $TRAIN_LANG.$TRAIN_FONT.exp0.box \
&& mv tmp.txt $TRAIN_LANG.$TRAIN_FONT.exp0.box \
&& tesseract $TRAIN_LANG.$TRAIN_FONT.exp0.tif $TRAIN_LANG.$TRAIN_FONT.exp0 nobatch box.train \
&& echo $TRAIN_FONT" 0 0 0 0 0" >> font_properties \
&& unicharset_extractor *.box \
&& mftraining -F font_properties -U unicharset -O $TRAIN_LANG.unicharset *.tr \
&& cntraining *.tr \
&& mkdir -p $TRAIN_DATA_DIR \
&& mv inttemp $TRAIN_DATA_DIR/$TRAIN_LANG.inttemp \
&& mv normproto $TRAIN_DATA_DIR/$TRAIN_LANG.normproto \
&& mv pffmtable $TRAIN_DATA_DIR/$TRAIN_LANG.pffmtable \
&& mv shapetable $TRAIN_DATA_DIR/$TRAIN_LANG.shapetable \
&& mv $TRAIN_LANG.unicharset $TRAIN_DATA_DIR/$TRAIN_LANG.unicharset \
&& combine_tessdata $TRAIN_DATA_DIR/$TRAIN_LANG. \
&& cp $TRAIN_DATA_DIR/$TRAIN_LANG.traineddata /usr/share/tesseract/tessdata/ \
&& tesseract $TRAIN_LANG.$TRAIN_FONT.exp0.tif stdout -l $TRAIN_LANG
