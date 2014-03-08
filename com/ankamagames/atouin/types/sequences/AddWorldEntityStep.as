package com.ankamagames.atouin.types.sequences
{
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.entities.interfaces.IDisplayable;
   import com.ankamagames.atouin.enums.PlacementStrataEnums;
   
   public class AddWorldEntityStep extends AbstractSequencable
   {
      
      public function AddWorldEntityStep(entity:IEntity) {
         super();
         this._entity = entity;
      }
      
      private var _entity:IEntity;
      
      override public function start() : void {
         (this._entity as IDisplayable).display(PlacementStrataEnums.STRATA_PLAYER);
         executeCallbacks();
      }
   }
}
