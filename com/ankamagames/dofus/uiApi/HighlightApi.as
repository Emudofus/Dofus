package com.ankamagames.dofus.uiApi
{
   import com.ankamagames.berilia.interfaces.IApi;
   import flash.utils.Timer;
   import flash.events.Event;
   import com.ankamagames.dofus.logic.common.managers.HyperlinkShowCellManager;
   import flash.geom.Point;
   import com.ankamagames.dofus.logic.common.managers.HyperlinkDisplayArrowManager;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import com.ankamagames.dofus.logic.common.managers.HyperlinkShowNpcManager;
   import com.ankamagames.dofus.logic.common.managers.HyperlinkShowMonsterManager;
   
   public class HighlightApi extends Object implements IApi
   {
      
      public function HighlightApi() {
         super();
      }
      
      private static var _showCellTimer:Timer;
      
      private static var _cellIds:Array;
      
      private static var _currentCell:int;
      
      private static function onCellTimer(e:Event) : void {
         HyperlinkShowCellManager.showCell(_cellIds[_currentCell]);
         _currentCell++;
         if(_currentCell >= _cellIds.length)
         {
            _currentCell = 0;
         }
      }
      
      public function forceArrowPosition(pUiName:String, pComponentName:String, pPosition:Point) : void {
         HyperlinkDisplayArrowManager.setArrowPosition(pUiName,pComponentName,pPosition);
      }
      
      public function highlightUi(uiName:String, componentName:String, pos:int=0, reverse:int=0, strata:int=5, loop:Boolean=false) : void {
         HyperlinkDisplayArrowManager.showArrow(uiName,componentName,pos,reverse,strata,loop?1:0);
      }
      
      public function highlightCell(cellIds:Array, loop:Boolean=false) : void {
         if(loop)
         {
            if(!_showCellTimer)
            {
               _showCellTimer = new Timer(2000);
               _showCellTimer.addEventListener(TimerEvent.TIMER,onCellTimer);
            }
            _cellIds = cellIds;
            _currentCell = 0;
            _showCellTimer.reset();
            _showCellTimer.start();
            onCellTimer(null);
         }
         else
         {
            if(_showCellTimer)
            {
               _showCellTimer.reset();
            }
            HyperlinkShowCellManager.showCell(cellIds);
         }
      }
      
      public function highlightAbsolute(targetRect:Rectangle, pos:uint, reverse:int=0, strata:int=5, loop:Boolean=false) : void {
         HyperlinkDisplayArrowManager.showAbsoluteArrow(targetRect,pos,reverse,strata,loop?1:0);
      }
      
      public function highlightMapTransition(mapId:int, shapeOrientation:int, position:int, reverse:Boolean=false, strata:int=5, loop:Boolean=false) : void {
         HyperlinkDisplayArrowManager.showMapTransition(mapId,shapeOrientation,position,reverse?1:0,strata,loop?1:0);
      }
      
      public function highlightNpc(npcId:int, loop:Boolean=false) : void {
         HyperlinkShowNpcManager.showNpc(npcId,loop?1:0);
      }
      
      public function highlightMonster(monsterId:int, loop:Boolean=false) : void {
         HyperlinkShowMonsterManager.showMonster(monsterId,loop?1:0);
      }
      
      public function stop() : void {
         HyperlinkDisplayArrowManager.destroyArrow();
         if(_showCellTimer)
         {
            _showCellTimer.reset();
         }
      }
   }
}
