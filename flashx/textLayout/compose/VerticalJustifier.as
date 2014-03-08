package flashx.textLayout.compose
{
   import flashx.textLayout.container.ContainerController;
   import flashx.textLayout.formats.BlockProgression;
   import flashx.textLayout.tlf_internal;
   import flashx.textLayout.formats.VerticalAlign;
   import flashx.textLayout.formats.Float;
   
   use namespace tlf_internal;
   
   public final class VerticalJustifier extends Object
   {
      
      public function VerticalJustifier() {
         super();
      }
      
      public static function applyVerticalAlignmentToColumn(param1:ContainerController, param2:String, param3:Array, param4:int, param5:int, param6:int, param7:int) : Number {
         var _loc8_:IVerticalAdjustmentHelper = null;
         var _loc9_:* = 0;
         var _loc10_:* = NaN;
         var _loc11_:IVerticalJustificationLine = null;
         var _loc12_:* = NaN;
         var _loc13_:* = 0;
         var _loc14_:FloatCompositionData = null;
         if(param1.rootElement.computedFormat.blockProgression == BlockProgression.RL)
         {
            _loc8_ = new RL_VJHelper(param1);
         }
         else
         {
            _loc8_ = new TB_VJHelper(param1);
         }
         switch(param2)
         {
            case VerticalAlign.MIDDLE:
            case VerticalAlign.BOTTOM:
               _loc11_ = param3[param4 + param5-1];
               _loc12_ = _loc8_.getBottom(_loc11_,param1,param6,param7);
               _loc10_ = param2 == VerticalAlign.MIDDLE?_loc8_.computeMiddleAdjustment(_loc12_):_loc8_.computeBottomAdjustment(_loc12_);
               _loc9_ = param4;
               while(_loc9_ < param4 + param5)
               {
                  _loc8_.applyAdjustment(param3[_loc9_]);
                  _loc9_++;
               }
               _loc13_ = param6;
               while(_loc13_ < param7)
               {
                  _loc14_ = param1.getFloatAt(_loc13_);
                  if(_loc14_.floatType != Float.NONE)
                  {
                     _loc8_.applyAdjustmentToFloat(_loc14_);
                  }
                  _loc13_++;
               }
               break;
            case VerticalAlign.JUSTIFY:
               _loc10_ = _loc8_.computeJustifyAdjustment(param3,param4,param5);
               _loc8_.applyJustifyAdjustment(param3,param4,param5);
               break;
         }
         return _loc10_;
      }
   }
}
import flashx.textLayout.compose.IVerticalJustificationLine;
import flashx.textLayout.container.ContainerController;
import flashx.textLayout.compose.FloatCompositionData;

interface IVerticalAdjustmentHelper
{
   
   function getBottom(param1:IVerticalJustificationLine, param2:ContainerController, param3:int, param4:int) : Number;
   
   function computeMiddleAdjustment(param1:Number) : Number;
   
   function applyAdjustment(param1:IVerticalJustificationLine) : void;
   
   function applyAdjustmentToFloat(param1:FloatCompositionData) : void;
   
   function computeBottomAdjustment(param1:Number) : Number;
   
   function computeJustifyAdjustment(param1:Array, param2:int, param3:int) : Number;
   
   function applyJustifyAdjustment(param1:Array, param2:int, param3:int) : void;
}
import flashx.textLayout.container.ContainerController;
import flashx.textLayout.compose.IVerticalJustificationLine;
import flashx.textLayout.compose.FloatCompositionData;
import flashx.textLayout.elements.InlineGraphicElement;
import flashx.textLayout.tlf_internal;
import flashx.textLayout.formats.Float;
import flashx.textLayout.compose.TextFlowLine;

use namespace tlf_internal;

class TB_VJHelper extends Object implements IVerticalAdjustmentHelper
{
   
   function TB_VJHelper(param1:ContainerController) {
      super();
      this._textFrame = param1;
   }
   
