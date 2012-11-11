package com.ankamagames.dofus.logic.connection.managers
{
    import com.ankamagames.dofus.*;
    import com.ankamagames.dofus.misc.utils.*;
    import com.ankamagames.dofus.network.enums.*;
    import flash.events.*;

    public class StreamingBetaAuthentification extends EventDispatcher
    {
        private var _rpc:RpcServiceManager;
        private var _haveAccess:Boolean = false;
        private static var BASE_URL:String = "http://api.ankama.";

        public function StreamingBetaAuthentification(param1:String)
        {
            var _loc_2:* = BASE_URL;
            if (BuildInfos.BUILD_TYPE == BuildTypeEnum.RELEASE || BuildInfos.BUILD_TYPE == BuildTypeEnum.BETA || BuildInfos.BUILD_TYPE == BuildTypeEnum.ALPHA)
            {
                _loc_2 = _loc_2 + "com";
            }
            else
            {
                _loc_2 = _loc_2 + "lan";
            }
            this._rpc = new RpcServiceManager(_loc_2 + "/forum/forum.json", "json");
            this._rpc.addEventListener(Event.COMPLETE, this.onDataReceived);
            this._rpc.callMethod("IsAuthorized", ["dofus", "fr", param1, 1210]);
            return;
        }// end function

        public function get haveAccess() : Boolean
        {
            return this._haveAccess;
        }// end function

        private function onDataReceived(event:Event) : void
        {
            this._haveAccess = this._rpc.getAllResultData();
            dispatchEvent(new Event(Event.INIT));
            return;
        }// end function

    }
}
