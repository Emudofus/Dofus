package com.ankamagames.jerakine.utils.benchmark.monitoring.ui
{
   import flash.display.Sprite;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.utils.Dictionary;
   import flash.display.Bitmap;
   import __AS3__.vec.Vector;
   import flash.text.TextField;
   import com.ankamagames.jerakine.utils.benchmark.monitoring.FpsManagerConst;
   import flash.text.TextFormat;
   import flash.events.MouseEvent;
   import flash.system.System;
   import flash.utils.getTimer;
   import com.ankamagames.jerakine.utils.benchmark.monitoring.FpsManagerUtils;
   import flash.display.BitmapData;
   import com.ankamagames.jerakine.utils.benchmark.monitoring.MonitoredObject;
   import flash.geom.Rectangle;
   
   public class MemoryPanel extends Sprite
   {
      
      public function MemoryPanel() {
         super();
         this.drawBG();
         this.init();
      }
      
      private static var MAX_THEO_VALUE:int = 250;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(MemoryPanel));
      
      private var _otherData:Dictionary;
      
      private var _memGraph:Bitmap;
      
      private var _memoryGraph:Vector.<Number>;
      
      private var _memoryLimits:Vector.<Number>;
      
      private var _lastTimer:int = 0;
      
      private var _infosTf:TextField;
      
      public var lastGc:int;
      
      private function drawBG() : void {
         graphics.beginFill(FpsManagerConst.BOX_COLOR,0.7);
         graphics.lineStyle(2,FpsManagerConst.BOX_COLOR);
         graphics.drawRoundRect(0,0,FpsManagerConst.BOX_WIDTH,FpsManagerConst.BOX_HEIGHT,8,8);
         graphics.endFill();
      }
      
      private function init() : void {
         this._memoryGraph = new Vector.<Number>();
         this._memoryLimits = new Vector.<Number>();
         this._otherData = new Dictionary();
         var _loc1_:TextFormat = new TextFormat("Verdana",13);
         _loc1_.color = 16777215;
         this._infosTf = new TextField();
         this._infosTf.y = FpsManagerConst.BOX_HEIGHT - 20;
         this._infosTf.x = 4;
         this._infosTf.defaultTextFormat = _loc1_;
         this._infosTf.selectable = false;
         this._infosTf.addEventListener(MouseEvent.MOUSE_UP,this.forceGC);
         addChild(this._infosTf);
      }
      
      private function forceGC(param1:MouseEvent) : void {
         System.gc();
         this.lastGc = getTimer();
      }
      
      public function updateData() : void {
         this._memoryGraph.push(FpsManagerUtils.calculateMB(System.totalMemory));
         this._memoryLimits.push(MAX_THEO_VALUE);
         if(this._memoryGraph.length > FpsManagerConst.BOX_WIDTH)
         {
            this._memoryGraph.shift();
            this._memoryLimits.shift();
         }
      }
      
      public function initMemGraph() : void {
         if(this._memGraph == null)
         {
            this._memGraph = new Bitmap(new BitmapData(FpsManagerConst.BOX_WIDTH,FpsManagerConst.BOX_HEIGHT,true,0));
            this._memGraph.smoothing = true;
            addChild(this._memGraph);
         }
         this.drawLine(this._memoryGraph,this._memoryLimits,4.294967295E9);
      }
      
      public function render() : void {
         var _loc1_:MonitoredObject = null;
         this._memGraph.bitmapData.lock();
         this._memGraph.bitmapData.scroll(-1,0);
         this._memGraph.bitmapData.fillRect(new Rectangle(FpsManagerConst.BOX_WIDTH-1,1,1,FpsManagerConst.BOX_HEIGHT),16711680);
         for each (_loc1_ in this._otherData)
         {
            if(!(_loc1_ == null) && (_loc1_.selected))
            {
               this.drawGraphValue(_loc1_.data,_loc1_.limits,FpsManagerUtils.addAlphaToColor(_loc1_.color,4.294967295E9));
            }
         }
         this.drawGraphValue(this._memoryGraph,this._memoryLimits,4.294967295E9);
         this._memGraph.bitmapData.unlock();
      }
      
      private function drawGraphValue(param1:Vector.<Number>, param2:Vector.<Number>, param3:uint) : void {
         var _loc5_:* = 0;
         var _loc7_:* = NaN;
         var _loc4_:int = FpsManagerConst.BOX_WIDTH-1;
         var _loc6_:Number = param2 == null?MAX_THEO_VALUE:param2[param1.length-1];
         _loc5_ = this.getGraphValue(param1,param1.length-1,_loc6_);
         if(param1.length >= 2)
         {
            _loc7_ = param2 == null?MAX_THEO_VALUE:param2[param1.length - 2];
            this.linkGraphValues(_loc4_,_loc5_,this.getGraphValue(param1,param1.length - 2,_loc7_),param3);
         }
         this._memGraph.bitmapData.setPixel32(_loc4_,_loc5_,param3);
      }
      
      public function clearOtherGraph() : void {
         var _loc1_:MonitoredObject = null;
         for each (_loc1_ in this._otherData)
         {
            if(_loc1_ != null)
            {
               this.removeGraph(_loc1_);
            }
         }
         removeChild(this._memGraph);
         this._memGraph.bitmapData.dispose();
         this._memGraph = null;
      }
      
      public function addNewGraph(param1:MonitoredObject) : void {
         if(this._otherData[param1.name] != null)
         {
            this.removeGraph(param1);
         }
         else
         {
            param1.selected = true;
            this._otherData[param1.name] = param1;
            this.drawLine(param1.data,param1.limits,FpsManagerUtils.addAlphaToColor(param1.color,4.294967295E9));
         }
      }
      
      public function removeGraph(param1:MonitoredObject) : void {
         param1.selected = false;
         this._otherData[param1.name] = null;
         this.drawLine(param1.data,param1.limits);
      }
      
      private function drawLine(param1:Vector.<Number>, param2:Vector.<Number>, param3:uint=16711680) : void {
         var _loc8_:* = NaN;
         var _loc9_:* = NaN;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:int = param1.length;
         var _loc7_:* = 0;
         _loc7_ = 0;
         while(_loc7_ < _loc6_)
         {
            _loc4_ = _loc6_ < FpsManagerConst.BOX_WIDTH?FpsManagerConst.BOX_WIDTH - _loc6_ + _loc7_:_loc7_;
            _loc8_ = param2 == null?MAX_THEO_VALUE:param2[_loc7_];
            _loc5_ = this.getGraphValue(param1,_loc7_,_loc8_);
            if(_loc7_ != 0)
            {
               _loc9_ = param2 == null?MAX_THEO_VALUE:param2[_loc7_-1];
               this.linkGraphValues(_loc4_,_loc5_,this.getGraphValue(param1,_loc7_-1,_loc9_),param3);
            }
            this._memGraph.bitmapData.setPixel32(_loc4_,_loc5_,param3);
            _loc7_++;
         }
      }
      
      public function updateGc(param1:Number=0) : void {
         if(param1 > 0)
         {
            MAX_THEO_VALUE = Math.ceil(param1);
         }
         this._infosTf.text = "GC " + FpsManagerUtils.getTimeFromNow(this.lastGc);
      }
      
      private function getGraphValue(param1:Vector.<Number>, param2:int, param3:int=-1) : int {
         if(param3 == -1)
         {
            param3 = param3 = FpsManagerUtils.getVectorMaxValue(param1);
         }
         var _loc4_:int = Math.floor(param1[param2] / param3 * FpsManagerConst.BOX_HEIGHT * -1 + FpsManagerConst.BOX_HEIGHT);
         var _loc5_:int = FpsManagerConst.BOX_HEIGHT-1;
         if(_loc4_ < 1)
         {
            _loc4_ = 1;
         }
         else
         {
            if(_loc4_ > _loc5_)
            {
               _loc4_ = _loc5_;
            }
         }
         return _loc4_;
      }
      
      private function linkGraphValues(param1:int, param2:int, param3:int, param4:uint) : void {
         if(Math.abs(param2 - param3) > 1)
         {
            this._memGraph.bitmapData.fillRect(new Rectangle(param1-1,(param2 > param3?param3:param2) + 1,1,Math.abs(param2 - param3)-1),param4);
         }
      }
   }
}
