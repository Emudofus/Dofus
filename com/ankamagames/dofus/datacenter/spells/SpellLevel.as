package com.ankamagames.dofus.datacenter.spells
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.datacenter.effects.instances.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.utils.display.spellZone.*;
    import flash.utils.*;

    public class SpellLevel extends Object implements ICellZoneProvider, IDataCenter
    {
        public var id:uint;
        public var spellId:uint;
        public var spellBreed:uint;
        public var apCost:uint;
        public var minRange:uint;
        public var range:uint;
        public var castInLine:Boolean;
        public var castInDiagonal:Boolean;
        public var castTestLos:Boolean;
        public var criticalHitProbability:uint;
        public var criticalFailureProbability:uint;
        public var needFreeCell:Boolean;
        public var needTakenCell:Boolean;
        public var needFreeTrapCell:Boolean;
        public var rangeCanBeBoosted:Boolean;
        public var maxStack:int;
        public var maxCastPerTurn:uint;
        public var maxCastPerTarget:uint;
        public var minCastInterval:uint;
        public var initialCooldown:uint;
        public var globalCooldown:int;
        public var minPlayerLevel:uint;
        public var criticalFailureEndsTurn:Boolean;
        public var hideEffects:Boolean;
        public var hidden:Boolean;
        public var statesRequired:Vector.<int>;
        public var statesForbidden:Vector.<int>;
        public var effects:Vector.<EffectInstanceDice>;
        public var criticalEffect:Vector.<EffectInstanceDice>;
        private var _spell:Spell;
        private var _spellZoneEffects:Vector.<IZoneShape>;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(SpellLevel));
        private static const MODULE:String = "SpellLevels";

        public function SpellLevel()
        {
            return;
        }// end function

        public function get spell() : Spell
        {
            if (!this._spell)
            {
                this._spell = Spell.getSpellById(this.spellId);
            }
            return this._spell;
        }// end function

        public function get minimalRange() : uint
        {
            return this.minRange;
        }// end function

        public function set minimalRange(param1:uint) : void
        {
            this.minRange = param1;
            return;
        }// end function

        public function get maximalRange() : uint
        {
            return this.range;
        }// end function

        public function set maximalRange(param1:uint) : void
        {
            this.range = param1;
            return;
        }// end function

        public function get castZoneInLine() : Boolean
        {
            return this.castInLine;
        }// end function

        public function set castZoneInLine(param1:Boolean) : void
        {
            this.castInLine = param1;
            return;
        }// end function

        public function get castZoneInDiagonal() : Boolean
        {
            return this.castInDiagonal;
        }// end function

        public function set castZoneInDiagonal(param1:Boolean) : void
        {
            this.castInDiagonal = param1;
            return;
        }// end function

        public function get spellZoneEffects() : Vector.<IZoneShape>
        {
            var _loc_1:EffectInstanceDice = null;
            var _loc_2:ZoneEffect = null;
            if (!this._spellZoneEffects)
            {
                this._spellZoneEffects = new Vector.<IZoneShape>;
                for each (_loc_1 in this.effects)
                {
                    
                    _loc_2 = new ZoneEffect(_loc_1.zoneSize, _loc_1.zoneShape);
                    this._spellZoneEffects.push(_loc_2);
                }
            }
            return this._spellZoneEffects;
        }// end function

        public function get canSummon() : Boolean
        {
            var _loc_1:EffectInstanceDice = null;
            for each (_loc_1 in this.effects)
            {
                
                if (_loc_1.effectId == 181 || _loc_1.effectId == 180 || _loc_1.effectId == 1011)
                {
                    return true;
                }
            }
            return false;
        }// end function

        public function get canBomb() : Boolean
        {
            var _loc_1:EffectInstanceDice = null;
            for each (_loc_1 in this.effects)
            {
                
                if (_loc_1.effectId == 1008)
                {
                    return true;
                }
            }
            return false;
        }// end function

        public static function getLevelById(param1:int) : SpellLevel
        {
            return GameData.getObject(MODULE, param1) as SpellLevel;
        }// end function

    }
}
