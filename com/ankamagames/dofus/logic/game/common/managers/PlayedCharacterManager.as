package com.ankamagames.dofus.logic.game.common.managers
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.datacenter.world.*;
    import com.ankamagames.dofus.internalDatacenter.items.*;
    import com.ankamagames.dofus.internalDatacenter.world.*;
    import com.ankamagames.dofus.misc.*;
    import com.ankamagames.dofus.network.types.game.character.characteristic.*;
    import com.ankamagames.dofus.network.types.game.character.choice.*;
    import com.ankamagames.dofus.network.types.game.character.restriction.*;
    import com.ankamagames.dofus.network.types.game.data.items.effects.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import com.ankamagames.tiphon.types.look.*;
    import flash.geom.*;
    import flash.utils.*;

    public class PlayedCharacterManager extends Object implements IDestroyable
    {
        private var _isPartyLeader:Boolean = false;
        private var _followingPlayerId:int = -1;
        public var infos:CharacterBaseInformations;
        public var restrictions:ActorRestrictionsInformations;
        public var characteristics:CharacterCharacteristicsInformations;
        public var spellsInventory:Array;
        public var playerSpellList:Array;
        public var playerShortcutList:Array;
        public var inventory:Vector.<ItemWrapper>;
        public var currentWeapon:WeaponWrapper;
        public var inventoryWeight:uint;
        public var inventoryWeightMax:uint;
        public var currentMap:WorldPointWrapper;
        public var currentSubArea:SubArea;
        public var jobs:Array;
        public var isInExchange:Boolean = false;
        public var isInHisHouse:Boolean = false;
        public var isInHouse:Boolean = false;
        public var lastCoord:Point;
        public var isInParty:Boolean = false;
        public var state:uint;
        public var publicMode:Boolean = false;
        public var isRidding:Boolean = false;
        public var isPetsMounting:Boolean = false;
        public var mount:Object;
        public var currentSummonedCreature:uint = 0;
        public var currentSummonedBomb:uint = 0;
        public var isFighting:Boolean = false;
        public var teamId:int = 0;
        public var isSpectator:Boolean = false;
        public var experiencePercent:int = 0;
        private static var _self:PlayedCharacterManager;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(PlayedCharacterManager));

        public function PlayedCharacterManager()
        {
            this.lastCoord = new Point(0, 0);
            if (_self != null)
            {
                throw new SingletonError("PlayedCharacterManager is a singleton and should not be instanciated directly.");
            }
            return;
        }// end function

        public function get id() : int
        {
            if (this.infos)
            {
                return this.infos.id;
            }
            return 0;
        }// end function

        public function get cantMinimize() : Boolean
        {
            return this.restrictions.cantMinimize;
        }// end function

        public function get forceSlowWalk() : Boolean
        {
            return this.restrictions.forceSlowWalk;
        }// end function

        public function get cantUseTaxCollector() : Boolean
        {
            return this.restrictions.cantUseTaxCollector;
        }// end function

        public function get cantTrade() : Boolean
        {
            return this.restrictions.cantTrade;
        }// end function

        public function get cantRun() : Boolean
        {
            return this.restrictions.cantRun;
        }// end function

        public function get cantMove() : Boolean
        {
            return this.restrictions.cantMove;
        }// end function

        public function get cantBeChallenged() : Boolean
        {
            return this.restrictions.cantBeChallenged;
        }// end function

        public function get cantBeAttackedByMutant() : Boolean
        {
            return this.restrictions.cantBeAttackedByMutant;
        }// end function

        public function get cantBeAggressed() : Boolean
        {
            return this.restrictions.cantBeAggressed;
        }// end function

        public function get cantAttack() : Boolean
        {
            return this.restrictions.cantAttack;
        }// end function

        public function get cantAgress() : Boolean
        {
            return this.restrictions.cantAggress;
        }// end function

        public function get cantChallenge() : Boolean
        {
            return this.restrictions.cantChallenge;
        }// end function

        public function get cantExchange() : Boolean
        {
            return this.restrictions.cantExchange;
        }// end function

        public function get cantChat() : Boolean
        {
            return this.restrictions.cantChat;
        }// end function

        public function get cantBeMerchant() : Boolean
        {
            return this.restrictions.cantBeMerchant;
        }// end function

        public function get cantUseObject() : Boolean
        {
            return this.restrictions.cantUseObject;
        }// end function

        public function get cantUseInteractiveObject() : Boolean
        {
            return this.restrictions.cantUseInteractive;
        }// end function

        public function get cantSpeakToNpc() : Boolean
        {
            return this.restrictions.cantSpeakToNPC;
        }// end function

        public function get cantChangeZone() : Boolean
        {
            return this.restrictions.cantChangeZone;
        }// end function

        public function get cantAttackMonster() : Boolean
        {
            return this.restrictions.cantAttackMonster;
        }// end function

        public function get cantWalkInEightDirections() : Boolean
        {
            return this.restrictions.cantWalk8Directions;
        }// end function

        public function get isIncarnation() : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_1:* = InventoryManager.getInstance().inventory.getView("equipment");
            for each (_loc_2 in _loc_1.content)
            {
                
                if (_loc_2)
                {
                    for each (_loc_3 in _loc_2.effectsList)
                    {
                        
                        if (_loc_3.actionId == 669)
                        {
                            return true;
                        }
                    }
                }
            }
            return false;
        }// end function

        public function set isPartyLeader(param1:Boolean) : void
        {
            if (!this.isInParty)
            {
                this._isPartyLeader = false;
            }
            else
            {
                this._isPartyLeader = param1;
            }
            return;
        }// end function

        public function get isPartyLeader() : Boolean
        {
            return this._isPartyLeader;
        }// end function

        public function get artworkId() : uint
        {
            return this.infos.entityLook.bonesId == 1 ? (this.infos.entityLook.skins[0]) : (this.infos.entityLook.bonesId);
        }// end function

        public function get followingPlayerId() : int
        {
            return this._followingPlayerId;
        }// end function

        public function set followingPlayerId(param1:int) : void
        {
            this._followingPlayerId = param1;
            return;
        }// end function

        public function destroy() : void
        {
            _self = null;
            return;
        }// end function

        public function get tiphonEntityLook() : TiphonEntityLook
        {
            return EntityLookAdapter.fromNetwork(this.infos.entityLook);
        }// end function

        public function resetSummonedCreature() : void
        {
            this.currentSummonedCreature = 0;
            return;
        }// end function

        public function addSummonedCreature() : void
        {
            (this.currentSummonedCreature + 1);
            return;
        }// end function

        public function removeSummonedCreature() : void
        {
            if (this.currentSummonedCreature > 0)
            {
                (this.currentSummonedCreature - 1);
            }
            return;
        }// end function

        private function getMaxSummonedCreature() : uint
        {
            return this.characteristics.summonableCreaturesBoost.base + this.characteristics.summonableCreaturesBoost.objectsAndMountBonus + this.characteristics.summonableCreaturesBoost.alignGiftBonus + this.characteristics.summonableCreaturesBoost.contextModif;
        }// end function

        private function getCurrentSummonedCreature() : uint
        {
            return this.currentSummonedCreature;
        }// end function

        public function canSummon() : Boolean
        {
            return this.getMaxSummonedCreature() > this.getCurrentSummonedCreature();
        }// end function

        public function resetSummonedBomb() : void
        {
            this.currentSummonedBomb = 0;
            return;
        }// end function

        public function addSummonedBomb() : void
        {
            (this.currentSummonedBomb + 1);
            return;
        }// end function

        public function removeSummonedBomb() : void
        {
            if (this.currentSummonedBomb > 0)
            {
                (this.currentSummonedBomb - 1);
            }
            return;
        }// end function

        private function getMaxSummonedBomb() : uint
        {
            return 3;
        }// end function

        public function canBomb() : Boolean
        {
            return this.getMaxSummonedBomb() > this.currentSummonedBomb;
        }// end function

        public function levelDiff(param1:uint) : int
        {
            var _loc_3:* = 0;
            var _loc_2:* = this.infos.level;
            var _loc_4:* = 1;
            if (param1 < _loc_2)
            {
                _loc_4 = -1;
            }
            if (Math.abs(param1 - _loc_2) > 20)
            {
                _loc_3 = 1 * _loc_4;
            }
            else if (param1 < _loc_2)
            {
                if (param1 / _loc_2 < 1.2)
                {
                    _loc_3 = 0;
                }
                else
                {
                    _loc_3 = 1 * _loc_4;
                }
            }
            else if (_loc_2 / param1 < 1.2)
            {
                _loc_3 = 0;
            }
            else
            {
                _loc_3 = 1 * _loc_4;
            }
            return _loc_3;
        }// end function

        public static function getInstance() : PlayedCharacterManager
        {
            if (_self == null)
            {
                _self = new PlayedCharacterManager;
            }
            return _self;
        }// end function

    }
}
