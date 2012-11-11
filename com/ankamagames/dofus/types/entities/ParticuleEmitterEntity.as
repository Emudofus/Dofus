package com.ankamagames.dofus.types.entities
{
    import com.ankamagames.jerakine.entities.behaviours.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.types.positions.*;
    import com.ankamagames.jerakine.utils.display.*;
    import flash.display.*;
    import flash.geom.*;
    import flash.utils.*;
    import org.flintparticles.common.renderers.*;
    import org.flintparticles.twoD.renderers.*;

    public class ParticuleEmitterEntity extends Sprite implements IDisplayable, IEntity
    {
        private var _id:int;
        private var _position:MapPoint;
        private var _renderer:Renderer;
        private var _displayed:Boolean;
        private var _displayBehavior:IDisplayBehavior;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(Projectile));
        public static const NORMAL_RENDERER_TYPE:uint = 0;
        public static const BITMAP_RENDERER_TYPE:uint = 1;
        public static const PIXEL_RENDERER_TYPE:uint = 2;

        public function ParticuleEmitterEntity(param1:int, param2:uint)
        {
            this.id = param1;
            switch(param2)
            {
                case NORMAL_RENDERER_TYPE:
                {
                    this._renderer = new DisplayObjectRenderer();
                    break;
                }
                case BITMAP_RENDERER_TYPE:
                {
                    this._renderer = new BitmapRenderer(new Rectangle(0, 0, StageShareManager.stage.stageWidth, StageShareManager.stage.stageHeight));
                    break;
                }
                case PIXEL_RENDERER_TYPE:
                {
                    this._renderer = new PixelRenderer(new Rectangle(0, 0, StageShareManager.stage.stageWidth, StageShareManager.stage.stageHeight));
                    break;
                }
                default:
                {
                    break;
                }
            }
            mouseChildren = false;
            mouseEnabled = false;
            return;
        }// end function

        public function get displayBehaviors() : IDisplayBehavior
        {
            return this._displayBehavior;
        }// end function

        public function set displayBehaviors(param1:IDisplayBehavior) : void
        {
            this._displayBehavior = param1;
            return;
        }// end function

        public function get id() : int
        {
            return this._id;
        }// end function

        public function set id(param1:int) : void
        {
            this._id = param1;
            return;
        }// end function

        public function get position() : MapPoint
        {
            return this._position;
        }// end function

        public function set position(param1:MapPoint) : void
        {
            this._position = param1;
            return;
        }// end function

        public function get absoluteBounds() : IRectangle
        {
            return this._displayBehavior.getAbsoluteBounds(this);
        }// end function

        public function get displayed() : Boolean
        {
            return this._displayed;
        }// end function

        public function display(param1:uint = 0) : void
        {
            this._displayBehavior.display(this, param1);
            this._displayed = true;
            return;
        }// end function

        public function remove() : void
        {
            this._displayed = false;
            return;
        }// end function

    }
}
