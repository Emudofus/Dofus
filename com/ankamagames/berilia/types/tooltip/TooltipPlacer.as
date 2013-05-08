package com.ankamagames.berilia.types.tooltip
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.berilia.types.LocationEnum;
   import flash.display.DisplayObject;
   import com.ankamagames.jerakine.interfaces.IRectangle;
   import flash.geom.Point;
   import com.ankamagames.jerakine.utils.display.Rectangle2;
   import flash.geom.Rectangle;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;


   public class TooltipPlacer extends Object
   {
         

      public function TooltipPlacer() {
         super();
      }

      protected static var _log:Logger = Log.getLogger(getQualifiedClassName(TooltipPlacer));

      private static const _anchors:Array = [];

      private static var _init:Boolean;

      private static function init() : void {
         var pt1:uint = 0;
         var pt2:uint = 0;
         if(_init)
         {
            return;
         }
         _init=true;
         var config:Array = [LocationEnum.POINT_TOPLEFT,LocationEnum.POINT_TOP,LocationEnum.POINT_TOPRIGHT,LocationEnum.POINT_LEFT,LocationEnum.POINT_CENTER,LocationEnum.POINT_RIGHT,LocationEnum.POINT_BOTTOMLEFT,LocationEnum.POINT_BOTTOM,LocationEnum.POINT_BOTTOMRIGHT];
         for each (pt1 in config)
         {
            for each (pt2 in config)
            {
               _anchors.push(
                  {
                     p1:pt1,
                     p2:pt2
                  }
               );
            }
         }
      }

      private static function getAnchors() : Array {
         init();
         return _anchors.concat();
      }

      public static function place(tooltip:DisplayObject, target:IRectangle, point:uint=6, relativePoint:uint=0, offset:int=3) : void {
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
            pTarget=new Point(target.x,target.y);
            pTooltip=new Point(tooltip.x,tooltip.y);
            hackIRectangle=new Rectangle2(tooltip.x,tooltip.y,tooltip.width,tooltip.height);
            processAnchor(pTooltip,hackIRectangle,point);
            processAnchor(pTarget,target,relativePoint);
            offsetPt=makeOffset(point,offset);
            pTarget.x=pTarget.x-pTooltip.x-offsetPt.x+ttBounds.left;
            pTarget.y=pTarget.y-pTooltip.y-offsetPt.y;
            tooltipZone=new Rectangle2(pTarget.x,pTarget.y,hackIRectangle.width,hackIRectangle.height);
            if(tooltipZone.y<0)
            {
               tooltipZone.y=0;
            }
            if(tooltipZone.x<0)
            {
               tooltipZone.x=0;
            }
            if(tooltipZone.y+tooltipZone.height>StageShareManager.startHeight)
            {
               tooltipZone.y=tooltipZone.y-tooltipZone.height+tooltipZone.y-StageShareManager.startHeight;
            }
            if(tooltipZone.x+tooltipZone.width>StageShareManager.startWidth)
            {
               tooltipZone.x=tooltipZone.x-tooltipZone.width+tooltipZone.x-StageShareManager.startWidth;
            }
            if(!lastTurn)
            {
               hitZoneSize=hitTest(tooltipZone,target);
               ok=hitZoneSize==0;
               if(!ok)
               {
                  newPt=anchors.shift();
                  if(!newPt)
                  {
                     smallerZone=
                        {
                           size:target.width*target.height,
                              {
                                 p1:truePoint,
                                 p2:trueRelativePoint
                              }
                           
                        }
                     ;
                     for each (obj in hitZones)
                     {
                        if(smallerZone.size>obj.size)
                        {
                           smallerZone=obj;
                        }
                     }
                     lastTurn=true;
                     point=smallerZone.point.p1;
                     relativePoint=smallerZone.point.p2;
                  }
                  else
                  {
                     hitZones.push(
                        {
                           size:hitZoneSize,
                              {
                                 p1:point,
                                 p2:relativePoint
                              }
                           
                        }
                     );
                     point=newPt.p1;
                     relativePoint=newPt.p2;
                  }
               }
            }
            else
            {
               ok=true;
            }
         }
         tooltip.x=tooltipZone.x;
         tooltip.y=tooltipZone.y;
      }

      public static function placeWithArrow(tooltip:DisplayObject, target:IRectangle) : Object {
         var pTooltip:Point = new Point(tooltip.x,tooltip.y);
         var info:Object = 
            {
               bottomFlip:false,
               leftFlip:false
            }
         ;
         pTooltip.x=target.x+target.width/2+5;
         pTooltip.y=target.y-tooltip.height;
         if(pTooltip.x+tooltip.width>StageShareManager.startWidth)
         {
            info.leftFlip=true;
            pTooltip.x=pTooltip.x-tooltip.width+10;
         }
         if(pTooltip.y<0)
         {
            info.bottomFlip=true;
            pTooltip.y=target.y+target.height;
         }
         tooltip.x=pTooltip.x;
         tooltip.y=pTooltip.y;
         return info;
      }

      private static function hitTest(item:IRectangle, zone:IRectangle) : int {
         var r1:Rectangle = new Rectangle(item.x,item.y,item.width,item.height);
         var r2:Rectangle = new Rectangle(zone.x,zone.y,zone.width,zone.height);
         var r3:Rectangle = r1.intersection(r2);
         return r3.width*r3.height;
      }

      private static function processAnchor(p:Point, target:IRectangle, location:uint) : Point {
         switch(location)
         {
            case LocationEnum.POINT_TOPLEFT:
               break;
            case LocationEnum.POINT_TOP:
               p.x=p.x+target.width/2;
               break;
            case LocationEnum.POINT_TOPRIGHT:
               p.x=p.x+target.width;
               break;
            case LocationEnum.POINT_LEFT:
               p.y=p.y+target.height/2;
               break;
            case LocationEnum.POINT_CENTER:
               p.x=p.x+target.width/2;
               p.y=p.y+target.height/2;
               break;
            case LocationEnum.POINT_RIGHT:
               p.x=p.x+target.width;
               p.y=p.y+target.height/2;
               break;
            case LocationEnum.POINT_BOTTOMLEFT:
               p.y=p.y+target.height;
               break;
            case LocationEnum.POINT_BOTTOM:
               p.x=p.x+target.width/2;
               p.y=p.y+target.height;
               break;
            case LocationEnum.POINT_BOTTOMRIGHT:
               p.x=p.x+target.width;
               p.y=p.y+target.height;
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
               offsetPt.x=offset;
               break;
            case LocationEnum.POINT_TOP:
               break;
            case LocationEnum.POINT_BOTTOMRIGHT:
            case LocationEnum.POINT_TOPRIGHT:
            case LocationEnum.POINT_RIGHT:
               offsetPt.x=-offset;
               break;
         }
         switch(point)
         {
            case LocationEnum.POINT_TOPLEFT:
            case LocationEnum.POINT_TOP:
            case LocationEnum.POINT_TOPRIGHT:
               offsetPt.y=offset;
               break;
            case LocationEnum.POINT_BOTTOMLEFT:
            case LocationEnum.POINT_BOTTOMRIGHT:
            case LocationEnum.POINT_BOTTOM:
               offsetPt.y=-offset;
               break;
         }
         return offsetPt;
      }


   }

}