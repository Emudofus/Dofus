package com.ankamagames.dofus.types.characteristicContextual
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.text.*;
    import flash.utils.*;

    public class TextContextual extends CharacteristicContextual
    {
        private var _tText:String;
        private var _text:TextField;
        private var _textFormat:TextFormat;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(TextContextual));

        public function TextContextual()
        {
            return;
        }// end function

        public function get text() : String
        {
            return this._tText;
        }// end function

        public function set text(param1:String) : void
        {
            this._tText = param1;
            return;
        }// end function

        public function get textFormat() : TextFormat
        {
            return this._textFormat;
        }// end function

        public function set textFormat(param1:TextFormat) : void
        {
            this._textFormat = param1;
            return;
        }// end function

        public function finalize() : void
        {
            this._text = new TextField();
            this._text.selectable = false;
            this._text.defaultTextFormat = this._textFormat;
            this._text.setTextFormat(this._textFormat);
            if (EmbedFontManager.getInstance().isEmbed(this._textFormat.font))
            {
                this._text.embedFonts = true;
            }
            this._text.text = this._tText;
            this._text.width = this._text.textWidth + 5;
            this._text.height = this._text.textHeight;
            addChild(this._text);
            return;
        }// end function

    }
}
