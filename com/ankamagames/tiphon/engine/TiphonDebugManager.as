package com.ankamagames.tiphon.engine
{
   import com.ankamagames.tiphon.display.TiphonSprite;
   import flash.text.TextField;
   import flash.utils.Timer;
   import flash.geom.Point;
   import flash.text.TextFormat;
   import flash.filters.GlowFilter;
   import flash.text.TextFieldAutoSize;
   import flash.events.TimerEvent;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   
   public final class TiphonDebugManager extends Object
   {
      
      public function TiphonDebugManager() {
         super();
      }
      
      private static var _enabled:Boolean = false;
      
      private static var _textList:Vector.<Object>;
      
      public static function enable() : void {
         _enabled = true;
      }
      
      public static function disable() : void {
         _enabled = false;
      }
      
      public static function displayDofusScriptError(text:String, tiphonSprite:TiphonSprite) : void {
         var textField:TextField = null;
         var timer:Timer = null;
         var pos:Point = null;
         if((_enabled) && (tiphonSprite))
         {
            textField = new TextField();
            textField.defaultTextFormat = new TextFormat("Verdana",14,16777215,true,null,null,null,null,"center");
            textField.filters = new Array(new GlowFilter(16711680,1,3,3,3,3));
            textField.text = text + "\n" + (tiphonSprite.look?tiphonSprite.look.toString():"");
            textField.autoSize = TextFieldAutoSize.LEFT;
            textField.mouseEnabled = false;
            timer = new Timer(10000,1);
            timer.addEventListener(TimerEvent.TIMER,onTimer);
            timer.start();
            _textList.push(timer,textField);
            StageShareManager.stage.addChild(textField);
            pos = tiphonSprite.localToGlobal(new Point(0,0));
            textField.x = pos.x - textField.width / 2;
            textField.y = pos.y - tiphonSprite.height / 2 + (20 - Math.random() * 40);
         }
      }
      
      private static function onTimer(e:TimerEvent) : void {
         var textField:TextField = null;
         var timer:Timer = e.currentTarget as Timer;
         var num:int = _textList.length;
         var i:int = 0;
         while(i < num)
         {
            if(timer == _textList[i])
            {
               textField = _textList[i + 1] as TextField;
               if(textField.parent)
               {
                  textField.parent.removeChild(textField);
               }
               _textList.splice(i,2);
               return;
            }
            i = i + 2;
         }
      }
   }
}
