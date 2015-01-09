package com.ankamagames.dofus.logic.game.common.steps
{
    import com.ankamagames.jerakine.sequencer.AbstractSequencable;
    import com.ankamagames.dofus.types.entities.AnimatedCharacter;
    import com.ankamagames.dofus.scripts.ScriptsUtil;

    public class TeleportStep extends AbstractSequencable 
    {

        private var _entity:AnimatedCharacter;
        private var _args:Array;

        public function TeleportStep(pEntity:AnimatedCharacter, pArgs:Array)
        {
            this._entity = pEntity;
            this._args = pArgs;
        }

        override public function start():void
        {
            this._entity.movementBehavior.jump(this._entity, ScriptsUtil.getMapPoint(this._args));
            executeCallbacks();
        }


    }
}//package com.ankamagames.dofus.logic.game.common.steps

