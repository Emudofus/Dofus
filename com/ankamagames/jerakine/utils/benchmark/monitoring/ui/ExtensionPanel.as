package com.ankamagames.jerakine.utils.benchmark.monitoring.ui
{
    import com.ankamagames.jerakine.utils.benchmark.monitoring.*;
    import flash.display.*;

    public class ExtensionPanel extends Sprite
    {
        private var _parent:Sprite;
        private var _currentState:int = 0;
        private var _memoryState:MemoryPanel;
        private var _leakState:LeakDetectionPanel;

        public function ExtensionPanel(param1:Sprite)
        {
            this._parent = param1;
            y = FpsManagerConst.BOX_HEIGHT;
            this._memoryState = new MemoryPanel();
            this._leakState = new LeakDetectionPanel();
            this._leakState.addEventListener("follow", this.addGraphToMemory);
            return;
        }// end function

        public function changeState() : void
        {
            switch(this._currentState)
            {
                case 0:
                {
                    this._parent.addChild(this);
                    this._memoryState.initMemGraph();
                    this._memoryState.y = 5;
                    addChild(this._memoryState);
                    var _loc_1:String = this;
                    var _loc_2:* = this._currentState + 1;
                    _loc_1._currentState = _loc_2;
                    break;
                }
                case 1:
                {
                    var _loc_1:String = this;
                    var _loc_2:* = this._currentState + 1;
                    _loc_1._currentState = _loc_2;
                    this._leakState.y = this._memoryState.y + FpsManagerConst.BOX_HEIGHT + 5;
                    addChild(this._leakState);
                    break;
                }
                case 2:
                {
                    this._parent.removeChild(this);
                    removeChild(this._memoryState);
                    removeChild(this._leakState);
                    this._memoryState.clearOtherGraph();
                    this._currentState = 0;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function update() : void
        {
            this._memoryState.updateData();
            this._leakState.updateData();
            if (this._currentState == 1 || this._currentState == 2)
            {
                this._memoryState.render();
            }
            return;
        }// end function

        private function addGraphToMemory(event:FpsManagerEvent) : void
        {
            var _loc_2:* = event.data as MonitoredObject;
            this._memoryState.addNewGraph(_loc_2);
            return;
        }// end function

        public function set lastGc(param1:int) : void
        {
            this._memoryState.lastGc = param1;
            return;
        }// end function

        public function watchObject(param1:Object, param2:uint, param3:Boolean = false) : void
        {
            this._leakState.watchObject(param1, param2, param3);
            return;
        }// end function

        public function updateGc(param1:Number = 0) : void
        {
            this._memoryState.updateGc(param1);
            return;
        }// end function

    }
}
