package com.ankamagames.dofus.uiApi
{
    import com.ankamagames.berilia.interfaces.IApi;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.berilia.types.data.UiModule;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.internalDatacenter.fight.FighterInformations;
    import com.ankamagames.berilia.utils.errors.ApiError;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.game.fight.frames.FightPreparationFrame;
    import com.ankamagames.dofus.logic.game.fight.frames.FightBattleFrame;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightMonsterInformations;
    import com.ankamagames.dofus.logic.game.fight.managers.BuffManager;
    import com.ankamagames.dofus.logic.game.fight.types.BasicBuff;
    import com.ankamagames.dofus.internalDatacenter.spells.EffectsWrapper;
    import com.ankamagames.dofus.datacenter.spells.Spell;
    import com.ankamagames.dofus.datacenter.effects.EffectInstance;
    import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceInteger;
    import com.ankamagames.dofus.internalDatacenter.spells.EffectsListWrapper;
    import com.ankamagames.dofus.logic.game.fight.frames.FightSpellCastFrame;
    import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
    import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristicsInformations;
    import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
    import com.ankamagames.dofus.network.enums.FightTypeEnum;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
    import com.ankamagames.jerakine.messages.Frame;
    import flash.utils.Dictionary;
    import com.ankamagames.dofus.network.enums.TeamEnum;
    import __AS3__.vec.*;

    [InstanciedApi]
    public class FightApi implements IApi 
    {

        private static var UNKNOWN_FIGHTER_NAME:String = "???";

        protected var _log:Logger;
        private var _module:UiModule;

        public function FightApi()
        {
            this._log = Log.getLogger(getQualifiedClassName(FightApi));
            super();
        }

        [ApiData(name="module")]
        public function set module(value:UiModule):void
        {
            this._module = value;
        }

        [Trusted]
        public function destroy():void
        {
            this._module = null;
        }

        [Untrusted]
        public function getFighterInformations(fighterId:int):FighterInformations
        {
            var fighterInfos:FighterInformations = new FighterInformations(fighterId);
            return (fighterInfos);
        }

        [Untrusted]
        public function getFighterName(fighterId:int):String
        {
            try
            {
                return (this.getFightFrame().getFighterName(fighterId));
            }
            catch(apiErr:ApiError)
            {
                return (UNKNOWN_FIGHTER_NAME);
            };
            return (null);
        }

        [Untrusted]
        public function getFighterLevel(fighterId:int):uint
        {
            return (this.getFightFrame().getFighterLevel(fighterId));
        }

        [Untrusted]
        public function getFighters():Vector.<int>
        {
            if (((Kernel.getWorker().getFrame(FightBattleFrame)) && (!(Kernel.getWorker().getFrame(FightPreparationFrame)))))
            {
                return (this.getFightFrame().battleFrame.fightersList);
            };
            return (this.getFightFrame().entitiesFrame.getOrdonnedPreFighters());
        }

        [Untrusted]
        public function getMonsterId(id:int):int
        {
            var gffi:GameFightFighterInformations = this.getFighterInfos(id);
            if ((gffi is GameFightMonsterInformations))
            {
                return (GameFightMonsterInformations(gffi).creatureGenericId);
            };
            return (-1);
        }

        [Untrusted]
        public function getDeadFighters():Vector.<int>
        {
            if (Kernel.getWorker().getFrame(FightBattleFrame))
            {
                return (this.getFightFrame().battleFrame.deadFightersList);
            };
            return (new Vector.<int>());
        }

        [Untrusted]
        public function getFightType():uint
        {
            return (this.getFightFrame().fightType);
        }

        [Untrusted]
        public function getBuffList(targetId:int):Array
        {
            return (BuffManager.getInstance().getAllBuff(targetId));
        }

        [Untrusted]
        public function getBuffById(buffId:uint, playerId:int):BasicBuff
        {
            return (BuffManager.getInstance().getBuff(buffId, playerId));
        }

        [Untrusted]
        public function createEffectsWrapper(spell:Spell, effects:Array, name:String):EffectsWrapper
        {
            return (new EffectsWrapper(effects, spell, name));
        }

        [Untrusted]
        public function getCastingSpellBuffEffects(targetId:int, castingSpellId:uint):EffectsWrapper
        {
            var spell:Spell;
            var buffItem:BasicBuff;
            var effects:EffectsWrapper;
            var ei:EffectInstance;
            var eii:EffectInstanceInteger;
            var res:Array = new Array();
            var buffs:Array = BuffManager.getInstance().getAllBuff(targetId);
            var triggerList:Array = new Array();
            for each (buffItem in buffs)
            {
                if (buffItem.castingSpell.castingSpellId == castingSpellId)
                {
                    ei = buffItem.effects;
                    if (((ei.trigger) && ((ei is EffectInstanceInteger))))
                    {
                        eii = (ei as EffectInstanceInteger);
                        if (triggerList[((eii.effectId + ",") + eii.value)])
                        {
                            continue;
                        };
                        triggerList[((eii.effectId + ",") + eii.value)] = true;
                        res.push(ei);
                    }
                    else
                    {
                        res.push(ei);
                    };
                    if (!(spell))
                    {
                        spell = buffItem.castingSpell.spell;
                    };
                };
            };
            effects = new EffectsWrapper(res, spell, "");
            return (effects);
        }

        [Untrusted]
        public function getAllBuffEffects(targetId:int):EffectsListWrapper
        {
            return (new EffectsListWrapper(BuffManager.getInstance().getAllBuff(targetId)));
        }

        [Untrusted]
        public function isCastingSpell():Boolean
        {
            return (Kernel.getWorker().contains(FightSpellCastFrame));
        }

        [Untrusted]
        public function cancelSpell():void
        {
            if (Kernel.getWorker().contains(FightSpellCastFrame))
            {
                Kernel.getWorker().removeFrame(Kernel.getWorker().getFrame(FightSpellCastFrame));
            };
        }

        [Untrusted]
        public function getChallengeList():Array
        {
            return (this.getFightFrame().challengesList);
        }

        [Untrusted]
        public function getCurrentPlayedFighterId():int
        {
            return (CurrentPlayedFighterManager.getInstance().currentFighterId);
        }

        [Untrusted]
        public function getCurrentPlayedCharacteristicsInformations():CharacterCharacteristicsInformations
        {
            return (CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations());
        }

        [Untrusted]
        public function preFightIsActive():Boolean
        {
            return (FightContextFrame.preFightIsActive);
        }

        [Untrusted]
        public function isWaitingBeforeFight():Boolean
        {
            if ((((this.getFightFrame().fightType == FightTypeEnum.FIGHT_TYPE_PvMA)) || ((this.getFightFrame().fightType == FightTypeEnum.FIGHT_TYPE_PvT))))
            {
                return (true);
            };
            return (false);
        }

        [Untrusted]
        public function isFightLeader():Boolean
        {
            return (this.getFightFrame().isFightLeader);
        }

        [Untrusted]
        public function isSpectator():Boolean
        {
            return (PlayedCharacterManager.getInstance().isSpectator);
        }

        [Untrusted]
        public function isDematerializated():Boolean
        {
            return (this.getFightFrame().entitiesFrame.dematerialization);
        }

        [Untrusted]
        public function getTurnsCount():int
        {
            return (this.getFightFrame().battleFrame.turnsCount);
        }

        [Untrusted]
        public function getFighterStatus(fighterId:uint):int
        {
            var frame:Frame = Kernel.getWorker().getFrame(FightEntitiesFrame);
            var fightersStatus:Dictionary = FightEntitiesFrame(frame).lastKnownPlayerStatus;
            if (fightersStatus[fighterId])
            {
                return (fightersStatus[fighterId]);
            };
            return (-1);
        }

        [Untrusted]
        public function isMouseOverFighter(fighterId:int):Boolean
        {
            var fcf:FightContextFrame = (Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame);
            return ((((this.getFighterInfos(fighterId).disposition.cellId == FightContextFrame.currentCell)) || (((fcf.timelineOverEntity) && ((fighterId == fcf.timelineOverEntityId))))));
        }

        private function getFighterInfos(fighterId:int):GameFightFighterInformations
        {
            return ((this.getFightFrame().entitiesFrame.getEntityInfos(fighterId) as GameFightFighterInformations));
        }

        private function getFightFrame():FightContextFrame
        {
            var frame:Frame = Kernel.getWorker().getFrame(FightContextFrame);
            if (!(frame))
            {
                throw (new ApiError("Unallowed call of FightApi method while not fighting."));
            };
            return ((frame as FightContextFrame));
        }

        private function getFighterTeam(fighterInfos:GameFightFighterInformations):String
        {
            switch (fighterInfos.teamId)
            {
                case TeamEnum.TEAM_CHALLENGER:
                    return ("challenger");
                case TeamEnum.TEAM_DEFENDER:
                    return ("defender");
                case TeamEnum.TEAM_SPECTATOR:
                    return ("spectator");
                default:
                    this._log.warn((("Unknown teamId " + fighterInfos.teamId) + " ?!"));
                    return ("unknown");
            };
        }


    }
}//package com.ankamagames.dofus.uiApi

