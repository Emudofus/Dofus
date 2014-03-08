package flashx.textLayout.utils
{
   import flash.geom.Rectangle;
   import flashx.textLayout.elements.FlowElement;
   import flashx.textLayout.tlf_internal;
   
   use namespace tlf_internal;
   
   public class HitTestArea extends Object
   {
      
      public function HitTestArea(param1:Object) {
         super();
         this.initialize(param1);
      }
      
      private var tl:HitTestArea = null;
      
      private var tr:HitTestArea = null;
      
      private var bl:HitTestArea = null;
      
      private var br:HitTestArea = null;
      
      private var _rect:Rectangle;
      
      private var _xm:Number;
      
      private var _ym:Number;
      
      private var _owner:FlowElement = null;
      
      tlf_internal function initialize(param1:Object) : void {
         var _loc2_:Object = null;
         var _loc4_:Rectangle = null;
         var _loc5_:Rectangle = null;
         var _loc6_:* = NaN;
         var _loc7_:* = NaN;
         var _loc8_:* = NaN;
         var _loc9_:* = NaN;
         var _loc3_:* = 0;
         if(param1)
         {
            for (_loc2_ in param1)
            {
               if(++_loc3_ > 1)
               {
                  break;
               }
            }
         }
         if(_loc3_ == 0)
         {
            this._rect = new Rectangle();
            this._xm = this._ym = 0;
            return;
         }
         if(_loc3_ == 1)
         {
            for each (_loc2_ in param1)
            {
               this._rect = _loc2_.rect;
               this._xm = this._rect.left;
               this._ym = this._rect.top;
               this._owner = _loc2_.owner;
               return;
            }
         }
         for each (_loc2_ in param1)
         {
            _loc4_ = _loc2_.rect;
            if(!this._rect)
            {
               this._rect = _loc4_;
            }
            else
            {
               this._rect = this._rect.union(_loc4_);
            }
         }
         this._xm = Math.ceil(this._rect.left + this._rect.width / 2);
         this._ym = Math.ceil(this._rect.top + this._rect.height / 2);
         if(this._rect.width <= 3 || this._rect.height <= 3)
         {
            for each (_loc2_ in param1)
            {
               this._owner = _loc2_.owner;
               return;
            }
         }
         for each (_loc2_ in param1)
         {
            _loc4_ = _loc2_.rect;
            if(!_loc4_.equals(this._rect))
            {
               if(_loc4_.contains(this._xm,this._ym))
               {
                  _loc6_ = this._xm - _loc4_.left;
                  _loc7_ = _loc4_.right - this._xm;
                  _loc8_ = this._ym - _loc4_.top;
                  _loc9_ = _loc4_.bottom - this._ym;
                  this._xm = _loc6_ > _loc7_?this._xm + _loc7_:this._xm - _loc6_;
                  this._ym = _loc8_ > _loc9_?this._ym + _loc9_:this._ym - _loc8_;
                  break;
               }
            }
         }
         _loc5_ = new Rectangle(this._rect.left,this._rect.top,this._xm - this._rect.left,this._ym - this._rect.top);
         this.addQuadrant(param1,"tl",_loc5_);
         _loc5_.left = this._xm;
         _loc5_.right = this._rect.right;
         this.addQuadrant(param1,"tr",_loc5_);
         _loc5_.left = this._rect.left;
         _loc5_.top = this._ym;
         _loc5_.right = this._xm;
         _loc5_.bottom = this._rect.bottom;
         this.addQuadrant(param1,"bl",_loc5_);
         _loc5_.left = this._xm;
         _loc5_.right = this._rect.right;
         this.addQuadrant(param1,"br",_loc5_);
      }
      
      public function hitTest(param1:Number, param2:Number) : FlowElement {
         if(!this._rect.contains(param1,param2))
         {
            return null;
         }
         if(this._owner)
         {
            return this._owner;
         }
         var _loc3_:String = param2 < this._ym?"t":"b";
         _loc3_ = _loc3_ + (param1 < this._xm?"l":"r");
         var _loc4_:HitTestArea = this[_loc3_];
         if(_loc4_ == null)
         {
            return null;
         }
         return _loc4_.hitTest(param1,param2);
      }
      
      private function addQuadrant(param1:Object, param2:String, param3:Rectangle) : void {
         var _loc6_:Object = null;
         var _loc7_:Rectangle = null;
         if(param3.isEmpty())
         {
            return;
         }
         var _loc4_:Object = {};
         var _loc5_:* = 0;
         for each (_loc6_ in param1)
         {
            _loc7_ = _loc6_.rect.intersection(param3);
            if(!_loc7_.isEmpty())
            {
               _loc4_[_loc5_++] = 
                  {
                     "owner":_loc6_.owner,
                     "rect":_loc7_
                  };
            }
         }
         if(_loc5_ > 0)
         {
            this[param2] = new HitTestArea(_loc4_);
         }
      }
   }
}
