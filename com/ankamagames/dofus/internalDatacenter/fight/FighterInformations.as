package com.ankamagames.dofus.internalDatacenter.fight
{
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.logic.game.fight.frames.*;
    import com.ankamagames.dofus.misc.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.types.game.context.fight.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.tiphon.types.*;
    import com.ankamagames.tiphon.types.look.*;
    import flash.utils.*;

    public class FighterInformations extends Object implements IDataCenter
    {
        private var _fighterId:int;
        private var _look:TiphonEntityLook;
        private var _currentCell:int;
        private var _currentOrientation:int;
        private var _isAlive:Boolean;
        private var _team:String;
        private var _lifePoints:int;
        private var _maxLifePoints:int;
        private var _actionPoints:int;
        private var _movementPoints:int;
        private var _paDodge:int;
        private var _pmDodge:int;
        private var _shieldPoints:int;
        private var _summoner:int;
        private var _summoned:Boolean;
        private var _invisibility:int;
        private var _permanentDamagePercent:int;
        private var _tackleBlock:int;
        private var _airResist:int;
        private var _earthResist:int;
        private var _fireResist:int;
        private var _neutralResist:int;
        private var _waterResist:int;
        private var _airFixedResist:int;
        private var _earthFixedResist:int;
        private var _fireFixedResist:int;
        private var _neutralFixedResist:int;
        private var _waterFixedResist:int;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(FighterInformations));

        public function FighterInformations(param1:int)
        {
            var _loc_2:* = Kernel.getWorker().getFrame(FightContextFrame);
            if (!_loc_2 || !(_loc_2 as FightContextFrame).entitiesFrame)
            {
                return;
            }
            var _loc_3:* = (_loc_2 as FightContextFrame).entitiesFrame.getEntityInfos(param1) as GameFightFighterInformations;
            if (!_loc_3)
            {
                return;
            }
            this._fighterId = param1;
            this._look = EntityLookAdapter.fromNetwork(_loc_3.look);
            this._look = TiphonUtility.getLookWithoutMount(this._look);
            var _loc_4:* = DofusEntities.getEntity(param1);
            if (DofusEntities.getEntity(param1) && _loc_4.position)
            {
                this._currentCell = _loc_4.position.cellId;
            }
            else
            {
                this._currentCell = _loc_3.disposition.cellId;
            }
            this._currentOrientation = _loc_3.disposition.direction;
            this._isAlive = _loc_3.alive;
            switch(_loc_3.teamId)
            {
                case TeamEnum.TEAM_CHALLENGER:
                {
                    this._team = "challenger";
                    break;
                }
                case TeamEnum.TEAM_DEFENDER:
                {
                    this._team = "defender";
                    break;
                }
                case TeamEnum.TEAM_SPECTATOR:
                {
                    this._team = "spectator";
                    break;
                }
                default:
                {
                    _log.warn("Unknown teamId " + _loc_3.teamId + " ?!");
                    this._team = "unknown";
                    break;
                    break;
                }
            }
            this._lifePoints = _loc_3.stats.lifePoints;
            this._maxLifePoints = _loc_3.stats.maxLifePoints;
            this._actionPoints = _loc_3.stats.actionPoints;
            this._movementPoints = _loc_3.stats.movementPoints;
            this._paDodge = _loc_3.stats.dodgePALostProbability;
            this._pmDodge = _loc_3.stats.dodgePMLostProbability;
            this._shieldPoints = _loc_3.stats.shieldPoints;
            this._summoner = _loc_3.stats.summoner;
            this._summoned = _loc_3.stats.summoned;
            this._invisibility = _loc_3.stats.invisibilityState;
            this._permanentDamagePercent = _loc_3.stats.permanentDamagePercent;
            this._tackleBlock = _loc_3.stats.tackleBlock;
            this._airResist = _loc_3.stats.airElementResistPercent;
            this._earthResist = _loc_3.stats.earthElementResistPercent;
            this._fireResist = _loc_3.stats.fireElementResistPercent;
            this._neutralResist = _loc_3.stats.neutralElementResistPercent;
            this._waterResist = _loc_3.stats.waterElementResistPercent;
            this._airFixedResist = _loc_3.stats.airElementReduction;
            this._earthFixedResist = _loc_3.stats.earthElementReduction;
            this._fireFixedResist = _loc_3.stats.fireElementReduction;
            this._neutralFixedResist = _loc_3.stats.neutralElementReduction;
            this._waterFixedResist = _loc_3.stats.waterElementReduction;
            return;
        }// end function

        public function get fighterId() : int
        {
            return this._fighterId;
        }// end function

        public function get look() : TiphonEntityLook
        {
            return this._look;
        }// end function

        public function get currentCell() : int
        {
            return this._currentCell;
        }// end function

        public function get currentOrientation() : int
        {
            return this._currentOrientation;
        }// end function

        public function get isAlive() : Boolean
        {
            return this._isAlive;
        }// end function

        public function get team() : String
        {
            return this._team;
        }// end function

        public function get lifePoints() : int
        {
            return this._lifePoints;
        }// end function

        public function get maxLifePoints() : int
        {
            return this._maxLifePoints;
        }// end function

        public function get actionPoints() : int
        {
            return this._actionPoints;
        }// end function

        public function get movementPoints() : int
        {
            return this._movementPoints;
        }// end function

        public function get paDodge() : int
        {
            return this._paDodge;
        }// end function

        public function get pmDodge() : int
        {
            return this._pmDodge;
        }// end function

        public function get shieldPoints() : int
        {
            return this._shieldPoints;
        }// end function

        public function get summoner() : int
        {
            return this._summoner;
        }// end function

        public function get summoned() : Boolean
        {
            return this._summoned;
        }// end function

        public function get invisibility() : int
        {
            return this._invisibility;
        }// end function

        public function get permanentDamagePercent() : int
        {
            return this._permanentDamagePercent;
        }// end function

        public function get tackleBlock() : int
        {
            return this._tackleBlock;
        }// end function

        public function get airResist() : int
        {
            return this._airResist;
        }// end function

        public function get earthResist() : int
        {
            return this._earthResist;
        }// end function

        public function get fireResist() : int
        {
            return this._fireResist;
        }// end function

        public function get neutralResist() : int
        {
            return this._neutralResist;
        }// end function

        public function get waterResist() : int
        {
            return this._waterResist;
        }// end function

        public function get airFixedResist() : int
        {
            return this._airFixedResist;
        }// end function

        public function get earthFixedResist() : int
        {
            return this._earthFixedResist;
        }// end function

        public function get fireFixedResist() : int
        {
            return this._fireFixedResist;
        }// end function

        public function get neutralFixedResist() : int
        {
            return this._neutralFixedResist;
        }// end function

        public function get waterFixedResist() : int
        {
            return this._waterFixedResist;
        }// end function

    }
}
