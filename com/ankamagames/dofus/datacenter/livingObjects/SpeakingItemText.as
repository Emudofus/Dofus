package com.ankamagames.dofus.datacenter.livingObjects
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class SpeakingItemText extends Object implements IDataCenter
    {
        public var textId:int;
        public var textProba:Number;
        public var textStringId:uint;
        public var textLevel:int;
        public var textSound:int;
        public var textRestriction:String;
        private var _textString:String;
        private static const MODULE:String = "SpeakingItemsText";
        static const _log:Logger = Log.getLogger(getQualifiedClassName(SpeakingItemText));

        public function SpeakingItemText()
        {
            return;
        }// end function

        public function get textString() : String
        {
            if (!this._textString)
            {
                this._textString = I18n.getText(this.textStringId);
            }
            return this._textString;
        }// end function

        public static function getSpeakingItemTextById(param1:int) : SpeakingItemText
        {
            return GameData.getObject(MODULE, param1) as SpeakingItemText;
        }// end function

        public static function getSpeakingItemsText() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
