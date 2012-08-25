package com.ankamagames.dofus.logic.common.managers
{
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.game.fight.frames.*;
    import com.ankamagames.dofus.logic.game.roleplay.frames.*;
    import com.ankamagames.dofus.network.types.game.context.fight.*;
    import com.ankamagames.dofus.network.types.game.context.roleplay.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class AccountManager extends Object
    {
        private var _accounts:Dictionary;
        private static var _singleton:AccountManager;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(AccountManager));

        public function AccountManager()
        {
            this._accounts = new Dictionary();
            return;
        }// end function

        public function getIsKnowAccount(param1:String) : Boolean
        {
            return this._accounts.hasOwnProperty(param1);
        }// end function

        public function getAccountId(param1:String) : int
        {
            if (this._accounts[param1])
            {
                return this._accounts[param1].id;
            }
            return 0;
        }// end function

        public function getAccountName(param1:String) : String
        {
            if (this._accounts[param1])
            {
                return this._accounts[param1].name;
            }
            return "";
        }// end function

        public function setAccount(param1:String, param2:int, param3:String = null) : void
        {
            this._accounts[param1] = {id:param2, name:param3};
            return;
        }// end function

        public function setAccountFromId(param1:int, param2:int, param3:String = null) : void
        {
            var _loc_5:GameRolePlayNamedActorInformations = null;
            var _loc_6:FightEntitiesFrame = null;
            var _loc_7:GameFightFighterNamedInformations = null;
            var _loc_4:* = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
            if (Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame)
            {
                _loc_5 = _loc_4.getEntityInfos(param1) as GameRolePlayNamedActorInformations;
                if (_loc_5)
                {
                    this._accounts[_loc_5.name] = {id:param2, name:param3};
                }
            }
            else
            {
                _loc_6 = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
                if (_loc_6)
                {
                    _loc_7 = _loc_6.getEntityInfos(param1) as GameFightFighterNamedInformations;
                    if (_loc_7)
                    {
                        this._accounts[_loc_7.name] = {id:param2, name:param3};
                    }
                }
            }
            return;
        }// end function

        public static function getInstance() : AccountManager
        {
            if (!_singleton)
            {
                _singleton = new AccountManager;
            }
            return _singleton;
        }// end function

    }
}
