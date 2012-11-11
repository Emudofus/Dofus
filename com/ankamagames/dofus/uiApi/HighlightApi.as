package com.ankamagames.dofus.uiApi
{
    import com.ankamagames.berilia.interfaces.*;
    import com.ankamagames.dofus.logic.common.managers.*;
    import flash.events.*;
    import flash.utils.*;

    public class HighlightApi extends Object implements IApi
    {
        private static var _showCellTimer:Timer;
        private static var _cellIds:Array;
        private static var _currentCell:int;

        public function HighlightApi()
        {
            return;
        }// end function

        public function highlightUi(param1:String, param2:String, param3:int = 0, param4:int = 0, param5:int = 5, param6:Boolean = false) : void
        {
            HyperlinkDisplayArrowManager.showArrow(param1, param2, param3, param4, param5, param6 ? (1) : (0));
            return;
        }// end function

        public function highlightCell(param1:Array, param2:Boolean = false) : void
        {
            if (param2)
            {
                if (!_showCellTimer)
                {
                    _showCellTimer = new Timer(2000);
                    _showCellTimer.addEventListener(TimerEvent.TIMER, onCellTimer);
                }
                _cellIds = param1;
                _currentCell = 0;
                _showCellTimer.reset();
                _showCellTimer.start();
                onCellTimer(null);
            }
            else
            {
                if (_showCellTimer)
                {
                    _showCellTimer.reset();
                }
                HyperlinkShowCellManager.showCell(param1);
            }
            return;
        }// end function

        public function highlightAbsolute(param1:uint, param2:uint, param3:uint, param4:int = 0, param5:int = 5, param6:Boolean = false) : void
        {
            HyperlinkDisplayArrowManager.showAbsoluteArrow(param1, param2, param3, param4, param5, param6 ? (1) : (0));
            return;
        }// end function

        public function highlightMapTransition(param1:int, param2:int, param3:int, param4:Boolean = false, param5:int = 5, param6:Boolean = false) : void
        {
            HyperlinkDisplayArrowManager.showMapTransition(param1, param2, param3, param4 ? (1) : (0), param5, param6 ? (1) : (0));
            return;
        }// end function

        public function highlightNpc(param1:int, param2:Boolean = false) : void
        {
            HyperlinkShowNpcManager.showNpc(param1, param2 ? (1) : (0));
            return;
        }// end function

        public function highlightMonster(param1:int, param2:Boolean = false) : void
        {
            HyperlinkShowMonsterManager.showMonster(param1, param2 ? (1) : (0));
            return;
        }// end function

        public function stop() : void
        {
            HyperlinkDisplayArrowManager.destoyArrow();
            if (_showCellTimer)
            {
                _showCellTimer.reset();
            }
            return;
        }// end function

        private static function onCellTimer(event:Event) : void
        {
            HyperlinkShowCellManager.showCell(_cellIds[_currentCell]);
            var _loc_3:* = _currentCell + 1;
            _currentCell = _loc_3;
            if (_currentCell >= _cellIds.length)
            {
                _currentCell = 0;
            }
            return;
        }// end function

    }
}
