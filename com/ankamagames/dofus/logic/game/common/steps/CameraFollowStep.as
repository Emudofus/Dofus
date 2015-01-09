package com.ankamagames.dofus.logic.game.common.steps
{
    import com.ankamagames.jerakine.sequencer.AbstractSequencable;
    import com.ankamagames.dofus.misc.utils.Camera;
    import com.ankamagames.dofus.types.entities.AnimatedCharacter;
    import com.ankamagames.atouin.Atouin;

    public class CameraFollowStep extends AbstractSequencable 
    {

        private var _camera:Camera;
        private var _entity:AnimatedCharacter;

        public function CameraFollowStep(pCamera:Camera, pEntity:AnimatedCharacter)
        {
            this._camera = pCamera;
            this._entity = pEntity;
        }

        override public function start():void
        {
            var step:CameraZoomStep;
            if (Atouin.getInstance().currentZoom != this._camera.currentZoom)
            {
                step = new CameraZoomStep(this._camera, [this._entity.position.x, this._entity.position.y], true);
                step.start();
            };
            if (this._camera.currentZoom > 1)
            {
                this._camera.followEntity(this._entity);
            };
            executeCallbacks();
        }


    }
}//package com.ankamagames.dofus.logic.game.common.steps

