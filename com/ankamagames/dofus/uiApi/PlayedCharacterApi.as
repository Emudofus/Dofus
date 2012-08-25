package com.ankamagames.dofus.uiApi
{
    import __AS3__.vec.*;
    import com.ankamagames.berilia.interfaces.*;
    import com.ankamagames.dofus.datacenter.breeds.*;
    import com.ankamagames.dofus.datacenter.spells.*;
    import com.ankamagames.dofus.datacenter.world.*;
    import com.ankamagames.dofus.internalDatacenter.items.*;
    import com.ankamagames.dofus.internalDatacenter.spells.*;
    import com.ankamagames.dofus.internalDatacenter.world.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.common.frames.*;
    import com.ankamagames.dofus.logic.game.common.frames.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.fight.frames.*;
    import com.ankamagames.dofus.logic.game.fight.managers.*;
    import com.ankamagames.dofus.logic.game.roleplay.frames.*;
    import com.ankamagames.dofus.misc.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.types.game.character.characteristic.*;
    import com.ankamagames.dofus.network.types.game.character.choice.*;
    import com.ankamagames.dofus.network.types.game.character.restriction.*;
    import com.ankamagames.dofus.network.types.game.context.roleplay.*;
    import com.ankamagames.dofus.types.data.*;
    import com.ankamagames.tiphon.types.look.*;
    import flash.utils.*;

    public class PlayedCharacterApi extends Object implements IApi
    {
        public static var MEMORY_LOG:Dictionary = new Dictionary(true);

        public function PlayedCharacterApi()
        {
            MEMORY_LOG[this] = 1;
            return;
        }// end function

        public static function characteristics() : CharacterCharacteristicsInformations
        {
            return PlayedCharacterManager.getInstance().characteristics;
        }// end function

        public static function getPlayedCharacterInfo() : Object
        {
            var _loc_1:* = PlayedCharacterManager.getInstance().infos;
            if (!_loc_1)
            {
                return null;
            }
            var _loc_2:* = new Object();
            _loc_2.id = _loc_1.id;
            _loc_2.breed = _loc_1.breed;
            _loc_2.level = _loc_1.level;
            _loc_2.sex = _loc_1.sex;
            _loc_2.name = _loc_1.name;
            _loc_2.entityLook = EntityLookAdapter.fromNetwork(_loc_1.entityLook);
            _loc_2.realEntityLook = EntityLookAdapter.fromNetwork(_loc_1.entityLook);
            var _loc_3:* = TiphonEntityLook(_loc_2.entityLook).getSubEntity(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER, 0);
            if (_loc_3)
            {
                if (_loc_3.getBone() == 2)
                {
                    _loc_3.setBone(1);
                }
                _loc_2.entityLook = _loc_3;
            }
            return _loc_2;
        }// end function

        public static function getInventory() : Vector.<ItemWrapper>
        {
            return InventoryManager.getInstance().realInventory;
        }// end function

        public static function getEquipment() : Array
        {
            var _loc_2:* = undefined;
            var _loc_1:* = new Array();
            for each (_loc_2 in PlayedCharacterManager.getInstance().inventory)
            {
                
                if (_loc_2.position <= 15)
                {
                    _loc_1.push(_loc_2);
                }
            }
            return _loc_1;
        }// end function

        public static function getSpellInventory() : Array
        {
            return PlayedCharacterManager.getInstance().spellsInventory;
        }// end function

        public static function getJobs() : Array
        {
            return PlayedCharacterManager.getInstance().jobs;
        }// end function

        public static function getMount() : Object
        {
            return PlayedCharacterManager.getInstance().mount;
        }// end function

        public static function inventoryWeight() : uint
        {
            return PlayedCharacterManager.getInstance().inventoryWeight;
        }// end function

        public static function inventoryWeightMax() : uint
        {
            return PlayedCharacterManager.getInstance().inventoryWeightMax;
        }// end function

        public static function isIncarnation() : Boolean
        {
            return PlayedCharacterManager.getInstance().isIncarnation;
        }// end function

        public static function isInHouse() : Boolean
        {
            return PlayedCharacterManager.getInstance().isInHouse;
        }// end function

        public static function isInExchange() : Boolean
        {
            return PlayedCharacterManager.getInstance().isInExchange;
        }// end function

        public static function isInFight() : Boolean
        {
            return Kernel.getWorker().getFrame(FightContextFrame) != null;
        }// end function

        public static function isInPreFight() : Boolean
        {
            return Kernel.getWorker().getFrame(FightPreparationFrame) != null;
        }// end function

        public static function isInParty() : Boolean
        {
            return PlayedCharacterManager.getInstance().isInParty;
        }// end function

        public static function isPartyLeader() : Boolean
        {
            return PlayedCharacterManager.getInstance().isPartyLeader;
        }// end function

        public static function isRidding() : Boolean
        {
            return PlayedCharacterManager.getInstance().isRidding;
        }// end function

        public static function isPetsMounting() : Boolean
        {
            return PlayedCharacterManager.getInstance().isPetsMounting;
        }// end function

        public static function id() : uint
        {
            return PlayedCharacterManager.getInstance().id;
        }// end function

        public static function restrictions() : ActorRestrictionsInformations
        {
            return PlayedCharacterManager.getInstance().restrictions;
        }// end function

        public static function isMutant() : Boolean
        {
            var _loc_1:* = Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame;
            var _loc_2:* = _loc_1.entitiesFrame.getEntityInfos(PlayedCharacterManager.getInstance().id) as GameRolePlayActorInformations;
            return _loc_2 is GameRolePlayMutantInformations;
        }// end function

        public static function publicMode() : Boolean
        {
            return PlayedCharacterManager.getInstance().publicMode;
        }// end function

        public static function artworkId() : int
        {
            return PlayedCharacterManager.getInstance().artworkId;
        }// end function

        public static function isCreature() : Boolean
        {
            var _loc_2:Breed = null;
            var _loc_1:* = getBone();
            for each (_loc_2 in Breed.getBreeds())
            {
                
                if (_loc_2.creatureBonesId == _loc_1)
                {
                    return true;
                }
            }
            return false;
        }// end function

        public static function getBone() : uint
        {
            var _loc_1:* = PlayedCharacterManager.getInstance().infos;
            return EntityLookAdapter.fromNetwork(_loc_1.entityLook).getBone();
        }// end function

        public static function getSkin() : uint
        {
            var _loc_1:* = PlayedCharacterManager.getInstance().infos;
            if (EntityLookAdapter.fromNetwork(_loc_1.entityLook) && EntityLookAdapter.fromNetwork(_loc_1.entityLook).getSkins() && EntityLookAdapter.fromNetwork(_loc_1.entityLook).getSkins().length > 0)
            {
                return EntityLookAdapter.fromNetwork(_loc_1.entityLook).getSkins()[0];
            }
            return 0;
        }// end function

        public static function getColors() : Object
        {
            var _loc_1:* = PlayedCharacterManager.getInstance().infos;
            return EntityLookAdapter.fromNetwork(_loc_1.entityLook).getColors();
        }// end function

        public static function getSubentityColors() : Object
        {
            var _loc_1:* = PlayedCharacterManager.getInstance().infos;
            var _loc_2:* = EntityLookAdapter.fromNetwork(_loc_1.entityLook).getSubEntity(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER, 0);
            return _loc_2.getColors();
        }// end function

        public static function getAlignmentSide() : int
        {
            return PlayedCharacterManager.getInstance().characteristics.alignmentInfos.alignmentSide;
        }// end function

        public static function getAlignmentValue() : uint
        {
            return PlayedCharacterManager.getInstance().characteristics.alignmentInfos.alignmentValue;
        }// end function

        public static function getAlignmentGrade() : uint
        {
            return PlayedCharacterManager.getInstance().characteristics.alignmentInfos.alignmentGrade;
        }// end function

        public static function getMaxSummonedCreature() : uint
        {
            return PlayedCharacterManager.getInstance().characteristics.summonableCreaturesBoost.base + PlayedCharacterManager.getInstance().characteristics.summonableCreaturesBoost.objectsAndMountBonus + PlayedCharacterManager.getInstance().characteristics.summonableCreaturesBoost.alignGiftBonus + PlayedCharacterManager.getInstance().characteristics.summonableCreaturesBoost.contextModif;
        }// end function

        public static function getCurrentSummonedCreature() : uint
        {
            return PlayedCharacterManager.getInstance().currentSummonedCreature;
        }// end function

        public static function canSummon() : Boolean
        {
            return getMaxSummonedCreature() >= (getCurrentSummonedCreature() + 1);
        }// end function

        public static function getSpell(param1:uint) : SpellWrapper
        {
            return CurrentPlayedFighterManager.getInstance().getSpellById(param1);
        }// end function

        public static function canCastThisSpell(param1:uint, param2:uint) : Boolean
        {
            return CurrentPlayedFighterManager.getInstance().canCastThisSpell(param1, param2);
        }// end function

        public static function canCastThisSpellOnTarget(param1:uint, param2:uint, param3:int) : Boolean
        {
            return CurrentPlayedFighterManager.getInstance().canCastThisSpell(param1, param2, param3);
        }// end function

        public static function getSpellModification(param1:uint, param2:int) : int
        {
            var _loc_3:* = CurrentPlayedFighterManager.getInstance().getSpellModifications(param1, param2);
            if (_loc_3 && _loc_3.value)
            {
                return _loc_3.value.alignGiftBonus + _loc_3.value.base + _loc_3.value.contextModif + _loc_3.value.objectsAndMountBonus;
            }
            return 0;
        }// end function

        public static function isInHisHouse() : Boolean
        {
            return PlayedCharacterManager.getInstance().isInHisHouse;
        }// end function

        public static function getPlayerHouses() : Vector.<AccountHouseInformations>
        {
            return (Kernel.getWorker().getFrame(MiscFrame) as MiscFrame).accountHouses;
        }// end function

        public static function currentMap() : WorldPointWrapper
        {
            return PlayedCharacterManager.getInstance().currentMap;
        }// end function

        public static function currentSubArea() : SubArea
        {
            return PlayedCharacterManager.getInstance().currentSubArea;
        }// end function

        public static function state() : uint
        {
            return PlayedCharacterManager.getInstance().state;
        }// end function

        public static function isAlive() : Boolean
        {
            return PlayedCharacterManager.getInstance().state == PlayerLifeStatusEnum.STATUS_ALIVE_AND_KICKING;
        }// end function

        public static function getFollowingPlayerId() : int
        {
            return PlayedCharacterManager.getInstance().followingPlayerId;
        }// end function

        public static function getPlayerSet(param1:uint) : PlayerSetInfo
        {
            return PlayedCharacterUpdatesFrame(Kernel.getWorker().getFrame(PlayedCharacterUpdatesFrame)).getPlayerSet(param1);
        }// end function

        public static function getWeapon() : WeaponWrapper
        {
            return PlayedCharacterManager.getInstance().currentWeapon;
        }// end function

        public static function getExperienceBonusPercent() : uint
        {
            return PlayedCharacterManager.getInstance().experiencePercent;
        }// end function

        public static function knowSpell(param1:uint) : int
        {
            var _loc_4:uint = 0;
            var _loc_6:uint = 0;
            var _loc_7:SpellWrapper = null;
            var _loc_8:Boolean = false;
            var _loc_9:SpellWrapper = null;
            var _loc_10:uint = 0;
            var _loc_11:SpellLevel = null;
            var _loc_2:* = Spell.getSpellById(param1);
            var _loc_3:* = SpellLevel.getLevelById(param1);
            if (param1 == 0)
            {
                _loc_4 = 0;
            }
            else
            {
                _loc_10 = _loc_2.spellLevels[0];
                _loc_11 = SpellLevel.getLevelById(_loc_10);
                _loc_4 = _loc_11.minPlayerLevel;
            }
            var _loc_5:* = getSpellInventory();
            for each (_loc_7 in _loc_5)
            {
                
                if (_loc_7.spellId == param1)
                {
                    _loc_6 = _loc_7.spellLevel;
                    continue;
                }
            }
            _loc_8 = true;
            for each (_loc_9 in _loc_5)
            {
                
                if (_loc_9.spellId == param1)
                {
                    _loc_8 = false;
                    continue;
                }
            }
            if (_loc_8)
            {
                return -1;
            }
            return _loc_6;
        }// end function

    }
}
