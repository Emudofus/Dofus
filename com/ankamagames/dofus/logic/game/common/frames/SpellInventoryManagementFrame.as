package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.logic.game.roleplay.actions.SpellSetPositionAction;
   import com.ankamagames.dofus.network.messages.game.inventory.spells.SpellListMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.SlaveSwitchContextMessage;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightSpellCooldown;
   import com.ankamagames.dofus.network.types.game.data.items.SpellItem;
   import com.ankamagames.dofus.datacenter.breeds.Breed;
   import com.ankamagames.dofus.datacenter.spells.Spell;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.logic.game.fight.types.SpellCastInFightManager;
   import com.ankamagames.dofus.logic.game.fight.types.castSpellManager.SpellManager;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   import com.ankamagames.dofus.network.enums.ShortcutBarEnum;
   import __AS3__.vec.*;
   
   public class SpellInventoryManagementFrame extends Object implements Frame
   {
      
      public function SpellInventoryManagementFrame() {
         this._fullSpellList = new Array();
         this._spellsGlobalCooldowns = new Dictionary();
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SpellInventoryManagementFrame));
      
      private var _fullSpellList:Array;
      
      private var _spellsGlobalCooldowns:Dictionary;
      
      public function get priority() : int {
         return Priority.NORMAL;
      }
      
      public function pushed() : Boolean {
         return true;
      }
      
      public function process(param1:Message) : Boolean {
         var _loc2_:SpellSetPositionAction = null;
         var _loc3_:SpellListMessage = null;
         var _loc4_:* = 0;
         var _loc5_:Array = null;
         var _loc6_:SlaveSwitchContextMessage = null;
         var _loc7_:* = 0;
         var _loc8_:Vector.<GameFightSpellCooldown> = null;
         var _loc9_:InventoryManagementFrame = null;
         var _loc10_:SpellItem = null;
         var _loc11_:Breed = null;
         var _loc12_:Spell = null;
         var _loc13_:SpellItem = null;
         var _loc14_:GameFightSpellCooldown = null;
         var _loc15_:SpellWrapper = null;
         var _loc16_:uint = 0;
         var _loc17_:* = 0;
         var _loc18_:SpellCastInFightManager = null;
         var _loc19_:SpellManager = null;
         var _loc20_:* = false;
         switch(true)
         {
            case param1 is SpellSetPositionAction:
               _loc2_ = param1 as SpellSetPositionAction;
               return true;
            case param1 is SpellListMessage:
               _loc3_ = param1 as SpellListMessage;
               _loc4_ = PlayedCharacterManager.getInstance().id;
               this._fullSpellList[_loc4_] = new Array();
               _loc5_ = new Array();
               for each (_loc10_ in _loc3_.spells)
               {
                  this._fullSpellList[_loc4_].push(SpellWrapper.create(_loc10_.position,_loc10_.spellId,_loc10_.spellLevel,true,PlayedCharacterManager.getInstance().id));
                  _loc5_.push(_loc10_.spellId);
               }
               if(_loc3_.spellPrevisualization)
               {
                  _loc11_ = Breed.getBreedById(PlayedCharacterManager.getInstance().infos.breed);
                  for each (_loc12_ in _loc11_.breedSpells)
                  {
                     if(_loc5_.indexOf(_loc12_.id) == -1)
                     {
                        this._fullSpellList[_loc4_].push(SpellWrapper.create(1,_loc12_.id,0,true,PlayedCharacterManager.getInstance().id));
                     }
                  }
               }
               PlayedCharacterManager.getInstance().spellsInventory = this._fullSpellList[_loc4_];
               PlayedCharacterManager.getInstance().playerSpellList = this._fullSpellList[_loc4_];
               KernelEventsManager.getInstance().processCallback(HookList.SpellList,this._fullSpellList[_loc4_]);
               return true;
            case param1 is SlaveSwitchContextMessage:
               _loc6_ = param1 as SlaveSwitchContextMessage;
               _loc7_ = _loc6_.slaveId;
               this._fullSpellList[_loc7_] = new Array();
               for each (_loc13_ in _loc6_.slaveSpells)
               {
                  this._fullSpellList[_loc7_].push(SpellWrapper.create(_loc13_.position,_loc13_.spellId,_loc13_.spellLevel,true,_loc7_));
               }
               PlayedCharacterManager.getInstance().spellsInventory = this._fullSpellList[_loc7_];
               CurrentPlayedFighterManager.getInstance().setCharacteristicsInformations(_loc7_,_loc6_.slaveStats);
               if(CurrentPlayedFighterManager.getInstance().getSpellCastManagerById(_loc7_).needCooldownUpdate)
               {
                  CurrentPlayedFighterManager.getInstance().getSpellCastManagerById(_loc7_).updateCooldowns();
               }
               _loc8_ = this._spellsGlobalCooldowns[_loc7_];
               if(_loc8_)
               {
                  for each (_loc14_ in _loc8_)
                  {
                     _loc18_ = CurrentPlayedFighterManager.getInstance().getSpellCastManagerById(_loc7_);
                     _loc17_ = _loc14_.cooldown;
                     _loc20_ = false;
                     for each (_loc15_ in this._fullSpellList[_loc7_])
                     {
                        if(_loc15_.spellId == _loc14_.spellId)
                        {
                           _loc20_ = true;
                           _loc16_ = _loc15_.spellLevel;
                           if(_loc17_ == -1)
                           {
                              _loc17_ = _loc15_.spellLevelInfos.minCastInterval;
                           }
                           break;
                        }
                     }
                     if(_loc20_)
                     {
                        if(!_loc18_.getSpellManagerBySpellId(_loc14_.spellId))
                        {
                           _loc18_.castSpell(_loc14_.spellId,_loc16_,[],false);
                        }
                        _loc19_ = _loc18_.getSpellManagerBySpellId(_loc14_.spellId);
                        _loc19_.forceCooldown(_loc17_);
                     }
                  }
                  _loc8_.length = 0;
                  delete this._spellsGlobalCooldowns[[_loc7_]];
               }
               KernelEventsManager.getInstance().processCallback(HookList.SpellList,this._fullSpellList[_loc7_]);
               _loc9_ = Kernel.getWorker().getFrame(InventoryManagementFrame) as InventoryManagementFrame;
               InventoryManager.getInstance().shortcutBarSpells = _loc9_.getWrappersFromShortcuts(_loc6_.shortcuts);
               KernelEventsManager.getInstance().processCallback(InventoryHookList.ShortcutBarViewContent,ShortcutBarEnum.SPELL_SHORTCUT_BAR);
               return false;
            default:
               return false;
         }
      }
      
      public function pulled() : Boolean {
         return true;
      }
      
      public function getFullSpellListByOwnerId(param1:int) : Array {
         return this._fullSpellList[param1];
      }
      
      public function addSpellGlobalCoolDownInfo(param1:int, param2:GameFightSpellCooldown) : void {
         if(!this._spellsGlobalCooldowns[param1])
         {
            this._spellsGlobalCooldowns[param1] = new Vector.<GameFightSpellCooldown>(0);
         }
         this._spellsGlobalCooldowns[param1].push(param2);
      }
      
      public function deleteSpellsGlobalCoolDownsData() : void {
         var _loc1_:* = undefined;
         for (_loc1_ in this._spellsGlobalCooldowns)
         {
            this._spellsGlobalCooldowns[_loc1_].length = 0;
            delete this._spellsGlobalCooldowns[[_loc1_]];
         }
      }
   }
}
