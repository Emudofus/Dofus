package flashx.textLayout.compose
{
   import flashx.textLayout.container.ContainerController;
   import flashx.textLayout.tlf_internal;
   import flash.text.engine.TextLine;
   import flashx.textLayout.formats.ClearFloats;
   import flashx.textLayout.formats.Direction;
   
   use namespace tlf_internal;
   
   public class Parcel extends Object
   {
      
      public function Parcel(param1:Boolean, param2:Number, param3:Number, param4:Number, param5:Number, param6:ContainerController, param7:int) {
         super();
         this.initialize(param1,param2,param3,param4,param5,param6,param7);
      }
      
      public var x:Number;
      
      public var y:Number;
      
      public var width:Number;
      
      public var height:Number;
      
      public var logicalWidth:Number;
      
      private var _controller:ContainerController;
      
      private var _columnIndex:int;
      
      private var _fitAny:Boolean;
      
      private var _composeToPosition:Boolean;
      
      private var _left:Edge;
      
      private var _right:Edge;
      
      private var _maxWidth:Number;
      
      private var _verticalText:Boolean;
      
      public function initialize(param1:Boolean, param2:Number, param3:Number, param4:Number, param5:Number, param6:ContainerController, param7:int) : Parcel {
         var _loc8_:* = NaN;
         var _loc9_:* = NaN;
         this.x = param2;
         this.y = param3;
         this.width = param4;
         this.height = param5;
         this.logicalWidth = param1?param5:param4;
         this._verticalText = param1;
         this._controller = param6;
         this._columnIndex = param7;
         this._fitAny = false;
         this._composeToPosition = false;
         if(param1)
         {
            _loc8_ = param3;
            this._maxWidth = param5;
         }
         else
         {
            _loc8_ = param2;
            this._maxWidth = param4;
         }
         if(this._maxWidth <= 0)
         {
            throw new Error("Malformed column");
         }
         else
         {
            this._left = new Edge(_loc8_);
            this._right = new Edge(_loc8_ + this._maxWidth);
            return this;
         }
      }
      
      tlf_internal function releaseAnyReferences() : void {
         this._controller = null;
      }
      
      public function get bottom() : Number {
         return this.y + this.height;
      }
      
      public function get right() : Number {
         return this.x + this.width;
      }
      
      public function get controller() : ContainerController {
         return this._controller;
      }
      
      public function get columnIndex() : int {
         return this._columnIndex;
      }
      
      public function get fitAny() : Boolean {
         return this._fitAny;
      }
      
      public function set fitAny(param1:Boolean) : void {
         this._fitAny = param1;
      }
      
      public function get composeToPosition() : Boolean {
         return this._composeToPosition;
      }
      
      public function set composeToPosition(param1:Boolean) : void {
         this._composeToPosition = param1;
      }
      
      private function getLogicalHeight() : Number {
         if(this._verticalText)
         {
            return this._controller.measureWidth?TextLine.MAX_LINE_WIDTH:this.width;
         }
         return this._controller.measureHeight?TextLine.MAX_LINE_WIDTH:this.height;
      }
      
      public function applyClear(param1:String, param2:Number, param3:String) : Number {
         var _loc4_:* = NaN;
         var _loc5_:* = NaN;
         var _loc6_:Number = param2;
         if(param1 == ClearFloats.START)
         {
            param1 = param3 == Direction.LTR?ClearFloats.LEFT:ClearFloats.RIGHT;
         }
         else
         {
            if(param1 == ClearFloats.END)
            {
               param1 = param3 == Direction.RTL?ClearFloats.LEFT:ClearFloats.RIGHT;
            }
         }
         while(_loc6_ < Number.MAX_VALUE)
         {
            _loc4_ = this._left.getMaxForSpan(_loc6_,_loc6_ + 1);
            if(_loc4_ > 0 && (param1 == ClearFloats.BOTH || param1 == ClearFloats.LEFT))
            {
               _loc6_ = this._left.findNextTransition(_loc6_);
               continue;
            }
            _loc5_ = this._right.getMaxForSpan(_loc6_,_loc6_ + 1);
            if(_loc5_ > 0 && (param1 == ClearFloats.BOTH || param1 == ClearFloats.RIGHT))
            {
               _loc6_ = this._right.findNextTransition(_loc6_);
               continue;
            }
            return _loc6_ - param2;
         }
         return this._verticalText?this.width:this.height;
      }
      
      public function fitsInHeight(param1:Number, param2:Number) : Boolean {
         return (this.composeToPosition) || param1 + param2 <= this.getLogicalHeight();
      }
      
      public function getLineSlug(param1:Slug, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Boolean, param10:Boolean) : Boolean {
         if(!this.fitsInHeight(param2,param5))
         {
            return false;
         }
         param1.height = param3;
         while(param2 < Number.MAX_VALUE)
         {
            param1.depth = param2;
            param1.leftMargin = this._left.getMaxForSpan(param1.depth,param1.depth + param3);
            param1.wrapsKnockOut = !(param1.leftMargin == 0);
            if(param6 > 0)
            {
               param1.leftMargin = Math.max(param6,param1.leftMargin);
            }
            else
            {
               param1.leftMargin = param1.leftMargin + param6;
            }
            param1.rightMargin = this._right.getMaxForSpan(param1.depth,param1.depth + param3);
            param1.wrapsKnockOut = (param1.wrapsKnockOut) || !(param1.rightMargin == 0);
            if(param7 > 0)
            {
               param1.rightMargin = Math.max(param7,param1.rightMargin);
            }
            else
            {
               param1.rightMargin = param1.rightMargin + param7;
            }
            if(param8)
            {
               if(param9)
               {
                  param1.leftMargin = param1.leftMargin + param8;
               }
               else
               {
                  param1.rightMargin = param1.rightMargin + param8;
               }
            }
            if((param10) || (this._verticalText) && (this._controller.measureHeight) || !this._verticalText && (this._controller.measureWidth))
            {
               param1.width = TextLine.MAX_LINE_WIDTH;
            }
            else
            {
               param1.width = this.logicalWidth - (param1.leftMargin + param1.rightMargin);
            }
            if(!param4 || param1.width >= param4)
            {
               break;
            }
            param2 = this.findNextTransition(param2);
         }
         return param2 < Number.MAX_VALUE;
      }
      
      public function knockOut(param1:Number, param2:Number, param3:Number, param4:Boolean) : void {
         var _loc5_:Edge = param4?this._left:this._right;
         _loc5_.addSpan(param1,param2,param3);
      }
      
      public function removeKnockOut(param1:Number, param2:Number, param3:Number, param4:Boolean) : void {
         var _loc5_:Edge = param4?this._left:this._right;
         _loc5_.removeSpan(param1,param2,param3);
      }
      
      public function isRectangular() : Boolean {
         return this._left.numSpans <= 0 && this._right.numSpans <= 0;
      }
      
      public function findNextTransition(param1:Number) : Number {
         return Math.min(this._left.findNextTransition(param1),this._right.findNextTransition(param1));
      }
   }
}
class Span extends Object
{
   
