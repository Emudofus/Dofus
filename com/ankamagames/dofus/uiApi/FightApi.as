package com.ankamagames.dofus.uiApi
{
    import __AS3__.vec.*;
    import com.ankamagames.berilia.interfaces.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.berilia.utils.errors.*;
    import com.ankamagames.dofus.datacenter.effects.*;
    import com.ankamagames.dofus.datacenter.effects.instances.*;
    import com.ankamagames.dofus.datacenter.spells.*;
    import com.ankamagames.dofus.internalDatacenter.fight.*;
    import com.ankamagames.dofus.internalDatacenter.spells.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.fight.frames.*;
    import com.ankamagames.dofus.logic.game.fight.managers.*;
    import com.ankamagames.dofus.logic.game.fight.types.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.types.game.character.characteristic.*;
    import com.ankamagames.dofus.network.types.game.context.fight.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import flash.utils.*;

    public class FightApi extends Object implements IApi
    {
        protected var _log:Logger;
        private var _module:UiModule;
        private static var UNKNOWN_FIGHTER_NAME:String = "???";

        public function FightApi()
        {
            this._log = Log.getLogger(getQualifiedClassName(FightApi));
            return;
        }// end function

        public function set module(param1:UiModule) : void
        {
            this._module = param1;
            return;
        }// end function

        public function destroy() : void
        {
            this._module = null;
            return;
        }// end function

        public function getFighterInformations(param1:int) : FighterInformations
        {
            var _loc_2:* = new FighterInformations(param1);
            return _loc_2;
        }// end function

        public function getFighterName(param1:int) : String
        {
            var fighterId:* = param1;
            try
            {
                return this.getFightFrame().getFighterName(fighterId);
            }
            catch (apiErr:ApiError)
            {
                return UNKNOWN_FIGHTER_NAME;
            }
            return null;
        }// end function

        public function getFighterLevel(param1:int) : uint
        {
            return this.getFightFrame().getFighterLevel(param1);
        }// end function

        public function getFighters() : Vector.<int>
        {
            if (Kernel.getWorker().getFrame(FightBattleFrame) && !Kernel.getWorker().getFrame(FightPreparationFrame))
            {
                return this.getFightFrame().battleFrame.fightersList;
            }
            return this.getFightFrame().entitiesFrame.getOrdonnedPreFighters();
        }// end function

        public function getMonsterId(param1:int) : int
        {
            var _loc_2:* = this.getFighterInfos(param1);
            if (_loc_2 is GameFightMonsterInformations)
            {
                return GameFightMonsterInformations(_loc_2).creatureGenericId;
            }
            return -1;
        }// end function

        public function getDeadFighters() : Vector.<int>
        {
            if (Kernel.getWorker().getFrame(FightBattleFrame))
            {
                return this.getFightFrame().battleFrame.deadFightersList;
            }
            return new Vector.<int>;
        }// end function

        public function getFightType() : uint
        {
            return this.getFightFrame().fightType;
        }// end function

        public function getBuffList(param1:int) : Array
        {
            return BuffManager.getInstance().getAllBuff(param1);
        }// end function

        public function getBuffById(param1:uint, param2:int) : BasicBuff
        {
            return BuffManager.getInstance().getBuff(param1, param2);
        }// end function

        public function createEffectsWrapper(param1:Spell, param2:Array, param3:String) : EffectsWrapper
        {
            return new EffectsWrapper(param2, param1, param3);
        }// end function

        public function getCastingSpellBuffEffects(param1:int, param2:uint) : EffectsWrapper
        {
            var _loc_5:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_3:* = new Array();
            var _loc_4:* = BuffManager.getInstance().getAllBuff(param1);
            var _loc_6:* = new Array();
            for each (_loc_7 in _loc_4)
            {
                
                if (_loc_7.castingSpell.castingSpellId == param2)
                {
                    _loc_9 = _loc_7.effects;
                    if (_loc_9.trigger && _loc_9 is EffectInstanceInteger)
                    {
                        _loc_10 = _loc_9 as EffectInstanceInteger;
                        if (_loc_6[_loc_10.effectId + "," + _loc_10.value])
                        {
                            continue;
                        }
                        else
                        {
                            _loc_6[_loc_10.effectId + "," + _loc_10.value] = true;
                            _loc_3.push(_loc_9);
                        }
                    }
                    else
                    {
                        _loc_3.push(_loc_9);
                    }
                    if (!_loc_5)
                    {
                        _loc_5 = _loc_7.castingSpell.spell;
                    }
                }
            }
            _loc_8 = new EffectsWrapper(_loc_3, _loc_5, "");
            return _loc_8;
        }// end function

        public function getAllBuffEffects(param1:int) : EffectsListWrapper
        {
            return new EffectsListWrapper(BuffManager.getInstance().getAllBuff(param1));
        }// end function

        public function isCastingSpell() : Boolean
        {
            return Kernel.getWorker().contains(FightSpellCastFrame);
        }// end function

        public function cancelSpell() : void
        {
            if (Kernel.getWorker().contains(FightSpellCastFrame))
            {
                Kernel.getWorker().removeFrame(Kernel.getWorker().getFrame(FightSpellCastFrame));
            }
            return;
        }// end function

        public function getChallengeList() : Array
        {
            return this.getFightFrame().challengesList;
        }// end function

        public function getCurrentPlayedFighterId() : int
        {
            return CurrentPlayedFighterManager.getInstance().currentFighterId;
        }// end function

        public function getCurrentPlayedCharacteristicsInformations() : CharacterCharacteristicsInformations
        {
            return CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations();
        }// end function

        public function preFightIsActive() : Boolean
        {
            return FightContextFrame.preFightIsActive;
        }// end function

        public function isWaitingBeforeFight() : Boolean
        {
            if (this.getFightFrame().fightType == FightTypeEnum.FIGHT_TYPE_PvMA || this.getFightFrame().fightType == FightTypeEnum.FIGHT_TYPE_PvT)
            {
                return true;
            }
            return false;
        }// end function

        public function isFightLeader() : Boolean
        {
            return this.getFightFrame().isFightLeader;
        }// end function

        public function isSpectator() : Boolean
        {
            return PlayedCharacterManager.getInstance().isSpectator;
        }// end function

        public function isDematerializated() : Boolean
        {
            return this.getFightFrame().entitiesFrame.dematerialization;
        }// end function

        public function getTurnsCount() : int
        {
            return this.getFightFrame().battleFrame.turnsCount;
        }// end function

        private function getFighterInfos(param1:int) : GameFightFighterInformations
        {
            return this.getFightFrame().entitiesFrame.getEntityInfos(param1) as GameFightFighterInformations;
        }// end function

        private function getFightFrame() : FightContextFrame
        {
            var _loc_1:* = Kernel.getWorker().getFrame(FightContextFrame);
            if (!_loc_1)
            {
                throw new ApiError("Unallowed call of FightApi method while not fighting.");
            }
            return _loc_1 as FightContextFrame;
        }// end function

        private function getFighterTeam(param1:GameFightFighterInformations) : String
        {
            switch(param1.teamId)
            {
                case TeamEnum.TEAM_CHALLENGER:
                {
                    return "challenger";
                }
                case TeamEnum.TEAM_DEFENDER:
                {
                    return "defender";
                }
                case TeamEnum.TEAM_SPECTATOR:
                {
                    return "spectator";
                }
                default:
                {
                    this._log.warn("Unknown teamId " + param1.teamId + " ?!");
                    return "unknown";
                    break;
                }
            }
        }// end function

    }
}
