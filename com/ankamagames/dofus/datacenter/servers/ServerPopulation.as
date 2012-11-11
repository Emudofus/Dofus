package com.ankamagames.dofus.datacenter.servers
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class ServerPopulation extends Object implements IDataCenter
    {
        public var id:int;
        public var nameId:uint;
        public var weight:int;
        private var _name:String;
        private static const MODULE:String = "ServerPopulations";
        private static var _log:Logger = Log.getLogger(getQualifiedClassName(ServerPopulation));

        public function ServerPopulation()
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

        public static function getServerPopulationById(param1:int) : ServerPopulation
        {
            return GameData.getObject(MODULE, param1) as ServerPopulation;
        }// end function

        public static function getServerPopulations() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
