package com.ankamagames.dofus.datacenter.servers
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class ServerGameType extends Object implements IDataCenter
    {
        public var id:int;
        public var nameId:uint;
        private var _name:String;
        private static const MODULE:String = "ServerGameTypes";
        private static var _log:Logger = Log.getLogger(getQualifiedClassName(ServerGameType));

        public function ServerGameType()
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

        public static function getServerGameTypeById(param1:int) : ServerGameType
        {
            return GameData.getObject(MODULE, param1) as ServerGameType;
        }// end function

        public static function getServerGameTypes() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