   private var _textFrame:ContainerController;
   
   private var adj:Number;
   
   public function getBottom(param1:IVerticalJustificationLine, param2:ContainerController, param3:int, param4:int) : Number {
      var _loc7_:FloatCompositionData = null;
      var _loc8_:InlineGraphicElement = null;
      var _loc5_:Number = this.getBaseline(param1) + param1.descent;
      var _loc6_:int = param3;
      while(_loc6_ < param4)
      {
         _loc7_ = param2.getFloatAt(_loc6_);
         if(_loc7_.floatType != Float.NONE)
         {
            _loc8_ = param2.rootElement.findLeaf(_loc7_.absolutePosition) as InlineGraphicElement;
            _loc5_ = Math.max(_loc5_,_loc7_.y + _loc8_.elementHeightWithMarginsAndPadding());
         }
         _loc6_++;
      }
      return _loc5_;
   }
   
   public function getBottomOfLine(param1:IVerticalJustificationLine) : Number {
      return this.getBaseline(param1) + param1.descent;
   }
   
   private function getBaseline(param1:IVerticalJustificationLine) : Number {
      if(param1 is TextFlowLine)
      {
         return param1.y + param1.ascent;
      }
      return param1.y;
   }
   
   private function setBaseline(param1:IVerticalJustificationLine, param2:Number) : void {
      if(param1 is TextFlowLine)
      {
         param1.y = param2 - param1.ascent;
      }
      else
      {
         param1.y = param2;
      }
   }
   
   public function computeMiddleAdjustment(param1:Number) : Number {
      var _loc2_:Number = this._textFrame.compositionHeight - Number(this._textFrame.getTotalPaddingBottom());
      this.adj = (_loc2_ - param1) / 2;
      if(this.adj < 0)
      {
         this.adj = 0;
      }
      return this.adj;
   }
   
   public function computeBottomAdjustment(param1:Number) : Number {
      var _loc2_:Number = this._textFrame.compositionHeight - Number(this._textFrame.getTotalPaddingBottom());
      this.adj = _loc2_ - param1;
      if(this.adj < 0)
      {
         this.adj = 0;
      }
      return this.adj;
   }
   
   public function applyAdjustment(param1:IVerticalJustificationLine) : void {
      param1.y = param1.y + this.adj;
   }
   
   public function applyAdjustmentToFloat(param1:FloatCompositionData) : void {
      param1.y = param1.y + this.adj;
   }
   
   public function computeJustifyAdjustment(param1:Array, param2:int, param3:int) : Number {
      this.adj = 0;
      if(param3 == 1)
      {
         return 0;
      }
      var _loc4_:IVerticalJustificationLine = param1[param2];
      var _loc5_:Number = this.getBaseline(_loc4_);
      var _loc6_:IVerticalJustificationLine = param1[param2 + param3-1];
      var _loc7_:Number = this._textFrame.compositionHeight - Number(this._textFrame.getTotalPaddingBottom());
      var _loc8_:Number = _loc7_ - this.getBottomOfLine(_loc6_);
      if(_loc8_ < 0)
      {
         return 0;
      }
      var _loc9_:Number = this.getBaseline(_loc6_);
      this.adj = _loc8_ / (_loc9_ - _loc5_);
      return this.adj;
   }
   
   public function applyJustifyAdjustment(param1:Array, param2:int, param3:int) : void {
      var _loc7_:IVerticalJustificationLine = null;
      var _loc8_:* = NaN;
      var _loc9_:* = NaN;
      if(param3 == 1 || this.adj == 0)
      {
         return;
      }
      var _loc4_:IVerticalJustificationLine = param1[param2];
      var _loc5_:Number = this.getBaseline(_loc4_);
      var _loc6_:Number = _loc5_;
      var _loc10_:* = 1;
      while(_loc10_ < param3)
      {
         _loc7_ = param1[_loc10_ + param2];
         _loc9_ = this.getBaseline(_loc7_);
         _loc8_ = _loc5_ + (_loc9_ - _loc6_) * (1 + this.adj);
         this.setBaseline(_loc7_,_loc8_);
         _loc6_ = _loc9_;
         _loc5_ = _loc8_;
         _loc10_++;
      }
   }
}
import flashx.textLayout.container.ContainerController;
import flashx.textLayout.compose.IVerticalJustificationLine;
import flashx.textLayout.compose.FloatCompositionData;
import flashx.textLayout.tlf_internal;
import flashx.textLayout.formats.Float;

