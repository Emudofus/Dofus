package com.ankamagames.dofus.types.entities
{
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.types.positions.*;
    import com.ankamagames.tiphon.display.*;
    import com.ankamagames.tiphon.types.look.*;
    import flash.events.*;
    import flash.geom.*;
    import org.flintparticles.common.actions.*;
    import org.flintparticles.common.counters.*;
    import org.flintparticles.common.displayObjects.*;
    import org.flintparticles.common.energyEasing.*;
    import org.flintparticles.common.initializers.*;
    import org.flintparticles.twoD.actions.*;
    import org.flintparticles.twoD.emitters.*;
    import org.flintparticles.twoD.initializers.*;
    import org.flintparticles.twoD.renderers.*;
    import org.flintparticles.twoD.zones.*;

    public class TailEntity extends TiphonSprite implements IEntity
    {
        private var _emiter:Emitter2D;
        private var _renderer:DisplayObjectRenderer;
        private var _startPositionZone:LineZone;
        private var _startPosition:Position;

        public function TailEntity()
        {
            this._emiter = new Emitter2D();
            this._renderer = new DisplayObjectRenderer();
            this._startPositionZone = new LineZone(new Point(0, 0), new Point(0, 0));
            super(new TiphonEntityLook());
            this._emiter.counter = new PerformanceAdjusted(10, 50, 40);
            this._emiter.addInitializer(new ImageClass(Dot, 1.5));
            this._emiter.addInitializer(new ColorInit(16777215, 16777215));
            this._emiter.addInitializer(new ScaleImageInit(0.5, 1));
            this._emiter.addInitializer(new Lifetime(1));
            this._startPosition = new Position(this._startPositionZone);
            this._emiter.addInitializer(this._startPosition);
            this._emiter.addAction(new Age(Quadratic.easeInOut));
            this._emiter.addAction(new Move());
            this._emiter.addAction(new Fade());
            this._emiter.addAction(new RandomDrift(100, 100));
            this._emiter.addAction(new Accelerate(0, 10));
            this._renderer.addEmitter(this._emiter);
            addEventListener(Event.ADDED_TO_STAGE, this.onTailAdded);
            addEventListener(Event.REMOVED_FROM_STAGE, this.onRemove);
            return;
        }// end function

        public function get id() : int
        {
            return 0;
        }// end function

        public function set id(param1:int) : void
        {
            return;
        }// end function

        public function get position() : MapPoint
        {
            return null;
        }// end function

        public function set position(param1:MapPoint) : void
        {
            return;
        }// end function

        private function onTailAdded(event:Event) : void
        {
            if (!this._emiter.running)
            {
                parent.parent.addChild(this._renderer);
                addEventListener(Event.ENTER_FRAME, this.onNewFrame);
                this._emiter.start();
            }
            return;
        }// end function

        private function onRemove(event:Event) : void
        {
            this._emiter.counter = new ZeroCounter();
            removeEventListener(Event.ENTER_FRAME, this.onNewFrame);
            return;
        }// end function

        private function onNewFrame(event:Event) : void
        {
            this._startPositionZone.point1.x = this._startPositionZone.point2.x;
            this._startPositionZone.point1.y = this._startPositionZone.point2.y;
            this._startPositionZone.point2.x = parent.x;
            this._startPositionZone.point2.y = parent.y;
            this._startPosition.zone = new LineZone(this._startPositionZone.point1, this._startPositionZone.point2);
            return;
        }// end function

    }
}
