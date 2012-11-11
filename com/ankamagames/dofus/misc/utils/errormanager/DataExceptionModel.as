package com.ankamagames.dofus.misc.utils.errormanager
{

    public class DataExceptionModel extends Object
    {
        public var hash:String;
        public var stacktrace:String;
        public var date:int;
        public var isBlockerAndReboot:Boolean;
        public var isBlockerAndChangeCharacter:Boolean;
        public var buildType:String;
        public var buildVersion:String;
        public var osType:String;
        public var osVersion:String;
        public var serverId:uint;
        public var characterId:uint;
        public var mapId:uint;
        public var isMultiAccount:Boolean;
        public var isInFight:Boolean;
        public var logsSos:String;
        public var framesList:String;
        public var replayFile:String;
        public var reportFile:String;
        public var customInfo:Object;
        public var sent:Boolean = false;

        public function DataExceptionModel()
        {
            return;
        }// end function

        public function get errorType() : String
        {
            if (this.isBlockerAndReboot)
            {
                return "reboot";
            }
            if (this.isBlockerAndChangeCharacter)
            {
                return "changeCharacter";
            }
            return "";
        }// end function

    }
}
