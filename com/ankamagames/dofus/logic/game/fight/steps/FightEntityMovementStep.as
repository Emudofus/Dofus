package com.ankamagames.dofus.logic.game.fight.steps
{
    import com.ankamagames.jerakine.sequencer.AbstractSequencable;
    import com.ankamagames.dofus.types.entities.AnimatedCharacter;
    import com.ankamagames.jerakine.types.positions.MovementPath;
    import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
    import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
    import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightCharacterInformations;
    import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
    import com.ankamagames.berilia.managers.TooltipManager;
    import com.ankamagames.berilia.types.LocationEnum;
    import com.ankamagames.dofus.logic.game.fight.frames.FightSpellCastFrame;
    import flash.events.Event;

    public class FightEntityMovementStep extends AbstractSequencable implements IFightStep 
    {

        private var _entityId:int;
        private var _entity:AnimatedCharacter;
        private var _path:MovementPath;
        private var _fightContextFrame:FightContextFrame;
        private var _ttCacheName:String;
        private var _ttName:String;

        public function FightEntityMovementStep(entityId:int, path:MovementPath)
        {
            this._entityId = entityId;
            this._path = path;
            timeout = (path.length * 1000);
            this._fightContextFrame = (Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame);
        }

        public function get stepType():String
        {
            return ("entityMovement");
        }

        override public function start():void
        {
            var fighterInfos:GameFightFighterInformations;
            this._entity = (DofusEntities.getEntity(this._entityId) as AnimatedCharacter);
            if (this._entity)
            {
                fighterInfos = (FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._entityId) as GameFightFighterInformations);
                fighterInfos.disposition.cellId = this._path.end.cellId;
                this._ttCacheName = (((fighterInfos is GameFightCharacterInformations)) ? ("PlayerShortInfos" + this._entityId) : ("EntityShortInfos" + this._entityId));
                this._ttName = ("tooltipOverEntity_" + this._entityId);
                EnterFrameDispatcher.addEventListener(this.onEnterFrame, "movementStep");
                this._entity.move(this._path, this.movementEnd);
            }
            else
            {
                _log.warn((("Unable to move unknown entity " + this._entityId) + "."));
                this.movementEnd();
            };
        }

        private function movementEnd():void
        {
            EnterFrameDispatcher.removeEventListener(this.onEnterFrame);
            if (this._fightContextFrame.timelineOverEntity)
            {
                TooltipManager.updatePosition(this._ttCacheName, this._ttName, this._entity.absoluteBounds, LocationEnum.POINT_BOTTOM, LocationEnum.POINT_TOP, 0, true, true, this._entity.position.cellId);
            };
            FightSpellCastFrame.updateRangeAndTarget();
            executeCallbacks();
        }

        private function onEnterFrame(pEvent:Event):void
        {
            if (this._fightContextFrame.timelineOverEntity)
            {
                TooltipManager.updatePosition(this._ttCacheName, this._ttName, this._entity.absoluteBounds, LocationEnum.POINT_BOTTOM, LocationEnum.POINT_TOP, 0, true, true, this._entity.position.cellId);
            };
        }


    }
}//package com.ankamagames.dofus.logic.game.fight.steps

