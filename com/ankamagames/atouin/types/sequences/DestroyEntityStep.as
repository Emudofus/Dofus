package com.ankamagames.atouin.types.sequences
{
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.sequencer.*;
    import com.ankamagames.tiphon.display.*;

    public class DestroyEntityStep extends AbstractSequencable
    {
        private var _entity:IEntity;

        public function DestroyEntityStep(param1:IEntity)
        {
            this._entity = param1;
            return;
        }// end function

        override public function start() : void
        {
            if (this._entity is IDisplayable)
            {
                (this._entity as IDisplayable).remove();
            }
            if (this._entity is TiphonSprite)
            {
                (this._entity as TiphonSprite).destroy();
            }
            executeCallbacks();
            return;
        }// end function

    }
}
