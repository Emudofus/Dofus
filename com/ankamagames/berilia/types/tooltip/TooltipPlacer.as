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
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class TooltipPlacer extends Object
   {
      
      public function TooltipPlacer() {
         super();
      }
      
      protected static var _log:Logger;
      
      private static var _tooltips:Vector.<TooltipPosition>;
      
      private static var _tooltipsRows:Dictionary;
      
      private static var _tooltipsToWait:Vector.<String>;
      
      private static const _anchors:Array;
      
      private static var _init:Boolean;
      
      private static function init() : void {
         var pt1:uint = 0;
         var pt2:uint = 0;
         if(_init)
         {
            return;
         }
         _init = true;
         var config:Array = [LocationEnum.POINT_TOPLEFT,LocationEnum.POINT_TOP,LocationEnum.POINT_TOPRIGHT,LocationEnum.POINT_LEFT,LocationEnum.POINT_CENTER,LocationEnum.POINT_RIGHT,LocationEnum.POINT_BOTTOMLEFT,LocationEnum.POINT_BOTTOM,LocationEnum.POINT_BOTTOMRIGHT];
         for each(pt1 in config)
         {
            for each(pt2 in config)
            {
               _anchors.push(
                  {
                     "p1":pt1,
                     "p2":pt2
                  });
            }
         }
      }
      
      private static function getAnchors() : Array {
         init();
         return _anchors.concat();
      }
      
      public static function place(tooltip:DisplayObject, target:IRectangle, point:uint=6, relativePoint:uint=0, offset:int=3, alwaysDisplayed:Boolean=true) : void {
         var pTarget:Point = null;
         var pTooltip:Point = null;
         var hackIRectangle:Rectangle2 = null;
         var offsetPt:Point = null;
         var tooltipZone:Rectangle2 = null;
         var hitZoneSize:* = 0;
         var newPt:Object = null;
         var smallerZone:Object = null;
         var obj:Object = null;
         var ok:Boolean = false;
         var ttBounds:Rectangle = tooltip.getBounds(tooltip);
         var truePoint:uint = point;
         var trueRelativePoint:uint = relativePoint;
         var lastTurn:Boolean = false;
         var anchors:Array = getAnchors();
         var hitZones:Array = new Array();
         while(!ok)
         {
            pTarget = new Point(target.x,target.y);
            pTooltip = new Point(tooltip.x,tooltip.y);
            hackIRectangle = new Rectangle2(tooltip.x,tooltip.y,tooltip.width,tooltip.height);
            processAnchor(pTooltip,hackIRectangle,point);
            processAnchor(pTarget,target,relativePoint);
            offsetPt = makeOffset(point,offset);
            pTarget.x = pTarget.x - (pTooltip.x - offsetPt.x + ttBounds.left);
            pTarget.y = pTarget.y - (pTooltip.y - offsetPt.y);
            tooltipZone = new Rectangle2(pTarget.x,pTarget.y,hackIRectangle.width,hackIRectangle.height);
            if(alwaysDisplayed)
            {
               if(tooltipZone.y < 0)
               {
                  tooltipZone.y = 0;
               }
               if(tooltipZone.x < 0)
               {
                  tooltipZone.x = 0;
               }
               if(tooltipZone.y + tooltipZone.height > StageShareManager.startHeight)
               {
                  tooltipZone.y = tooltipZone.y - (tooltipZone.height + tooltipZone.y - StageShareManager.startHeight);
               }
               if(tooltipZone.x + tooltipZone.width > StageShareManager.startWidth)
               {
                  tooltipZone.x = tooltipZone.x - (tooltipZone.width + tooltipZone.x - StageShareManager.startWidth);
               }
            }
            if(!lastTurn)
            {
               hitZoneSize = hitTest(tooltipZone,target);
               ok = hitZoneSize == 0;
               if(!ok)
               {
                  newPt = anchors.shift();
                  if(!newPt)
                  {
                     smallerZone = 
                        {
                           "size":target.width * target.height,
                           "point":
                              {
                                 "p1":truePoint,
                                 "p2":trueRelativePoint
                              }
                        };
                     for each (obj in hitZones)
                     {
                        if(smallerZone.size > obj.size)
                        {
                           smallerZone = obj;
                        }
                     }
                     lastTurn = true;
                     point = smallerZone.point.p1;
                     relativePoint = smallerZone.point.p2;
                  }
                  else
                  {
                     hitZones.push(
                        {
                           "size":hitZoneSize,
                           "point":
                              {
                                 "p1":point,
                                 "p2":relativePoint
                              }
                        });
                     point = newPt.p1;
                     relativePoint = newPt.p2;
                  }
               }
            }
            else
            {
               ok = true;
            }
         }
         tooltip.x = tooltipZone.x;
         tooltip.y = tooltipZone.y;
      }
      
      public static function placeWithArrow(tooltip:DisplayObject, target:IRectangle) : Object {
         var pTooltip:Point = new Point(tooltip.x,tooltip.y);
         var info:Object = 
            {
               "bottomFlip":false,
               "leftFlip":false
            };
         pTooltip.x = target.x + target.width / 2 + 5;
         pTooltip.y = target.y - tooltip.height;
         if(pTooltip.x + tooltip.width > StageShareManager.startWidth)
         {
            info.leftFlip = true;
            pTooltip.x = pTooltip.x - (tooltip.width + 10);
         }
         if(pTooltip.y < 0)
         {
            info.bottomFlip = true;
            pTooltip.y = target.y + target.height;
         }
         tooltip.x = pTooltip.x;
         tooltip.y = pTooltip.y;
         return info;
      }
      
      public static function waitBeforeOrder(pTooltipId:String) : void {
         if(_tooltipsToWait.indexOf(pTooltipId) == -1)
         {
            _tooltipsToWait.push(pTooltipId);
         }
      }
      
      public static function addTooltipPosition(pTooltip:UiRootContainer, pTarget:IRectangle, pCellId:uint) : void {
         var i:* = 0;
         var nbTooltips:int = _tooltips.length;
         var exists:Boolean = false;
         var tooltipName:String = TooltipManager.getTooltipName(pTooltip);
         if(!tooltipName)
         {
            tooltipName = pTooltip.customUnicName;
         }
         i = 0;
         while(i < nbTooltips)
         {
            if(_tooltips[i].tooltip == pTooltip)
            {
               exists = true;
               _tooltips.splice(i,1,new TooltipPosition(pTooltip,pTarget,pCellId));
               break;
            }
            i++;
         }
         if(!exists)
         {
            _tooltips.push(new TooltipPosition(pTooltip,pTarget,pCellId));
         }
         var tIndex:int = _tooltipsToWait.indexOf(tooltipName);
         if(tIndex != -1)
         {
            _tooltipsToWait.splice(tIndex,1);
         }
         if(_tooltipsToWait.length == 0)
         {
            checkRender();
         }
      }
      
      public static function checkRender(pEvent:Event = null) : void {
         var tp:TooltipPosition = null;
         if(pEvent)
         {
            pEvent.currentTarget.removeEventListener(UiRenderEvent.UIRenderComplete,checkRender);
         }
         for each(tp in _tooltips)
         {
            if(!tp.tooltip.ready)
            {
               tp.tooltip.addEventListener(UiRenderEvent.UIRenderComplete,checkRender);
               return;
            }
         }
         orderTooltips();
      }
      
      public static function removeTooltipPosition(pTooltip:UiRootContainer) : void {
         var tp:TooltipPosition = null;
         var tIndexWait:* = 0;
         var tIndex:int = -1;
         for each(tp in _tooltips)
         {
            if(tp.tooltip == pTooltip)
            {
               tIndex = _tooltips.indexOf(tp);
               break;
            }
         }
         if(tIndex != -1)
         {
            _tooltips.splice(tIndex,1);
         }
         var uiName:String = TooltipManager.getTooltipName(pTooltip);
         tIndexWait = _tooltipsToWait.indexOf(uiName);
         if(tIndexWait != -1)
         {
            _tooltipsToWait.splice(tIndexWait,1);
         }
      }
      
      public static function removeTooltipPositionByName(pTooltipName:String) : void {
         var tp:TooltipPosition = null;
         var tIndexWait:* = 0;
         var tIndex:int = -1;
         for each(tp in _tooltips)
         {
            if(tp.tooltip.customUnicName == pTooltipName)
            {
               tIndex = _tooltips.indexOf(tp);
               break;
            }
         }
         if(tIndex != -1)
         {
            _tooltips.splice(tIndex,1);
         }
         tIndexWait = _tooltipsToWait.indexOf(pTooltipName);
         if(tIndexWait != -1)
         {
            _tooltipsToWait.splice(tIndexWait,1);
         }
      }
      
      private static function orderTooltips() : void {
         var i:* = 0;
         var j:* = 0;
         var ttp:TooltipPosition = null;
         var ttps:Vector.<TooltipPosition> = null;
         var centerX:* = NaN;
         var rowWidth:* = NaN;
         var rowLen:* = 0;
         var currentTooltipRow:* = 0;
         var ttpRow:* = 0;
         var ok:* = false;
         var newY:* = NaN;
         var addToRow:* = false;
         var prevX:* = NaN;
         var offScreenX:* = false;
         var row:Object = null;
         var len:int = _tooltips.length;
         var minX:Number = 0;
         var minTooltipY:Number = 0;
         var maxX:Number = 0;
         _tooltips.sort(compareVerticalPos);
         i = len - 1;
         while(i >= 0)
         {
            currentTooltipRow = _tooltips[i].mapRow;
            if(!_tooltipsRows[currentTooltipRow])
            {
               _tooltipsRows[currentTooltipRow] = new Vector.<TooltipPosition>(0);
            }
            ttps = isTooltipSuperposed(_tooltips[i]);
            addToRow = false;
            for each(ttp in ttps)
            {
               if((ttp.mapRow == currentTooltipRow) && (!(ttp.tooltip.customUnicName == _tooltips[i].tooltip.customUnicName)))
               {
                  addToRow = true;
                  break;
               }
            }
            if(addToRow)
            {
               _tooltipsRows[currentTooltipRow].push(_tooltips[i]);
            }
            if(i + 1 < len)
            {
               rowLen = _tooltipsRows[currentTooltipRow].length;
               if(rowLen > 1)
               {
                  rowWidth = 0;
                  minX = 0;
                  maxX = 0;
                  minTooltipY = 0;
                  for each(ttp in _tooltipsRows[currentTooltipRow])
                  {
                     minTooltipY = minTooltipY == 0?ttp.tooltip.y:ttp.tooltip.y < minTooltipY?ttp.tooltip.y:minTooltipY;
                  }
                  j = i + 1;
                  while(j < len)
                  {
                     if((!(_tooltips[j].mapRow == currentTooltipRow)) && (minTooltipY > _tooltips[j].tooltip.y - _tooltips[i].tooltip.height - 2))
                     {
                        minTooltipY = _tooltips[j].tooltip.y - _tooltips[i].tooltip.height - 2;
                        break;
                     }
                     j++;
                  }
                  for each(ttp in _tooltipsRows[currentTooltipRow])
                  {
                     ttp.tooltip.y = minTooltipY;
                  }
                  minX = maxX = _tooltips[i].target.x;
                  for each(ttp in _tooltipsRows[currentTooltipRow])
                  {
                     if(ttp.target.x < minX)
                     {
                        minX = ttp.target.x;
                     }
                     else if(ttp.target.x > maxX)
                     {
                        maxX = ttp.target.x;
                     }
                     
                     rowWidth = rowWidth + ttp.tooltip.width;
                  }
                  _tooltipsRows[currentTooltipRow].sort(compareHorizontalPos);
                  rowLen = _tooltipsRows[currentTooltipRow].length;
                  if(rowLen > 0)
                  {
                     rowWidth = rowWidth + 2 * (rowLen - 1);
                     centerX = maxX - (maxX - minX) / 2;
                     _tooltipsRows[currentTooltipRow][0].tooltip.x = centerX + 43 - rowWidth / 2;
                     j = 1;
                     while(j < rowLen)
                     {
                        _tooltipsRows[currentTooltipRow][j].tooltip.x = _tooltipsRows[currentTooltipRow][j - 1].tooltip.x + _tooltipsRows[currentTooltipRow][j - 1].tooltip.width + 2;
                        j++;
                     }
                  }
               }
               else
               {
                  ok = false;
                  loop2:
                  while(!ok)
                  {
                     j = i + 1;
                     while(j < len)
                     {
                        ok = true;
                        if(hitTest(_tooltips[i].rect,_tooltips[j].rect) != 0)
                        {
                           newY = _tooltips[j].tooltip.y - _tooltips[i].tooltip.height - 2;
                           if(newY < 0)
                           {
                              _tooltips[i].tooltip.y = 0;
                              ttp = _tooltips[j];
                              prevX = _tooltips[i].tooltip.x;
                              if(_tooltips[i].originalX < ttp.originalX)
                              {
                                 _tooltips[i].tooltip.x = ttp.tooltip.x - _tooltips[i].tooltip.width - 2;
                              }
                              else
                              {
                                 _tooltips[i].tooltip.x = ttp.tooltip.x + ttp.tooltip.width + 2;
                              }
                              offScreenX = (_tooltips[i].tooltip.x < 0) || (_tooltips[i].tooltip.x + _tooltips[i].tooltip.width + 2 > StageShareManager.stage.stageWidth);
                              if((offScreenX) || (isTooltipSuperposed(_tooltips[i])))
                              {
                                 _tooltips[i].tooltip.x = prevX;
                                 _tooltips[i].tooltip.y = newY;
                              }
                           }
                           else
                           {
                              _tooltips[i].tooltip.y = newY;
                           }
                           ok = false;
                           continue loop2;
                        }
                        j++;
                     }
                  }
               }
            }
            i--;
         }
         for(row in _tooltipsRows)
         {
            delete _tooltipsRows[row];
         }
      }
      
      private static function isTooltipSuperposed(pTooltipPosition:TooltipPosition) : Vector.<TooltipPosition> {
         var tp:TooltipPosition = null;
         var ttpsInCollision:Vector.<TooltipPosition> = null;
         for each(tp in _tooltips)
         {
            if((!(tp == pTooltipPosition)) && (!(hitTest(tp.rect,pTooltipPosition.rect) == 0)))
            {
               if(!ttpsInCollision)
               {
                  ttpsInCollision = new Vector.<TooltipPosition>(0);
               }
               ttpsInCollision.push(tp);
            }
         }
         return ttpsInCollision;
      }
      
      private static function compareVerticalPos(pTooltipPosA:TooltipPosition, pTooltipPosB:TooltipPosition) : int {
         var result:* = 0;
         if(pTooltipPosA.mapRow > pTooltipPosB.mapRow)
         {
            result = 1;
         }
         else if(pTooltipPosA.mapRow < pTooltipPosB.mapRow)
         {
            result = -1;
         }
         else
         {
            result = 0;
         }
         
         return result;
      }
      
      private static function compareHorizontalPos(pTooltipPosA:TooltipPosition, pTooltipPosB:TooltipPosition) : int {
         var result:* = 0;
         if(pTooltipPosA.tooltip.x > pTooltipPosB.tooltip.x)
         {
            result = 1;
         }
         else if(pTooltipPosA.tooltip.x < pTooltipPosB.tooltip.x)
         {
            result = -1;
         }
         else
         {
            result = 0;
         }
         
         return result;
      }
      
      private static function hitTest(item:IRectangle, zone:IRectangle) : int {
         var r1:Rectangle = new Rectangle(item.x,item.y,item.width,item.height);
         var r2:Rectangle = new Rectangle(zone.x,zone.y,zone.width,zone.height);
         var r3:Rectangle = r1.intersection(r2);
         return r3.width * r3.height;
      }
      
      private static function processAnchor(p:Point, target:IRectangle, location:uint) : Point {
         switch(location)
         {
            case LocationEnum.POINT_TOPLEFT:
               break;
            case LocationEnum.POINT_TOP:
               p.x = p.x + target.width / 2;
               break;
            case LocationEnum.POINT_TOPRIGHT:
               p.x = p.x + target.width;
               break;
            case LocationEnum.POINT_LEFT:
               p.y = p.y + target.height / 2;
               break;
            case LocationEnum.POINT_CENTER:
               p.x = p.x + target.width / 2;
               p.y = p.y + target.height / 2;
               break;
            case LocationEnum.POINT_RIGHT:
               p.x = p.x + target.width;
               p.y = p.y + target.height / 2;
               break;
            case LocationEnum.POINT_BOTTOMLEFT:
               p.y = p.y + target.height;
               break;
            case LocationEnum.POINT_BOTTOM:
               p.x = p.x + target.width / 2;
               p.y = p.y + target.height;
               break;
            case LocationEnum.POINT_BOTTOMRIGHT:
               p.x = p.x + target.width;
               p.y = p.y + target.height;
               break;
         }
         return p;
      }
      
      private static function makeOffset(point:uint, offset:uint) : Point {
         var offsetPt:Point = new Point();
         switch(point)
         {
            case LocationEnum.POINT_TOPLEFT:
            case LocationEnum.POINT_BOTTOMLEFT:
            case LocationEnum.POINT_LEFT:
               offsetPt.x = offset;
               break;
            case LocationEnum.POINT_TOP:
               break;
            case LocationEnum.POINT_BOTTOMRIGHT:
            case LocationEnum.POINT_TOPRIGHT:
            case LocationEnum.POINT_RIGHT:
               offsetPt.x = -offset;
               break;
         }
         switch(point)
         {
            case LocationEnum.POINT_TOPLEFT:
            case LocationEnum.POINT_TOP:
            case LocationEnum.POINT_TOPRIGHT:
               offsetPt.y = offset;
               break;
            case LocationEnum.POINT_BOTTOMLEFT:
            case LocationEnum.POINT_BOTTOMRIGHT:
            case LocationEnum.POINT_BOTTOM:
               offsetPt.y = -offset;
               break;
         }
         return offsetPt;
      }
   }
}