use namespace tlf_internal;

class RL_VJHelper extends Object implements IVerticalAdjustmentHelper
{
   
   function RL_VJHelper(param1:ContainerController) {
      super();
      this._textFrame = param1;
   }
   
   private var _textFrame:ContainerController;
   
   private var adj:Number = 0;
   
   public function getBottom(param1:IVerticalJustificationLine, param2:ContainerController, param3:int, param4:int) : Number {
      var _loc8_:FloatCompositionData = null;
      var _loc5_:Number = this._textFrame.compositionWidth - Number(this._textFrame.getTotalPaddingLeft());
      var _loc6_:Number = _loc5_ + param1.x - param1.descent;
      var _loc7_:int = param3;
      while(_loc7_ < param4)
      {
         _loc8_ = param2.getFloatAt(_loc7_);
         if(_loc8_.floatType != Float.NONE)
         {
            _loc6_ = Math.min(_loc6_,_loc8_.x + _loc5_);
         }
         _loc7_++;
      }
      return _loc6_;
   }
   
   public function computeMiddleAdjustment(param1:Number) : Number {
      this.adj = param1 / 2;
      if(this.adj < 0)
      {
         this.adj = 0;
      }
      return -this.adj;
   }
   
   public function computeBottomAdjustment(param1:Number) : Number {
      this.adj = param1;
      if(this.adj < 0)
      {
         this.adj = 0;
      }
      return -this.adj;
   }
   
   public function applyAdjustment(param1:IVerticalJustificationLine) : void {
      param1.x = param1.x - this.adj;
   }
   
   public function applyAdjustmentToFloat(param1:FloatCompositionData) : void {
      param1.x = param1.x - this.adj;
   }
   
   public function computeJustifyAdjustment(param1:Array, param2:int, param3:int) : Number {
      this.adj = 0;
      if(param3 == 1)
      {
         return 0;
      }
      var _loc4_:IVerticalJustificationLine = param1[param2];
      var _loc5_:Number = _loc4_.x;
      var _loc6_:IVerticalJustificationLine = param1[param2 + param3-1];
      var _loc7_:Number = Number(this._textFrame.getTotalPaddingLeft()) - this._textFrame.compositionWidth;
      var _loc8_:Number = _loc6_.x - _loc6_.descent - _loc7_;
      if(_loc8_ < 0)
      {
         return 0;
      }
      var _loc9_:Number = _loc6_.x;
      this.adj = _loc8_ / (_loc5_ - _loc9_);
      return -this.adj;
   }
   
   public function applyJustifyAdjustment(param1:Array, param2:int, param3:int) : void {
      var _loc7_:IVerticalJustificationLine = null;
      var _loc8_:* = NaN;
      var _loc9_:* = NaN;
      if(param3 == 1 || this.adj == 0)
      {
         return;
      }
      var _loc4_:IVerticalJustificationLine = param1[param2];
      var _loc5_:Number = _loc4_.x;
      var _loc6_:Number = _loc5_;
      var _loc10_:* = 1;
      while(_loc10_ < param3)
      {
         _loc7_ = param1[_loc10_ + param2];
         _loc9_ = _loc7_.x;
         _loc8_ = _loc5_ - (_loc6_ - _loc9_) * (1 + this.adj);
         _loc7_.x = _loc8_;
         _loc6_ = _loc9_;
         _loc5_ = _loc8_;
         _loc10_++;
      }
   }
}
