package com.ankamagames.jerakine.utils.benchmark.monitoring.ui
{
   import flash.display.Sprite;
   import __AS3__.vec.Vector;
   import flash.events.MouseEvent;
   import flash.events.Event;
   import com.ankamagames.jerakine.utils.benchmark.monitoring.FpsManagerUtils;
   import flash.text.TextFormat;
   import flash.text.TextField;
   
   public class Graph extends Sprite
   {
      
      public function Graph(param1:String, param2:uint=16777215) {
         var _loc3_:TextFormat = null;
         var _loc4_:TextField = null;
         super();
         this.indice = param1;
         this.color = param2;
         this.points = new Vector.<int>();
         this._isNewFrame = true;
         if(!FpsManagerUtils.isSpecialGraph(this.indice))
         {
            this.grapheIsVisible = false;
            this._menu = new Sprite();
            this._menu.alpha = MENU_OUT_ALPHA;
            this._menu.buttonMode = true;
            this._menu.graphics.beginFill(this.color);
            this._menu.graphics.lineStyle(2,0);
            this._menu.graphics.drawRect(0,0,20,20);
            this._menu.graphics.endFill();
            this._menu.addEventListener(MouseEvent.CLICK,this.clickHandler);
            this._menu.addEventListener(MouseEvent.ROLL_OVER,this.mouseOverHandler);
            this._menu.addEventListener(MouseEvent.ROLL_OUT,this.mouseOutHandler);
            addChild(this._menu);
            _loc3_ = new TextFormat("Verdana",13);
            _loc3_.color = this.color;
            _loc4_ = new TextField();
            _loc4_.mouseEnabled = false;
            _loc4_.selectable = false;
            _loc4_.defaultTextFormat = _loc3_;
            _loc4_.text = this.indice;
            _loc4_.x = (_loc4_.width - _loc4_.textWidth) / 2;
            this._sprTooltip = new Sprite();
            this._sprTooltip.graphics.beginFill(16777215);
            this._sprTooltip.graphics.lineStyle(1,0);
            this._sprTooltip.graphics.drawRoundRect(0,0,_loc4_.width,20,4,4);
            this._sprTooltip.addChild(_loc4_);
            this._sprTooltip.y = -30;
            this._sprTooltip.x = -10;
         }
      }
      
      private static const MENU_OUT_ALPHA:Number = 0.5;
      
      public var indice:String;
      
      public var points:Vector.<int>;
      
      public var color:uint;
      
      private var _isNewFrame:Boolean;
      
      public var startTime:int = 0;
      
      private var _menu:Sprite;
      
      private var _sprTooltip:Sprite;
      
      private var grapheIsVisible:Boolean = true;
      
      private function clickHandler(param1:MouseEvent) : void {
         this.grapheIsVisible = !this.grapheIsVisible;
         this._menu.alpha = this.grapheIsVisible?1:MENU_OUT_ALPHA;
         if(this.grapheIsVisible)
         {
            dispatchEvent(new Event("showGraph"));
         }
         else
         {
            dispatchEvent(new Event("hideGraph"));
         }
      }
      
      private function mouseOverHandler(param1:MouseEvent) : void {
         if(!this.grapheIsVisible)
         {
            this._menu.alpha = 1;
         }
         this._menu.addChild(this._sprTooltip);
      }
      
      private function mouseOutHandler(param1:MouseEvent) : void {
         if(!this.grapheIsVisible)
         {
            this._menu.alpha = MENU_OUT_ALPHA;
         }
         this._menu.removeChild(this._sprTooltip);
      }
      
      public function insertNewValue(param1:int) : void {
         if(this._isNewFrame)
         {
            this.addValue(param1);
         }
         else
         {
            this.updateLastValue(param1);
         }
      }
      
      private function addValue(param1:int) : void {
         this._isNewFrame = false;
         this.points.push(param1);
      }
      
      private function updateLastValue(param1:int) : void {
         this.points[this.points.length-1] = this.points[this.points.length-1] + param1;
      }
      
      public function setNewFrame() : void {
         if(!FpsManagerUtils.isSpecialGraph(this.indice))
         {
            this.startTime = 0;
         }
         this._isNewFrame = true;
      }
      
      public function get length() : int {
         return this.points.length;
      }
      
      public function setMenuPosition(param1:Number, param2:Number) : void {
         this._menu.x = param1;
         this._menu.y = param2;
      }
      
      public function get graphVisible() : Boolean {
         return this.grapheIsVisible;
      }
   }
}
