package com.ankamagames.jerakine.utils.benchmark.monitoring.ui
{
   import flash.display.Sprite;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.text.TextField;
   import flash.display.Bitmap;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.utils.benchmark.monitoring.FpsManagerConst;
   import flash.text.TextFormat;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   import com.ankamagames.jerakine.utils.benchmark.monitoring.FpsManagerUtils;
   import flash.utils.getTimer;
   import flash.events.Event;
   
   public class GraphDisplayer extends Sprite
   {
      
      public function GraphDisplayer() {
         super();
         this._graphToDisplay = new Dictionary();
         this.initDisplay();
         this.initTexts();
      }
      
      protected static const _log:Logger;
      
      private var _txtSprite:Sprite;
      
      private var _fpsTf:TextField;
      
      private var _memTf:TextField;
      
      public var previousFreeMem:Number;
      
      private var _graphSpr:Sprite;
      
      private var _graphDisplay:Bitmap;
      
      private var _graphToDisplay:Dictionary;
      
      private var _redrawRegionsVisible:Boolean = false;
      
      private function initTexts() : void {
         this._txtSprite = new Sprite();
         this._txtSprite.mouseEnabled = false;
         this._txtSprite.x = FpsManagerConst.PADDING_LEFT;
         this._txtSprite.y = FpsManagerConst.PADDING_TOP;
         var tf:TextFormat = new TextFormat("Verdana",13);
         tf.color = 16777215;
         this._fpsTf = new TextField();
         this._fpsTf.defaultTextFormat = tf;
         this._fpsTf.selectable = false;
         this._fpsTf.text = StageShareManager.stage.frameRate + " FPS";
         this._txtSprite.addChild(this._fpsTf);
         this._memTf = new TextField();
         this._memTf.y = 30;
         this._memTf.defaultTextFormat = tf;
         this._memTf.selectable = false;
         this._memTf.text = "00 MB";
         this._txtSprite.addChild(this._memTf);
         addChild(this._txtSprite);
      }
      
      private function initDisplay() : void {
         graphics.beginFill(FpsManagerConst.BOX_COLOR,0.7);
         graphics.lineStyle(FpsManagerConst.BOX_BORDER,0);
         graphics.drawRoundRect(0,0,FpsManagerConst.BOX_WIDTH,FpsManagerConst.BOX_HEIGHT,8,8);
         graphics.endFill();
         this._graphSpr = new Sprite();
         addChild(this._graphSpr);
         this._graphDisplay = new Bitmap(new BitmapData(FpsManagerConst.BOX_WIDTH,FpsManagerConst.BOX_HEIGHT,true,0));
         this._graphDisplay.smoothing = true;
         addChild(this._graphDisplay);
         var spr:Sprite = new Sprite();
         spr.graphics.beginFill(0,0.4);
         spr.graphics.drawRoundRect(0,0,FpsManagerConst.BOX_FILTER_WIDTH,FpsManagerConst.BOX_HEIGHT,8,8);
         addChild(spr);
      }
      
      public function update(graphicalUpdate:Boolean = true) : void {
         var py:* = 0;
         var color:uint = 0;
         var g:Graph = null;
         this.addConstValue(FpsManagerConst.SPECIAL_GRAPH[1].name,1000 / StageShareManager.stage.frameRate);
         if(!graphicalUpdate)
         {
            return;
         }
         var px:int = FpsManagerConst.BOX_WIDTH - 1;
         this._graphDisplay.bitmapData.lock();
         this._graphDisplay.bitmapData.scroll(-1,0);
         this._graphDisplay.bitmapData.fillRect(new Rectangle(px,1,1,FpsManagerConst.BOX_HEIGHT),16711680);
         for each(g in this._graphToDisplay)
         {
            if(!FpsManagerUtils.isSpecialGraph(g.indice))
            {
               this.addConstValue(g.indice);
            }
            g.setNewFrame();
            if(!((g.points.length == 0) || (!g.graphVisible)))
            {
               py = this.formateValue(g.points[g.points.length - 1]);
               color = FpsManagerUtils.addAlphaToColor(g.color,4.294967295E9);
               if(g.points.length >= 2)
               {
                  this.linkGraphValues(px,py,this.formateValue(g.points[g.points.length - 2]),color);
               }
               this._graphDisplay.bitmapData.setPixel32(px,py,py == 1?4.29490176E9:color);
            }
         }
         this._graphDisplay.bitmapData.unlock();
      }
      
      public function updateFpsValue(fpsValue:Number) : void {
         this._fpsTf.text = fpsValue.toFixed(1) + " FPS";
      }
      
      public function get memory() : String {
         return this._memTf.text;
      }
      
      public function set memory(val:String) : void {
         this._memTf.text = val;
      }
      
      public function startTracking(pIndice:String, pColor:uint = 16777215) : void {
         var graph:Graph = this._graphToDisplay[pIndice];
         if(graph == null)
         {
            graph = new Graph(pIndice,pColor);
            graph.addEventListener("showGraph",this.showGraph);
            graph.addEventListener("hideGraph",this.hideGraph);
            if(!FpsManagerUtils.isSpecialGraph(pIndice))
            {
               graph.setMenuPosition((FpsManagerUtils.countKeys(this._graphToDisplay) - FpsManagerUtils.numberOfSpecialGraphDisplayed(this._graphToDisplay)) * 24,-25);
            }
            this._graphSpr.addChild(graph);
            this._graphToDisplay[pIndice] = graph;
         }
         graph.startTime = getTimer();
      }
      
      public function stopTracking(pIndice:String) : void {
         var graph:Graph = this._graphToDisplay[pIndice];
         if(graph == null)
         {
            return;
         }
         var step:int = getTimer() - graph.startTime;
         graph.insertNewValue(step);
         graph.startTime = 0;
         if(graph.points.length > FpsManagerConst.BOX_WIDTH)
         {
            graph.points.shift();
         }
      }
      
      public function addConstValue(pIndice:String, cst:int = 0) : void {
         var graph:Graph = this._graphToDisplay[pIndice];
         if(graph == null)
         {
            return;
         }
         graph.insertNewValue(cst);
         if(graph.points.length > FpsManagerConst.BOX_WIDTH)
         {
            graph.points.shift();
         }
      }
      
      private function showGraph(pEvt:Event) : void {
         var px:* = 0;
         var py:* = 0;
         var g:Graph = pEvt.currentTarget as Graph;
         var len:int = g.points.length;
         var it:int = 0;
         var color:uint = FpsManagerUtils.addAlphaToColor(g.color,4.294967295E9);
         this._graphDisplay.bitmapData.lock();
         it = 0;
         while(it < len)
         {
            px = len < FpsManagerConst.BOX_WIDTH?FpsManagerConst.BOX_WIDTH - len + it:it;
            py = this.formateValue(g.points[it]);
            if(g.points.length >= 2)
            {
               this.linkGraphValues(px,py,this.formateValue(g.points[g.points.length - 2]),color);
            }
            this._graphDisplay.bitmapData.setPixel32(px,py,color);
            it++;
         }
         this._graphDisplay.bitmapData.unlock();
      }
      
      private function hideGraph(pEvt:Event) : void {
      }
      
      private function formateValue(py:int) : int {
         var bottom:int = FpsManagerConst.BOX_HEIGHT - 1;
         if(py < 1)
         {
            py = 1;
         }
         else if(py > bottom)
         {
            py = bottom;
         }
         
         return py * -1 + FpsManagerConst.BOX_HEIGHT;
      }
      
      private function linkGraphValues(px:int, py1:int, py2:int, pColor:uint) : void {
         if(Math.abs(py1 - py2) > 1)
         {
            this._graphDisplay.bitmapData.fillRect(new Rectangle(px - 1,(py1 > py2?py2:py1) + 1,1,Math.abs(py1 - py2) - 1),pColor);
         }
      }
      
      public function getExternalGraphs() : Array {
         var g:Graph = null;
         var datas:Array = new Array();
         for each(g in this._graphToDisplay)
         {
            datas.push(
               {
                  "name":g.indice,
                  "points":g.points,
                  "color":g.color
               });
         }
         return datas;
      }
   }
}
