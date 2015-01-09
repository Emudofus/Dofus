package com.ankamagames.dofus.logic.game.common.steps
{
    import com.ankamagames.jerakine.sequencer.AbstractSequencable;
    import com.ankamagames.dofus.misc.utils.Camera;
    import flash.geom.Point;
    import flash.display.DisplayObjectContainer;
    import com.ankamagames.atouin.Atouin;
    import gs.TweenLite;
    import com.ankamagames.dofus.scripts.ScriptsUtil;
    import com.ankamagames.jerakine.types.positions.MapPoint;
    import com.ankamagames.atouin.managers.InteractiveCellManager;
    import com.ankamagames.atouin.types.GraphicCell;

    public class CameraZoomStep extends AbstractSequencable 
    {

        private var _camera:Camera;
        private var _args:Array;
        private var _instant:Boolean;
        private var _targetPos:Point;
        private var _container:DisplayObjectContainer;

        public function CameraZoomStep(pCamera:Camera, pArgs:Array, pInstant:Boolean)
        {
            this._camera = pCamera;
            this._args = pArgs;
            this._instant = pInstant;
            this._container = Atouin.getInstance().rootContainer;
        }

        override public function start():void
        {
            var _local_4:Object;
            var _local_5:TweenLite;
            var mp:MapPoint = ScriptsUtil.getMapPoint(this._args);
            var cell:GraphicCell = InteractiveCellManager.getInstance().getCell(mp.cellId);
            var cellPos:Point = cell.parent.localToGlobal(new Point((cell.x + (cell.width / 2)), (cell.y + (cell.height / 2))));
            this._targetPos = this._container.globalToLocal(cellPos);
            if (this._instant)
            {
                this._camera.zoomOnPos(this._camera.currentZoom, this._targetPos.x, this._targetPos.y);
                executeCallbacks();
            }
            else
            {
                _local_4 = {"zoom":Atouin.getInstance().currentZoom};
                _local_5 = new TweenLite(_local_4, 1, {
                    "zoom":this._camera.currentZoom,
                    "onUpdate":this.updateZoom,
                    "onUpdateParams":[_local_4],
                    "onComplete":this.zoomComplete
                });
            };
        }

        private function updateZoom(pZoomObj:Object):void
        {
            this._camera.zoomOnPos(pZoomObj.zoom, this._targetPos.x, this._targetPos.y);
        }

        private function zoomComplete():void
        {
            executeCallbacks();
        }


    }
}//package com.ankamagames.dofus.logic.game.common.steps

