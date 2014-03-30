package com.ankamagames.dofus.logic.game.fight.managers
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.utils.Dictionary;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.FightHookList;
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   import com.ankamagames.dofus.network.enums.ShortcutBarEnum;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristicsInformations;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.logic.game.fight.types.SpellCastInFightManager;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterSpellModification;
   import com.ankamagames.dofus.datacenter.items.Weapon;
   import com.ankamagames.dofus.datacenter.spells.SpellState;
   import com.ankamagames.dofus.datacenter.spells.Spell;
   import com.ankamagames.dofus.datacenter.spells.SpellLevel;
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.dofus.logic.game.common.misc.SpellModificator;
   import com.ankamagames.dofus.network.enums.CharacterSpellModificationTypeEnum;
   import com.ankamagames.dofus.logic.game.fight.types.castSpellManager.SpellManager;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.logic.game.fight.miscs.FightReachableCellsMaker;
   
   public final class CurrentPlayedFighterManager extends Object
   {
      
      public function CurrentPlayedFighterManager() {
         this._characteristicsInformationsList = new Dictionary();
         this._spellCastInFightManagerList = new Dictionary();
         super();
      }
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(CurrentPlayedFighterManager));
      
      private static var _self:CurrentPlayedFighterManager;
      
      public static function getInstance() : CurrentPlayedFighterManager {
         if(_self == null)
         {
            _self = new CurrentPlayedFighterManager();
            _self.currentFighterId = PlayedCharacterManager.getInstance().id;
         }
         return _self;
      }
      
      private var _currentFighterId:int = 0;
      
      private var _currentFighterIsRealPlayer:Boolean = true;
      
      private var _characteristicsInformationsList:Dictionary;
      
      private var _spellCastInFightManagerList:Dictionary;
      
      public function get currentFighterId() : int {
         return this._currentFighterId;
      }
      
      public function set currentFighterId(id:int) : void {
         if(id == this._currentFighterId)
         {
            return;
         }
         var lastFighterId:int = this._currentFighterId;
         this._currentFighterId = id;
         var playerManager:PlayedCharacterManager = PlayedCharacterManager.getInstance();
         this._currentFighterIsRealPlayer = this._currentFighterId == playerManager.id;
         var lastFighterEntity:AnimatedCharacter = DofusEntities.getEntity(lastFighterId) as AnimatedCharacter;
         if(lastFighterEntity)
         {
            lastFighterEntity.setCanSeeThrough(false);
         }
         var currentFighterEntity:AnimatedCharacter = DofusEntities.getEntity(this._currentFighterId) as AnimatedCharacter;
         if(currentFighterEntity)
         {
            currentFighterEntity.setCanSeeThrough(true);
         }
         if((!(playerManager.id == id)) || (lastFighterId))
         {
            KernelEventsManager.getInstance().processCallback(FightHookList.SlaveStatsList,this.getCharacteristicsInformations());
         }
         if(playerManager.isFighting)
         {
            this.updatePortrait(currentFighterEntity);
         }
      }
      
      public function isRealPlayer() : Boolean {
         return this._currentFighterIsRealPlayer;
      }
      
      public function resetPlayerSpellList() : void {
         var playerManager:PlayedCharacterManager = PlayedCharacterManager.getInstance();
         var inventoryManager:InventoryManager = InventoryManager.getInstance();
         if(playerManager.spellsInventory != playerManager.playerSpellList)
         {
            playerManager.spellsInventory = playerManager.playerSpellList;
            KernelEventsManager.getInstance().processCallback(HookList.SpellList,playerManager.playerSpellList);
         }
         if(inventoryManager.shortcutBarSpells != playerManager.playerShortcutList)
         {
            inventoryManager.shortcutBarSpells = playerManager.playerShortcutList;
            KernelEventsManager.getInstance().processCallback(InventoryHookList.ShortcutBarViewContent,ShortcutBarEnum.SPELL_SHORTCUT_BAR);
         }
      }
      
      public function setCharacteristicsInformations(id:int, characteristics:CharacterCharacteristicsInformations) : void {
         if(PlayedCharacterManager.getInstance().id == id)
         {
            PlayedCharacterManager.getInstance().characteristics = characteristics;
         }
         else
         {
            if(!this._characteristicsInformationsList[id])
            {
               this._characteristicsInformationsList[id] = characteristics;
            }
         }
      }
      
      public function getCharacteristicsInformations(id:int=0) : CharacterCharacteristicsInformations {
         var player:PlayedCharacterManager = PlayedCharacterManager.getInstance();
         if(id)
         {
            if(id == player.id)
            {
               return player.characteristics;
            }
            return this._characteristicsInformationsList[id];
         }
         if((this._currentFighterIsRealPlayer) || (!player.isFighting))
         {
            return player.characteristics;
         }
         return this._characteristicsInformationsList[this._currentFighterId];
      }
      
      public function getSpellById(spellId:uint) : SpellWrapper {
         var thisSpell:SpellWrapper = null;
         var spellKnown:SpellWrapper = null;
         var player:PlayedCharacterManager = PlayedCharacterManager.getInstance();
         for each (spellKnown in player.spellsInventory)
         {
            if(spellKnown.id == spellId)
            {
               return spellKnown;
            }
         }
         return null;
      }
      
      public function getSpellCastManager() : SpellCastInFightManager {
         var scm:SpellCastInFightManager = this._spellCastInFightManagerList[this._currentFighterId];
         if(!scm)
         {
            scm = new SpellCastInFightManager(this._currentFighterId);
            this._spellCastInFightManagerList[this._currentFighterId] = scm;
         }
         return scm;
      }
      
      public function getSpellCastManagerById(id:int) : SpellCastInFightManager {
         var scm:SpellCastInFightManager = this._spellCastInFightManagerList[id];
         if(!scm)
         {
            scm = new SpellCastInFightManager(id);
            this._spellCastInFightManagerList[id] = scm;
         }
         return scm;
      }
      
      public function canCastThisSpell(spellId:uint, lvl:uint, pTargetId:int=2147483647) : Boolean {
         var thisSpell:SpellWrapper = null;
         var spellKnown:SpellWrapper = null;
         var apCost:uint = 0;
         var maxCastPerTurn:uint = 0;
         var spellModification:CharacterSpellModification = null;
         var state:* = 0;
         var stateRequired:* = 0;
         var weapon:Weapon = null;
         var currentState:SpellState = null;
         var weapon2:Weapon = null;
         var numberCastOnTarget:uint = 0;
         var spell:Spell = Spell.getSpellById(spellId);
         var spellLevel:SpellLevel = spell.getSpellLevel(lvl);
         if(spellLevel == null)
         {
            return false;
         }
         var player:PlayedCharacterManager = PlayedCharacterManager.getInstance();
         if(spellLevel.minPlayerLevel > player.infos.level)
         {
            return false;
         }
         for each (spellKnown in player.spellsInventory)
         {
            if(spellKnown.id == spellId)
            {
               thisSpell = spellKnown;
            }
         }
         if(!thisSpell)
         {
            return false;
         }
         var characteristics:CharacterCharacteristicsInformations = this.getCharacteristicsInformations();
         if(!characteristics)
         {
            return false;
         }
         var currentPA:int = characteristics.actionPointsCurrent;
         if((spellId == 0) && (!(player.currentWeapon == null)))
         {
            weapon = Item.getItemById(player.currentWeapon.objectGID) as Weapon;
            if(!weapon)
            {
               return false;
            }
            apCost = weapon.apCost;
            maxCastPerTurn = weapon.maxCastPerTurn;
         }
         else
         {
            apCost = thisSpell.apCost;
            maxCastPerTurn = thisSpell.maxCastPerTurn;
         }
         var spellModifs:SpellModificator = new SpellModificator();
         for each (spellModification in characteristics.spellModifications)
         {
            if(spellModification.spellId == spellId)
            {
               switch(spellModification.modificationType)
               {
                  case CharacterSpellModificationTypeEnum.AP_COST:
                     spellModifs.apCost = spellModification.value;
                     continue;
                  case CharacterSpellModificationTypeEnum.CAST_INTERVAL:
                     spellModifs.castInterval = spellModification.value;
                     continue;
                  case CharacterSpellModificationTypeEnum.CAST_INTERVAL_SET:
                     spellModifs.castIntervalSet = spellModification.value;
                     continue;
                  case CharacterSpellModificationTypeEnum.MAX_CAST_PER_TARGET:
                     spellModifs.maxCastPerTarget = spellModification.value;
                     continue;
                  case CharacterSpellModificationTypeEnum.MAX_CAST_PER_TURN:
                     spellModifs.maxCastPerTurn = spellModification.value;
                     continue;
               }
            }
            else
            {
               continue;
            }
         }
         if(apCost > currentPA)
         {
            return false;
         }
         var states:Array = FightersStateManager.getInstance().getStates(this._currentFighterId);
         if(!states)
         {
            states = new Array();
         }
         for each (state in states)
         {
            currentState = SpellState.getSpellStateById(state);
            if((currentState.preventsFight) && (spellId == 0))
            {
               return false;
            }
            if((currentState.id == 101) && (spellId == 0))
            {
               weapon2 = Item.getItemById(player.currentWeapon.objectGID) as Weapon;
               if(weapon2.typeId != 2)
               {
                  return false;
               }
            }
            if((spellLevel.statesForbidden) && (!(spellLevel.statesForbidden.indexOf(state) == -1)))
            {
               return false;
            }
            if(currentState.preventsSpellCast)
            {
               if(spellLevel.statesRequired)
               {
                  if(spellLevel.statesRequired.indexOf(state) == -1)
                  {
                     return false;
                  }
                  continue;
               }
               return false;
            }
         }
         for each (stateRequired in spellLevel.statesRequired)
         {
            if(states.indexOf(stateRequired) == -1)
            {
               return false;
            }
         }
         if((spellLevel.canSummon) && (!player.canSummon()))
         {
            return false;
         }
         if((spellLevel.canBomb) && (!player.canBomb()))
         {
            return false;
         }
         if(!player.isFighting)
         {
            return true;
         }
         var spellCastManager:SpellCastInFightManager = this.getSpellCastManager();
         var spellManager:SpellManager = spellCastManager.getSpellManagerBySpellId(spellId);
         if(spellManager == null)
         {
            return true;
         }
         if((maxCastPerTurn <= spellManager.numberCastThisTurn) && (maxCastPerTurn > 0))
         {
            return false;
         }
         if((spellManager.cooldown > 0) || (thisSpell.actualCooldown > 0))
         {
            return false;
         }
         numberCastOnTarget = spellManager.getCastOnEntity(pTargetId);
         if((spellLevel.maxCastPerTarget + spellModifs.getTotalBonus(spellModifs.maxCastPerTarget) <= numberCastOnTarget) && (spellLevel.maxCastPerTarget > 0))
         {
            return false;
         }
         return true;
      }
      
      public function endFight() : void {
         if(PlayedCharacterManager.getInstance().id != this._currentFighterId)
         {
            this.currentFighterId = PlayedCharacterManager.getInstance().id;
            this.resetPlayerSpellList();
            this.updatePortrait(DofusEntities.getEntity(this._currentFighterId) as AnimatedCharacter);
         }
         this._currentFighterId = 0;
         this._characteristicsInformationsList = new Dictionary();
         this._spellCastInFightManagerList = new Dictionary();
      }
      
      public function getSpellModifications(spellId:int, carac:int) : CharacterSpellModification {
         var spellModification:CharacterSpellModification = null;
         var characteristics:CharacterCharacteristicsInformations = this.getCharacteristicsInformations();
         if(characteristics)
         {
            for each (spellModification in characteristics.spellModifications)
            {
               if((spellModification.spellId == spellId) && (spellModification.modificationType == carac))
               {
                  return spellModification;
               }
            }
         }
         return null;
      }
      
      public function canPlay() : Boolean {
         var _loc5_:FightEntitiesFrame = null;
         var _loc6_:GameFightFighterInformations = null;
         var _loc7_:FightReachableCellsMaker = null;
         var _loc8_:PlayedCharacterManager = null;
         var _loc9_:SpellWrapper = null;
         var _loc10_:Weapon = null;
         return true;
      }
      
      private function updatePortrait(currentFighterEntity:AnimatedCharacter) : void {
         if(this._currentFighterIsRealPlayer)
         {
            KernelEventsManager.getInstance().processCallback(FightHookList.ShowMonsterArtwork,0);
         }
         else
         {
            if(currentFighterEntity)
            {
               KernelEventsManager.getInstance().processCallback(FightHookList.ShowMonsterArtwork,currentFighterEntity.look.getBone());
            }
         }
      }
   }
}
