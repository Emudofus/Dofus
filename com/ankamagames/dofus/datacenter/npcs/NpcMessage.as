package com.ankamagames.dofus.datacenter.npcs
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class NpcMessage extends Object implements IDataCenter
    {
        public var id:int;
        public var messageId:uint;
        public var messageParams:String;
        private var _messageText:String;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(NpcMessage));
        private static const MODULE:String = "NpcMessages";

        public function NpcMessage()
        {
            return;
        }// end function

        public function get message() : String
        {
            if (!this._messageText)
            {
                this._messageText = I18n.getText(this.messageId);
            }
            return this._messageText;
        }// end function

        public static function getNpcMessageById(param1:int) : NpcMessage
        {
            return GameData.getObject(MODULE, param1) as NpcMessage;
        }// end function

    }
}
