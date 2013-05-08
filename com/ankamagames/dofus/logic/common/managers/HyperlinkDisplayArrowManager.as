package com.ankamagames.dofus.logic.common.managers
{
   import flash.display.MovieClip;
   import flash.utils.Timer;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   import com.ankamagames.berilia.Berilia;
   import flash.display.DisplayObjectContainer;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.jerakine.types.enums.DirectionsEnum;
   import flash.events.Event;
   import flash.events.TimerEvent;


   public class HyperlinkDisplayArrowManager extends Object
   {
         

      public function HyperlinkDisplayArrowManager() {
         super();
      }

      private static const ARROW_CLIP:Class = HyperlinkDisplayArrowManager_ARROW_CLIP;

      private static var _arrowClip:MovieClip;

      private static var _arrowTimer:Timer;

      private static var _displayLastArrow:Boolean = false;

      private static var _lastArrowX:int;

      private static var _lastArrowY:int;

      private static var _lastArrowPos:int;

      private static var _lastStrata:int;

      private static var _lastReverse:int;

      public static function showArrow(uiName:String, componentName:String, pos:int=0, reverse:int=0, strata:int=5, loop:int=0) : MovieClip {
         var uirc:UiRootContainer = null;
         var displayObject:DisplayObject = null;
         var rect:Rectangle = null;
         var arrow:MovieClip = getArrow(loop==1);
         var container:DisplayObjectContainer = Berilia.getInstance().docMain.getChildAt(strata) as DisplayObjectContainer;
         container.addChild(arrow);
         if(isNaN(Number(uiName)))
         {
            uirc=Berilia.getInstance().getUi(uiName);
            if(uirc)
            {
               displayObject=uirc.getElement(componentName);
               if((displayObject)&&(displayObject.visible))
               {
                  rect=displayObject.getRect(container);
                  place(_arrowClip,rect,pos);
               }
               else
               {
                  container.removeChild(arrow);
               }
            }
            if(reverse==1)
            {
               _arrowClip.scaleX=_arrowClip.scaleX*-1;
            }
            if(loop)
            {
               _displayLastArrow=true;
               _lastArrowX=arrow.x;
               _lastArrowY=arrow.y;
               _lastArrowPos=pos;
               _lastStrata=strata;
               _lastReverse=_arrowClip.scaleX;
            }
            return _arrowClip;
         }
         return showAbsoluteArrow(int(uiName),int(componentName),pos,reverse,strata,loop);
      }

      public static function showAbsoluteArrow(x:int, y:int, pos:int=0, reverse:int=0, strata:int=5, loop:int=0) : MovieClip {
         var arrow:MovieClip = getArrow(loop==1);
         DisplayObjectContainer(Berilia.getInstance().docMain.getChildAt(strata)).addChild(arrow);
         place(arrow,new Rectangle(x,y),pos);
         if(reverse==1)
         {
            _arrowClip.scaleX=_arrowClip.scaleX*-1;
         }
         if(loop)
         {
            _displayLastArrow=true;
            _lastArrowX=arrow.x;
            _lastArrowY=arrow.y;
            _lastArrowPos=pos;
            _lastStrata=strata;
            _lastReverse=_arrowClip.scaleX;
         }
         return arrow;
      }

      public static function showMapTransition(mapId:int, shapeOrientation:int, position:int, reverse:int=0, strata:int=5, loop:int=0) : MovieClip {
         var arrow:MovieClip = null;
         var x:uint = 0;
         var y:uint = 0;
         var orientation:uint = 0;
         if((mapId==-1)||(mapId==PlayedCharacterManager.getInstance().currentMap.mapId))
         {
            arrow=getArrow(loop==1);
            DisplayObjectContainer(Berilia.getInstance().docMain.getChildAt(strata)).addChild(arrow);
            switch(shapeOrientation)
            {
               case DirectionsEnum.DOWN:
                  x=position;
                  y=880;
                  orientation=1;
                  break;
               case DirectionsEnum.LEFT:
                  x=0;
                  y=position;
                  orientation=5;
                  break;
               case DirectionsEnum.UP:
                  x=position;
                  y=0;
                  orientation=7;
                  break;
               case DirectionsEnum.RIGHT:
                  x=1280;
                  y=position;
                  orientation=1;
                  break;
            }
            place(arrow,new Rectangle(x,y),orientation);
            if(reverse==1)
            {
               _arrowClip.scaleX=_arrowClip.scaleX*-1;
            }
            if(loop)
            {
               _displayLastArrow=true;
               _lastArrowX=arrow.x;
               _lastArrowY=arrow.y;
               _lastArrowPos=orientation;
               _lastStrata=strata;
               _lastReverse=_arrowClip.scaleX;
            }
            return arrow;
         }
         return null;
      }

      public static function destoyArrow(E:Event=null) : void {
         if(E)
         {
            if(_displayLastArrow)
            {
               (Berilia.getInstance().docMain.getChildAt(_lastStrata) as DisplayObjectContainer).addChild(_arrowClip);
               place(_arrowClip,new Rectangle(_lastArrowX,_lastArrowY),_lastArrowPos);
               _arrowClip.scaleX=_lastReverse;
               return;
            }
         }
         else
         {
            _displayLastArrow=false;
         }
         if(_arrowClip)
         {
            _arrowClip.gotoAndStop(1);
            if(_arrowClip.parent)
            {
               _arrowClip.parent.removeChild(_arrowClip);
            }
         }
      }

      private static function getArrow(loop:Boolean=false) : MovieClip {
         if(_arrowClip)
         {
            _arrowClip.gotoAndPlay(1);
         }
         else
         {
            _arrowClip=new ARROW_CLIP() as MovieClip;
            _arrowClip.mouseEnabled=false;
            _arrowClip.mouseChildren=false;
         }
         if(loop)
         {
            if(_arrowTimer)
            {
               _arrowTimer.reset();
            }
         }
         else
         {
            if(_arrowTimer)
            {
               _arrowTimer.reset();
            }
            else
            {
               _arrowTimer=new Timer(2000,1);
               _arrowTimer.addEventListener(TimerEvent.TIMER,destoyArrow);
            }
            _arrowTimer.start();
         }
         return _arrowClip;
      }

      public static function place(arrow:MovieClip, rect:Rectangle, pos:int) : void {
         if(pos==0)
         {
            arrow.scaleX=1;
            arrow.scaleY=1;
            arrow.x=int(rect.x);
            arrow.y=int(rect.y);
         }
         else
         {
            if(pos==1)
            {
               arrow.scaleX=1;
               arrow.scaleY=1;
               arrow.x=int(rect.x+rect.width/2);
               arrow.y=int(rect.y);
            }
            else
            {
               if(pos==2)
               {
                  arrow.scaleX=-1;
                  arrow.scaleY=1;
                  arrow.x=int(rect.x+rect.width);
                  arrow.y=int(rect.y);
               }
               else
               {
                  if(pos==3)
                  {
                     arrow.scaleX=1;
                     arrow.scaleY=1;
                     arrow.x=int(rect.x);
                     arrow.y=int(rect.y+rect.height/2);
                  }
                  else
                  {
                     if(pos==4)
                     {
                        arrow.scaleX=1;
                        arrow.scaleY=1;
                        arrow.x=int(rect.x+rect.width/2);
                        arrow.y=int(rect.y+rect.height/2);
                     }
                     else
                     {
                        if(pos==5)
                        {
                           arrow.scaleX=-1;
                           arrow.scaleY=1;
                           arrow.x=int(rect.x+rect.width);
                           arrow.y=int(rect.y+rect.height/2);
                        }
                        else
                        {
                           if(pos==6)
                           {
                              arrow.scaleX=1;
                              arrow.scaleY=-1;
                              arrow.x=int(rect.x);
                              arrow.y=int(rect.y+rect.height);
                           }
                           else
                           {
                              if(pos==7)
                              {
                                 arrow.scaleX=1;
                                 arrow.scaleY=-1;
                                 arrow.x=int(rect.x+rect.width/2);
                                 arrow.y=int(rect.y+rect.height);
                              }
                              else
                              {
                                 if(pos==8)
                                 {
                                    arrow.scaleY=-1;
                                    arrow.scaleX=-1;
                                    arrow.x=int(rect.x+rect.width);
                                    arrow.y=int(rect.y+rect.height);
                                 }
                                 else
                                 {
                                    arrow.scaleX=1;
                                    arrow.scaleY=1;
                                    arrow.x=int(rect.x);
                                    arrow.y=int(rect.y);
                                 }
                              }
                           }
                        }
                     }
                  }
               }
            }
         }
      }


   }

}