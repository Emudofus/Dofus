package com.ankamagames.dofus.datacenter.servers
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.data.GameData;
    import com.ankamagames.jerakine.data.I18n;

    public class ServerGameType implements IDataCenter 
    {

        public static const MODULE:String = "ServerGameTypes";
        private static var _log:Logger = Log.getLogger(getQualifiedClassName(ServerGameType));

        public var id:int;
        public var nameId:uint;
        private var _name:String;


        public static function getServerGameTypeById(id:int):ServerGameType
        {
            return ((GameData.getObject(MODULE, id) as ServerGameType));
        }

        public static function getServerGameTypes():Array
        {
            return (GameData.getObjects(MODULE));
        }


        public function get name():String
        {
            if (!(this._name))
            {
                this._name = I18n.getText(this.nameId);
            };
            return (this._name);
        }


    }
}//package com.ankamagames.dofus.datacenter.servers

