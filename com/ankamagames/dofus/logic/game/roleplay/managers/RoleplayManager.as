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
   import com.ankamagames.dofus.logic.game.roleplay.types.GameContextPaddockItemInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayMountInformations;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.atouin.managers.InteractiveCellManager;
   import flash.display.Sprite;
   import com.ankamagames.atouin.managers.EntitiesDisplayManager;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   
   public class RoleplayManager extends Object implements IDestroyable
   {
      
      public function RoleplayManager() {
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
      
      public static function getInstance() : RoleplayManager {
         if(_self == null)
         {
            _self = new RoleplayManager();
         }
         return _self;
      }
      
      public var dofusTimeYearLag:int;
      
      private function get roleplayContextFrame() : RoleplayContextFrame {
         return Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame;
      }
      
      public function destroy() : void {
         _self = null;
      }
      
      public function displayCharacterContextualMenu(param1:GameContextActorInformations) : Boolean {
         var _loc2_:Object = UiModuleManager.getInstance().getModule("Ankama_ContextMenu").mainClass;
         var _loc3_:ContextMenuData = MenusFactory.create(param1,null,[{"id":param1.contextualId}]);
         if(_loc3_)
         {
            _loc2_.createContextMenu(_loc3_);
            return true;
         }
         return false;
      }
      
      public function displayContextualMenu(param1:GameContextActorInformations, param2:IInteractive) : Boolean {
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
      
      public function putEntityOnTop(param1:AnimatedCharacter) : void {
         var _loc2_:Sprite = InteractiveCellManager.getInstance().getCell(param1.position.cellId);
         EntitiesDisplayManager.getInstance().orderEntity(param1,_loc2_);
      }
   }
}
