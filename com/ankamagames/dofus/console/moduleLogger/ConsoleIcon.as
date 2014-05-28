package com.ankamagames.dofus.console.moduleLogger
{
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import flash.display.Shape;
   import flash.text.TextField;
   import flash.filters.GlowFilter;
   import flash.geom.ColorTransform;
   import flash.events.MouseEvent;
   import flash.display.MovieClip;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   
   public final class ConsoleIcon extends Sprite
   {
      
      public function ConsoleIcon(name:String, size:int = 16, toolTip:String = "") {
         super();
         this._size = size;
         if(_assets[name])
         {
            this._icon = new _assets[name]();
         }
         else
         {
            this._icon = new MovieClip();
            this._icon.name = name;
            this._icon.graphics.beginFill(16711935);
            this._icon.graphics.drawRect(0,0,this._size,this._size);
            this._icon.graphics.endFill();
         }
         this._icon.width = this._size;
         this._icon.height = this._size;
         addChild(this._icon);
         mouseChildren = false;
         useHandCursor = true;
         buttonMode = true;
         addEventListener(MouseEvent.MOUSE_OVER,this.onRollOver);
         addEventListener(MouseEvent.MOUSE_OUT,this.onRollOut);
         if(toolTip.length > 0)
         {
            this._toolTip = new TextField();
            this._toolTip.text = toolTip;
            this._toolTip.background = true;
            this._toolTip.backgroundColor = 16776389;
            this._toolTip.autoSize = TextFieldAutoSize.LEFT;
            this._toolTip.visible = false;
            this._toolTip.setTextFormat(new TextFormat("Arial"));
         }
      }
      
      private static const I_CANCEL:Class;
      
      private static const I_DISK:Class;
      
      private static const I_LIST:Class;
      
      private static const I_BOOK:Class;
      
      private static const I_TERMINAL:Class;
      
      private static const I_SCREEN:Class;
      
      private static const I_SCRIPT:Class;
      
      private static const I_RECORD:Class;
      
      private static const I_PAUSE:Class;
      
      private static const I_WAIT:Class;
      
      private static const I_WAITAUTO:Class;
      
      private static const I_STOP:Class;
      
      private static const I_PLAY:Class;
      
      private static const I_SAVE:Class;
      
      private static const I_MOVE_DEFAULT:Class;
      
      private static const I_MOVE_WALK:Class;
      
      private static const I_MOVE_RUN:Class;
      
      private static const I_MOVE_TELEPORT:Class;
      
      private static const I_MOVE_SLIDE:Class;
      
      private static const I_OPEN:Class;
      
      private static const I_CAMERA_AUTOFOLLOW:Class;
      
      private static const I_CAMERA_ZOOM_IN:Class;
      
      private static const I_CAMERA_ZOOM_OUT:Class;
      
      private static const I_RESET_WORLD:Class;
      
      private static const I_AUTO_RESET:Class;
      
      private static const _assets:Dictionary;
      
      private var _enabled:Boolean = true;
      
      private var _toggled:Boolean = false;
      
      private var _icon:Sprite;
      
      private var _cross:Shape;
      
      private var _size:int;
      
      private var _toolTip:TextField;
      
      public function get toggled() : Boolean {
         return this._toggled;
      }
      
      public function set toggled(value:Boolean) : void {
         var IconClass:Class = null;
         this._toggled = value;
         if((!(this._icon.name.toLowerCase().indexOf("record") == -1)) || (!(this._icon.name.toLowerCase().indexOf("pause") == -1)))
         {
            IconClass = this._toggled?I_PAUSE:I_RECORD;
            removeChild(this._icon);
            this._icon = new IconClass();
            this._icon.width = this._size;
            this._icon.height = this._size;
            addChild(this._icon);
         }
         else if(this._toggled)
         {
            this._icon.filters = [new GlowFilter(16777215,1,8,8)];
         }
         else
         {
            this._icon.filters = [];
         }
         
      }
      
      public function get enabled() : Boolean {
         return this._enabled;
      }
      
      public function set enabled(value:Boolean) : void {
         this._enabled = value;
         if(this._enabled)
         {
            alpha = 1;
         }
         else
         {
            alpha = 0.4;
         }
         mouseEnabled = this._enabled;
      }
      
      public function disable(value:Boolean) : void {
         if(value)
         {
            if(!this._cross)
            {
               this._cross = new Shape();
               this._cross.graphics.lineStyle(2,14492194);
               this._cross.graphics.moveTo(0,0);
               this._cross.graphics.lineTo(this._size,this._size);
               this._cross.graphics.moveTo(0,this._size);
               this._cross.graphics.lineTo(this._size,0);
               addChild(this._cross);
            }
         }
         else if(this._cross)
         {
            removeChild(this._cross);
            this._cross = null;
         }
         
      }
      
      public function changeColor(color:ColorTransform) : void {
         this._icon.transform.colorTransform = color;
      }
      
      private function onRollOver(e:MouseEvent) : void {
         transform.colorTransform = new ColorTransform(1.4,1.4,1.4);
         if(this._toolTip)
         {
            if(!this._toolTip.parent)
            {
               stage.addChild(this._toolTip);
            }
            this._toolTip.x = e.stageX + 10;
            this._toolTip.y = e.stageY + 20;
            if(this._toolTip.x + this._toolTip.width > stage.stageWidth)
            {
               this._toolTip.x = stage.stageWidth - this._toolTip.width;
            }
            this._toolTip.visible = true;
         }
      }
      
      private function onRollOut(e:MouseEvent) : void {
         transform.colorTransform = new ColorTransform(1,1,1);
         this.enabled = this._enabled;
         if(this._toolTip)
         {
            this._toolTip.visible = false;
         }
      }
   }
}
