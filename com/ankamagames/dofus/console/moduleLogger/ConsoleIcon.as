package com.ankamagames.dofus.console.moduleLogger
{
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import flash.display.Shape;
   import flash.geom.ColorTransform;
   import flash.events.MouseEvent;
   import flash.display.MovieClip;


   public final class ConsoleIcon extends Sprite
   {
         

      public function ConsoleIcon(name:String, size:int=16) {
         super();
         this._size=size;
         if(_assets[name])
         {
            this._icon=new _assets[name]();
         }
         else
         {
            this._icon=new MovieClip();
            this._icon.graphics.beginFill(16711935);
            this._icon.graphics.drawRect(0,0,this._size,this._size);
            this._icon.graphics.endFill();
         }
         this._icon.width=this._size;
         this._icon.height=this._size;
         addChild(this._icon);
         mouseChildren=false;
         useHandCursor=true;
         buttonMode=true;
         addEventListener(MouseEvent.MOUSE_OVER,this.onRollOver);
         addEventListener(MouseEvent.MOUSE_OUT,this.onRollOut);
      }

      private static const I_CANCEL:Class = ConsoleIcon_I_CANCEL;

      private static const I_DISK:Class = ConsoleIcon_I_DISK;

      private static const I_LIST:Class = ConsoleIcon_I_LIST;

      private static const I_BOOK:Class = ConsoleIcon_I_BOOK;

      private static const I_TERMINAL:Class = ConsoleIcon_I_TERMINAL;

      private static const I_SCREEN:Class = ConsoleIcon_I_SCREEN;

      private static const _assets:Dictionary = new Dictionary();

      private var _icon:Sprite;

      private var _cross:Shape;

      private var _size:int;

      public function disable(value:Boolean) : void {
         if(value)
         {
            if(!this._cross)
            {
               this._cross=new Shape();
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
               this._cross=null;
            }
         }
      }

      public function changeColor(color:ColorTransform) : void {
         this._icon.transform.colorTransform=color;
      }

      private function onRollOver(e:MouseEvent) : void {
         transform.colorTransform=new ColorTransform(1.4,1.4,1.4);
      }

      private function onRollOut(e:MouseEvent) : void {
         transform.colorTransform=new ColorTransform(1,1,1);
      }
   }

}