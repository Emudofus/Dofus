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
      
      public function ConsoleIcon(param1:String, param2:int=16, param3:String="") {
         super();
         this._size = param2;
         if(_assets[param1])
         {
            this._icon = new _assets[param1]();
         }
         else
         {
            this._icon = new MovieClip();
            this._icon.name = param1;
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
         if(param3.length > 0)
         {
            this._toolTip = new TextField();
            this._toolTip.text = param3;
            this._toolTip.background = true;
            this._toolTip.backgroundColor = 16776389;
            this._toolTip.autoSize = TextFieldAutoSize.LEFT;
            this._toolTip.visible = false;
            this._toolTip.setTextFormat(new TextFormat("Arial"));
         }
      }
      
      private static const I_CANCEL:Class = ConsoleIcon_I_CANCEL;
      
      private static const I_DISK:Class = ConsoleIcon_I_DISK;
      
      private static const I_LIST:Class = ConsoleIcon_I_LIST;
      
      private static const I_BOOK:Class = ConsoleIcon_I_BOOK;
      
      private static const I_TERMINAL:Class = ConsoleIcon_I_TERMINAL;
      
      private static const I_SCREEN:Class = ConsoleIcon_I_SCREEN;
      
      private static const I_SCRIPT:Class = ConsoleIcon_I_SCRIPT;
      
      private static const I_RECORD:Class = ConsoleIcon_I_RECORD;
      
      private static const I_PAUSE:Class = ConsoleIcon_I_PAUSE;
      
      private static const I_WAIT:Class = ConsoleIcon_I_WAIT;
      
      private static const I_WAITAUTO:Class = ConsoleIcon_I_WAITAUTO;
      
      private static const I_STOP:Class = ConsoleIcon_I_STOP;
      
      private static const I_PLAY:Class = ConsoleIcon_I_PLAY;
      
      private static const I_SAVE:Class = ConsoleIcon_I_SAVE;
      
      private static const I_MOVE_DEFAULT:Class = ConsoleIcon_I_MOVE_DEFAULT;
      
      private static const I_MOVE_WALK:Class = ConsoleIcon_I_MOVE_WALK;
      
      private static const I_MOVE_RUN:Class = ConsoleIcon_I_MOVE_RUN;
      
      private static const I_MOVE_TELEPORT:Class = ConsoleIcon_I_MOVE_TELEPORT;
      
      private static const I_MOVE_SLIDE:Class = ConsoleIcon_I_MOVE_SLIDE;
      
      private static const I_OPEN:Class = ConsoleIcon_I_OPEN;
      
      private static const I_CAMERA_AUTOFOLLOW:Class = ConsoleIcon_I_CAMERA_AUTOFOLLOW;
      
      private static const I_CAMERA_ZOOM_IN:Class = ConsoleIcon_I_CAMERA_ZOOM_IN;
      
      private static const I_CAMERA_ZOOM_OUT:Class = ConsoleIcon_I_CAMERA_ZOOM_OUT;
      
      private static const I_RESET_WORLD:Class = ConsoleIcon_I_RESET_WORLD;
      
      private static const I_AUTO_RESET:Class = ConsoleIcon_I_AUTO_RESET;
      
      private static const _assets:Dictionary = new Dictionary();
      
      private var _enabled:Boolean = true;
      
      private var _toggled:Boolean = false;
      
      private var _icon:Sprite;
      
      private var _cross:Shape;
      
      private var _size:int;
      
      private var _toolTip:TextField;
      
      public function get toggled() : Boolean {
         return this._toggled;
      }
      
      public function set toggled(param1:Boolean) : void {
         var _loc2_:Class = null;
         this._toggled = param1;
         if(!(this._icon.name.toLowerCase().indexOf("record") == -1) || !(this._icon.name.toLowerCase().indexOf("pause") == -1))
         {
            _loc2_ = this._toggled?I_PAUSE:I_RECORD;
            removeChild(this._icon);
            this._icon = new _loc2_();
            this._icon.width = this._size;
            this._icon.height = this._size;
            addChild(this._icon);
         }
         else
         {
            if(this._toggled)
            {
               this._icon.filters = [new GlowFilter(16777215,1,8,8)];
            }
            else
            {
               this._icon.filters = [];
            }
         }
      }
      
      public function get enabled() : Boolean {
         return this._enabled;
      }
      
      public function set enabled(param1:Boolean) : void {
         this._enabled = param1;
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
      
      public function disable(param1:Boolean) : void {
         if(param1)
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
         else
         {
            if(this._cross)
            {
               removeChild(this._cross);
               this._cross = null;
            }
         }
      }
      
      public function changeColor(param1:ColorTransform) : void {
         this._icon.transform.colorTransform = param1;
      }
      
      private function onRollOver(param1:MouseEvent) : void {
         transform.colorTransform = new ColorTransform(1.4,1.4,1.4);
         if(this._toolTip)
         {
            if(!this._toolTip.parent)
            {
               stage.addChild(this._toolTip);
            }
            this._toolTip.x = param1.stageX + 10;
            this._toolTip.y = param1.stageY + 20;
            if(this._toolTip.x + this._toolTip.width > stage.stageWidth)
            {
               this._toolTip.x = stage.stageWidth - this._toolTip.width;
            }
            this._toolTip.visible = true;
         }
      }
      
      private function onRollOut(param1:MouseEvent) : void {
         transform.colorTransform = new ColorTransform(1,1,1);
         this.enabled = this._enabled;
         if(this._toolTip)
         {
            this._toolTip.visible = false;
         }
      }
   }
}
