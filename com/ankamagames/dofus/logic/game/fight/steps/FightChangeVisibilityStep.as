package com.ankamagames.dofus.logic.game.fight.steps
{
    import com.ankamagames.atouin.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.logic.game.fight.fightEvents.*;
    import com.ankamagames.dofus.logic.game.fight.frames.*;
    import com.ankamagames.dofus.logic.game.fight.miscs.*;
    import com.ankamagames.dofus.logic.game.fight.steps.*;
    import com.ankamagames.dofus.logic.game.fight.types.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.types.game.context.fight.*;
    import com.ankamagames.dofus.types.entities.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.sequencer.*;
    import com.ankamagames.tiphon.display.*;
    import flash.display.*;

    public class FightChangeVisibilityStep extends AbstractSequencable implements IFightStep
    {
        private var _entityId:int;
        private var _visibilityState:int;
        private var _oldVisibilityState:int;

        public function FightChangeVisibilityStep(param1:int, param2:int)
        {
            var _loc_3:* = FightEntitiesFrame.getCurrentInstance().getEntityInfos(param1) as GameFightFighterInformations;
            this._oldVisibilityState = _loc_3.stats.invisibilityState;
            this._entityId = param1;
            this._visibilityState = param2;
            return;
        }// end function

        public function get stepType() : String
        {
            return "changeVisibility";
        }// end function

        override public function start() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            switch(this._visibilityState)
            {
                case GameActionFightInvisibilityStateEnum.VISIBLE:
                {
                    if (Atouin.getInstance().options.transparentOverlayMode)
                    {
                        _loc_2 = this.respawnEntity();
                        _loc_2.alpha = AtouinConstants.OVERLAY_MODE_ALPHA;
                    }
                    else
                    {
                        _loc_2 = this.respawnEntity();
                        _loc_2.alpha = 1;
                    }
                    if (_loc_2 is AnimatedCharacter)
                    {
                        AnimatedCharacter(_loc_2).setCanSeeThrough(false);
                    }
                    if (this._oldVisibilityState == GameActionFightInvisibilityStateEnum.DETECTED || this._oldVisibilityState == GameActionFightInvisibilityStateEnum.INVISIBLE)
                    {
                        _loc_1 = GameActionFightInvisibilityStateEnum.VISIBLE;
                    }
                    break;
                }
                case GameActionFightInvisibilityStateEnum.DETECTED:
                {
                    if (this._oldVisibilityState == GameActionFightInvisibilityStateEnum.VISIBLE)
                    {
                        _loc_1 = GameActionFightInvisibilityStateEnum.INVISIBLE;
                    }
                    _loc_2 = this.respawnEntity();
                    if (_loc_2 is AnimatedCharacter)
                    {
                        AnimatedCharacter(_loc_2).setCanSeeThrough(true);
                    }
                    _loc_2.alpha = 0.5;
                    break;
                }
                case GameActionFightInvisibilityStateEnum.INVISIBLE:
                {
                    if (this._oldVisibilityState == GameActionFightInvisibilityStateEnum.VISIBLE)
                    {
                        _loc_1 = GameActionFightInvisibilityStateEnum.INVISIBLE;
                    }
                    this.unspawnEntity();
                    break;
                }
                default:
                {
                    break;
                }
            }
            FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_VISIBILITY_CHANGED, [this._entityId, _loc_1], this._entityId, castingSpellId);
            var _loc_3:* = FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._entityId) as GameFightFighterInformations;
            _loc_3.stats.invisibilityState = this._visibilityState;
            executeCallbacks();
            return;
        }// end function

        private function unspawnEntity() : void
        {
            if (FightEntitiesHolder.getInstance().getEntity(this._entityId))
            {
                return;
            }
            var _loc_1:* = DofusEntities.getEntity(this._entityId) as IDisplayable;
            FightEntitiesHolder.getInstance().holdEntity(_loc_1 as IEntity);
            _loc_1.remove();
            return;
        }// end function

        private function respawnEntity() : DisplayObject
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_1:* = DofusEntities.getEntity(this._entityId) as TiphonSprite;
            if (_loc_1 && _loc_1.parentSprite)
            {
                _loc_2 = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
                if (_loc_2)
                {
                    _loc_2.addOrUpdateActor(_loc_2.getEntityInfos(this._entityId));
                }
                return _loc_1;
            }
            else
            {
                if (FightEntitiesHolder.getInstance().getEntity(this._entityId))
                {
                    _loc_3 = DofusEntities.getEntity(this._entityId) as IDisplayable;
                    _loc_3.display();
                    FightEntitiesHolder.getInstance().unholdEntity(this._entityId);
                }
            }
            return DofusEntities.getEntity(this._entityId) as DisplayObject;
        }// end function

    }
}
