package com.ankamagames.atouin.types.sequences
{
    import com.ankamagames.atouin.enums.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.sequencer.*;

    public class AddWorldEntityStep extends AbstractSequencable
    {
        private var _entity:IEntity;

        public function AddWorldEntityStep(param1:IEntity)
        {
            this._entity = param1;
            return;
        }// end function

        override public function start() : void
        {
            (this._entity as IDisplayable).display(PlacementStrataEnums.STRATA_PLAYER);
            executeCallbacks();
            return;
        }// end function

    }
}
