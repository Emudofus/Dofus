package com.ankamagames.dofus.logic.common.managers
{
    import com.ankamagames.dofus.datacenter.servers.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.utils.errors.*;

    public class PlayerManager extends Object implements IDestroyable
    {
        public var accountId:uint;
        public var communityId:uint;
        public var hasRights:Boolean;
        public var nickname:String;
        public var subscriptionEndDate:Number;
        public var secretQuestion:String;
        public var adminStatus:int;
        public var passkey:String;
        public var accountCreation:Number;
        private var _server:Server;
        public var serverCommunityId:int = -1;
        public var serverLang:String;
        private static var _self:PlayerManager;

        public function PlayerManager()
        {
            if (_self != null)
            {
                throw new SingletonError("PlayerManager is a singleton and should not be instanciated directly.");
            }
            return;
        }// end function

        public function set server(param1:Server) : void
        {
            this._server = param1;
            return;
        }// end function

        public function get server() : Server
        {
            if (this._server)
            {
                if (this.serverCommunityId > -1)
                {
                    this._server.communityId = this.serverCommunityId;
                }
                if (this.serverLang != "")
                {
                    this._server.language = this.serverLang;
                }
            }
            return this._server;
        }// end function

        public function destroy() : void
        {
            _self = null;
            return;
        }// end function

        public static function getInstance() : PlayerManager
        {
            if (_self == null)
            {
                _self = new PlayerManager;
            }
            return _self;
        }// end function

    }
}
