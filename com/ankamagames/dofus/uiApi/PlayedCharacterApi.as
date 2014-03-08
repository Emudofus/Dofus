package com.ankamagames.dofus.uiApi
{
   import com.ankamagames.berilia.interfaces.IApi;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristicsInformations;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.network.types.game.character.choice.CharacterBaseInformations;
   import com.ankamagames.dofus.misc.EntityLookAdapter;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import com.ankamagames.dofus.network.enums.SubEntityBindingPointCategoryEnum;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
   import com.ankamagames.dofus.datacenter.appearance.Title;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayCharacterInformations;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.frames.TinselFrame;
   import com.ankamagames.dofus.network.types.game.context.roleplay.HumanOptionTitle;
   import com.ankamagames.dofus.datacenter.appearance.Ornament;
   import com.ankamagames.dofus.logic.game.common.frames.AbstractEntitiesFrame;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
   import com.ankamagames.dofus.logic.game.roleplay.types.CharacterTooltipInformation;
   import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
   import com.ankamagames.dofus.logic.game.fight.frames.FightPreparationFrame;
   import com.ankamagames.dofus.network.types.game.character.restriction.ActorRestrictionsInformations;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayContextFrame;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayActorInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayMutantInformations;
   import com.ankamagames.dofus.logic.game.common.managers.EntitiesLooksManager;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterSpellModification;
   import com.ankamagames.dofus.network.types.game.house.AccountHouseInformations;
   import com.ankamagames.dofus.logic.common.frames.MiscFrame;
   import com.ankamagames.dofus.internalDatacenter.world.WorldPointWrapper;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.network.enums.PlayerLifeStatusEnum;
   import com.ankamagames.dofus.types.data.PlayerSetInfo;
   import com.ankamagames.dofus.logic.game.common.frames.PlayedCharacterUpdatesFrame;
   import com.ankamagames.dofus.internalDatacenter.items.WeaponWrapper;
   import com.ankamagames.dofus.datacenter.spells.SpellLevel;
   import com.ankamagames.dofus.datacenter.spells.Spell;
   import com.ankamagames.jerakine.logger.Log;
   import avmplus.getQualifiedClassName;
   
   public class PlayedCharacterApi extends Object implements IApi
   {
      
      public function PlayedCharacterApi() {
         super();
         MEMORY_LOG[this] = 1;
      }
      
      public static var MEMORY_LOG:Dictionary = new Dictionary(true);
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(PlayedCharacterApi));
      
      public static function characteristics() : CharacterCharacteristicsInformations {
         return PlayedCharacterManager.getInstance().characteristics;
      }
      
      public static function getPlayedCharacterInfo() : Object {
         var _loc1_:CharacterBaseInformations = PlayedCharacterManager.getInstance().infos;
         if(!_loc1_)
         {
            return null;
         }
         var _loc2_:Object = new Object();
         _loc2_.id = _loc1_.id;
         _loc2_.breed = _loc1_.breed;
         _loc2_.level = _loc1_.level;
         _loc2_.sex = _loc1_.sex;
         _loc2_.name = _loc1_.name;
         _loc2_.entityLook = EntityLookAdapter.fromNetwork(_loc1_.entityLook);
         _loc2_.realEntityLook = _loc2_.entityLook;
         if((isCreature()) && (PlayedCharacterManager.getInstance().realEntityLook))
         {
            _loc2_.entityLook = EntityLookAdapter.fromNetwork(PlayedCharacterManager.getInstance().realEntityLook);
         }
         var _loc3_:TiphonEntityLook = TiphonEntityLook(_loc2_.entityLook).getSubEntity(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,0);
         if(_loc3_)
         {
            if(_loc3_.getBone() == 2)
            {
               _loc3_.setBone(1);
            }
            _loc2_.entityLook = _loc3_;
         }
         return _loc2_;
      }
      
      public static function getCurrentEntityLook() : Object {
         var _loc1_:TiphonEntityLook = null;
         var _loc2_:AnimatedCharacter = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id) as AnimatedCharacter;
         if(_loc2_)
         {
            _loc1_ = _loc2_.look.clone();
         }
         else
         {
            _loc1_ = EntityLookAdapter.fromNetwork(PlayedCharacterManager.getInstance().infos.entityLook);
         }
         return _loc1_;
      }
      
      public static function getInventory() : Vector.<ItemWrapper> {
         return InventoryManager.getInstance().realInventory;
      }
      
      public static function getEquipment() : Array {
         var _loc2_:* = undefined;
         var _loc1_:Array = new Array();
         for each (_loc2_ in PlayedCharacterManager.getInstance().inventory)
         {
            if(_loc2_.position <= 15)
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      public static function getSpellInventory() : Array {
         return PlayedCharacterManager.getInstance().spellsInventory;
      }
      
      public static function getJobs() : Array {
         return PlayedCharacterManager.getInstance().jobs;
      }
      
      public static function getMount() : Object {
         return PlayedCharacterManager.getInstance().mount;
      }
      
      public static function getTitle() : Title {
         var _loc2_:Title = null;
         var _loc3_:GameRolePlayCharacterInformations = null;
         var _loc4_:* = undefined;
         var _loc5_:Title = null;
         var _loc1_:int = (Kernel.getWorker().getFrame(TinselFrame) as TinselFrame).currentTitle;
         if(_loc1_)
         {
            _loc2_ = Title.getTitleById(_loc1_);
            return _loc2_;
         }
         _loc3_ = getEntityInfos();
         if((_loc3_) && (_loc3_.humanoidInfo))
         {
            for each (_loc4_ in _loc3_.humanoidInfo.options)
            {
               if(_loc4_ is HumanOptionTitle)
               {
                  _loc1_ = _loc4_.titleId;
               }
            }
            _loc5_ = Title.getTitleById(_loc1_);
            return _loc5_;
         }
         return null;
      }
      
      public static function getOrnament() : Ornament {
         var _loc2_:Ornament = null;
         var _loc1_:int = (Kernel.getWorker().getFrame(TinselFrame) as TinselFrame).currentOrnament;
         if(_loc1_)
         {
            _loc2_ = Ornament.getOrnamentById(_loc1_);
            return _loc2_;
         }
         return null;
      }
      
      public static function getKnownTitles() : Vector.<uint> {
         return (Kernel.getWorker().getFrame(TinselFrame) as TinselFrame).knownTitles;
      }
      
      public static function getKnownOrnaments() : Vector.<uint> {
         return (Kernel.getWorker().getFrame(TinselFrame) as TinselFrame).knownOrnaments;
      }
      
      public static function titlesOrnamentsAskedBefore() : Boolean {
         return (Kernel.getWorker().getFrame(TinselFrame) as TinselFrame).titlesOrnamentsAskedBefore;
      }
      
      public static function getEntityInfos() : GameRolePlayCharacterInformations {
         var _loc1_:AbstractEntitiesFrame = null;
         if(isInFight())
         {
            _loc1_ = Kernel.getWorker().getFrame(FightEntitiesFrame) as AbstractEntitiesFrame;
         }
         else
         {
            _loc1_ = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as AbstractEntitiesFrame;
         }
         if(!_loc1_)
         {
            return null;
         }
         var _loc2_:GameRolePlayCharacterInformations = _loc1_.getEntityInfos(PlayedCharacterManager.getInstance().id) as GameRolePlayCharacterInformations;
         return _loc2_;
      }
      
      public static function getEntityTooltipInfos() : CharacterTooltipInformation {
         var _loc1_:GameRolePlayCharacterInformations = getEntityInfos();
         if(!_loc1_)
         {
            return null;
         }
         var _loc2_:CharacterTooltipInformation = new CharacterTooltipInformation(_loc1_,0);
         return _loc2_;
      }
      
      public static function inventoryWeight() : uint {
         return PlayedCharacterManager.getInstance().inventoryWeight;
      }
      
      public static function inventoryWeightMax() : uint {
         return PlayedCharacterManager.getInstance().inventoryWeightMax;
      }
      
      public static function isIncarnation() : Boolean {
         return PlayedCharacterManager.getInstance().isIncarnation;
      }
      
      public static function isInHouse() : Boolean {
         return PlayedCharacterManager.getInstance().isInHouse;
      }
      
      public static function isInExchange() : Boolean {
         return PlayedCharacterManager.getInstance().isInExchange;
      }
      
      public static function isInFight() : Boolean {
         return !(Kernel.getWorker().getFrame(FightContextFrame) == null);
      }
      
      public static function isInPreFight() : Boolean {
         return !(Kernel.getWorker().getFrame(FightPreparationFrame) == null);
      }
      
      public static function isInParty() : Boolean {
         return PlayedCharacterManager.getInstance().isInParty;
      }
      
      public static function isPartyLeader() : Boolean {
         return PlayedCharacterManager.getInstance().isPartyLeader;
      }
      
      public static function isRidding() : Boolean {
         return PlayedCharacterManager.getInstance().isRidding;
      }
      
      public static function isPetsMounting() : Boolean {
         return PlayedCharacterManager.getInstance().isPetsMounting;
      }
      
      public static function hasCompanion() : Boolean {
         return PlayedCharacterManager.getInstance().hasCompanion;
      }
      
      public static function id() : uint {
         return PlayedCharacterManager.getInstance().id;
      }
      
      public static function restrictions() : ActorRestrictionsInformations {
         return PlayedCharacterManager.getInstance().restrictions;
      }
      
      public static function isMutant() : Boolean {
         var _loc1_:RoleplayContextFrame = Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame;
         var _loc2_:GameRolePlayActorInformations = _loc1_.entitiesFrame.getEntityInfos(PlayedCharacterManager.getInstance().id) as GameRolePlayActorInformations;
         return _loc2_ is GameRolePlayMutantInformations;
      }
      
      public static function publicMode() : Boolean {
         return PlayedCharacterManager.getInstance().publicMode;
      }
      
      public static function artworkId() : int {
         return PlayedCharacterManager.getInstance().artworkId;
      }
      
      public static function isCreature() : Boolean {
         return EntitiesLooksManager.getInstance().isCreature(id());
      }
      
      public static function getBone() : uint {
         var _loc1_:CharacterBaseInformations = PlayedCharacterManager.getInstance().infos;
         return EntityLookAdapter.fromNetwork(_loc1_.entityLook).getBone();
      }
      
      public static function getSkin() : uint {
         var _loc1_:CharacterBaseInformations = PlayedCharacterManager.getInstance().infos;
         if((EntityLookAdapter.fromNetwork(_loc1_.entityLook)) && (EntityLookAdapter.fromNetwork(_loc1_.entityLook).getSkins()) && EntityLookAdapter.fromNetwork(_loc1_.entityLook).getSkins().length > 0)
         {
            return EntityLookAdapter.fromNetwork(_loc1_.entityLook).getSkins()[0];
         }
         return 0;
      }
      
      public static function getColors() : Object {
         var _loc1_:CharacterBaseInformations = PlayedCharacterManager.getInstance().infos;
         return EntityLookAdapter.fromNetwork(_loc1_.entityLook).getColors();
      }
      
      public static function getSubentityColors() : Object {
         var _loc1_:CharacterBaseInformations = PlayedCharacterManager.getInstance().infos;
         var _loc2_:TiphonEntityLook = EntityLookAdapter.fromNetwork(_loc1_.entityLook).getSubEntity(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,0);
         if(!_loc2_ && (PlayedCharacterManager.getInstance().realEntityLook))
         {
            _loc2_ = EntityLookAdapter.fromNetwork(PlayedCharacterManager.getInstance().realEntityLook).getSubEntity(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,0);
         }
         return _loc2_?_loc2_.getColors():null;
      }
      
      public static function getAlignmentSide() : int {
         return PlayedCharacterManager.getInstance().characteristics.alignmentInfos.alignmentSide;
      }
      
      public static function getAlignmentValue() : uint {
         return PlayedCharacterManager.getInstance().characteristics.alignmentInfos.alignmentValue;
      }
      
      public static function getAlignmentAggressableStatus() : uint {
         return PlayedCharacterManager.getInstance().characteristics.alignmentInfos.aggressable;
      }
      
      public static function getAlignmentGrade() : uint {
         return PlayedCharacterManager.getInstance().characteristics.alignmentInfos.alignmentGrade;
      }
      
      public static function getMaxSummonedCreature() : uint {
         return PlayedCharacterManager.getInstance().characteristics.summonableCreaturesBoost.base + PlayedCharacterManager.getInstance().characteristics.summonableCreaturesBoost.objectsAndMountBonus + PlayedCharacterManager.getInstance().characteristics.summonableCreaturesBoost.alignGiftBonus + PlayedCharacterManager.getInstance().characteristics.summonableCreaturesBoost.contextModif;
      }
      
      public static function getCurrentSummonedCreature() : uint {
         return PlayedCharacterManager.getInstance().currentSummonedCreature;
      }
      
      public static function canSummon() : Boolean {
         return getMaxSummonedCreature() >= getCurrentSummonedCreature() + 1;
      }
      
      public static function getSpell(param1:uint) : SpellWrapper {
         return CurrentPlayedFighterManager.getInstance().getSpellById(param1);
      }
      
      public static function canCastThisSpell(param1:uint, param2:uint) : Boolean {
         return CurrentPlayedFighterManager.getInstance().canCastThisSpell(param1,param2);
      }
      
      public static function canCastThisSpellOnTarget(param1:uint, param2:uint, param3:int) : Boolean {
         return CurrentPlayedFighterManager.getInstance().canCastThisSpell(param1,param2,param3);
      }
      
      public static function getSpellModification(param1:uint, param2:int) : int {
         var _loc3_:CharacterSpellModification = CurrentPlayedFighterManager.getInstance().getSpellModifications(param1,param2);
         if((_loc3_) && (_loc3_.value))
         {
            return _loc3_.value.alignGiftBonus + _loc3_.value.base + _loc3_.value.contextModif + _loc3_.value.objectsAndMountBonus;
         }
         return 0;
      }
      
      public static function isInHisHouse() : Boolean {
         return PlayedCharacterManager.getInstance().isInHisHouse;
      }
      
      public static function getPlayerHouses() : Vector.<AccountHouseInformations> {
         return (Kernel.getWorker().getFrame(MiscFrame) as MiscFrame).accountHouses;
      }
      
      public static function currentMap() : WorldPointWrapper {
         return PlayedCharacterManager.getInstance().currentMap;
      }
      
      public static function currentSubArea() : SubArea {
         return PlayedCharacterManager.getInstance().currentSubArea;
      }
      
      public static function state() : uint {
         return PlayedCharacterManager.getInstance().state;
      }
      
      public static function isAlive() : Boolean {
         return PlayedCharacterManager.getInstance().state == PlayerLifeStatusEnum.STATUS_ALIVE_AND_KICKING;
      }
      
      public static function getFollowingPlayerId() : int {
         return PlayedCharacterManager.getInstance().followingPlayerId;
      }
      
      public static function getPlayerSet(param1:uint) : PlayerSetInfo {
         return PlayedCharacterUpdatesFrame(Kernel.getWorker().getFrame(PlayedCharacterUpdatesFrame)).getPlayerSet(param1);
      }
      
      public static function getWeapon() : WeaponWrapper {
         return PlayedCharacterManager.getInstance().currentWeapon;
      }
      
      public static function getExperienceBonusPercent() : int {
         return PlayedCharacterManager.getInstance().experiencePercent;
      }
      
      public static function knowSpell(param1:uint) : int {
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:SpellWrapper = null;
         var _loc8_:* = false;
         var _loc9_:SpellWrapper = null;
         var _loc10_:SpellLevel = null;
         var _loc2_:Spell = Spell.getSpellById(param1);
         var _loc3_:SpellLevel = SpellLevel.getLevelById(param1);
         if(param1 == 0)
         {
            _loc4_ = 0;
         }
         else
         {
            _loc10_ = _loc2_.getSpellLevel(1);
            _loc4_ = _loc10_.minPlayerLevel;
         }
         var _loc5_:Array = getSpellInventory();
         for each (_loc7_ in _loc5_)
         {
            if(_loc7_.spellId == param1)
            {
               _loc6_ = _loc7_.spellLevel;
            }
         }
         _loc8_ = true;
         for each (_loc9_ in _loc5_)
         {
            if(_loc9_.spellId == param1)
            {
               _loc8_ = false;
            }
         }
         if(_loc8_)
         {
            return -1;
         }
         return _loc6_;
      }
   }
}
