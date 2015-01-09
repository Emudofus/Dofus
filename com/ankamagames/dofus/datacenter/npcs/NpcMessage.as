package com.ankamagames.dofus.datacenter.npcs
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.data.GameData;
    import com.ankamagames.jerakine.data.I18n;

    public class NpcMessage implements IDataCenter 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(NpcMessage));
        public static const MODULE:String = "NpcMessages";

        public var id:int;
        public var messageId:uint;
        private var _messageText:String;


        public static function getNpcMessageById(id:int):NpcMessage
        {
            return ((GameData.getObject(MODULE, id) as NpcMessage));
        }


        public function get message():String
        {
            if (!(this._messageText))
            {
                this._messageText = I18n.getText(this.messageId);
            };
            return (this._messageText);
        }


    }
}//package com.ankamagames.dofus.datacenter.npcs

