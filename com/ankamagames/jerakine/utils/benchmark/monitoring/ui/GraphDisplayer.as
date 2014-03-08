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
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(GraphDisplayer));
      
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
         var _loc1_:TextFormat = new TextFormat("Verdana",13);
         _loc1_.color = 16777215;
         this._fpsTf = new TextField();
         this._fpsTf.defaultTextFormat = _loc1_;
         this._fpsTf.selectable = false;
         this._fpsTf.text = StageShareManager.stage.frameRate + " FPS";
         this._txtSprite.addChild(this._fpsTf);
         this._memTf = new TextField();
         this._memTf.y = 30;
         this._memTf.defaultTextFormat = _loc1_;
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
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.beginFill(0,0.4);
         _loc1_.graphics.drawRoundRect(0,0,FpsManagerConst.BOX_FILTER_WIDTH,FpsManagerConst.BOX_HEIGHT,8,8);
         addChild(_loc1_);
      }
      
      public function update(param1:Boolean=true) : void {
         var _loc3_:* = 0;
         var _loc4_:uint = 0;
         var _loc5_:Graph = null;
         this.addConstValue(FpsManagerConst.SPECIAL_GRAPH[1].name,1000 / StageShareManager.stage.frameRate);
         if(!param1)
         {
            return;
         }
         var _loc2_:int = FpsManagerConst.BOX_WIDTH-1;
         this._graphDisplay.bitmapData.lock();
         this._graphDisplay.bitmapData.scroll(-1,0);
         this._graphDisplay.bitmapData.fillRect(new Rectangle(_loc2_,1,1,FpsManagerConst.BOX_HEIGHT),16711680);
         for each (_loc5_ in this._graphToDisplay)
         {
            if(!FpsManagerUtils.isSpecialGraph(_loc5_.indice))
            {
               this.addConstValue(_loc5_.indice);
            }
            _loc5_.setNewFrame();
            if(!(_loc5_.points.length == 0 || !_loc5_.graphVisible))
            {
               _loc3_ = this.formateValue(_loc5_.points[_loc5_.points.length-1]);
               _loc4_ = FpsManagerUtils.addAlphaToColor(_loc5_.color,4.294967295E9);
               if(_loc5_.points.length >= 2)
               {
                  this.linkGraphValues(_loc2_,_loc3_,this.formateValue(_loc5_.points[_loc5_.points.length - 2]),_loc4_);
               }
               this._graphDisplay.bitmapData.setPixel32(_loc2_,_loc3_,_loc3_ == 1?4.29490176E9:_loc4_);
            }
         }
         this._graphDisplay.bitmapData.unlock();
      }
      
      public function updateFpsValue(param1:Number) : void {
         this._fpsTf.text = param1.toFixed(1) + " FPS";
      }
      
      public function get memory() : String {
         return this._memTf.text;
      }
      
      public function set memory(param1:String) : void {
         this._memTf.text = param1;
      }
      
      public function startTracking(param1:String, param2:uint=16777215) : void {
         var _loc3_:Graph = this._graphToDisplay[param1];
         if(_loc3_ == null)
         {
            _loc3_ = new Graph(param1,param2);
            _loc3_.addEventListener("showGraph",this.showGraph);
            _loc3_.addEventListener("hideGraph",this.hideGraph);
            if(!FpsManagerUtils.isSpecialGraph(param1))
            {
               _loc3_.setMenuPosition((FpsManagerUtils.countKeys(this._graphToDisplay) - FpsManagerUtils.numberOfSpecialGraphDisplayed(this._graphToDisplay)) * 24,-25);
            }
            this._graphSpr.addChild(_loc3_);
            this._graphToDisplay[param1] = _loc3_;
         }
         _loc3_.startTime = getTimer();
      }
      
      public function stopTracking(param1:String) : void {
         var _loc2_:Graph = this._graphToDisplay[param1];
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:int = getTimer() - _loc2_.startTime;
         _loc2_.insertNewValue(_loc3_);
         _loc2_.startTime = 0;
         if(_loc2_.points.length > FpsManagerConst.BOX_WIDTH)
         {
            _loc2_.points.shift();
         }
      }
      
      public function addConstValue(param1:String, param2:int=0) : void {
         var _loc3_:Graph = this._graphToDisplay[param1];
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.insertNewValue(param2);
         if(_loc3_.points.length > FpsManagerConst.BOX_WIDTH)
         {
            _loc3_.points.shift();
         }
      }
      
      private function showGraph(param1:Event) : void {
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc2_:Graph = param1.currentTarget as Graph;
         var _loc3_:int = _loc2_.points.length;
         var _loc4_:* = 0;
         var _loc7_:uint = FpsManagerUtils.addAlphaToColor(_loc2_.color,4.294967295E9);
         this._graphDisplay.bitmapData.lock();
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = _loc3_ < FpsManagerConst.BOX_WIDTH?FpsManagerConst.BOX_WIDTH - _loc3_ + _loc4_:_loc4_;
            _loc6_ = this.formateValue(_loc2_.points[_loc4_]);
            if(_loc2_.points.length >= 2)
            {
               this.linkGraphValues(_loc5_,_loc6_,this.formateValue(_loc2_.points[_loc2_.points.length - 2]),_loc7_);
            }
            this._graphDisplay.bitmapData.setPixel32(_loc5_,_loc6_,_loc7_);
            _loc4_++;
         }
         this._graphDisplay.bitmapData.unlock();
      }
      
      private function hideGraph(param1:Event) : void {
      }
      
      private function formateValue(param1:int) : int {
         var _loc2_:int = FpsManagerConst.BOX_HEIGHT-1;
         if(param1 < 1)
         {
            param1 = 1;
         }
         else
         {
            if(param1 > _loc2_)
            {
               param1 = _loc2_;
            }
         }
         return param1 * -1 + FpsManagerConst.BOX_HEIGHT;
      }
      
      private function linkGraphValues(param1:int, param2:int, param3:int, param4:uint) : void {
         if(Math.abs(param2 - param3) > 1)
         {
            this._graphDisplay.bitmapData.fillRect(new Rectangle(param1-1,(param2 > param3?param3:param2) + 1,1,Math.abs(param2 - param3)-1),param4);
         }
      }
      
      public function getExternalGraphs() : Array {
         var _loc2_:Graph = null;
         var _loc1_:Array = new Array();
         for each (_loc2_ in this._graphToDisplay)
         {
            _loc1_.push(
               {
                  "name":_loc2_.indice,
                  "points":_loc2_.points,
                  "color":_loc2_.color
               });
         }
         return _loc1_;
      }
   }
}
