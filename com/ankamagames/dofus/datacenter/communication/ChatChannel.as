package com.ankamagames.dofus.datacenter.communication
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class ChatChannel extends Object implements IDataCenter
    {
        public var id:uint;
        public var nameId:uint;
        public var descriptionId:uint;
        public var shortcut:String;
        public var shortcutKey:String;
        public var isPrivate:Boolean;
        public var allowObjects:Boolean;
        private var _name:String;
        private static const MODULE:String = "ChatChannels";
        static const _log:Logger = Log.getLogger(getQualifiedClassName(ChatChannel));

        public function ChatChannel()
        {
            return;
        }// end function

        public function get name() : String
        {
            if (!this._name)
            {
                this._name = I18n.getText(this.nameId);
            }
            return this._name;
        }// end function

        public static function getChannelById(param1:int) : ChatChannel
        {
            return GameData.getObject(MODULE, param1) as ;
        }// end function

        public static function getChannels() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
