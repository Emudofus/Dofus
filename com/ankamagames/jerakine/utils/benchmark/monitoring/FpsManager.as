package com.ankamagames.jerakine.utils.benchmark.monitoring
{
    import com.ankamagames.jerakine.utils.benchmark.monitoring.ui.*;
    import com.ankamagames.jerakine.utils.display.*;
    import com.ankamagames.jerakine.utils.system.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.net.*;
    import flash.profiler.*;
    import flash.system.*;
    import flash.utils.*;

    public class FpsManager extends Sprite
    {
        private var conn:LocalConnection;
        private var isExternal:Boolean;
        private var _decal:Point;
        private var _btnStateSpr:StateButton;
        private var _btnRetrace:RedrawRegionButton;
        private var _graphPanel:GraphDisplayer;
        private var _extensionPanel:ExtensionPanel;
        private var _redrawRegionsVisible:Boolean = false;
        private var _ticks:uint = 0;
        private var _last:uint;
        private static var _instance:FpsManager;

        public function FpsManager()
        {
            this._last = getTimer();
            this._btnRetrace = new RedrawRegionButton(FpsManagerConst.BOX_WIDTH + 30, 0);
            this._btnRetrace.addEventListener(MouseEvent.CLICK, this.redrawRegionHandler);
            addChild(this._btnRetrace);
            this._graphPanel = new GraphDisplayer();
            addChild(this._graphPanel);
            this._extensionPanel = new ExtensionPanel(this);
            this._btnStateSpr = new StateButton(FpsManagerConst.BOX_WIDTH + 5, 0);
            this._btnStateSpr.addEventListener(MouseEvent.CLICK, this.changeStateHandler);
            addChild(this._btnStateSpr);
            FpsManagerConst.PLAYER_VERSION = FpsManagerUtils.getVersion();
            var _loc_1:* = 50;
            y = 50;
            x = _loc_1;
            if (FpsManagerConst.PLAYER_VERSION >= 10)
            {
                if (AirScanner.hasAir())
                {
                    this._graphPanel.previousFreeMem = FpsManagerUtils.calculateMB(System["freeMemory"]);
                }
                this._extensionPanel.lastGc = getTimer();
            }
            this.startTracking(FpsManagerConst.SPECIAL_GRAPH[1].name, FpsManagerConst.SPECIAL_GRAPH[1].color);
            return;
        }// end function

        public function display(param1:Boolean = false) : void
        {
            if (_instance == null)
            {
                throw new Error("FpsManager is not initialized");
            }
            this.isExternal = param1;
            if (param1)
            {
                this.conn = new LocalConnection();
                this.conn.addEventListener(StatusEvent.STATUS, this.onStatus);
                this.conn.send("app#DofusDebugger:DofusDebugConnection", "updateStatus", true);
            }
            StageShareManager.stage.addChild(_instance);
            this._graphPanel.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
            StageShareManager.stage.addEventListener(Event.ENTER_FRAME, this.loop);
            return;
        }// end function

        public function hide() : void
        {
            if (_instance == null)
            {
                throw new Error("FpsManager is not initialized");
            }
            if (this.isExternal)
            {
                this.conn.send("app#DofusDebugger:DofusDebugConnection", "updateStatus", false);
                this.conn.removeEventListener(StatusEvent.STATUS, this.onStatus);
                this.conn.close();
                this.conn = null;
            }
            else
            {
                StageShareManager.stage.removeChild(_instance);
                this._graphPanel.removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
            }
            StageShareManager.stage.removeEventListener(Event.ENTER_FRAME, this.loop);
            return;
        }// end function

        private function onMouseDown(event:MouseEvent) : void
        {
            this._decal = new Point(event.localX, event.localY);
            StageShareManager.stage.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
            StageShareManager.stage.addEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMove);
            return;
        }// end function

        private function onMouseUp(event:MouseEvent) : void
        {
            this._decal = null;
            StageShareManager.stage.removeEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
            StageShareManager.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMove);
            return;
        }// end function

        private function onMouseMove(event:MouseEvent) : void
        {
            x = StageShareManager.stage.mouseX - this._decal.x;
            y = StageShareManager.stage.mouseY - this._decal.y;
            event.updateAfterEvent();
            return;
        }// end function

        private function onStatus(event:StatusEvent) : void
        {
            switch(event.level)
            {
                case "status":
                {
                    break;
                }
                case "error":
                {
                    trace("LocalConnection.send() failed");
                    this.conn.removeEventListener(StatusEvent.STATUS, this.onStatus);
                    this.conn = null;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function redrawRegionHandler(event:MouseEvent) : void
        {
            this._redrawRegionsVisible = !this._redrawRegionsVisible;
            showRedrawRegions(this._redrawRegionsVisible, 17595);
            return;
        }// end function

        private function changeStateHandler(event:MouseEvent) : void
        {
            this._extensionPanel.changeState();
            return;
        }// end function

        private function loop(event:Event) : void
        {
            var _loc_4:* = NaN;
            var _loc_5:* = null;
            var _loc_6:* = null;
            this.stopTracking(FpsManagerConst.SPECIAL_GRAPH[0].name);
            this.startTracking(FpsManagerConst.SPECIAL_GRAPH[0].name, FpsManagerConst.SPECIAL_GRAPH[0].color);
            this._graphPanel.update();
            this.updateMem();
            var _loc_7:* = this;
            var _loc_8:* = this._ticks + 1;
            _loc_7._ticks = _loc_8;
            var _loc_2:* = getTimer();
            var _loc_3:* = _loc_2 - this._last;
            if (_loc_3 >= 500)
            {
                _loc_4 = this._ticks / _loc_3 * 1000;
                if (this.isExternal && this.conn != null)
                {
                    this.conn.send("app#DofusDebugger:DofusDebugConnection", "updateValues", _loc_4, this._graphPanel.memory, FpsManagerUtils.getTimeFromNow(this._extensionPanel.lastGc));
                    _loc_5 = this._graphPanel.getExternalGraphs();
                    for each (_loc_6 in _loc_5)
                    {
                        
                        if (this.conn == null)
                        {
                            break;
                        }
                        this.conn.send("app#DofusDebugger:DofusDebugConnection", "updateGraphValues", _loc_6.name, _loc_6.color, _loc_6.points);
                    }
                    this.conn.send("app#DofusDebugger:DofusDebugConnection", "updateGraphes");
                }
                this._graphPanel.updateFpsValue(_loc_4);
                this._extensionPanel.update();
                this._ticks = 0;
                this._last = _loc_2;
            }
            return;
        }// end function

        private function updateMem() : void
        {
            var _loc_1:* = NaN;
            var _loc_2:* = NaN;
            this._graphPanel.memory = FpsManagerUtils.calculateMB(System.totalMemory).toPrecision(3);
            if (AirScanner.hasAir())
            {
                if (FpsManagerConst.PLAYER_VERSION >= 10)
                {
                    _loc_1 = FpsManagerUtils.calculateMB(System["freeMemory"]);
                    if (_loc_1 - this._graphPanel.previousFreeMem > 1)
                    {
                        this._extensionPanel.lastGc = getTimer();
                    }
                    _loc_2 = FpsManagerUtils.calculateMB(System["privateMemory"]);
                    this._graphPanel.memory = this._graphPanel.memory + ("/" + _loc_2.toPrecision(3));
                    this._graphPanel.previousFreeMem = _loc_1;
                    this._extensionPanel.updateGc(_loc_2);
                }
            }
            this._graphPanel.memory = this._graphPanel.memory + " MB";
            return;
        }// end function

        public function startTracking(param1:String, param2:uint = 16777215) : void
        {
            this._graphPanel.startTracking(param1, param2);
            return;
        }// end function

        public function stopTracking(param1:String) : void
        {
            this._graphPanel.stopTracking(param1);
            return;
        }// end function

        public function watchObject(param1:Object, param2:Boolean = false) : void
        {
            this._extensionPanel.watchObject(param1, FpsManagerUtils.getBrightRandomColor(), param2);
            return;
        }// end function

        public static function getInstance() : FpsManager
        {
            if (_instance == null)
            {
                _instance = new FpsManager;
            }
            return _instance;
        }// end function

    }
}
