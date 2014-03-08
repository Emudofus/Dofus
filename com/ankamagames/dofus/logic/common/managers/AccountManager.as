package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.utils.Dictionary;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayNamedActorInformations;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterNamedInformations;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
   
   public class AccountManager extends Object
   {
      
      public function AccountManager() {
         super();
         this._accounts = new Dictionary();
      }
      
      private static var _singleton:AccountManager;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AccountManager));
      
      public static function getInstance() : AccountManager {
         if(!_singleton)
         {
            _singleton = new AccountManager();
         }
         return _singleton;
      }
      
      private var _accounts:Dictionary;
      
      public function getIsKnowAccount(param1:String) : Boolean {
         return this._accounts.hasOwnProperty(param1);
      }
      
      public function getAccountId(param1:String) : int {
         if(this._accounts[param1])
         {
            return this._accounts[param1].id;
         }
         return 0;
      }
      
      public function getAccountName(param1:String) : String {
         if(this._accounts[param1])
         {
            return this._accounts[param1].name;
         }
         return "";
      }
      
      public function setAccount(param1:String, param2:int, param3:String=null) : void {
         this._accounts[param1] = 
            {
               "id":param2,
               "name":param3
            };
      }
      
      public function setAccountFromId(param1:int, param2:int, param3:String=null) : void {
         var _loc5_:GameRolePlayNamedActorInformations = null;
         var _loc6_:FightEntitiesFrame = null;
         var _loc7_:GameFightFighterNamedInformations = null;
         var _loc4_:RoleplayEntitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
         if(_loc4_)
         {
            _loc5_ = _loc4_.getEntityInfos(param1) as GameRolePlayNamedActorInformations;
            if(_loc5_)
            {
               this._accounts[_loc5_.name] = 
                  {
                     "id":param2,
                     "name":param3
                  };
            }
         }
         else
         {
            _loc6_ = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
            if(_loc6_)
            {
               _loc7_ = _loc6_.getEntityInfos(param1) as GameFightFighterNamedInformations;
               if(_loc7_)
               {
                  this._accounts[_loc7_.name] = 
                     {
                        "id":param2,
                        "name":param3
                     };
               }
            }
         }
      }
   }
}
