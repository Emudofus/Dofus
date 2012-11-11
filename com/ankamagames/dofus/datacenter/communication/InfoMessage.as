package com.ankamagames.dofus.datacenter.communication
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class InfoMessage extends Object implements IDataCenter
    {
        public var typeId:uint;
        public var messageId:uint;
        public var textId:uint;
        private var _text:String;
        private static const MODULE:String = "InfoMessages";
        private static var _log:Logger = Log.getLogger(getQualifiedClassName(InfoMessage));

        public function InfoMessage()
        {
            return;
        }// end function

        public function get text() : String
        {
            if (!this._text)
            {
                this._text = I18n.getText(this.textId);
            }
            return this._text;
        }// end function

        public static function getInfoMessageById(param1:uint) : InfoMessage
        {
            var _loc_2:* = GameData.getObject(MODULE, param1);
            var _loc_3:* = GameData.getObject(MODULE, param1) as ;
            return GameData.getObject(MODULE, param1) as ;
        }// end function

        public static function getInfoMessages() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
