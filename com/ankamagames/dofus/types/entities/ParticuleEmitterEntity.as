package com.ankamagames.dofus.types.entities
{
   import flash.display.Sprite;
   import com.ankamagames.jerakine.entities.interfaces.IDisplayable;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import org.flintparticles.common.renderers.Renderer;
   import com.ankamagames.jerakine.entities.behaviours.IDisplayBehavior;
   import com.ankamagames.jerakine.interfaces.IRectangle;
   import org.flintparticles.twoD.renderers.DisplayObjectRenderer;
   import org.flintparticles.twoD.renderers.BitmapRenderer;
   import flash.geom.Rectangle;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import org.flintparticles.twoD.renderers.PixelRenderer;
   
   public class ParticuleEmitterEntity extends Sprite implements IDisplayable, IEntity
   {
      
      public function ParticuleEmitterEntity(nId:int, renderedType:uint) {
         super();
         this.id = nId;
         switch(renderedType)
         {
            case NORMAL_RENDERER_TYPE:
               this._renderer = new DisplayObjectRenderer();
               break;
            case BITMAP_RENDERER_TYPE:
               this._renderer = new BitmapRenderer(new Rectangle(0,0,StageShareManager.stage.stageWidth,StageShareManager.stage.stageHeight));
               break;
            case PIXEL_RENDERER_TYPE:
               this._renderer = new PixelRenderer(new Rectangle(0,0,StageShareManager.stage.stageWidth,StageShareManager.stage.stageHeight));
               break;
         }
         mouseChildren = false;
         mouseEnabled = false;
      }
      
      protected static const _log:Logger;
      
      public static const NORMAL_RENDERER_TYPE:uint = 0;
      
      public static const BITMAP_RENDERER_TYPE:uint = 1;
      
      public static const PIXEL_RENDERER_TYPE:uint = 2;
      
      private var _id:int;
      
      private var _position:MapPoint;
      
      private var _renderer:Renderer;
      
      private var _displayed:Boolean;
      
      private var _displayBehavior:IDisplayBehavior;
      
      public function get displayBehaviors() : IDisplayBehavior {
         return this._displayBehavior;
      }
      
      public function set displayBehaviors(oValue:IDisplayBehavior) : void {
         this._displayBehavior = oValue;
      }
      
      public function get id() : int {
         return this._id;
      }
      
      public function set id(nValue:int) : void {
         this._id = nValue;
      }
      
      public function get position() : MapPoint {
         return this._position;
      }
      
      public function set position(oValue:MapPoint) : void {
         this._position = oValue;
      }
      
      public function get absoluteBounds() : IRectangle {
         return this._displayBehavior.getAbsoluteBounds(this);
      }
      
      public function get displayed() : Boolean {
         return this._displayed;
      }
      
      public function display(strata:uint = 0) : void {
         this._displayBehavior.display(this,strata);
         this._displayed = true;
      }
      
      public function remove() : void {
         this._displayed = false;
      }
   }
}
