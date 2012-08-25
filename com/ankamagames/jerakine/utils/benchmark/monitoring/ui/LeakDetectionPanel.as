package com.ankamagames.jerakine.utils.benchmark.monitoring.ui
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.utils.benchmark.monitoring.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;

    public class LeakDetectionPanel extends Sprite
    {
        private var _listDataObject:Dictionary;
        private var _dataTf:TextField;
        public var dataToDisplay:Vector.<Number>;
        private static const WIDTH:int = 250;
        private static const HEIGHT:int = 300;

        public function LeakDetectionPanel()
        {
            this._listDataObject = new Dictionary();
            this._dataTf = new TextField();
            this._dataTf.selectable = false;
            this._dataTf.multiline = true;
            this._dataTf.thickness = 200;
            this._dataTf.autoSize = "left";
            this._dataTf.addEventListener(TextEvent.LINK, this.linkHandler);
            addChild(this._dataTf);
            this.drawBG();
            return;
        }// end function

        private function drawBG() : void
        {
            graphics.clear();
            graphics.beginFill(FpsManagerConst.BOX_COLOR, 0.7);
            graphics.lineStyle(2, FpsManagerConst.BOX_COLOR);
            graphics.drawRoundRect(0, 0, WIDTH, this._dataTf.textHeight + 8, 8, 8);
            graphics.endFill();
            return;
        }// end function

        public function watchObject(param1:Object, param2:uint, param3:Boolean = false) : void
        {
            var _loc_6:List = null;
            var _loc_7:List = null;
            var _loc_8:List = null;
            var _loc_9:XML = null;
            var _loc_10:String = null;
            var _loc_11:XML = null;
            var _loc_4:* = getQualifiedClassName(param1).split("::")[1];
            var _loc_5:* = this._listDataObject[_loc_4];
            if (this._listDataObject[_loc_4] == null)
            {
                if (param3)
                {
                    _loc_6 = new List(_loc_4);
                    _loc_7 = _loc_6;
                    _loc_9 = describeType(param1);
                    for each (_loc_11 in _loc_9.extendsClass)
                    {
                        
                        _loc_10 = _loc_11.@type.toString().split("::")[1];
                        if (this._listDataObject[_loc_10] != null)
                        {
                            _loc_7.next = this._listDataObject[_loc_10].extendsClass;
                            break;
                        }
                        _loc_8 = new List(_loc_10);
                        _loc_7.next = _loc_8;
                        _loc_8 = _loc_7;
                    }
                }
                _loc_5 = new MonitoredObject(_loc_4, param2, _loc_6);
                this._listDataObject[_loc_4] = _loc_5;
                if (param3 && _loc_6 != null)
                {
                    this.updateParents(_loc_6, _loc_5);
                }
            }
            else if (_loc_5.color == 16777215)
            {
                _loc_5.color = param2;
            }
            _loc_5.addNewValue(param1);
            return;
        }// end function

        private function updateParents(param1:List, param2:Object) : void
        {
            var _loc_3:* = param1;
            if (_loc_3 != null)
            {
                do
                {
                    
                    if (_loc_3.value != null)
                    {
                        this.updateParent(_loc_3.value.toString(), param2, _loc_3.next);
                    }
                    var _loc_4:* = _loc_3.next;
                    _loc_3 = _loc_3.next;
                }while (_loc_4 != null)
            }
            return;
        }// end function

        private function updateParent(param1:String, param2:Object, param3:List) : void
        {
            var _loc_4:* = this._listDataObject[param1];
            if (this._listDataObject[param1] == null)
            {
                _loc_4 = new MonitoredObject(param1, 16777215, param3);
                this._listDataObject[param1] = _loc_4;
            }
            _loc_4.addNewValue(param2);
            return;
        }// end function

        public function updateData() : void
        {
            var _loc_2:MonitoredObject = null;
            var _loc_1:String = "";
            for each (_loc_2 in this._listDataObject)
            {
                
                _loc_2.update();
                _loc_1 = _loc_1 + ("<font face=\'Verdana\' size=\'15\' color=\'#" + _loc_2.color.toString(16) + "\' >");
                if (_loc_2.selected)
                {
                    _loc_1 = _loc_1 + "(*) ";
                }
                _loc_1 = _loc_1 + ("<a href=\'event:" + _loc_2.name + "\'>[" + _loc_2.name + "]</a> : " + FpsManagerUtils.countKeys(_loc_2.list));
                _loc_1 = _loc_1 + "</font>\n";
            }
            this._dataTf.htmlText = _loc_1;
            this._dataTf.width = this._dataTf.textWidth + 10;
            this.drawBG();
            return;
        }// end function

        private function linkHandler(event:TextEvent) : void
        {
            var _loc_2:* = this._listDataObject[event.text];
            if (_loc_2 == null)
            {
                return;
            }
            var _loc_3:* = new FpsManagerEvent("follow");
            _loc_3.data = _loc_2;
            dispatchEvent(_loc_3);
            return;
        }// end function

    }
}
