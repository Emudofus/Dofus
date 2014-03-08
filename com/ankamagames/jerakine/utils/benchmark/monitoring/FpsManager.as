package com.ankamagames.jerakine.utils.benchmark.monitoring
{
   import flash.display.Sprite;
   import flash.net.LocalConnection;
   import flash.geom.Point;
   import com.ankamagames.jerakine.utils.benchmark.monitoring.ui.StateButton;
   import com.ankamagames.jerakine.utils.benchmark.monitoring.ui.RedrawRegionButton;
   import com.ankamagames.jerakine.utils.benchmark.monitoring.ui.GraphDisplayer;
   import com.ankamagames.jerakine.utils.benchmark.monitoring.ui.ExtensionPanel;
   import flash.events.StatusEvent;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import flash.events.MouseEvent;
   import flash.events.Event;
   import flash.profiler.showRedrawRegions;
   import flash.utils.getTimer;
   import flash.system.System;
   import com.ankamagames.jerakine.utils.system.AirScanner;
   
   public class FpsManager extends Sprite
   {
      
      public function FpsManager() {
         this._last = getTimer();
         super();
         this._btnRetrace = new RedrawRegionButton(FpsManagerConst.BOX_WIDTH + 30,0);
         this._btnRetrace.addEventListener(MouseEvent.CLICK,this.redrawRegionHandler);
         addChild(this._btnRetrace);
         this._graphPanel = new GraphDisplayer();
         addChild(this._graphPanel);
         this._extensionPanel = new ExtensionPanel(this);
         this._btnStateSpr = new StateButton(FpsManagerConst.BOX_WIDTH + 5,0);
         this._btnStateSpr.addEventListener(MouseEvent.CLICK,this.changeStateHandler);
         addChild(this._btnStateSpr);
         FpsManagerConst.PLAYER_VERSION = FpsManagerUtils.getVersion();
         x = y = 50;
         if(FpsManagerConst.PLAYER_VERSION >= 10)
         {
            if(AirScanner.hasAir())
            {
               this._graphPanel.previousFreeMem = FpsManagerUtils.calculateMB(System["freeMemory"]);
            }
            this._extensionPanel.lastGc = getTimer();
         }
         this.startTracking(FpsManagerConst.SPECIAL_GRAPH[1].name,FpsManagerConst.SPECIAL_GRAPH[1].color);
      }
      
      private static var _instance:FpsManager;
      
      public static function getInstance() : FpsManager {
         if(_instance == null)
         {
            _instance = new FpsManager();
         }
         return _instance;
      }
      
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
      
      public function display(pExternal:Boolean=false) : void {
         if(_instance == null)
         {
            throw new Error("FpsManager is not initialized");
         }
         else
         {
            this.isExternal = pExternal;
            if(pExternal)
            {
               this.conn = new LocalConnection();
               this.conn.addEventListener(StatusEvent.STATUS,this.onStatus);
               this.conn.send("app#DofusDebugger:DofusDebugConnection","updateStatus",true);
            }
            StageShareManager.stage.addChild(_instance);
            this._graphPanel.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
            StageShareManager.stage.addEventListener(Event.ENTER_FRAME,this.loop);
            return;
         }
      }
      
      public function hide() : void {
         if(_instance == null)
         {
            throw new Error("FpsManager is not initialized");
         }
         else
         {
            if(this.isExternal)
            {
               this.conn.send("app#DofusDebugger:DofusDebugConnection","updateStatus",false);
               this.conn.removeEventListener(StatusEvent.STATUS,this.onStatus);
               this.conn.close();
               this.conn = null;
            }
            else
            {
               StageShareManager.stage.removeChild(_instance);
               this._graphPanel.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
            }
            StageShareManager.stage.removeEventListener(Event.ENTER_FRAME,this.loop);
            return;
         }
      }
      
      private function onMouseDown(pEvt:MouseEvent) : void {
         this._decal = new Point(pEvt.localX,pEvt.localY);
         StageShareManager.stage.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         StageShareManager.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
      }
      
      private function onMouseUp(pEvt:MouseEvent) : void {
         this._decal = null;
         StageShareManager.stage.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         StageShareManager.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
      }
      
      private function onMouseMove(pEvt:MouseEvent) : void {
         x = StageShareManager.stage.mouseX - this._decal.x;
         y = StageShareManager.stage.mouseY - this._decal.y;
         pEvt.updateAfterEvent();
      }
      
      private function onStatus(event:StatusEvent) : void {
         switch(event.level)
         {
            case "status":
               break;
            case "error":
               trace("LocalConnection.send() failed");
               this.conn.removeEventListener(StatusEvent.STATUS,this.onStatus);
               this.conn = null;
               break;
         }
      }
      
      private function redrawRegionHandler(pEvt:MouseEvent) : void {
         this._redrawRegionsVisible = !this._redrawRegionsVisible;
         showRedrawRegions(this._redrawRegionsVisible,17595);
      }
      
      private function changeStateHandler(pEvt:MouseEvent) : void {
         this._extensionPanel.changeState();
      }
      
      private function loop(pEvt:Event) : void {
         var fpsValue:* = NaN;
         var graphList:Array = null;
         var o:Object = null;
         this.stopTracking(FpsManagerConst.SPECIAL_GRAPH[0].name);
         this.startTracking(FpsManagerConst.SPECIAL_GRAPH[0].name,FpsManagerConst.SPECIAL_GRAPH[0].color);
         this._graphPanel.update();
         this.updateMem();
         this._ticks++;
         var now:uint = getTimer();
         var delta:uint = now - this._last;
         if(delta >= 500)
         {
            fpsValue = this._ticks / delta * 1000;
            if((this.isExternal) && (!(this.conn == null)))
            {
               this.conn.send("app#DofusDebugger:DofusDebugConnection","updateValues",fpsValue,this._graphPanel.memory,FpsManagerUtils.getTimeFromNow(this._extensionPanel.lastGc));
               graphList = this._graphPanel.getExternalGraphs();
               for each (o in graphList)
               {
                  if(this.conn == null)
                  {
                     break;
                  }
                  this.conn.send("app#DofusDebugger:DofusDebugConnection","updateGraphValues",o.name,o.color,o.points);
               }
               this.conn.send("app#DofusDebugger:DofusDebugConnection","updateGraphes");
            }
            this._graphPanel.updateFpsValue(fpsValue);
            this._extensionPanel.update();
            this._ticks = 0;
            this._last = now;
         }
      }
      
      private function updateMem() : void {
         var currentFreeMem:* = NaN;
         var max_memory:* = NaN;
         this._graphPanel.memory = FpsManagerUtils.calculateMB(System.totalMemory).toPrecision(3);
         if(AirScanner.hasAir())
         {
            if(FpsManagerConst.PLAYER_VERSION >= 10)
            {
               currentFreeMem = FpsManagerUtils.calculateMB(System["freeMemory"]);
               if(currentFreeMem - this._graphPanel.previousFreeMem > 1)
               {
                  this._extensionPanel.lastGc = getTimer();
               }
               max_memory = FpsManagerUtils.calculateMB(System["privateMemory"]);
               this._graphPanel.memory = this._graphPanel.memory + ("/" + max_memory.toPrecision(3));
               this._graphPanel.previousFreeMem = currentFreeMem;
               this._extensionPanel.updateGc(max_memory);
            }
         }
         this._graphPanel.memory = this._graphPanel.memory + " MB";
      }
      
      public function startTracking(pIndice:String, pColor:uint=16777215) : void {
         this._graphPanel.startTracking(pIndice,pColor);
      }
      
      public function stopTracking(pIndice:String) : void {
         this._graphPanel.stopTracking(pIndice);
      }
      
      public function watchObject(o:Object, incrementParents:Boolean=false) : void {
         this._extensionPanel.watchObject(o,FpsManagerUtils.getBrightRandomColor(),incrementParents);
      }
   }
}
