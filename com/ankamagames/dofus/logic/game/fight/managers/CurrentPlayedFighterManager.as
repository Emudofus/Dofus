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
      
      public function set currentFighterId(param1:int) : void {
         if(param1 == this._currentFighterId)
         {
            return;
         }
         var _loc2_:int = this._currentFighterId;
         this._currentFighterId = param1;
         var _loc3_:PlayedCharacterManager = PlayedCharacterManager.getInstance();
         this._currentFighterIsRealPlayer = this._currentFighterId == _loc3_.id;
         var _loc4_:AnimatedCharacter = DofusEntities.getEntity(_loc2_) as AnimatedCharacter;
         if(_loc4_)
         {
            _loc4_.setCanSeeThrough(false);
         }
         var _loc5_:AnimatedCharacter = DofusEntities.getEntity(this._currentFighterId) as AnimatedCharacter;
         if(_loc5_)
         {
            _loc5_.setCanSeeThrough(true);
         }
         if(!(_loc3_.id == param1) || (_loc2_))
         {
            KernelEventsManager.getInstance().processCallback(FightHookList.SlaveStatsList,this.getCharacteristicsInformations());
         }
         if(_loc3_.isFighting)
         {
            this.updatePortrait(_loc5_);
         }
      }
      
      public function isRealPlayer() : Boolean {
         return this._currentFighterIsRealPlayer;
      }
      
      public function resetPlayerSpellList() : void {
         var _loc1_:PlayedCharacterManager = PlayedCharacterManager.getInstance();
         var _loc2_:InventoryManager = InventoryManager.getInstance();
         if(_loc1_.spellsInventory != _loc1_.playerSpellList)
         {
            _loc1_.spellsInventory = _loc1_.playerSpellList;
            KernelEventsManager.getInstance().processCallback(HookList.SpellList,_loc1_.playerSpellList);
         }
         if(_loc2_.shortcutBarSpells != _loc1_.playerShortcutList)
         {
            _loc2_.shortcutBarSpells = _loc1_.playerShortcutList;
            KernelEventsManager.getInstance().processCallback(InventoryHookList.ShortcutBarViewContent,ShortcutBarEnum.SPELL_SHORTCUT_BAR);
         }
      }
      
      public function setCharacteristicsInformations(param1:int, param2:CharacterCharacteristicsInformations) : void {
         this._characteristicsInformationsList[param1] = param2;
      }
      
      public function getCharacteristicsInformations() : CharacterCharacteristicsInformations {
         var _loc1_:PlayedCharacterManager = PlayedCharacterManager.getInstance();
         if((this._currentFighterIsRealPlayer) || !_loc1_.isFighting)
         {
            return _loc1_.characteristics;
         }
         return this._characteristicsInformationsList[this._currentFighterId];
      }
      
      public function getSpellById(param1:uint) : SpellWrapper {
         var _loc2_:SpellWrapper = null;
         var _loc4_:SpellWrapper = null;
         var _loc3_:PlayedCharacterManager = PlayedCharacterManager.getInstance();
         for each (_loc4_ in _loc3_.spellsInventory)
         {
            if(_loc4_.id == param1)
            {
               return _loc4_;
            }
         }
         return null;
      }
      
      public function getSpellCastManager() : SpellCastInFightManager {
         var _loc1_:SpellCastInFightManager = this._spellCastInFightManagerList[this._currentFighterId];
         if(!_loc1_)
         {
            _loc1_ = new SpellCastInFightManager(this._currentFighterId);
            this._spellCastInFightManagerList[this._currentFighterId] = _loc1_;
         }
         return _loc1_;
      }
      
      public function getSpellCastManagerById(param1:int) : SpellCastInFightManager {
         var _loc2_:SpellCastInFightManager = this._spellCastInFightManagerList[param1];
         if(!_loc2_)
         {
            _loc2_ = new SpellCastInFightManager(param1);
            this._spellCastInFightManagerList[param1] = _loc2_;
         }
         return _loc2_;
      }
      
      public function canCastThisSpell(param1:uint, param2:uint, param3:int=2147483647) : Boolean {
         var _loc6_:SpellWrapper = null;
         var _loc8_:SpellWrapper = null;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc14_:CharacterSpellModification = null;
         var _loc16_:* = 0;
         var _loc17_:* = 0;
         var _loc20_:Weapon = null;
         var _loc21_:SpellState = null;
         var _loc22_:Weapon = null;
         var _loc23_:uint = 0;
         var _loc4_:Spell = Spell.getSpellById(param1);
         var _loc5_:SpellLevel = _loc4_.getSpellLevel(param2);
         if(_loc5_ == null)
         {
            return false;
         }
         var _loc7_:PlayedCharacterManager = PlayedCharacterManager.getInstance();
         if(_loc5_.minPlayerLevel > _loc7_.infos.level)
         {
            return false;
         }
         for each (_loc8_ in _loc7_.spellsInventory)
         {
            if(_loc8_.id == param1)
            {
               _loc6_ = _loc8_;
            }
         }
         if(!_loc6_)
         {
            return false;
         }
         var _loc9_:CharacterCharacteristicsInformations = this.getCharacteristicsInformations();
         if(!_loc9_)
         {
            return false;
         }
         var _loc10_:int = _loc9_.actionPointsCurrent;
         if(param1 == 0 && !(_loc7_.currentWeapon == null))
         {
            _loc20_ = Item.getItemById(_loc7_.currentWeapon.objectGID) as Weapon;
            if(!_loc20_)
            {
               return false;
            }
            _loc11_ = _loc20_.apCost;
            _loc12_ = _loc20_.maxCastPerTurn;
         }
         else
         {
            _loc11_ = _loc6_.apCost;
            _loc12_ = _loc6_.maxCastPerTurn;
         }
         var _loc13_:SpellModificator = new SpellModificator();
         for each (_loc14_ in _loc9_.spellModifications)
         {
            if(_loc14_.spellId == param1)
            {
               switch(_loc14_.modificationType)
               {
                  case CharacterSpellModificationTypeEnum.AP_COST:
                     _loc13_.apCost = _loc14_.value;
                     continue;
                  case CharacterSpellModificationTypeEnum.CAST_INTERVAL:
                     _loc13_.castInterval = _loc14_.value;
                     continue;
                  case CharacterSpellModificationTypeEnum.CAST_INTERVAL_SET:
                     _loc13_.castIntervalSet = _loc14_.value;
                     continue;
                  case CharacterSpellModificationTypeEnum.MAX_CAST_PER_TARGET:
                     _loc13_.maxCastPerTarget = _loc14_.value;
                     continue;
                  case CharacterSpellModificationTypeEnum.MAX_CAST_PER_TURN:
                     _loc13_.maxCastPerTurn = _loc14_.value;
                     continue;
                  default:
                     continue;
               }
            }
            else
            {
               continue;
            }
         }
         if(_loc11_ > _loc10_)
         {
            return false;
         }
         var _loc15_:Array = FightersStateManager.getInstance().getStates(this._currentFighterId);
         if(!_loc15_)
         {
            _loc15_ = new Array();
         }
         for each (_loc16_ in _loc15_)
         {
            _loc21_ = SpellState.getSpellStateById(_loc16_);
            if((_loc21_.preventsFight) && param1 == 0)
            {
               return false;
            }
            if(_loc21_.id == 101 && param1 == 0)
            {
               _loc22_ = Item.getItemById(_loc7_.currentWeapon.objectGID) as Weapon;
               if(_loc22_.typeId != 2)
               {
                  return false;
               }
            }
            if((_loc5_.statesForbidden) && !(_loc5_.statesForbidden.indexOf(_loc16_) == -1))
            {
               return false;
            }
            if(_loc21_.preventsSpellCast)
            {
               if(_loc5_.statesRequired)
               {
                  if(_loc5_.statesRequired.indexOf(_loc16_) == -1)
                  {
                     return false;
                  }
                  continue;
               }
               return false;
            }
         }
         for each (_loc17_ in _loc5_.statesRequired)
         {
            if(_loc15_.indexOf(_loc17_) == -1)
            {
               return false;
            }
         }
         if((_loc5_.canSummon) && !_loc7_.canSummon())
         {
            return false;
         }
         if((_loc5_.canBomb) && !_loc7_.canBomb())
         {
            return false;
         }
         if(!_loc7_.isFighting)
         {
            return true;
         }
         var _loc18_:SpellCastInFightManager = this.getSpellCastManager();
         var _loc19_:SpellManager = _loc18_.getSpellManagerBySpellId(param1);
         if(_loc19_ == null)
         {
            return true;
         }
         if(_loc12_ <= _loc19_.numberCastThisTurn && _loc12_ > 0)
         {
            return false;
         }
         if(_loc19_.cooldown > 0 || _loc6_.actualCooldown > 0)
         {
            return false;
         }
         _loc23_ = _loc19_.getCastOnEntity(param3);
         if(_loc5_.maxCastPerTarget + _loc13_.getTotalBonus(_loc13_.maxCastPerTarget) <= _loc23_ && _loc5_.maxCastPerTarget > 0)
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
      
      public function getSpellModifications(param1:int, param2:int) : CharacterSpellModification {
         var _loc4_:CharacterSpellModification = null;
         var _loc3_:CharacterCharacteristicsInformations = this.getCharacteristicsInformations();
         if(_loc3_)
         {
            for each (_loc4_ in _loc3_.spellModifications)
            {
               if(_loc4_.spellId == param1 && _loc4_.modificationType == param2)
               {
                  return _loc4_;
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
      
      private function updatePortrait(param1:AnimatedCharacter) : void {
         if(this._currentFighterIsRealPlayer)
         {
            KernelEventsManager.getInstance().processCallback(FightHookList.ShowMonsterArtwork,0);
         }
         else
         {
            if(param1)
            {
               KernelEventsManager.getInstance().processCallback(FightHookList.ShowMonsterArtwork,param1.look.getBone());
            }
         }
      }
   }
}
