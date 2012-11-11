package com.ankamagames.dofus.datacenter.servers
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class ServerCommunity extends Object implements IDataCenter
    {
        public var id:int;
        public var nameId:uint;
        public var shortId:String;
        public var defaultCountries:Vector.<String>;
        private var _name:String;
        private static const MODULE:String = "ServerCommunities";
        private static var _log:Logger = Log.getLogger(getQualifiedClassName(ServerCommunity));

        public function ServerCommunity()
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

        public static function getServerCommunityById(param1:int) : ServerCommunity
        {
            return GameData.getObject(MODULE, param1) as ServerCommunity;
        }// end function

        public static function getServerCommunities() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
