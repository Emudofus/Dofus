package flashx.textLayout.container
{
   import flash.geom.Rectangle;
   import flashx.textLayout.tlf_internal;
   import flashx.textLayout.formats.ITextLayoutFormat;
   import flashx.textLayout.formats.FormatValue;
   import flashx.textLayout.formats.LineBreak;
   import flashx.textLayout.formats.BlockProgression;
   import flashx.textLayout.formats.Direction;
   import flashx.textLayout.utils.Twips;
   
   use namespace tlf_internal;
   
   public class ColumnState extends Object
   {
      
      public function ColumnState(param1:String, param2:String, param3:ContainerController, param4:Number, param5:Number) {
         super();
         this._inputsChanged = true;
         this._columnCount = 0;
         if(param1 != null)
         {
            this.updateInputs(param1,param2,param3,param4,param5);
            this.computeColumns();
         }
      }
      
      private var _inputsChanged:Boolean;
      
      private var _blockProgression:String;
      
      private var _columnDirection:String;
      
      private var _paddingTop:Number;
      
      private var _paddingBottom:Number;
      
      private var _paddingLeft:Number;
      
      private var _paddingRight:Number;
      
      private var _compositionWidth:Number;
      
      private var _compositionHeight:Number;
      
      private var _forceSingleColumn:Boolean;
      
      private var _inputColumnWidth:Object;
      
      private var _inputColumnGap:Number;
      
      private var _inputColumnCount:Object;
      
      private var _columnWidth:Number;
      
      private var _columnCount:int;
      
      private var _columnGap:Number;
      
      private var _inset:Number;
      
      private var _columnArray:Array;
      
      private var _singleColumn:Rectangle;
      
      public function get columnWidth() : Number {
         return this._columnWidth;
      }
      
      public function get columnCount() : int {
         return this._columnCount;
      }
      
      public function get columnGap() : Number {
         return this._columnGap;
      }
      
      public function getColumnAt(param1:int) : Rectangle {
         return this._columnCount == 1?this._singleColumn:this._columnArray[param1];
      }
      
      tlf_internal function updateInputs(param1:String, param2:String, param3:ContainerController, param4:Number, param5:Number) : void {
         var _loc6_:Number = param3.getTotalPaddingTop();
         var _loc7_:Number = param3.getTotalPaddingBottom();
         var _loc8_:Number = param3.getTotalPaddingLeft();
         var _loc9_:Number = param3.getTotalPaddingRight();
         var _loc10_:ITextLayoutFormat = param3.computedFormat;
         var _loc11_:Object = _loc10_.columnWidth;
         var _loc12_:Number = _loc10_.columnGap;
         var _loc13_:Object = _loc10_.columnCount;
         var _loc14_:Boolean = _loc10_.columnCount == FormatValue.AUTO && (_loc10_.columnWidth == FormatValue.AUTO || Number(_loc10_.columnWidth) == 0) || param3.rootElement.computedFormat.lineBreak == LineBreak.EXPLICIT || (isNaN(param1 == BlockProgression.RL?param5:param4));
         if(this._inputsChanged == false)
         {
            this._inputsChanged = !(param4 == this._compositionHeight) || !(param5 == this._compositionHeight) || !(this._paddingTop == _loc6_) || !(this._paddingBottom == _loc7_) || !(this._paddingLeft == _loc8_) || !(this._paddingRight == _loc9_) || !(this._blockProgression == this._blockProgression) || !(this._columnDirection == param2) || !(this._forceSingleColumn == _loc14_) || !(this._inputColumnWidth == _loc11_) || !(this._inputColumnGap == _loc12_) || !(this._inputColumnCount == _loc13_);
         }
         if(this._inputsChanged)
         {
            this._blockProgression = param1;
            this._columnDirection = param2;
            this._paddingTop = _loc6_;
            this._paddingBottom = _loc7_;
            this._paddingLeft = _loc8_;
            this._paddingRight = _loc9_;
            this._compositionWidth = param4;
            this._compositionHeight = param5;
            this._forceSingleColumn = _loc14_;
            this._inputColumnWidth = _loc11_;
            this._inputColumnGap = _loc12_;
            this._inputColumnCount = _loc13_;
         }
      }
      
      tlf_internal function computeColumns() : void {
         var _loc1_:* = NaN;
         var _loc2_:* = 0;
         var _loc3_:* = NaN;
         var _loc6_:* = NaN;
         var _loc7_:* = NaN;
         var _loc8_:* = NaN;
         var _loc9_:* = NaN;
         var _loc10_:* = NaN;
         var _loc11_:* = NaN;
         var _loc12_:* = NaN;
         var _loc13_:* = 0;
         if(!this._inputsChanged)
         {
            return;
         }
         var _loc4_:Number = this._blockProgression == BlockProgression.RL?this._compositionHeight:this._compositionWidth;
         var _loc5_:Number = this._blockProgression == BlockProgression.RL?this._paddingTop + this._paddingBottom:this._paddingLeft + this._paddingRight;
         _loc4_ = _loc4_ > _loc5_ && !isNaN(_loc4_)?_loc4_ - _loc5_:0;
         if(this._forceSingleColumn)
         {
            _loc2_ = 1;
            _loc3_ = _loc4_;
            _loc1_ = 0;
         }
         else
         {
            _loc1_ = this._inputColumnGap;
            if(this._inputColumnWidth == FormatValue.AUTO)
            {
               _loc2_ = Number(this._inputColumnCount);
               if((_loc2_-1) * _loc1_ < _loc4_)
               {
                  _loc3_ = (_loc4_ - (_loc2_-1) * _loc1_) / _loc2_;
               }
               else
               {
                  if(_loc1_ > _loc4_)
                  {
                     _loc2_ = 1;
                     _loc3_ = _loc4_;
                     _loc1_ = 0;
                  }
                  else
                  {
                     _loc2_ = Math.floor(_loc4_ / _loc1_);
                     _loc3_ = (_loc4_ - (_loc2_-1) * _loc1_) / _loc2_;
                  }
               }
            }
            else
            {
               if(this._inputColumnCount == FormatValue.AUTO)
               {
                  _loc3_ = Number(this._inputColumnWidth);
                  if(_loc3_ >= _loc4_)
                  {
                     _loc2_ = 1;
                     _loc3_ = _loc4_;
                     _loc1_ = 0;
                  }
                  else
                  {
                     _loc2_ = Math.floor((_loc4_ + _loc1_) / (_loc3_ + _loc1_));
                     _loc3_ = (_loc4_ + _loc1_) / _loc2_ - _loc1_;
                  }
               }
               else
               {
                  _loc2_ = Number(this._inputColumnCount);
                  _loc3_ = Number(this._inputColumnWidth);
                  if(_loc2_ * _loc3_ + (_loc2_-1) * _loc1_ > _loc4_)
                  {
                     if(_loc3_ >= _loc4_)
                     {
                        _loc2_ = 1;
                        _loc1_ = 0;
                     }
                     else
                     {
                        _loc2_ = Math.floor((_loc4_ + _loc1_) / (_loc3_ + _loc1_));
                        _loc3_ = (_loc4_ + _loc1_) / _loc2_ - _loc1_;
                     }
                  }
               }
            }
         }
         this._columnWidth = _loc3_;
         this._columnCount = _loc2_;
         this._columnGap = _loc1_;
         this._inset = _loc5_;
         if(this._blockProgression == BlockProgression.TB)
         {
            if(this._columnDirection == Direction.LTR)
            {
               _loc6_ = this._paddingLeft;
               _loc8_ = this._columnWidth + this._columnGap;
               _loc11_ = this._columnWidth;
            }
            else
            {
               _loc6_ = isNaN(this._compositionWidth)?this._paddingLeft:this._compositionWidth - this._paddingRight - this._columnWidth;
               _loc8_ = -(this._columnWidth + this._columnGap);
               _loc11_ = this._columnWidth;
            }
            _loc7_ = this._paddingTop;
            _loc9_ = 0;
            _loc12_ = this._paddingTop + this._paddingBottom;
            _loc10_ = this._compositionHeight > _loc12_ && !isNaN(this._compositionHeight)?this._compositionHeight - _loc12_:0;
         }
         else
         {
            if(this._blockProgression == BlockProgression.RL)
            {
               _loc6_ = isNaN(this._compositionWidth)?-this._paddingRight:this._paddingLeft - this._compositionWidth;
               _loc7_ = this._paddingTop;
               _loc8_ = 0;
               _loc9_ = this._columnWidth + this._columnGap;
               _loc12_ = this._paddingLeft + this._paddingRight;
               _loc11_ = this._compositionWidth > _loc12_?this._compositionWidth - _loc12_:0;
               _loc10_ = this._columnWidth;
            }
         }
         if(_loc11_ == 0)
         {
            _loc11_ = Twips.ONE_TWIP;
            if(this._blockProgression == BlockProgression.RL)
            {
               _loc6_ = _loc6_ - _loc11_;
            }
         }
         if(_loc10_ == 0)
         {
            _loc10_ = Twips.ONE_TWIP;
         }
         if(this._columnCount == 1)
         {
            this._singleColumn = new Rectangle(_loc6_,_loc7_,_loc11_,_loc10_);
            this._columnArray = null;
         }
         else
         {
            if(this._columnCount == 0)
            {
               this._singleColumn = null;
               this._columnArray = null;
            }
            else
            {
               if(this._columnArray)
               {
                  this._columnArray.splice(0);
               }
               else
               {
                  this._columnArray = new Array();
               }
               _loc13_ = 0;
               while(_loc13_ < this._columnCount)
               {
                  this._columnArray.push(new Rectangle(_loc6_,_loc7_,_loc11_,_loc10_));
                  _loc6_ = _loc6_ + _loc8_;
                  _loc7_ = _loc7_ + _loc9_;
                  _loc13_++;
               }
            }
         }
      }
   }
}
