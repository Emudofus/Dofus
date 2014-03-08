package com.ankamagames.dofus.logic.game.common.steps
{
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.dofus.misc.utils.Camera;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.atouin.Atouin;
   
   public class CameraFollowStep extends AbstractSequencable
   {
      
      public function CameraFollowStep(param1:Camera, param2:AnimatedCharacter) {
         super();
         this._camera = param1;
         this._entity = param2;
      }
      
      private var _camera:Camera;
      
      private var _entity:AnimatedCharacter;
      
      override public function start() : void {
         var _loc1_:CameraZoomStep = null;
         if(Atouin.getInstance().currentZoom != this._camera.currentZoom)
         {
            _loc1_ = new CameraZoomStep(this._camera,[this._entity.position.x,this._entity.position.y],true);
            _loc1_.start();
         }
         if(this._camera.currentZoom > 1)
         {
            this._camera.followEntity(this._entity);
         }
         executeCallbacks();
      }
   }
}
