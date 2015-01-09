package com.ankamagames.atouin.types.sequences
{
    import com.ankamagames.jerakine.sequencer.AbstractSequencable;
    import com.ankamagames.jerakine.entities.interfaces.IEntity;
    import com.ankamagames.jerakine.entities.interfaces.IDisplayable;
    import com.ankamagames.atouin.enums.PlacementStrataEnums;

    public class AddWorldEntityStep extends AbstractSequencable 
    {

        private var _entity:IEntity;

        public function AddWorldEntityStep(entity:IEntity)
        {
            this._entity = entity;
        }

        override public function start():void
        {
            (this._entity as IDisplayable).display(PlacementStrataEnums.STRATA_PLAYER);
            executeCallbacks();
        }


    }
}//package com.ankamagames.atouin.types.sequences

