package com.ankamagames.dofus.logic.connection.managers
{
    import flash.events.EventDispatcher;
    import com.ankamagames.dofus.misc.utils.RpcServiceManager;
    import com.ankamagames.dofus.BuildInfos;
    import com.ankamagames.dofus.network.enums.BuildTypeEnum;
    import flash.events.Event;
    import flash.utils.setTimeout;

    public class SpecialBetaAuthentification extends EventDispatcher 
    {

        private static var BASE_URL:String = "http://api.ankama.";
        public static const STREAMING:String = "streaming";
        public static const MODULES:String = "modules";

        private var _rpc:RpcServiceManager;
        private var _haveAccess:Boolean = false;

        public function SpecialBetaAuthentification(login:String, type:String)
        {
            var url:String = BASE_URL;
            if ((((((BuildInfos.BUILD_TYPE == BuildTypeEnum.RELEASE)) || ((BuildInfos.BUILD_TYPE == BuildTypeEnum.BETA)))) || ((BuildInfos.BUILD_TYPE == BuildTypeEnum.ALPHA))))
            {
                url = (url + "com");
            }
            else
            {
                url = (url + "lan");
            };
            var forumId:Array = [];
            switch (type)
            {
                case STREAMING:
                    forumId.push(1210, 1080, 1008, 1127, 1508);
                    break;
                case MODULES:
                    forumId.push(1127);
                    break;
            };
            this._haveAccess = false;
            if (forumId.length)
            {
                this._rpc = new RpcServiceManager((url + "/forum/forum.json"), "json");
                this._rpc.addEventListener(Event.COMPLETE, this.onDataReceived);
                this._rpc.callMethod("IsAuthorized", ["dofus", "fr", login, forumId]);
            }
            else
            {
                setTimeout(dispatchEvent, 1, new Event(Event.INIT));
            };
        }

        public function get haveAccess():Boolean
        {
            return (this._haveAccess);
        }

        private function onDataReceived(e:Event):void
        {
            while (true)
            {
                this._haveAccess = this._rpc.getAllResultData();
                goto _label_2;
            };
            var _local_3 = _local_3;
            
        _label_1: 
            return;
            
        _label_2: 
            dispatchEvent(new Event(Event.INIT));
            goto _label_1;
            return;
        }


    }
}//package com.ankamagames.dofus.logic.connection.managers