   function Span(param1:Number, param2:Number, param3:Number) {
      super();
      this.x = param1;
      this.ymin = param2;
      this.ymax = param3;
   }
   
   public var x:Number;
   
   public var ymin:Number;
   
   public var ymax:Number;
   
   public function overlapsInY(param1:Number, param2:Number) : Boolean {
      return !(param2 < this.ymin || param1 >= this.ymax);
   }
   
   public function equals(param1:Number, param2:Number, param3:Number) : Boolean {
      return param1 == this.x && param2 == this.ymin && param3 == this.ymax;
   }
}
import __AS3__.vec.Vector;

class Edge extends Object
{
   
   function Edge(param1:Number) {
      super();
      this._xbase = param1;
      this._spanList = new Vector.<Span>();
   }
   
   private var _xbase:Number;
   
   private var _spanList:Vector.<Span>;
   
   public function get base() : Number {
      return this._xbase;
   }
   
   public function addSpan(param1:Number, param2:Number, param3:Number) : void {
      this._spanList.push(new Span(param1,param2,param3));
   }
   
   public function removeSpan(param1:Number, param2:Number, param3:Number) : void {
      var _loc4_:* = 0;
      while(_loc4_ < this._spanList.length)
      {
         if(this._spanList[_loc4_].equals(param1,param2,param3))
         {
            this._spanList.splice(_loc4_,1);
            return;
         }
         _loc4_++;
      }
   }
   
   public function get numSpans() : int {
      return this._spanList.length;
   }
   
   public function getMaxForSpan(param1:Number, param2:Number) : Number {
      var _loc4_:Span = null;
      var _loc3_:Number = 0;
      for each (_loc4_ in this._spanList)
      {
         if(_loc4_.x > _loc3_ && (_loc4_.overlapsInY(param1,param2)))
         {
            _loc3_ = _loc4_.x;
         }
      }
      return _loc3_;
   }
   
   public function findNextTransition(param1:Number) : Number {
      var _loc3_:Span = null;
      var _loc2_:Number = Number.MAX_VALUE;
      for each (_loc3_ in this._spanList)
      {
         if(_loc3_.ymin > param1 && _loc3_.ymin < _loc2_)
         {
            _loc2_ = _loc3_.ymin;
         }
         if(_loc3_.ymax > param1 && _loc3_.ymax < _loc2_)
         {
            _loc2_ = _loc3_.ymax;
         }
      }
      return _loc2_;
   }
}
