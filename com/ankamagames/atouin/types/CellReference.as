package com.ankamagames.atouin.types
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.display.Sprite;
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   import com.ankamagames.jerakine.pools.PoolsManager;
   import com.ankamagames.jerakine.pools.PoolableRectangle;
   import flash.geom.ColorTransform;
   
   public class CellReference extends Object
   {
      
      public function CellReference(param1:uint) {
         super();
         this.id = param1;
         this.listSprites = new Array();
         this.gfxId = new Array();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(CellReference));
      
      private var _visible:Boolean;
      
      private var _lock:Boolean = false;
      
      public var id:uint;
      
      public var listSprites:Array;
      
      public var elevation:int = 0;
      
      public var x:Number = 0;
      
      public var y:Number = 0;
      
      public var width:Number = 0;
      
      public var height:Number = 0;
      
      public var mov:Boolean;
      
      public var isDisabled:Boolean = false;
      
      public var rendered:Boolean = false;
      
      public var heightestDecor:Sprite;
      
      public var gfxId:Array;
      
      public function addSprite(param1:DisplayObject) : void {
         this.listSprites.push(param1);
      }
      
      public function addGfx(param1:int) : void {
         this.gfxId.push(param1);
      }
      
      public function lock() : void {
         this._lock = true;
      }
      
      public function get locked() : Boolean {
         return this._lock;
      }
      
      public function get visible() : Boolean {
         return this._visible;
      }
      
      public function set visible(param1:Boolean) : void {
         var _loc2_:uint = 0;
         if(this._visible != param1)
         {
            this._visible = param1;
            _loc2_ = 0;
            while(_loc2_ < this.listSprites.length)
            {
               if(this.listSprites[_loc2_] != null)
               {
                  this.listSprites[_loc2_].visible = param1;
               }
               _loc2_++;
            }
         }
      }
      
      public function get bounds() : Rectangle {
         var _loc3_:DisplayObject = null;
         var _loc1_:PoolableRectangle = (PoolsManager.getInstance().getRectanglePool().checkOut() as PoolableRectangle).renew();
         var _loc2_:PoolableRectangle = PoolsManager.getInstance().getRectanglePool().checkOut() as PoolableRectangle;
         for each (_loc3_ in this.listSprites)
         {
            _loc1_.extend(_loc2_.renew(_loc3_.x,_loc3_.y,_loc3_.width,_loc3_.height));
         }
         PoolsManager.getInstance().getRectanglePool().checkIn(_loc2_);
         PoolsManager.getInstance().getRectanglePool().checkIn(_loc1_);
         return _loc1_ as Rectangle;
      }
      
      public function getAvgColor() : uint {
         var _loc4_:ColorTransform = null;
         var _loc5_:* = 0;
         var _loc1_:Number = 0;
         var _loc2_:Number = 0;
         var _loc3_:Number = 0;
         var _loc6_:int = this.listSprites.length;
         _loc5_ = 0;
         while(_loc5_ < _loc6_)
         {
            _loc4_ = (this.listSprites[_loc5_] as DisplayObject).transform.colorTransform;
            _loc1_ = _loc1_ + _loc4_.redOffset * _loc4_.redMultiplier;
            _loc2_ = _loc2_ + _loc4_.greenOffset * _loc4_.greenMultiplier;
            _loc3_ = _loc3_ + _loc4_.blueOffset * _loc4_.blueMultiplier;
            _loc5_ = _loc5_ + 1;
         }
         _loc1_ = _loc1_ / _loc6_;
         _loc2_ = _loc2_ / _loc6_;
         _loc3_ = _loc3_ / _loc6_;
         return _loc1_ << 16 | _loc2_ << 8 | _loc3_;
      }
   }
}
