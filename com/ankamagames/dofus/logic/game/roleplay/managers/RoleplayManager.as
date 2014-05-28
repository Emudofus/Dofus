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
      
      public function displayCharacterContextualMenu(pGameContextActorInformations:GameContextActorInformations) : Boolean {
         var modContextMenu:Object = UiModuleManager.getInstance().getModule("Ankama_ContextMenu").mainClass;
         var menu:ContextMenuData = MenusFactory.create(pGameContextActorInformations,null,[{"id":pGameContextActorInformations.contextualId}]);
         if(menu)
         {
            modContextMenu.createContextMenu(menu);
            return true;
         }
         return false;
      }
      
      public function displayContextualMenu(pGameContextActorInformations:GameContextActorInformations, pEntity:IInteractive) : Boolean {
         var menu:ContextMenuData = null;
         var modContextMenu:Object = UiModuleManager.getInstance().getModule("Ankama_ContextMenu").mainClass;
         switch(true)
         {
            case pGameContextActorInformations is GameRolePlayMutantInformations:
               if((pGameContextActorInformations as GameRolePlayMutantInformations).humanoidInfo.restrictions.cantAttack)
               {
                  menu = MenusFactory.create(pGameContextActorInformations,null,[pEntity]);
               }
               break;
            case pGameContextActorInformations is GameRolePlayCharacterInformations:
               menu = MenusFactory.create(pGameContextActorInformations,null,[pEntity]);
               break;
            case pGameContextActorInformations is GameRolePlayMerchantInformations:
               menu = MenusFactory.create(pGameContextActorInformations,null,[pEntity]);
               break;
            case pGameContextActorInformations is GameRolePlayNpcInformations:
               menu = MenusFactory.create(pGameContextActorInformations,null,[pEntity]);
               break;
            case pGameContextActorInformations is GameRolePlayTaxCollectorInformations:
               menu = MenusFactory.create(pGameContextActorInformations,null,[pEntity]);
               break;
            case pGameContextActorInformations is GameRolePlayPrismInformations:
               menu = MenusFactory.create(pGameContextActorInformations,null,[pEntity]);
               break;
            case pGameContextActorInformations is GameRolePlayPortalInformations:
               menu = MenusFactory.create(pGameContextActorInformations,null,[pEntity]);
               break;
            case pGameContextActorInformations is GameContextPaddockItemInformations:
               if(this.roleplayContextFrame.currentPaddock.guildIdentity)
               {
                  menu = MenusFactory.create(pGameContextActorInformations,null,[pEntity]);
               }
               break;
            case pGameContextActorInformations is GameRolePlayMountInformations:
               menu = MenusFactory.create(pGameContextActorInformations,null,[pEntity]);
               break;
         }
         if(menu)
         {
            modContextMenu.createContextMenu(menu);
            return true;
         }
         return false;
      }
      
      public function putEntityOnTop(entity:AnimatedCharacter) : void {
         var cellSprite:Sprite = InteractiveCellManager.getInstance().getCell(entity.position.cellId);
         EntitiesDisplayManager.getInstance().orderEntity(entity,cellSprite);
      }
   }
}
