package com.ankamagames.dofus.logic.game.roleplay.managers
{
   import com.ankamagames.jerakine.interfaces.IDestroyable;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayContextFrame;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.factories.MenusFactory;
   import com.ankamagames.berilia.types.data.ContextMenuData;
   import com.ankamagames.jerakine.entities.interfaces.IInteractive;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayMutantInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayCharacterInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayMerchantInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayNpcInformations;
   import com.ankamagames.dofus.network.types.game.context.GameRolePlayTaxCollectorInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayPrismInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayPortalInformations;
   import com.ankamagames.dofus.logic.game.roleplay.types.GameContextPaddockItemInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayMountInformations;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.atouin.managers.InteractiveCellManager;
   import flash.display.Sprite;
   import com.ankamagames.atouin.managers.EntitiesDisplayManager;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   
   public class RoleplayManager extends Object implements IDestroyable
   {
      
      public function RoleplayManager()
      {
         super();
         if(_self != null)
         {
            throw new SingletonError("RoleplayManager is a singleton and should not be instanciated directly.");
         }
         else
         {
            return;
         }
      }
      
      private static var _self:RoleplayManager;
      
      private static const REWARD_SCALE_CAP:Number = 1.5;
      
      private static const REWARD_REDUCED_SCALE:Number = 0.7;
      
      public static function getInstance() : RoleplayManager
      {
         if(_self == null)
         {
            _self = new RoleplayManager();
         }
         return _self;
      }
      
      public var dofusTimeYearLag:int;
      
      private function get roleplayContextFrame() : RoleplayContextFrame
      {
         return Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame;
      }
      
      public function destroy() : void
      {
         _self = null;
      }
      
      public function displayCharacterContextualMenu(param1:GameContextActorInformations) : Boolean
      {
         var _loc2_:Object = UiModuleManager.getInstance().getModule("Ankama_ContextMenu").mainClass;
         var _loc3_:ContextMenuData = MenusFactory.create(param1,null,[{"id":param1.contextualId}]);
         if(_loc3_)
         {
            _loc2_.createContextMenu(_loc3_);
            return true;
         }
         return false;
      }
      
      public function displayContextualMenu(param1:GameContextActorInformations, param2:IInteractive) : Boolean
      {
         var _loc3_:ContextMenuData = null;
         var _loc4_:Object = UiModuleManager.getInstance().getModule("Ankama_ContextMenu").mainClass;
         switch(true)
         {
            case param1 is GameRolePlayMutantInformations:
               if((param1 as GameRolePlayMutantInformations).humanoidInfo.restrictions.cantAttack)
               {
                  _loc3_ = MenusFactory.create(param1,null,[param2]);
               }
               break;
            case param1 is GameRolePlayCharacterInformations:
               _loc3_ = MenusFactory.create(param1,null,[param2]);
               break;
            case param1 is GameRolePlayMerchantInformations:
               _loc3_ = MenusFactory.create(param1,null,[param2]);
               break;
            case param1 is GameRolePlayNpcInformations:
               _loc3_ = MenusFactory.create(param1,null,[param2]);
               break;
            case param1 is GameRolePlayTaxCollectorInformations:
               _loc3_ = MenusFactory.create(param1,null,[param2]);
               break;
            case param1 is GameRolePlayPrismInformations:
               _loc3_ = MenusFactory.create(param1,null,[param2]);
               break;
            case param1 is GameRolePlayPortalInformations:
               _loc3_ = MenusFactory.create(param1,null,[param2]);
               break;
            case param1 is GameContextPaddockItemInformations:
               if(this.roleplayContextFrame.currentPaddock.guildIdentity)
               {
                  _loc3_ = MenusFactory.create(param1,null,[param2]);
               }
               break;
            case param1 is GameRolePlayMountInformations:
               _loc3_ = MenusFactory.create(param1,null,[param2]);
               break;
         }
         if(_loc3_)
         {
            _loc4_.createContextMenu(_loc3_);
            return true;
         }
         return false;
      }
      
      public function putEntityOnTop(param1:AnimatedCharacter) : void
      {
         var _loc2_:Sprite = InteractiveCellManager.getInstance().getCell(param1.position.cellId);
         EntitiesDisplayManager.getInstance().orderEntity(param1,_loc2_);
      }
      
      public function getKamasReward(param1:Boolean = true, param2:int = -1, param3:Number = 1, param4:Number = 1, param5:int = -1) : Number
      {
         if(param5 == -1 && (param1))
         {
            var param5:int = PlayedCharacterManager.getInstance().infos.level;
         }
         var _loc6_:int = param1?param5:param2;
         return (Math.pow(_loc6_,2) + 20 * _loc6_ - 20) * param3 * param4;
      }
      
      public function getExperienceReward(param1:int, param2:int, param3:int = -1, param4:Number = 1, param5:Number = 1) : int
      {
         var _loc7_:* = 0;
         var _loc6_:Number = 1 + param2 / 100;
         if(param1 > param3)
         {
            _loc7_ = Math.min(param1,param3 * REWARD_SCALE_CAP);
            return ((1 - REWARD_REDUCED_SCALE) * this.getFixeExperienceReward(param3,param5,param4) + REWARD_REDUCED_SCALE * this.getFixeExperienceReward(_loc7_,param5,param4)) * _loc6_;
         }
         return this.getFixeExperienceReward(param1,param5,param4) * _loc6_;
      }
      
      private function getFixeExperienceReward(param1:int, param2:Number, param3:Number) : Number
      {
         return param1 * Math.pow(100 + 2 * param1,2) / 20 * param2 * param3;
      }
   }
}
