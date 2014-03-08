package com.ankamagames.jerakine.utils.benchmark.monitoring.ui
{
   import flash.display.Sprite;
   import com.ankamagames.jerakine.utils.benchmark.monitoring.FpsManagerConst;
   import com.ankamagames.jerakine.utils.benchmark.monitoring.FpsManagerEvent;
   import com.ankamagames.jerakine.utils.benchmark.monitoring.MonitoredObject;
   
   public class ExtensionPanel extends Sprite
   {
      
      public function ExtensionPanel(param1:Sprite) {
         super();
         this._parent = param1;
         y = FpsManagerConst.BOX_HEIGHT;
         this._memoryState = new MemoryPanel();
         this._leakState = new LeakDetectionPanel();
         this._leakState.addEventListener("follow",this.addGraphToMemory);
      }
      
      private var _parent:Sprite;
      
      private var _currentState:int = 0;
      
      private var _memoryState:MemoryPanel;
      
      private var _leakState:LeakDetectionPanel;
      
      public function get lastGc() : int {
         return this._memoryState.lastGc;
      }
      
      public function changeState() : void {
         switch(this._currentState)
         {
            case 0:
               this._parent.addChild(this);
               this._memoryState.initMemGraph();
               this._memoryState.y = 5;
               addChild(this._memoryState);
               this._currentState++;
               break;
            case 1:
               this._currentState++;
               this._leakState.y = this._memoryState.y + FpsManagerConst.BOX_HEIGHT + 5;
               addChild(this._leakState);
               break;
            case 2:
               this._parent.removeChild(this);
               removeChild(this._memoryState);
               removeChild(this._leakState);
               this._memoryState.clearOtherGraph();
               this._currentState = 0;
               break;
         }
      }
      
      public function update() : void {
         this._memoryState.updateData();
         this._leakState.updateData();
         if(this._currentState == 1 || this._currentState == 2)
         {
            this._memoryState.render();
         }
      }
      
      private function addGraphToMemory(param1:FpsManagerEvent) : void {
         var _loc2_:MonitoredObject = param1.data as MonitoredObject;
         this._memoryState.addNewGraph(_loc2_);
      }
      
      public function set lastGc(param1:int) : void {
         this._memoryState.lastGc = param1;
      }
      
      public function watchObject(param1:Object, param2:uint, param3:Boolean=false) : void {
         this._leakState.watchObject(param1,param2,param3);
      }
      
      public function updateGc(param1:Number=0) : void {
         this._memoryState.updateGc(param1);
      }
   }
}
