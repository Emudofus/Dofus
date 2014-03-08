package com.ankamagames.berilia.types.tooltip
{
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.Dictionary;
   import com.ankamagames.berilia.types.LocationEnum;
   import flash.display.DisplayObject;
   import com.ankamagames.jerakine.interfaces.IRectangle;
   import flash.geom.Point;
   import com.ankamagames.jerakine.utils.display.Rectangle2;
   import flash.geom.Rectangle;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.managers.TooltipManager;
   import flash.events.Event;
   import com.ankamagames.berilia.types.event.UiRenderEvent;
   import __AS3__.vec.*;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class TooltipPlacer extends Object
   {
      
      public function TooltipPlacer() {
         super();
      }
      
      protected static var _log:Logger = Log.getLogger(getQualifiedClassName(TooltipPlacer));
      
      private static var _tooltips:Vector.<TooltipPosition> = new Vector.<TooltipPosition>(0);
      
      private static var _tooltipsRows:Dictionary = new Dictionary();
      
      private static var _tooltipsToWait:Vector.<String> = new Vector.<String>(0);
      
      private static const _anchors:Array = [];
      
      private static var _init:Boolean;
      
      private static function init() : void {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         if(_init)
         {
            return;
         }
         _init = true;
         var _loc1_:Array = [LocationEnum.POINT_TOPLEFT,LocationEnum.POINT_TOP,LocationEnum.POINT_TOPRIGHT,LocationEnum.POINT_LEFT,LocationEnum.POINT_CENTER,LocationEnum.POINT_RIGHT,LocationEnum.POINT_BOTTOMLEFT,LocationEnum.POINT_BOTTOM,LocationEnum.POINT_BOTTOMRIGHT];
         for each (_loc2_ in _loc1_)
         {
            for each (_loc3_ in _loc1_)
            {
               _anchors.push(
                  {
                     "p1":_loc2_,
                     "p2":_loc3_
                  });
            }
         }
      }
      
      private static function getAnchors() : Array {
         init();
         return _anchors.concat();
      }
      
      public static function place(param1:DisplayObject, param2:IRectangle, param3:uint=6, param4:uint=0, param5:int=3, param6:Boolean=true) : void {
         var _loc14_:Point = null;
         var _loc15_:Point = null;
         var _loc16_:Rectangle2 = null;
         var _loc17_:Point = null;
         var _loc18_:Rectangle2 = null;
         var _loc19_:* = 0;
         var _loc20_:Object = null;
         var _loc21_:Object = null;
         var _loc22_:Object = null;
         var _loc7_:* = false;
         var _loc8_:Rectangle = param1.getBounds(param1);
         var _loc9_:uint = param3;
         var _loc10_:uint = param4;
         var _loc11_:* = false;
         var _loc12_:Array = getAnchors();
         var _loc13_:Array = new Array();
         while(!_loc7_)
         {
            _loc14_ = new Point(param2.x,param2.y);
            _loc15_ = new Point(param1.x,param1.y);
            _loc16_ = new Rectangle2(param1.x,param1.y,param1.width,param1.height);
            processAnchor(_loc15_,_loc16_,param3);
            processAnchor(_loc14_,param2,param4);
            _loc17_ = makeOffset(param3,param5);
            _loc14_.x = _loc14_.x - (_loc15_.x - _loc17_.x + _loc8_.left);
            _loc14_.y = _loc14_.y - (_loc15_.y - _loc17_.y);
            _loc18_ = new Rectangle2(_loc14_.x,_loc14_.y,_loc16_.width,_loc16_.height);
            if(param6)
            {
               if(_loc18_.y < 0)
               {
                  _loc18_.y = 0;
               }
               if(_loc18_.x < 0)
               {
                  _loc18_.x = 0;
               }
               if(_loc18_.y + _loc18_.height > StageShareManager.startHeight)
               {
                  _loc18_.y = _loc18_.y - (_loc18_.height + _loc18_.y - StageShareManager.startHeight);
               }
               if(_loc18_.x + _loc18_.width > StageShareManager.startWidth)
               {
                  _loc18_.x = _loc18_.x - (_loc18_.width + _loc18_.x - StageShareManager.startWidth);
               }
            }
            if(!_loc11_)
            {
               _loc19_ = hitTest(_loc18_,param2);
               _loc7_ = _loc19_ == 0;
               if(!_loc7_)
               {
                  _loc20_ = _loc12_.shift();
                  if(!_loc20_)
                  {
                     _loc21_ = 
                        {
                           "size":param2.width * param2.height,
                           "point":
                              {
                                 "p1":_loc9_,
                                 "p2":_loc10_
                              }
                        };
                     for each (_loc22_ in _loc13_)
                     {
                        if(_loc21_.size > _loc22_.size)
                        {
                           _loc21_ = _loc22_;
                        }
                     }
                     _loc11_ = true;
                     param3 = _loc21_.point.p1;
                     param4 = _loc21_.point.p2;
                  }
                  else
                  {
                     _loc13_.push(
                        {
                           "size":_loc19_,
                           "point":
                              {
                                 "p1":param3,
                                 "p2":param4
                              }
                        });
                     param3 = _loc20_.p1;
                     param4 = _loc20_.p2;
                  }
               }
            }
            else
            {
               _loc7_ = true;
            }
         }
         param1.x = _loc18_.x;
         param1.y = _loc18_.y;
      }
      
      public static function placeWithArrow(param1:DisplayObject, param2:IRectangle) : Object {
         var _loc3_:Point = new Point(param1.x,param1.y);
         var _loc4_:Object = 
            {
               "bottomFlip":false,
               "leftFlip":false
            };
         _loc3_.x = param2.x + param2.width / 2 + 5;
         _loc3_.y = param2.y - param1.height;
         if(_loc3_.x + param1.width > StageShareManager.startWidth)
         {
            _loc4_.leftFlip = true;
            _loc3_.x = _loc3_.x - (param1.width + 10);
         }
         if(_loc3_.y < 0)
         {
            _loc4_.bottomFlip = true;
            _loc3_.y = param2.y + param2.height;
         }
         param1.x = _loc3_.x;
         param1.y = _loc3_.y;
         return _loc4_;
      }
      
      public static function waitBeforeOrder(param1:String) : void {
         if(_tooltipsToWait.indexOf(param1) == -1)
         {
            _tooltipsToWait.push(param1);
         }
      }
      
      public static function addTooltipPosition(param1:UiRootContainer, param2:IRectangle, param3:uint) : void {
         var _loc4_:* = 0;
         var _loc5_:int = _tooltips.length;
         var _loc6_:* = false;
         var _loc7_:String = TooltipManager.getTooltipName(param1);
         if(!_loc7_)
         {
            _loc7_ = param1.customUnicName;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            if(_tooltips[_loc4_].tooltip == param1)
            {
               _loc6_ = true;
               _tooltips.splice(_loc4_,1,new TooltipPosition(param1,param2,param3));
               break;
            }
            _loc4_++;
         }
         if(!_loc6_)
         {
            _tooltips.push(new TooltipPosition(param1,param2,param3));
         }
         var _loc8_:int = _tooltipsToWait.indexOf(_loc7_);
         if(_loc8_ != -1)
         {
            _tooltipsToWait.splice(_loc8_,1);
         }
         if(_tooltipsToWait.length == 0)
         {
            checkRender();
         }
      }
      
      public static function checkRender(param1:Event=null) : void {
         var _loc2_:TooltipPosition = null;
         if(param1)
         {
            param1.currentTarget.removeEventListener(UiRenderEvent.UIRenderComplete,checkRender);
         }
         for each (_loc2_ in _tooltips)
         {
            if(!_loc2_.tooltip.ready)
            {
               _loc2_.tooltip.addEventListener(UiRenderEvent.UIRenderComplete,checkRender);
               return;
            }
         }
         orderTooltips();
      }
      
      public static function removeTooltipPosition(param1:UiRootContainer) : void {
         var _loc2_:TooltipPosition = null;
         var _loc5_:* = 0;
         var _loc3_:* = -1;
         for each (_loc2_ in _tooltips)
         {
            if(_loc2_.tooltip == param1)
            {
               _loc3_ = _tooltips.indexOf(_loc2_);
               break;
            }
         }
         if(_loc3_ != -1)
         {
            _tooltips.splice(_loc3_,1);
         }
         var _loc4_:String = TooltipManager.getTooltipName(param1);
         _loc5_ = _tooltipsToWait.indexOf(_loc4_);
         if(_loc5_ != -1)
         {
            _tooltipsToWait.splice(_loc5_,1);
         }
      }
      
      public static function removeTooltipPositionByName(param1:String) : void {
         var _loc2_:TooltipPosition = null;
         var _loc4_:* = 0;
         var _loc3_:* = -1;
         for each (_loc2_ in _tooltips)
         {
            if(_loc2_.tooltip.customUnicName == param1)
            {
               _loc3_ = _tooltips.indexOf(_loc2_);
               break;
            }
         }
         if(_loc3_ != -1)
         {
            _tooltips.splice(_loc3_,1);
         }
         _loc4_ = _tooltipsToWait.indexOf(param1);
         if(_loc4_ != -1)
         {
            _tooltipsToWait.splice(_loc4_,1);
         }
      }
      
      private static function orderTooltips() : void {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:TooltipPosition = null;
         var _loc5_:Vector.<TooltipPosition> = null;
         var _loc9_:* = NaN;
         var _loc10_:* = NaN;
         var _loc11_:* = 0;
         var _loc12_:* = 0;
         var _loc13_:* = 0;
         var _loc14_:* = false;
         var _loc15_:* = NaN;
         var _loc16_:* = false;
         var _loc17_:* = NaN;
         var _loc18_:* = false;
         var _loc19_:Object = null;
         var _loc1_:int = _tooltips.length;
         var _loc6_:Number = 0;
         var _loc7_:Number = 0;
         var _loc8_:Number = 0;
         _tooltips.sort(compareVerticalPos);
         _loc2_ = _loc1_-1;
         while(_loc2_ >= 0)
         {
            _loc12_ = _tooltips[_loc2_].mapRow;
            if(!_tooltipsRows[_loc12_])
            {
               _tooltipsRows[_loc12_] = new Vector.<TooltipPosition>(0);
            }
            _loc5_ = isTooltipSuperposed(_tooltips[_loc2_]);
            _loc16_ = false;
            for each (_loc4_ in _loc5_)
            {
               if(_loc4_.mapRow == _loc12_ && !(_loc4_.tooltip.customUnicName == _tooltips[_loc2_].tooltip.customUnicName))
               {
                  _loc16_ = true;
                  break;
               }
            }
            if(_loc16_)
            {
               _tooltipsRows[_loc12_].push(_tooltips[_loc2_]);
            }
            if(_loc2_ + 1 < _loc1_)
            {
               _loc11_ = _tooltipsRows[_loc12_].length;
               if(_loc11_ > 1)
               {
                  _loc10_ = 0;
                  _loc6_ = 0;
                  _loc8_ = 0;
                  _loc7_ = 0;
                  for each (_loc4_ in _tooltipsRows[_loc12_])
                  {
                     _loc7_ = _loc7_ == 0?_loc4_.tooltip.y:_loc4_.tooltip.y < _loc7_?_loc4_.tooltip.y:_loc7_;
                  }
                  _loc3_ = _loc2_ + 1;
                  while(_loc3_ < _loc1_)
                  {
                     if(!(_tooltips[_loc3_].mapRow == _loc12_) && _loc7_ > _tooltips[_loc3_].tooltip.y - _tooltips[_loc2_].tooltip.height - 2)
                     {
                        _loc7_ = _tooltips[_loc3_].tooltip.y - _tooltips[_loc2_].tooltip.height - 2;
                        break;
                     }
                     _loc3_++;
                  }
                  for each (_loc4_ in _tooltipsRows[_loc12_])
                  {
                     _loc4_.tooltip.y = _loc7_;
                  }
                  _loc6_ = _loc8_ = _tooltips[_loc2_].target.x;
                  for each (_loc4_ in _tooltipsRows[_loc12_])
                  {
                     if(_loc4_.target.x < _loc6_)
                     {
                        _loc6_ = _loc4_.target.x;
                     }
                     else
                     {
                        if(_loc4_.target.x > _loc8_)
                        {
                           _loc8_ = _loc4_.target.x;
                        }
                     }
                     _loc10_ = _loc10_ + _loc4_.tooltip.width;
                  }
                  _tooltipsRows[_loc12_].sort(compareHorizontalPos);
                  _loc11_ = _tooltipsRows[_loc12_].length;
                  if(_loc11_ > 0)
                  {
                     _loc10_ = _loc10_ + 2 * (_loc11_-1);
                     _loc9_ = _loc8_ - (_loc8_ - _loc6_) / 2;
                     _tooltipsRows[_loc12_][0].tooltip.x = _loc9_ + 43 - _loc10_ / 2;
                     _loc3_ = 1;
                     while(_loc3_ < _loc11_)
                     {
                        _tooltipsRows[_loc12_][_loc3_].tooltip.x = _tooltipsRows[_loc12_][_loc3_-1].tooltip.x + _tooltipsRows[_loc12_][_loc3_-1].tooltip.width + 2;
                        _loc3_++;
                     }
                  }
               }
               else
               {
                  _loc14_ = false;
                  while(!_loc14_)
                  {
                     _loc3_ = _loc2_ + 1;
                     while(_loc3_ < _loc1_)
                     {
                        _loc14_ = true;
                        if(hitTest(_tooltips[_loc2_].rect,_tooltips[_loc3_].rect) != 0)
                        {
                           _loc15_ = _tooltips[_loc3_].tooltip.y - _tooltips[_loc2_].tooltip.height - 2;
                           if(_loc15_ < 0)
                           {
                              _tooltips[_loc2_].tooltip.y = 0;
                              _loc4_ = _tooltips[_loc3_];
                              _loc17_ = _tooltips[_loc2_].tooltip.x;
                              if(_tooltips[_loc2_].originalX < _loc4_.originalX)
                              {
                                 _tooltips[_loc2_].tooltip.x = _loc4_.tooltip.x - _tooltips[_loc2_].tooltip.width - 2;
                              }
                              else
                              {
                                 _tooltips[_loc2_].tooltip.x = _loc4_.tooltip.x + _loc4_.tooltip.width + 2;
                              }
                              _loc18_ = _tooltips[_loc2_].tooltip.x < 0 || _tooltips[_loc2_].tooltip.x + _tooltips[_loc2_].tooltip.width + 2 > StageShareManager.stage.stageWidth;
                              if((_loc18_) || (isTooltipSuperposed(_tooltips[_loc2_])))
                              {
                                 _tooltips[_loc2_].tooltip.x = _loc17_;
                                 _tooltips[_loc2_].tooltip.y = _loc15_;
                              }
                           }
                           else
                           {
                              _tooltips[_loc2_].tooltip.y = _loc15_;
                           }
                           _loc14_ = false;
                           break;
                        }
                        _loc3_++;
                     }
                  }
               }
            }
            _loc2_--;
         }
         for (_loc19_ in _tooltipsRows)
         {
            delete _tooltipsRows[[_loc19_]];
         }
      }
      
      private static function isTooltipSuperposed(param1:TooltipPosition) : Vector.<TooltipPosition> {
         var _loc2_:TooltipPosition = null;
         var _loc3_:Vector.<TooltipPosition> = null;
         for each (_loc2_ in _tooltips)
         {
            if(!(_loc2_ == param1) && !(hitTest(_loc2_.rect,param1.rect) == 0))
            {
               if(!_loc3_)
               {
                  _loc3_ = new Vector.<TooltipPosition>(0);
               }
               _loc3_.push(_loc2_);
            }
         }
         return _loc3_;
      }
      
      private static function compareVerticalPos(param1:TooltipPosition, param2:TooltipPosition) : int {
         var _loc3_:* = 0;
         if(param1.mapRow > param2.mapRow)
         {
            _loc3_ = 1;
         }
         else
         {
            if(param1.mapRow < param2.mapRow)
            {
               _loc3_ = -1;
            }
            else
            {
               _loc3_ = 0;
            }
         }
         return _loc3_;
      }
      
      private static function compareHorizontalPos(param1:TooltipPosition, param2:TooltipPosition) : int {
         var _loc3_:* = 0;
         if(param1.tooltip.x > param2.tooltip.x)
         {
            _loc3_ = 1;
         }
         else
         {
            if(param1.tooltip.x < param2.tooltip.x)
            {
               _loc3_ = -1;
            }
            else
            {
               _loc3_ = 0;
            }
         }
         return _loc3_;
      }
      
      private static function hitTest(param1:IRectangle, param2:IRectangle) : int {
         var _loc3_:Rectangle = new Rectangle(param1.x,param1.y,param1.width,param1.height);
         var _loc4_:Rectangle = new Rectangle(param2.x,param2.y,param2.width,param2.height);
         var _loc5_:Rectangle = _loc3_.intersection(_loc4_);
         return _loc5_.width * _loc5_.height;
      }
      
      private static function processAnchor(param1:Point, param2:IRectangle, param3:uint) : Point {
         switch(param3)
         {
            case LocationEnum.POINT_TOPLEFT:
               break;
            case LocationEnum.POINT_TOP:
               param1.x = param1.x + param2.width / 2;
               break;
            case LocationEnum.POINT_TOPRIGHT:
               param1.x = param1.x + param2.width;
               break;
            case LocationEnum.POINT_LEFT:
               param1.y = param1.y + param2.height / 2;
               break;
            case LocationEnum.POINT_CENTER:
               param1.x = param1.x + param2.width / 2;
               param1.y = param1.y + param2.height / 2;
               break;
            case LocationEnum.POINT_RIGHT:
               param1.x = param1.x + param2.width;
               param1.y = param1.y + param2.height / 2;
               break;
            case LocationEnum.POINT_BOTTOMLEFT:
               param1.y = param1.y + param2.height;
               break;
            case LocationEnum.POINT_BOTTOM:
               param1.x = param1.x + param2.width / 2;
               param1.y = param1.y + param2.height;
               break;
            case LocationEnum.POINT_BOTTOMRIGHT:
               param1.x = param1.x + param2.width;
               param1.y = param1.y + param2.height;
               break;
         }
         return param1;
      }
      
      private static function makeOffset(param1:uint, param2:uint) : Point {
         var _loc3_:Point = new Point();
         switch(param1)
         {
            case LocationEnum.POINT_TOPLEFT:
            case LocationEnum.POINT_BOTTOMLEFT:
            case LocationEnum.POINT_LEFT:
               _loc3_.x = param2;
               break;
            case LocationEnum.POINT_TOP:
               break;
            case LocationEnum.POINT_BOTTOMRIGHT:
            case LocationEnum.POINT_TOPRIGHT:
            case LocationEnum.POINT_RIGHT:
               _loc3_.x = -param2;
               break;
         }
         switch(param1)
         {
            case LocationEnum.POINT_TOPLEFT:
            case LocationEnum.POINT_TOP:
            case LocationEnum.POINT_TOPRIGHT:
               _loc3_.y = param2;
               break;
            case LocationEnum.POINT_BOTTOMLEFT:
            case LocationEnum.POINT_BOTTOMRIGHT:
            case LocationEnum.POINT_BOTTOM:
               _loc3_.y = -param2;
               break;
         }
         return _loc3_;
      }
   }
}
