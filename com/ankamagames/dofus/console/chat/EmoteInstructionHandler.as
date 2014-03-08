package com.ankamagames.dofus.console.chat
{
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.dofus.logic.game.roleplay.actions.EmotePlayRequestAction;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.network.enums.PlayerLifeStatusEnum;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.datacenter.communication.Emoticon;
   
   public class EmoteInstructionHandler extends Object implements ConsoleInstructionHandler
   {
      
      public function EmoteInstructionHandler() {
         this.sysApi = new SystemApi();
         super();
      }
      
      private var sysApi:SystemApi;
      
      public function handle(param1:ConsoleHandler, param2:String, param3:Array) : void {
         var _loc6_:EmotePlayRequestAction = null;
         var _loc4_:uint = this.getEmoteId(param2);
         var _loc5_:PlayedCharacterManager = PlayedCharacterManager.getInstance();
         if(_loc4_ > 0 && _loc5_.state == PlayerLifeStatusEnum.STATUS_ALIVE_AND_KICKING && (_loc5_.isRidding) || (_loc5_.isPetsMounting) || _loc5_.infos.entityLook.bonesId == 1)
         {
            _loc6_ = EmotePlayRequestAction.create(_loc4_);
            Kernel.getWorker().process(_loc6_);
         }
      }
      
      public function getHelp(param1:String) : String {
         return null;
      }
      
      private function getEmoteId(param1:String) : uint {
         var _loc2_:Emoticon = null;
         for each (_loc2_ in Emoticon.getEmoticons())
         {
            if(_loc2_.shortcut == param1)
            {
               return _loc2_.id;
            }
            if(_loc2_.defaultAnim == param1)
            {
               return _loc2_.id;
            }
         }
         return 0;
      }
      
      public function getParamPossibilities(param1:String, param2:uint=0, param3:Array=null) : Array {
         return [];
      }
   }
}
