package flashx.textLayout.elements
{
   import flash.utils.Dictionary;
   import flash.text.engine.TextLine;
   import flash.geom.Rectangle;
   import flashx.textLayout.tlf_internal;
   import flashx.textLayout.compose.TextFlowLine;
   import flash.display.Shape;
   import flashx.textLayout.container.ContainerController;
   import flash.display.Sprite;
   
   use namespace tlf_internal;
   
   public class BackgroundManager extends Object
   {
      
      public function BackgroundManager() {
         super();
         this._lineDict = new Dictionary(true);
      }
      
      protected var _lineDict:Dictionary;
      
      public function addRect(param1:TextLine, param2:FlowLeafElement, param3:Rectangle, param4:uint, param5:Number) : void {
         var _loc10_:Object = null;
         var _loc6_:Array = this._lineDict[param1];
         if(_loc6_ == null)
         {
            _loc6_ = this._lineDict[param1] = new Array();
         }
         var _loc7_:Object = new Object();
         _loc7_.rect = param3;
         _loc7_.fle = param2;
         _loc7_.color = param4;
         _loc7_.alpha = param5;
         var _loc8_:int = param2.getAbsoluteStart();
         var _loc9_:* = 0;
         while(_loc9_ < _loc6_.length)
         {
            _loc10_ = _loc6_[_loc9_];
            if((_loc10_.hasOwnProperty("fle")) && _loc10_.fle.getAbsoluteStart() == _loc8_)
            {
               _loc6_[_loc9_] = _loc7_;
               return;
            }
            _loc9_++;
         }
         _loc6_.push(_loc7_);
      }
      
      public function addNumberLine(param1:TextLine, param2:TextLine) : void {
         var _loc3_:Array = this._lineDict[param1];
         if(_loc3_ == null)
         {
            _loc3_ = this._lineDict[param1] = new Array();
         }
         _loc3_.push({"numberLine":param2});
      }
      
      public function finalizeLine(param1:TextFlowLine) : void {
      }
      
      tlf_internal function getEntry(param1:TextLine) : * {
         return this._lineDict?this._lineDict[param1]:undefined;
      }
      
      public function drawAllRects(param1:TextFlow, param2:Shape, param3:Number, param4:Number) : void {
         var _loc5_:Object = null;
         var _loc6_:Array = null;
         var _loc7_:Rectangle = null;
         var _loc8_:Rectangle = null;
         var _loc9_:Object = null;
         var _loc10_:* = 0;
         var _loc11_:TextLine = null;
         var _loc12_:BackgroundManager = null;
         var _loc13_:Array = null;
         var _loc14_:* = 0;
         var _loc15_:Object = null;
         for (_loc5_ in this._lineDict)
         {
            _loc6_ = this._lineDict[_loc5_];
            if(_loc6_.length)
            {
               _loc7_ = _loc6_[0].columnRect;
               _loc10_ = 0;
               while(_loc10_ < _loc6_.length)
               {
                  _loc9_ = _loc6_[_loc10_];
                  if(_loc9_.hasOwnProperty("numberLine"))
                  {
                     _loc11_ = _loc9_.numberLine;
                     _loc12_ = TextFlowLine.getNumberLineBackground(_loc11_);
                     _loc13_ = _loc12_._lineDict[_loc11_];
                     _loc14_ = 0;
                     while(_loc14_ < _loc13_.length)
                     {
                        _loc15_ = _loc13_[_loc14_];
                        _loc8_ = _loc15_.rect;
                        _loc8_.x = _loc8_.x + (_loc5_.x + _loc11_.x);
                        _loc8_.y = _loc8_.y + (_loc5_.y + _loc11_.y);
                        TextFlowLine.constrainRectToColumn(param1,_loc8_,_loc7_,0,0,param3,param4);
                        param2.graphics.beginFill(_loc15_.color,_loc15_.alpha);
                        param2.graphics.drawRect(_loc8_.x,_loc8_.y,_loc8_.width,_loc8_.height);
                        param2.graphics.endFill();
                        _loc14_++;
                     }
                  }
                  else
                  {
                     _loc8_ = _loc9_.rect;
                     _loc8_.x = _loc8_.x + _loc5_.x;
                     _loc8_.y = _loc8_.y + _loc5_.y;
                     TextFlowLine.constrainRectToColumn(param1,_loc8_,_loc7_,0,0,param3,param4);
                     param2.graphics.beginFill(_loc9_.color,_loc9_.alpha);
                     param2.graphics.drawRect(_loc8_.x,_loc8_.y,_loc8_.width,_loc8_.height);
                     param2.graphics.endFill();
                  }
                  if(_loc9_.hasOwnProperty("numberLine"))
                  {
                     _loc10_++;
                  }
                  else
                  {
                     _loc10_++;
                  }
               }
            }
         }
      }
      
      public function removeLineFromCache(param1:TextLine) : void {
         delete this._lineDict[[param1]];
      }
      
      public function onUpdateComplete(param1:ContainerController) : void {
         var _loc3_:Shape = null;
         var _loc4_:* = 0;
         var _loc5_:TextLine = null;
         var _loc6_:Array = null;
         var _loc7_:Rectangle = null;
         var _loc8_:TextFlowLine = null;
         var _loc9_:* = 0;
         var _loc10_:Object = null;
         var _loc11_:TextLine = null;
         var _loc12_:BackgroundManager = null;
         var _loc13_:Array = null;
         var _loc14_:* = 0;
         var _loc15_:Object = null;
         var _loc2_:Sprite = param1.container;
         if((_loc2_) && (_loc2_.numChildren))
         {
            _loc3_ = param1.getBackgroundShape();
            _loc3_.graphics.clear();
            _loc4_ = 0;
            while(_loc4_ < param1.textLines.length)
            {
               _loc5_ = param1.textLines[_loc4_];
               _loc6_ = this._lineDict[_loc5_];
               if(_loc6_)
               {
                  _loc8_ = _loc5_.userData as TextFlowLine;
                  _loc9_ = 0;
                  while(_loc9_ < _loc6_.length)
                  {
                     _loc10_ = _loc6_[_loc9_];
                     if(_loc10_.hasOwnProperty("numberLine"))
                     {
                        _loc11_ = _loc10_.numberLine;
                        _loc12_ = TextFlowLine.getNumberLineBackground(_loc11_);
                        _loc13_ = _loc12_._lineDict[_loc11_];
                        _loc14_ = 0;
                        while(_loc14_ < _loc13_.length)
                        {
                           _loc15_ = _loc13_[_loc14_];
                           _loc7_ = _loc15_.rect.clone();
                           _loc7_.x = _loc7_.x + _loc11_.x;
                           _loc7_.y = _loc7_.y + _loc11_.y;
                           _loc8_.convertLineRectToContainer(_loc7_,true);
                           _loc3_.graphics.beginFill(_loc15_.color,_loc15_.alpha);
                           _loc3_.graphics.drawRect(_loc7_.x,_loc7_.y,_loc7_.width,_loc7_.height);
                           _loc3_.graphics.endFill();
                           _loc14_++;
                        }
                     }
                     else
                     {
                        _loc7_ = _loc10_.rect.clone();
                        _loc8_.convertLineRectToContainer(_loc7_,true);
                        _loc3_.graphics.beginFill(_loc10_.color,_loc10_.alpha);
                        _loc3_.graphics.drawRect(_loc7_.x,_loc7_.y,_loc7_.width,_loc7_.height);
                        _loc3_.graphics.endFill();
                     }
                     _loc9_++;
                  }
               }
               _loc4_++;
            }
         }
      }
   }
}
