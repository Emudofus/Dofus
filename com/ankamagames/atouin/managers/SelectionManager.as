package com.ankamagames.atouin.managers
{
    import __AS3__.vec.*;
    import com.ankamagames.atouin.*;
    import com.ankamagames.atouin.types.*;
    import com.ankamagames.atouin.utils.errors.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class SelectionManager extends Object
    {
        private var _aSelection:Array;
        private static var _self:SelectionManager;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(SelectionManager));

        public function SelectionManager()
        {
            if (_self)
            {
                throw new AtouinError("SelectionManager is a singleton class. Please acces it through getInstance()");
            }
            this.init();
            return;
        }// end function

        public function init() : void
        {
            this._aSelection = new Array();
            return;
        }// end function

        public function addSelection(param1:Selection, param2:String, param3:uint = 561) : void
        {
            if (this._aSelection[param2])
            {
                Selection(this._aSelection[param2]).remove();
            }
            this._aSelection[param2] = param1;
            if (param3 != (AtouinConstants.MAP_CELLS_COUNT + 1))
            {
                this.update(param2, param3);
            }
            return;
        }// end function

        public function getSelection(param1:String) : Selection
        {
            return this._aSelection[param1];
        }// end function

        public function update(param1:String, param2:uint = 0) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_3:* = this.getSelection(param1);
            if (!_loc_3)
            {
                return;
            }
            if (_loc_3.zone)
            {
                _loc_4 = _loc_3.zone.getCells(param2);
                _loc_5 = !_loc_3.cells ? (null) : (var _loc_6:* = (_loc_3.cells as Vector.<uint>).concat(), _loc_5 = (_loc_3.cells as Vector.<uint>).concat(), _loc_6);
                _loc_3.remove(_loc_5);
                _loc_3.cells = _loc_4;
                if (_loc_3.renderer)
                {
                    _loc_3.update();
                }
                else
                {
                    _log.error("No renderer set for selection [" + param1 + "]");
                }
            }
            else
            {
                _log.error("No zone set for selection [" + param1 + "]");
            }
            return;
        }// end function

        public function isInside(param1:uint, param2:String) : Boolean
        {
            var _loc_3:* = this.getSelection(param2);
            if (!_loc_3)
            {
                return false;
            }
            return _loc_3.isInside(param1);
        }// end function

        private function diff(param1:Vector.<uint>, param2:Vector.<uint>) : Vector.<uint>
        {
            var _loc_4:* = undefined;
            var _loc_3:* = new Vector.<uint>;
            for each (_loc_4 in param2)
            {
                
                if (param1.indexOf(_loc_4) == -1)
                {
                    _loc_3.push(_loc_4);
                }
            }
            return _loc_3;
        }// end function

        public static function getInstance() : SelectionManager
        {
            if (!_self)
            {
                _self = new SelectionManager;
            }
            return _self;
        }// end function

    }
}
