package com.ankamagames.dofus.uiApi
{
   import com.ankamagames.berilia.interfaces.IApi;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayInteractivesFrame;
   import com.ankamagames.dofus.logic.game.common.frames.SpellInventoryManagementFrame;
   import com.ankamagames.dofus.logic.game.common.frames.EmoticonFrame;
   import com.ankamagames.dofus.logic.game.roleplay.frames.ZaapFrame;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.dofus.logic.game.roleplay.managers.RoleplayManager;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayContextFrame;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayNamedActorInformations;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class RoleplayApi extends Object implements IApi
   {
      
      public function RoleplayApi() {
         this._log = Log.getLogger(getQualifiedClassName(RoleplayApi));
         super();
      }
      
      private var _module:UiModule;
      
      protected var _log:Logger;
      
      private function get roleplayEntitiesFrame() : RoleplayEntitiesFrame {
         return Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
      }
      
      private function get roleplayInteractivesFrame() : RoleplayInteractivesFrame {
         return Kernel.getWorker().getFrame(RoleplayInteractivesFrame) as RoleplayInteractivesFrame;
      }
      
      private function get spellInventoryManagementFrame() : SpellInventoryManagementFrame {
         return Kernel.getWorker().getFrame(SpellInventoryManagementFrame) as SpellInventoryManagementFrame;
      }
      
      private function get roleplayEmoticonFrame() : EmoticonFrame {
         return Kernel.getWorker().getFrame(EmoticonFrame) as EmoticonFrame;
      }
      
      private function get zaapFrame() : ZaapFrame {
         return Kernel.getWorker().getFrame(ZaapFrame) as ZaapFrame;
      }
      
      public function set module(param1:UiModule) : void {
         this._module = param1;
      }
      
      public function destroy() : void {
         this._module = null;
      }
      
      public function getTotalFightOnCurrentMap() : uint {
         return this.roleplayEntitiesFrame.fightNumber;
      }
      
      public function getSpellToForgetList() : Array {
         var _loc2_:SpellWrapper = null;
         var _loc1_:Array = new Array();
         for each (_loc2_ in PlayedCharacterManager.getInstance().spellsInventory)
         {
            if(_loc2_.spellLevel > 1)
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      public function getEmotesList() : Array {
         var _loc1_:Array = this.roleplayEmoticonFrame.emotesList;
         return _loc1_;
      }
      
      public function getUsableEmotesList() : Array {
         return this.roleplayEmoticonFrame.emotes;
      }
      
      public function getSpawnMap() : uint {
         return this.zaapFrame.spawnMapId;
      }
      
      public function getEntitiesOnCell(param1:int) : Array {
         return EntitiesManager.getInstance().getEntitiesOnCell(param1);
      }
      
      public function getPlayersIdOnCurrentMap() : Array {
         return this.roleplayEntitiesFrame.playersId;
      }
      
      public function getPlayerIsInCurrentMap(param1:int) : Boolean {
         return !(this.roleplayEntitiesFrame.playersId.indexOf(param1) == -1);
      }
      
      public function isUsingInteractive() : Boolean {
         if(!this.roleplayInteractivesFrame)
         {
            return false;
         }
         return this.roleplayInteractivesFrame.usingInteractive;
      }
      
      public function getFight(param1:int) : Object {
         return this.roleplayEntitiesFrame.fights[param1];
      }
      
      public function putEntityOnTop(param1:AnimatedCharacter) : void {
         RoleplayManager.getInstance().putEntityOnTop(param1);
      }
      
      public function getEntityInfos(param1:Object) : Object {
         var _loc2_:RoleplayContextFrame = Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame;
         return _loc2_.entitiesFrame.getEntityInfos(param1.id);
      }
      
      public function getEntityByName(param1:String) : Object {
         var _loc3_:IEntity = null;
         var _loc4_:GameRolePlayNamedActorInformations = null;
         var _loc2_:RoleplayContextFrame = Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame;
         for each (_loc3_ in EntitiesManager.getInstance().entities)
         {
            _loc4_ = _loc2_.entitiesFrame.getEntityInfos(_loc3_.id) as GameRolePlayNamedActorInformations;
            if((_loc4_) && param1 == _loc4_.name)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function switchButtonWrappers(param1:Object, param2:Object) : void {
         var _loc3_:int = param2.position;
         var _loc4_:int = param1.position;
         param2.setPosition(_loc4_);
         param1.setPosition(_loc3_);
      }
      
      public function setButtonWrapperActivation(param1:Object, param2:Boolean) : void {
         param1.active = param2;
      }
   }
}
