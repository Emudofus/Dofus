package com.ankamagames.dofus.logic.game.fight.steps
{
    import com.ankamagames.dofus.logic.game.fight.steps.abstract.AbstractStatContextualStep;
    import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
    import com.ankamagames.dofus.types.entities.AnimatedCharacter;
    import com.ankamagames.tiphon.events.TiphonEvent;
    import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightCharacterInformations;
    import com.ankamagames.berilia.managers.TooltipManager;
    import com.ankamagames.berilia.types.LocationEnum;
    import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
    import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
    import com.ankamagames.tiphon.display.TiphonSprite;

    public class FightShieldPointsVariationStep extends AbstractStatContextualStep implements IFightStep 
    {

        public static const COLOR:uint = 10053324;
        private static const BLOCKING:Boolean = false;

        private var _intValue:int;
        private var _actionId:int;

        public function FightShieldPointsVariationStep(entityId:int, value:int, actionId:int)
        {
            super(COLOR, value.toString(), entityId, BLOCKING);
            this._intValue = value;
            this._actionId = actionId;
            _virtual = false;
        }

        public function get stepType():String
        {
            return ("shieldPointsVariation");
        }

        public function get value():int
        {
            return (this._intValue);
        }

        public function set virtual(pValue:Boolean):void
        {
            _virtual = pValue;
        }

        override public function start():void
        {
            var ttCacheName:String;
            var target:AnimatedCharacter = (DofusEntities.getEntity(_targetId) as AnimatedCharacter);
            if (((target) && (target.isPlayingAnimation())))
            {
                target.addEventListener(TiphonEvent.ANIMATION_END, this.onAnimationEnd);
                return;
            };
            var fighterInfos:GameFightFighterInformations = (FightEntitiesFrame.getCurrentInstance().getEntityInfos(_targetId) as GameFightFighterInformations);
            if (!(fighterInfos))
            {
                super.executeCallbacks();
                return;
            };
            var previousShieldPoints:uint = fighterInfos.stats.shieldPoints;
            fighterInfos.stats.shieldPoints = Math.max(0, (fighterInfos.stats.shieldPoints + this._intValue));
            var ttName:String = ("tooltipOverEntity_" + fighterInfos.contextualId);
            if ((fighterInfos is GameFightCharacterInformations))
            {
                ttCacheName = ("PlayerShortInfos" + fighterInfos.contextualId);
            }
            else
            {
                ttCacheName = ("EntityShortInfos" + fighterInfos.contextualId);
            };
            TooltipManager.updateContent(ttCacheName, ttName, fighterInfos);
            fighterInfos.stats.shieldPoints = previousShieldPoints;
            TooltipManager.updatePosition(ttCacheName, ttName, target.absoluteBounds, LocationEnum.POINT_BOTTOM, LocationEnum.POINT_TOP, 0, true, true, target.position.cellId);
            if (this._intValue < 0)
            {
                FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_SHIELD_LOSS, [_targetId, Math.abs(this._intValue), this._actionId], _targetId, castingSpellId);
            }
            else
            {
                if (this._intValue == 0)
                {
                    FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_NO_CHANGE, [_targetId], _targetId, castingSpellId);
                };
            };
            super.start();
        }

        private function onAnimationEnd(pEvent:TiphonEvent):void
        {
            var target:TiphonSprite = (pEvent.currentTarget as TiphonSprite);
            target.removeEventListener(TiphonEvent.ANIMATION_END, this.onAnimationEnd);
            this.start();
        }


    }
}//package com.ankamagames.dofus.logic.game.fight.steps

