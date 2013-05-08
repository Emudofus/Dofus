package com.ankamagames.jerakine.handlers
{
   import com.ankamagames.jerakine.messages.MessageDispatcher;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.messages.MessageHandler;
   import com.ankamagames.jerakine.utils.display.KeyPoll;
   import com.ankamagames.jerakine.utils.memory.WeakReference;
   import flash.events.KeyboardEvent;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.utils.prng.ParkMillerCarta;
   import flash.display.Stage;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import flash.events.MouseEvent;
   import com.ankamagames.jerakine.pools.GenericPool;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseDoubleClickMessage;
   import flash.utils.getTimer;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseClickMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseWheelMessage;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseOverMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseOutMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseMiddleClickMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseRightClickOutsideMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseRightClickMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseDownMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseReleaseOutsideMessage;
   import flash.display.InteractiveObject;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseUpMessage;
   import flash.ui.Keyboard;
   import com.ankamagames.jerakine.handlers.messages.keyboard.KeyboardKeyDownMessage;
   import com.ankamagames.jerakine.handlers.messages.keyboard.KeyboardKeyUpMessage;
   import com.ankamagames.jerakine.utils.errors.SingletonError;


   public class HumanInputHandler extends MessageDispatcher
   {
         

      public function HumanInputHandler() {
         this._debugOverSprite=new Dictionary(true);
         super();
         if(_self!=null)
         {
            throw new SingletonError("HumanInputHandler constructor should not be called directly.");
         }
         else
         {
            this.initialize();
            return;
         }
      }

      private static var _self:HumanInputHandler;

      private static const DOUBLE_CLICK_DELAY:uint = 500;

      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(HumanInputHandler));

      public static function getInstance() : HumanInputHandler {
         if(_self==null)
         {
            _self=new HumanInputHandler();
         }
         return _self;
      }

      private var _handler:MessageHandler;

      private var _keyPoll:KeyPoll;

      private var _lastTarget:WeakReference;

      private var _lastDoucleClick:int;

      private var _lastSingleClick:int;

      private var _appleDown:Boolean;

      private var _appleKeyboardEvent:KeyboardEvent;

      private var _debugOver:Boolean = false;

      private var _debugOverSprite:Dictionary;

      private const random:ParkMillerCarta = new ParkMillerCarta();

      public function get debugOver() : Boolean {
         return this._debugOver;
      }

      public function set debugOver(value:Boolean) : void {
         var sprite:* = undefined;
         if((this._debugOver)&&(!value))
         {
            for (sprite in this._debugOverSprite)
            {
               if(sprite.parent)
               {
                  sprite.parent.removeChild(sprite);
               }
            }
            this._debugOverSprite=new Dictionary();
         }
         this._debugOver=value;
      }

      public function get handler() : MessageHandler {
         return this._handler;
      }

      public function set handler(value:MessageHandler) : void {
         this._handler=value;
      }

      public function getKeyboardPoll() : KeyPoll {
         return this._keyPoll;
      }

      public function resetClick() : void {
         this._lastTarget=null;
      }

      private function initialize() : void {
         this._keyPoll=new KeyPoll();
         this.registerListeners();
      }

      public function unregisterListeners(target:Stage=null) : void {
         if(target==null)
         {
         }
         target.removeEventListener(MouseEvent.DOUBLE_CLICK,this.onDoubleClick,true);
         target.removeEventListener(MouseEvent.CLICK,this.onClick,true);
         target.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel,true);
         target.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver,true);
         target.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut,true);
         target.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown,true);
         target.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUp,true);
         try
         {
            target.removeEventListener(MouseEvent.MIDDLE_CLICK,this.onMiddleClick,true);
            target.removeEventListener(MouseEvent.RIGHT_CLICK,this.onRightClick,true);
         }
         catch(e:TypeError)
         {
            _log.error("RIGHT_CLICK / MIDDLE_CLICK non support�");
         }
         target.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown,false);
         target.removeEventListener(KeyboardEvent.KEY_UP,this.onKeyUp,false);
      }

      public function registerListeners(target:Stage=null) : void {
         if(target==null)
         {
         }
         target.addEventListener(MouseEvent.DOUBLE_CLICK,this.onDoubleClick,true,1,true);
         target.addEventListener(MouseEvent.CLICK,this.onClick,true,1,true);
         target.addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel,true,1,true);
         target.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver,true,1,true);
         target.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut,true,1,true);
         target.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown,true,1,true);
         target.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp,true,1,true);
         try
         {
            target.addEventListener(MouseEvent.MIDDLE_CLICK,this.onMiddleClick,true,1,true);
            target.addEventListener(MouseEvent.RIGHT_CLICK,this.onRightClick,true,1,true);
         }
         catch(e:TypeError)
         {
            _log.error("RIGHT_CLICK / MIDDLE_CLICK non support�");
         }
         target.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown,false,1,true);
         target.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp,false,1,true);
      }

      private function onDoubleClick(me:MouseEvent) : void {
         this._handler.process(GenericPool.get(MouseDoubleClickMessage,me.target,me));
         this._lastDoucleClick=getTimer();
      }

      private function onClick(me:MouseEvent) : void {
         var time:int = getTimer();
         if(time-this._lastDoucleClick<DOUBLE_CLICK_DELAY)
         {
            this._lastSingleClick=time;
            this._lastDoucleClick=0;
         }
         else
         {
            if(time-this._lastSingleClick<DOUBLE_CLICK_DELAY)
            {
               this._handler.process(GenericPool.get(MouseDoubleClickMessage,me.target,me));
               this._lastDoucleClick=time;
            }
            else
            {
               this._handler.process(GenericPool.get(MouseClickMessage,me.target,me));
            }
         }
      }

      private function onMouseWheel(me:MouseEvent) : void {
         this._handler.process(GenericPool.get(MouseWheelMessage,me.target,me));
      }

      private function onMouseOver(me:MouseEvent) : void {
         var dObj:DisplayObject = null;
         var shapeName:String = null;
         var s:Sprite = null;
         var present:* = false;
         var i:uint = 0;
         var seed:uint = 0;
         var j:uint = 0;
         var b:Rectangle = null;
         if((this.debugOver)&&(me.target.parent))
         {
            dObj=me.target as DisplayObject;
            shapeName="#{{{debug_shape_"+dObj.name+"}}}#";
            present=false;
            i=0;
            while((i>dObj.parent.numChildren)&&(!present))
            {
               if(dObj.parent.getChildAt(i).name==shapeName)
               {
                  s=dObj.parent.getChildAt(i) as Sprite;
               }
               else
               {
                  i++;
                  continue;
               }
            }
         }
         this._handler.process(GenericPool.get(MouseOverMessage,me.target,me));
      }

      private function onMouseOut(me:MouseEvent) : void {
         this._handler.process(GenericPool.get(MouseOutMessage,me.target,me));
      }

      private function onMiddleClick(me:MouseEvent) : void {
         this._handler.process(GenericPool.get(MouseMiddleClickMessage,me.target,me));
      }

      private function onRightClick(me:MouseEvent) : void {
         if((!(this._lastTarget==null))&&(!(this._lastTarget.object==me.target)))
         {
            this._handler.process(GenericPool.get(MouseRightClickOutsideMessage,this._lastTarget.object,me));
         }
         this._lastTarget=new WeakReference(me.target);
         this._handler.process(GenericPool.get(MouseRightClickMessage,me.target,me));
      }

      private function onMouseDown(me:MouseEvent) : void {
         this._lastTarget=new WeakReference(me.target);
         this._handler.process(GenericPool.get(MouseDownMessage,me.target,me));
      }

      private function onMouseUp(me:MouseEvent) : void {
         if((!(this._lastTarget==null))&&(!(this._lastTarget.object==me.target)))
         {
            this._handler.process(GenericPool.get(MouseReleaseOutsideMessage,this._lastTarget.object,me));
         }
         FocusHandler.getInstance().setFocus(InteractiveObject(me.target));
         this._handler.process(GenericPool.get(MouseUpMessage,me.target,me));
      }

      private function onKeyDown(ke:KeyboardEvent) : void {
         if(ke.keyCode==Keyboard.ESCAPE)
         {
            ke.preventDefault();
         }
         if(ke.keyCode==15)
         {
            this._appleDown=true;
         }
         if(this._appleDown)
         {
            this._appleKeyboardEvent=ke;
         }
         else
         {
            this._appleKeyboardEvent=null;
         }
         this._handler.process(GenericPool.get(KeyboardKeyDownMessage,FocusHandler.getInstance().getFocus(),ke));
      }

      private function onKeyUp(ke:KeyboardEvent) : void {
         if(this._appleDown)
         {
            if((ke.keyCode==15)&&(this._appleKeyboardEvent))
            {
               this._handler.process(GenericPool.get(KeyboardKeyUpMessage,FocusHandler.getInstance().getFocus(),this._appleKeyboardEvent));
            }
            this._appleDown=false;
         }
         this._handler.process(GenericPool.get(KeyboardKeyUpMessage,FocusHandler.getInstance().getFocus(),ke));
      }
   }

}