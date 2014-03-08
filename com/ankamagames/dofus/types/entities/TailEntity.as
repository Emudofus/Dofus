package com.ankamagames.dofus.types.entities
{
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import org.flintparticles.twoD.emitters.Emitter2D;
   import org.flintparticles.twoD.renderers.DisplayObjectRenderer;
   import org.flintparticles.twoD.zones.LineZone;
   import org.flintparticles.twoD.initializers.Position;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import flash.events.Event;
   import org.flintparticles.common.counters.ZeroCounter;
   import flash.geom.Point;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import org.flintparticles.common.counters.PerformanceAdjusted;
   import org.flintparticles.common.initializers.ImageClass;
   import org.flintparticles.common.displayObjects.Dot;
   import org.flintparticles.common.initializers.ColorInit;
   import org.flintparticles.common.initializers.ScaleImageInit;
   import org.flintparticles.common.initializers.Lifetime;
   import org.flintparticles.common.actions.Age;
   import org.flintparticles.common.energyEasing.Quadratic;
   import org.flintparticles.twoD.actions.Move;
   import org.flintparticles.common.actions.Fade;
   import org.flintparticles.twoD.actions.RandomDrift;
   import org.flintparticles.twoD.actions.Accelerate;
   
   public class TailEntity extends TiphonSprite implements IEntity
   {
      
      public function TailEntity() {
         this._emiter = new Emitter2D();
         this._renderer = new DisplayObjectRenderer();
         this._startPositionZone = new LineZone(new Point(0,0),new Point(0,0));
         super(new TiphonEntityLook());
         this._emiter.counter = new PerformanceAdjusted(10,50,40);
         this._emiter.addInitializer(new ImageClass(Dot,1.5));
         this._emiter.addInitializer(new ColorInit(16777215,16777215));
         this._emiter.addInitializer(new ScaleImageInit(0.5,1));
         this._emiter.addInitializer(new Lifetime(1));
         this._startPosition = new Position(this._startPositionZone);
         this._emiter.addInitializer(this._startPosition);
         this._emiter.addAction(new Age(Quadratic.easeInOut));
         this._emiter.addAction(new Move());
         this._emiter.addAction(new Fade());
         this._emiter.addAction(new RandomDrift(100,100));
         this._emiter.addAction(new Accelerate(0,10));
         this._renderer.addEmitter(this._emiter);
         addEventListener(Event.ADDED_TO_STAGE,this.onTailAdded);
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemove);
      }
      
      private var _emiter:Emitter2D;
      
      private var _renderer:DisplayObjectRenderer;
      
      private var _startPositionZone:LineZone;
      
      private var _startPosition:Position;
      
      public function get id() : int {
         return 0;
      }
      
      public function set id(nValue:int) : void {
      }
      
      public function get position() : MapPoint {
         return null;
      }
      
      public function set position(oValue:MapPoint) : void {
      }
      
      private function onTailAdded(e:Event) : void {
         if(!this._emiter.running)
         {
            parent.parent.addChild(this._renderer);
            addEventListener(Event.ENTER_FRAME,this.onNewFrame);
            this._emiter.start();
         }
      }
      
      private function onRemove(e:Event) : void {
         this._emiter.counter = new ZeroCounter();
         removeEventListener(Event.ENTER_FRAME,this.onNewFrame);
      }
      
      private function onNewFrame(e:Event) : void {
         this._startPositionZone.point1.x = this._startPositionZone.point2.x;
         this._startPositionZone.point1.y = this._startPositionZone.point2.y;
         this._startPositionZone.point2.x = parent.x;
         this._startPositionZone.point2.y = parent.y;
         this._startPosition.zone = new LineZone(this._startPositionZone.point1,this._startPositionZone.point2);
      }
   }
}
