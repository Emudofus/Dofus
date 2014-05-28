package flashx.textLayout.compose
{
   import flashx.textLayout.tlf_internal;
   import flashx.textLayout.elements.TextFlow;
   import flash.text.engine.TextLine;
   import flash.text.engine.TextBlock;
   import flashx.textLayout.elements.BackgroundManager;
   import flash.text.engine.TextLineValidity;
   import flashx.textLayout.elements.FlowLeafElement;
   
   use namespace tlf_internal;
   
   public class FlowComposerBase extends Object
   {
      
      public function FlowComposerBase() {
         super();
         this._lines = new Array();
         this._swfContext = null;
      }
      
      tlf_internal  static function computeBaseSWFContext(param1:ISWFContext) : ISWFContext {
         return (param1) && (Object(param1).hasOwnProperty("getBaseSWFContext"))?param1["getBaseSWFContext"]():param1;
      }
      
      private var _lines:Array;
      
      protected var _textFlow:TextFlow;
      
      protected var _damageAbsoluteStart:int;
      
      protected var _swfContext:ISWFContext;
      
      public function get lines() : Array {
         return this._lines;
      }
      
      public function getLineAt(param1:int) : TextFlowLine {
         return this._lines[param1];
      }
      
      public function get numLines() : int {
         return this._lines.length;
      }
      
      public function get textFlow() : TextFlow {
         return this._textFlow;
      }
      
      public function get damageAbsoluteStart() : int {
         return this._damageAbsoluteStart;
      }
      
      protected function initializeLines() : void {
         var _loc2_:TextFlowLine = null;
         var _loc3_:TextLine = null;
         var _loc4_:TextBlock = null;
         var _loc1_:BackgroundManager = this._textFlow?this._textFlow.backgroundManager:null;
         if(TextLineRecycler.textLineRecyclerEnabled)
         {
            for each (_loc2_ in this._lines)
            {
               _loc3_ = _loc2_.peekTextLine();
               if((_loc3_) && !_loc3_.parent)
               {
                  if(_loc3_.validity != TextLineValidity.INVALID)
                  {
                     _loc4_ = _loc3_.textBlock;
                     _loc4_.releaseLines(_loc4_.firstLine,_loc4_.lastLine);
                  }
                  if(_loc3_.validity != TextLineValidity.INVALID)
                  {
                     _loc3_.userData = null;
                     TextLineRecycler.addLineForReuse(_loc3_);
                     if(_loc1_)
                     {
                        _loc1_.removeLineFromCache(_loc3_);
                     }
                  }
                  else
                  {
                     _loc3_.userData = null;
                     TextLineRecycler.addLineForReuse(_loc3_);
                     if(_loc1_)
                     {
                        _loc1_.removeLineFromCache(_loc3_);
                     }
                  }
               }
            }
         }
         this._lines.splice(0);
         this._damageAbsoluteStart = 0;
      }
      
      protected function finalizeLinesAfterCompose() : void {
         var _loc1_:TextFlowLine = null;
         var _loc2_:* = 0;
         if(this._lines.length == 0)
         {
            _loc1_ = new TextFlowLine(null,null);
            _loc1_.setTextLength(this.textFlow.textLength);
            this._lines.push(_loc1_);
         }
         else
         {
            _loc1_ = this._lines[this._lines.length-1];
            _loc2_ = _loc1_.absoluteStart + _loc1_.textLength;
            if(_loc2_ < this.textFlow.textLength)
            {
               _loc1_ = new TextFlowLine(null,null);
               _loc1_.setAbsoluteStart(_loc2_);
               _loc1_.setTextLength(this.textFlow.textLength - _loc2_);
               this._lines.push(_loc1_);
            }
         }
      }
      
      public function updateLengths(param1:int, param2:int) : void {
         var _loc3_:TextFlowLine = null;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         if(this.numLines == 0)
         {
            return;
         }
         var _loc4_:int = this.findLineIndexAtPosition(param1);
         var _loc5_:int = int.MAX_VALUE;
         if(param2 > 0)
         {
            if(_loc4_ == this._lines.length)
            {
               _loc3_ = this._lines[this._lines.length-1];
               _loc3_.setTextLength(_loc3_.textLength + param2);
            }
            else
            {
               _loc3_ = this._lines[_loc4_++];
               _loc3_.setTextLength(_loc3_.textLength + param2);
            }
            _loc5_ = _loc3_.absoluteStart;
         }
         else
         {
            _loc6_ = -param2;
            _loc7_ = 0;
            do
            {
                  _loc3_ = this._lines[_loc4_];
                  _loc3_.setAbsoluteStart(_loc3_.absoluteStart + _loc6_ + param2);
                  _loc7_ = param1 > _loc3_.absoluteStart?param1:_loc3_.absoluteStart;
                  _loc8_ = _loc3_.absoluteStart + _loc3_.textLength;
                  _loc9_ = 0;
                  if(_loc7_ + _loc6_ <= _loc8_)
                  {
                     if(_loc7_ == _loc3_.absoluteStart)
                     {
                        _loc9_ = _loc6_;
                     }
                     else
                     {
                        if(_loc7_ == param1)
                        {
                           _loc9_ = _loc6_;
                        }
                     }
                  }
                  else
                  {
                     if(_loc7_ == _loc3_.absoluteStart)
                     {
                        _loc9_ = _loc3_.textLength;
                     }
                     else
                     {
                        _loc9_ = _loc8_ - _loc7_;
                     }
                  }
                  if(_loc7_ == _loc3_.absoluteStart && _loc7_ + _loc9_ == _loc8_)
                  {
                     _loc6_ = _loc6_ - _loc9_;
                     this._lines.splice(_loc4_,1);
                  }
                  else
                  {
                     if(_loc5_ > _loc3_.absoluteStart)
                     {
                        _loc5_ = _loc3_.absoluteStart;
                     }
                     _loc3_.setTextLength(_loc3_.textLength - _loc9_);
                     _loc6_ = _loc6_ - _loc9_;
                     _loc4_++;
                  }
               }while(_loc6_ > 0);
               
            }
            while(_loc4_ < this._lines.length)
            {
               _loc3_ = this._lines[_loc4_];
               if(param2 >= 0)
               {
                  _loc3_.setAbsoluteStart(_loc3_.absoluteStart + param2);
               }
               else
               {
                  _loc3_.setAbsoluteStart(_loc3_.absoluteStart > -param2?_loc3_.absoluteStart + param2:0);
               }
               _loc4_++;
            }
            if(this._damageAbsoluteStart > _loc5_)
            {
               this._damageAbsoluteStart = _loc5_;
            }
         }
         
         public function damage(param1:int, param2:int, param3:String) : void {
            var _loc6_:TextFlowLine = null;
            if(this._lines.length == 0 || this.textFlow.textLength == 0)
            {
               return;
            }
            if(param1 == this.textFlow.textLength)
            {
               return;
            }
            var _loc4_:int = this.findLineIndexAtPosition(param1);
            var _loc5_:FlowLeafElement = this.textFlow.findLeaf(param1);
            if((_loc5_) && _loc4_ > 0)
            {
               _loc4_--;
            }
            if(this.lines[_loc4_].absoluteStart < this._damageAbsoluteStart)
            {
               this._damageAbsoluteStart = this._lines[_loc4_].absoluteStart;
            }
            while(_loc4_ < this._lines.length)
            {
               _loc6_ = this._lines[_loc4_];
               if(_loc6_.absoluteStart >= param1 + param2)
               {
                  break;
               }
               _loc6_.damage(param3);
               _loc4_++;
            }
         }
         
         public function isDamaged(param1:int) : Boolean {
            if(this._lines.length == 0)
            {
               return true;
            }
            return this._damageAbsoluteStart <= param1 && !(this._damageAbsoluteStart == this.textFlow.textLength);
         }
         
         public function findLineIndexAtPosition(param1:int, param2:Boolean=false) : int {
            var _loc5_:* = 0;
            var _loc6_:TextFlowLine = null;
            var _loc3_:* = 0;
            var _loc4_:int = this._lines.length-1;
            while(_loc3_ <= _loc4_)
            {
               _loc5_ = (_loc3_ + _loc4_) / 2;
               _loc6_ = this._lines[_loc5_];
               if(_loc6_.absoluteStart <= param1)
               {
                  if(param2)
                  {
                     if(_loc6_.absoluteStart + _loc6_.textLength >= param1)
                     {
                        return _loc5_;
                     }
                  }
                  else
                  {
                     if(_loc6_.absoluteStart + _loc6_.textLength > param1)
                     {
                        return _loc5_;
                     }
                  }
                  _loc3_ = _loc5_ + 1;
               }
               else
               {
                  _loc4_ = _loc5_-1;
               }
            }
            return this._lines.length;
         }
         
         public function findLineAtPosition(param1:int, param2:Boolean=false) : TextFlowLine {
            return this._lines[this.findLineIndexAtPosition(param1,param2)];
         }
         
         public function addLine(param1:TextFlowLine, param2:int) : void {
            var _loc4_:TextFlowLine = null;
            var _loc6_:* = 0;
            var _loc7_:* = 0;
            var _loc8_:* = 0;
            var _loc9_:* = 0;
            var _loc10_:BackgroundManager = null;
            var _loc11_:* = 0;
            var _loc12_:TextLine = null;
            var _loc3_:TextFlowLine = this._lines[param2];
            var _loc5_:int = int.MAX_VALUE;
            if(this._damageAbsoluteStart == param1.absoluteStart)
            {
               this._damageAbsoluteStart = param1.absoluteStart + param1.textLength;
            }
            if(_loc3_ == null)
            {
               this.lines.push(param1);
            }
            else
            {
               if(_loc3_.absoluteStart != param1.absoluteStart)
               {
                  if(_loc3_.absoluteStart + _loc3_.textLength > param1.absoluteStart + param1.textLength)
                  {
                     _loc4_ = new TextFlowLine(null,param1.paragraph);
                     _loc4_.setAbsoluteStart(param1.absoluteStart + param1.textLength);
                     _loc6_ = _loc3_.textLength;
                     _loc3_.setTextLength(param1.absoluteStart - _loc3_.absoluteStart);
                     _loc4_.setTextLength(_loc6_ - param1.textLength - _loc3_.textLength);
                     this._lines.splice(param2 + 1,0,param1,_loc4_);
                  }
                  else
                  {
                     _loc3_.setTextLength(param1.absoluteStart - _loc3_.absoluteStart);
                     _loc4_ = this._lines[param2 + 1];
                     _loc4_.setTextLength(param1.absoluteStart + param1.textLength - _loc4_.absoluteStart);
                     _loc4_.setAbsoluteStart(param1.absoluteStart + param1.textLength);
                     this._lines.splice(param2 + 1,0,param1);
                  }
                  _loc5_ = _loc3_.absoluteStart;
               }
               else
               {
                  if(_loc3_.textLength > param1.textLength)
                  {
                     _loc3_.setTextLength(_loc3_.textLength - param1.textLength);
                     _loc3_.setAbsoluteStart(param1.absoluteStart + param1.textLength);
                     _loc3_.damage(TextLineValidity.INVALID);
                     this._lines.splice(param2,0,param1);
                     _loc5_ = _loc3_.absoluteStart;
                  }
                  else
                  {
                     _loc7_ = 1;
                     if(_loc3_.textLength != param1.textLength)
                     {
                        _loc8_ = param1.textLength - _loc3_.textLength;
                        _loc9_ = param2 + 1;
                        while(_loc8_ > 0)
                        {
                           _loc4_ = this._lines[_loc9_];
                           if(_loc8_ < _loc4_.textLength)
                           {
                              _loc4_.setTextLength(_loc4_.textLength - _loc8_);
                              _loc4_.damage(TextLineValidity.INVALID);
                              break;
                           }
                           _loc7_++;
                           _loc8_ = _loc8_ - _loc4_.textLength;
                           _loc9_++;
                           _loc4_ = _loc9_ < this._lines.length?this._lines[_loc9_]:null;
                        }
                        if((_loc4_) && !(_loc4_.absoluteStart == param1.absoluteStart + param1.textLength))
                        {
                           _loc4_.setAbsoluteStart(param1.absoluteStart + param1.textLength);
                           _loc4_.damage(TextLineValidity.INVALID);
                        }
                        _loc5_ = param1.absoluteStart + param1.textLength;
                     }
                     if(TextLineRecycler.textLineRecyclerEnabled)
                     {
                        _loc10_ = this.textFlow.backgroundManager;
                        _loc11_ = param2;
                        while(_loc11_ < param2 + _loc7_)
                        {
                           _loc12_ = TextFlowLine(this._lines[_loc11_]).peekTextLine();
                           if((_loc12_) && !_loc12_.parent)
                           {
                              if(_loc12_.validity != TextLineValidity.VALID)
                              {
                                 _loc12_.userData = null;
                                 TextLineRecycler.addLineForReuse(_loc12_);
                                 if(_loc10_)
                                 {
                                    _loc10_.removeLineFromCache(_loc12_);
                                 }
                              }
                           }
                           _loc11_++;
                        }
                     }
                     this._lines.splice(param2,_loc7_,param1);
                  }
               }
            }
            if(this._damageAbsoluteStart > _loc5_)
            {
               this._damageAbsoluteStart = _loc5_;
            }
         }
         
         public function get swfContext() : ISWFContext {
            return this._swfContext;
         }
         
         public function set swfContext(param1:ISWFContext) : void {
            var _loc2_:ISWFContext = null;
            var _loc3_:ISWFContext = null;
            if(param1 != this._swfContext)
            {
               if(this.textFlow)
               {
                  _loc2_ = computeBaseSWFContext(param1);
                  _loc3_ = computeBaseSWFContext(this._swfContext);
                  this._swfContext = param1;
                  if(_loc2_ != _loc3_)
                  {
                     this.damage(0,this.textFlow.textLength,FlowDamageType.INVALID);
                     this.textFlow.invalidateAllFormats();
                  }
               }
               else
               {
                  this._swfContext = param1;
               }
            }
         }
      }
   }
